Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp02.br.ibm.com ([32.104.18.86]:42061 "EHLO
	e24smtp02.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422AbcCRP1f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2016 11:27:35 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Fri, 18 Mar 2016 12:27:33 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 3BE451DC007C
	for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2016 11:27:24 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2IERcXA13500784
	for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2016 11:27:38 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2IFRRfa024087
	for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2016 12:27:28 -0300
Subject: Re: [PATCH v3] powerpc/pci: Assign fixed PHB number based on
 device-tree properties
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1458245026-27635-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160317223757.GA6336@gwshan> <20160318040036.GA4078@gwshan>
Cc: mikey@neuling.org, linux-pci@vger.kernel.org, paulus@samba.org,
	andrew.donnellan@au1.ibm.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <56EC1E5F.2020309@linux.vnet.ibm.com>
Date: Fri, 18 Mar 2016 12:27:27 -0300
MIME-Version: 1.0
In-Reply-To: <20160318040036.GA4078@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/18/2016 01:00 AM, Gavin Shan wrote:
>> Apart from below minor issues to be fixed, it looks good to me.
>>
>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks for the review Gavin, I'll fix the else/if detail and send a v4.


>>> +	} else {
>>> +		if (machine_is(powernv)) {
>>> +			prop64 = of_get_property(dn, "ibm,opal-phbid", NULL);
>>> +			if (prop64)
>>> +				return (int)(be64_to_cpup(prop64) & 0xFFFF);
>>> +		}
>>> +	}
>>> +
>>
>> The nested statements can be merged to one with "else if (machine_is(powernv))".
>>
>>> +	/* if not pSeries nor PowerNV, fallback to dynamic PHB numbering */
>>> +	phb_id = find_first_zero_bit(phb_bitmap, MAX_PHBS);
>>> +	BUG_ON(phb_id >= MAX_PHBS); /* reached maximum number of PHBs */
>>> +	set_bit(phb_id, phb_bitmap);
>>> +	return phb_id;
>>
>> It's possible another CPU sets this bit before current CPU updates it, which
>> will cause same domain number used by two PHBs though it's very rare. I guess
>> it might be worthwhile to check if the bit is reserved by somebody else to
>> avoid the issue.
>>
>
> Please ignore this comment: there is a lock (hose_spinlock) avoiding the issue.
>

Ok =)


>> Thanks,
>> Gavin

Cheers,


Guilherme

