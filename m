Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56165 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965579Ab2ERR1c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 May 2012 13:27:32 -0400
Message-ID: <4FB6865A.30406@redhat.com>
Date: Fri, 18 May 2012 13:26:50 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
CC: ddutile@redhat.com, betty.dall@hp.com,
	Shyam Iyer <shiyer@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci, Add AER_panic sysfs file
References: <20120518045130.GA3281@kroah.com> <1337350606-32648-1-git-send-email-prarit@redhat.com> <20120518154715.GA21043@kroah.com>
In-Reply-To: <20120518154715.GA21043@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Prarit Bhargava <prarit <at> redhat.com> writes:
> 
>>  /**
>> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
>> index 58ad791..dd6b352 100644
>> --- a/drivers/pci/pcie/aer/aerdrv.c
>> +++ b/drivers/pci/pcie/aer/aerdrv.c
>> @@ -346,6 +346,9 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>      u32 reg32;
>>      int pos;
>>
>> +    if (dev->rp_AER_panic)
>> +        panic("%s: AER detected on Root Port", pci_name(dev));
>> +
>>      pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>>
> 
> 
> I really like this idea. I just wonder if the panic can happen in do_recovery in
> aerdrv_core.c before the broadcast_error_message() is done that invokes all of
> the error_detected callbacks. It would be best to panic as soon as possible to
> increase error containment.

Hi Betty,

Thanks for the review.

IMO that sounds like a better idea.  As you said, panicking early as possible in
order to increase error containment is the best option.

Bjorn, any objection to moving the panic up as far as possible?

I'll let the rest of the discussion settle before putting out a [v3].

P.
