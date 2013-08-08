Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:32334
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965436Ab3HHRRH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2013 13:17:07 -0400
Message-ID: <5203D287.1010608@amd.com>
Date: Thu, 8 Aug 2013 12:16:55 -0500
From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<dougthompson@xmission.com>, <bhelgaas@google.com>,
	<jbeulich@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3 V2] EDAC, AMD64_EDAC: Add ECC decoding support for
 newer F15h models.
References: <1375483384-2302-1-git-send-email-Aravind.Gopalakrishnan@amd.com> <1375483384-2302-4-git-send-email-Aravind.Gopalakrishnan@amd.com> <20130806202323.GH14891@pd.tnic> <520162C1.2080603@amd.com>
In-Reply-To: <520162C1.2080603@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


>
>>>           addr -= 0x100;
>>>       }
>>>   @@ -205,8 +213,9 @@ static int amd64_set_scrub_rate(struct 
>>> mem_ctl_info *mci, u32 bw)
>>>       if (boot_cpu_data.x86 == 0xf)
>>>           min_scrubrate = 0x0;
>>>   -    /* F15h Erratum #505 */
>>> -    if (boot_cpu_data.x86 == 0x15)
>>> +    /* F15h Models 0x00 - 0x0f Erratum #505 */
>> Hmm, are you sure this erratum is fixed in SR? Talk to Eric about it
>> first, please. RG says "No fix planned".
>>
>>> +    if (boot_cpu_data.x86 == 0x15 &&
>>> +        boot_cpu_data.x86_model != 0x30)
>>>           f15h_select_dct(pvt, 0);
>>>         return __amd64_set_scrub_rate(pvt->F3, bw, min_scrubrate);
>>> @@ -218,8 +227,9 @@ static int amd64_get_scrub_rate(struct 
>>> mem_ctl_info *mci)
>>>       u32 scrubval = 0;
>>>       int i, retval = -EINVAL;
>>>   -    /* F15h Erratum #505 */
>>> -    if (boot_cpu_data.x86 == 0x15)
>>> +    /* F15h Models 0x00 - 0x0f Erratum #505 */
>> ditto.
>
> I have pinged some people about it, will let you know..
>
 From email conversations internally, here are the current status of the 
errata:
* Erratum 505: Should not be carried over to newer Fam15h models.
* Erratum 637: Not fixed.

I have taken this into account and changed the code to workaround only E637.

> will send out changes in V3;
>
> Thanks,
> Aravind.
Corrected the indentations; Removed unnecessary comments;
Sending out changes in  [PATCH 3/3 V3].
Thanks,
-Aravind.


