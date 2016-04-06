Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:40592 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbcDFVvv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2016 17:51:51 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Wed, 6 Apr 2016 18:51:48 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 138ED3520070
	for <linux-pci@vger.kernel.org>; Wed,  6 Apr 2016 17:51:34 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u36Kp8OT12648778
	for <linux-pci@vger.kernel.org>; Wed, 6 Apr 2016 17:51:09 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u36LphMR005721
	for <linux-pci@vger.kernel.org>; Wed, 6 Apr 2016 17:51:45 -0400
Subject: Re: [PATCH v4] powerpc/pci: Assign fixed PHB number based on
 device-tree properties
To: Ian Munsie <imunsie@au1.ibm.com>
References: <1458337746-20337-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1459971134-sup-6269@x230.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>,
	Michael C Hollinger <mchollin@us.ibm.com>,
	Frederic Barrat <frederic.barrat@fr.ibm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
	gwshan <gwshan@linux.vnet.ibm.com>,
	Manoj Kumar <kumarmn@us.ibm.com>, paulus <paulus@samba.org>,
	"andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
	bhelgaas <bhelgaas@google.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Michael Ellerman <mpe@ellerman.id.au>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <570584EF.1010904@linux.vnet.ibm.com>
Date: Wed, 6 Apr 2016 18:51:43 -0300
MIME-Version: 1.0
In-Reply-To: <1459971134-sup-6269@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/06/2016 04:38 PM, Ian Munsie wrote:
>> +    /* try fixed PHB numbering first, by checking archs and reading
>> +     * the respective device-tree property. */
>> +    if (machine_is(pseries)) {
>> +        regs = of_get_property(dn, "reg", NULL);
>> +        if (regs)
>> +            return (int)(be32_to_cpu(regs[1]) & 0xFFFF);
>> +    } else if (machine_is(powernv)) {
>> +        prop64 = of_get_property(dn, "ibm,opal-phbid", NULL);
>> +        if (prop64)
>> +            return (int)(be64_to_cpup(prop64) & 0xFFFF);
>> +    }
>
> I think these cases should still set the bit in phb_bitmap, otherwise a
> virtual PHB (e.g. as used in cxl/cxlflash) will be assigned PHB 0, and
> since that is already taken it will fail - we're already seeing a
> failure in Ubuntu Xenial since Canonical picked this patch up already
> (though have not confirmed that this is definitely the cause yet).
>
> There might also be some interesting races to think about here if a
> virtual PHB grabs a PHB number before the real one gets a chance.

This is a very interesting case I didn't think before. Thanks for 
pointing this Ian.

We can, as you suggested, set the bitmap in any case to avoid conflicts 
with virtual PHBs.

And in the case a virtual PHB grabs the bitmap before, we just need to 
add Michael's suggested check and fallback to bitmap PHB numbering in 
this case.

Do you think this is enough to avoid issues with cxl'a virtual PHBs?

Thanks,


Guilherme

