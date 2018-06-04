Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:56845 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750915AbeFDQOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jun 2018 12:14:39 -0400
Cc: <bhelgaas@google.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: <Alex_Gagniuc@Dellteam.com>
To: <keith.busch@intel.com>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI: access.c: Piggyback user config access on
 pci_read/write_*()
Date: Mon, 4 Jun 2018 16:14:36 +0000
Message-ID: <02be2689d0b44afdb449b4dc17415b8f@ausx13mps321.AMER.DELL.COM>
References: <20180604154803.14185-1-mr.nuke.me@gmail.com>
 <20180604161213.GA7712@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/4/2018 11:09 AM, Keith Busch wrote:=0A=
> On Mon, Jun 04, 2018 at 10:48:02AM -0500, Alexandru Gagniuc wrote:=0A=
>> +++ b/drivers/pci/access.c=0A=
>> @@ -223,16 +223,9 @@ int pci_user_read_config_##size						\=0A=
>>   	(struct pci_dev *dev, int pos, type *val)			\=0A=
>>   {									\=0A=
>>   	int ret =3D PCIBIOS_SUCCESSFUL;					\=0A=
>> -	u32 data =3D -1;							\=0A=
>>   	if (PCI_##size##_BAD)						\=0A=
>>   		return -EINVAL;						\=0A=
>> -	raw_spin_lock_irq(&pci_lock);				\=0A=
>> -	if (unlikely(dev->block_cfg_access))				\=0A=
>> -		pci_wait_cfg(dev);					\=0A=
>> -	ret =3D dev->bus->ops->read(dev->bus, dev->devfn,			\=0A=
>> -					pos, sizeof(type), &data);	\=0A=
>> -	raw_spin_unlock_irq(&pci_lock);				\=0A=
>> -	*val =3D (type)data;						\=0A=
>> +	ret =3D pci_read_config_##size(dev, pos, val);			\=0A=
>>   	return pcibios_err_to_errno(ret);				\=0A=
>>   }									\=0A=
> =0A=
> If it wasn't for the block_cfg_access check for user access, this would=
=0A=
> have been a nice code reuse cleanup.=0A=
=0A=
Great fresh catch! I'll get that fixed in v2.=0A=
=0A=
Alex=0A=
=0A=
