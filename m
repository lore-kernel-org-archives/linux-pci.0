Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:57226 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbbKMAVT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2015 19:21:19 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 13 Nov 2015 10:21:16 +1000
Date: Fri, 13 Nov 2015 11:20:15 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, aik@ozlabs.ru, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 39/50] powerpc/powernv: Fundamental reset in
 pnv_pci_reset_secondary_bus()
Message-ID: <20151113002015.GA21341@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
 <87fv0azrpe.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fv0azrpe.fsf@gamma.ozlabs.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 13, 2015 at 11:08:29AM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>>  void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>>  {
>> -	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>> +	int option, freset = 0;
>> +
>> +	if (dev->subordinate)
>> +		pci_walk_bus(dev->subordinate,
>> +			     pnv_pci_dev_reset_type, &freset);
>> +
>> +	option = freset ? EEH_RESET_FUNDAMENTAL : EEH_RESET_HOT;
>> +	pnv_eeh_bridge_reset(dev, option);
>
>According to the skiboot sources, fundamental reset isn't supported on
>p5ioc2. As far as I can tell from your corresponding skiboot patches,
>this is still the case after they are applied. Do we need a fallback to
>EEH_RESET_HOT in this case? Otherwise there will be no reset performed
>at all.
>
>Likewise, if the FUNDAMENTAL reset fails for any reason, should we fall
>back to a HOT reset?
>

P5IOC2 won't export any PCI slots. So kernel won't issue fundamental reset
to PCI buses on P5IOC2.

We had the failback: hot reset is picked if fundamental reset can't be
supported on the target PCI bus. In case fundamental reset fails, we
shouldn't go ahead try hot reset.

Thanks,
Gavin

>Regards,
>Daniel


