Return-Path: <SRS0=AO0a=BR=codeaurora.org=tbaicar@kernel.org>
Return-Path: <SRS0=AO0a=BR=codeaurora.org=tbaicar@kernel.org>
Subject: Re: [PATCH] PCI/AER: update AER status string print to match other
 AER logs
To: David Laight <David.Laight@ACULAB.COM>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1508254922-30925-1-git-send-email-tbaicar@codeaurora.org>
 <063D6719AE5E284EB5DD2968C1650D6DD0099999@AcuExch.aculab.com>
 <afd74efa-96eb-3597-7323-a110f53e221b@codeaurora.org>
 <063D6719AE5E284EB5DD2968C1650D6DD009A8FD@AcuExch.aculab.com>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <fb9df680-6b4a-89bb-4d04-d2a05f0fd93e@codeaurora.org>
Date: Wed, 18 Oct 2017 14:23:58 -0400
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD009A8FD@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 10/18/2017 6:14 AM, David Laight wrote:
> From: Tyler Baicar [mailto:tbaicar@codeaurora.org]
>> Sent: 17 October 2017 18:14
>> On 10/17/2017 12:00 PM, David Laight wrote:
>>> From: Tyler Baicar
>>>> Sent: 17 October 2017 16:42
>>>> Currently the AER driver uses cper_print_bits() to print the AER status
>>>> string. This causes the status string to not include the proper PCI device
>>>> name prefix that the other AER prints include. Also, it has a different
>>>> print level than all the other AER prints.
>>>>
>>>> Update the AER driver to print the AER status string with the proper string
>>>> prefix and proper print level.
>>>>
>>>> Previous log example:
>>>>
>>>> e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
>>>> Receiver Error, Bad TLP
>>> ...
>>>> New log:
>>>>
>>>> e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
>>>> e1000e 0003:01:00.1: Receiver Error
>>>> e1000e 0003:01:00.1: Bad TLP
>>> Wouldn't it be better to manage to print the above all on 1 line?
>   
>> I broke them up into separate lines to simplify the code. If you look at
>> cper_print_bits(),
>> it is not a clean solution and involves some hard coded values to try to limit
>> the lines to 80 characters.
> I'm not sure the 80 char limit is needed.
>
>
> How about:
> #define MAX_STR 32
> void pr_bits(unsigned int val, const char *strs[], unsigned int num_str)
> {
>          const char *str[MAX_STR] = {};
>          unsigned int i, num;
>
>          if (num_str > MAX_STR)
>                  num_str = MAX_STR;
>          for (i = 0, num = 0; i < num_str; i++) {
>                  if (!(val & (1 << i)))
>                          continue;
>                  str[num++] = strs[i];
>          }
>          printf(" %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n" + (MAX_STR - num) * 3,
>                  str[0], str[1], str[2], str[3],
>                  str[4], str[5], str[6], str[7],
>                  str[8], str[9], str[10], str[11],
>                  str[12], str[13], str[14], str[15],
>                  str[16], str[17], str[18], str[19],
>                  str[20], str[21], str[22], str[23],
>                  str[24], str[25], str[26], str[27],
>                  str[28], str[29], str[30], str[31]);
> }
>
> For kernel use you'd probably want to pass in 'dev' and a printf list
> and use %pV to put the fixed text on the front of the line.
>
> All rather begging for a new %p? feature that is passed the value, strings
> and separator.
Hi David,

This seems like a bad approach. This can make the print in the kernel logs and 
the code both
look pretty awful. I would prefer to have each error that occurred have it's own 
print line in
the logs rather than introduce this code for the sole purpose of keeping the 
list on a single
print line. I don't see any real downside to having a few additional print lines 
in error
scenarios.

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
