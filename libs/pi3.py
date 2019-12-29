#!/usr/bin/env python3.7
# -*- coding: utf-8 -*-

import datetime
from datetime import timedelta
import json


class pi3:

	ROBOT_LIBRARY_SCOPE = 'TEST SUITE'
	__version__ = 0.1


	def timestamp(self, FMT):

		#curr = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
		curr = datetime.datetime.now().strftime(FMT)
		return curr

	def hour_stamp(self, FMT='%Y-%m-%d %H:', post_str='--'):
		"""
		Hour based Time stamp
		- Returns timestamp based FMT and post string

		FMT = '%Y-%m-%d %H:%M:%S'
		FMT = '%M:%S,%f'   -   Minutes:Seconds:Microseconds

		Examples:
		| ${tmp}= | Hour Stamp | '%H:%M:%S,%f' |
		| ${tmp}= | Hour Stamp | '%H:%M:%S,%f' | xx |

		"""
		curr = datetime.datetime.now().strftime(FMT)
		curr = curr + post_str
		return curr


	def time_delta(self, timest=0, FMT='%H:%M:%S,%f'):
		"""
        Calculate Time Delta
        - 1st start timestamp
        - 2nd stop timestamp
        - Returns timestamp and delay in seconds

		FMT = '%M:%S,%f'   -   Minutes:Seconds:Microseconds

        Examples:
        | ${tmp}= | Time Delta | 0 |
        | ${tmp}= | Time Delta | ${tmp} |
        | ${tmp}= | Time Delta | ${tmp} | '%H:%M:%S,%f' |

        """
		if timest == 0:
			curr = datetime.datetime.now().strftime(FMT)
			return curr
		else:
			curr = datetime.datetime.now().strftime(FMT)
			tdelta = datetime.datetime.strptime(curr, FMT) - datetime.datetime.strptime(timest, FMT)
			#return curr, tdelta.seconds
			#return curr, tdelta.microseconds
			return curr, tdelta.total_seconds()

		
	def Random_True_False(self, max=10):
		"""
        Return False randomly....

        Examples:
        | ${tmp}= | Random_True_False | 
        | ${tmp}= | Random_True_False | 25 |

        """
		if max <= 10:
			max = 10
		value = randint(0, max)
		if value == 5:
			return 'False'
		else:
			return 'True'		
		
		

	def Read_JSON_File(self, json_file):
		"""Read JSON file

		Examples:
        | ${json-obj}= | Read JSON File | filename.json |
		"""
		with open(json_file) as data_file:
			data_loaded = json.load(data_file)
		return data_loaded


	def Write_JSON_File(self, json_file, json_obj):
		"""Writes json object to file

		Examples:
        | ${json-obj}= | Write JSON File | filename.json |
		"""
		with open(json_file, 'w') as outfile:
			json.dump(json_obj, outfile, sort_keys=True, indent=4)
			# sort_keys, indent are optional and used for pretty-write


	def Clean_Timestamps(self, stamps):
		"""
		Clean timestamps from json file
		- Remove duplicates
		- Reverse ordering
		- Return cleaned list

		Examples:
        | ${tmp}= | Clean Timestamps | ${values} |

		"""
		tmp_l = []
		i = 0
		lenght = len(stamps)
		for x in range(0, lenght):
			found = False
			for item in tmp_l:
				if item == stamps[x]:
					found = True
			if found == False:
				tmp_l.append(stamps[x])
		tmp_l.sort(reverse=True)
		return tmp_l



	def Get_Min_Max(self, values ,select='max'):
		"""
		Takes a list as argument and returns Min, Average or Max value
		based on input.

		:param values:
		:param select:
		:return:

		Examples:
        | ${tmp}= | Get_Min_Max | ${values} |
        | ${tmp}= | Get_Min_Max | ${values} | Avg |

		"""
		if len(values) == 0:
			return -1

		select = select.upper()
		if select == 'MAX':
			result = max(values)
		elif select == 'MIN':
			result = min(values)
		elif select == 'AVG':
			result = sum(values) / len(values)
		else:
			result = 0

		return round(result, 1)

		# result = round(result, 2)
