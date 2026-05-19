Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC33E0C4D;
	Tue, 19 May 2026 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178857; cv=none; b=HXY+aoq6FHnGfoDiKxPO59P86eNyv1OXfIpSChhyBBG2oSZkg4LaT9zNTH0nnd/tTpw/n8kky9CcPnhETP3pEJxcTzKOA7mnbQMREQW81QFLLrHnPETXGDWouBevfqI5UTxVjuSbOs4kVwm8PyEqffHXzxzvHPtSUkhHauiQOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178857; c=relaxed/simple;
	bh=fuzhnyoilWzd57vJ+bEoD5Zmuhb+4Qh4JxANN6Dr0sY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ysuk8Vu0ClBW+mdmxPUf8767hZzy4dvkrDD288UKS1ZnjB3hslsHyS3BG5CA4HRoxei0NBCa1z8jFpsMnWIGdpSTNmNiTqVhz4phxeSAvaQugesC/l5y7f24KzGuYeSEpEEnzt8kG2+iJO4/oS8zrvIu3nrvLR10mpPYc+lILd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=USXO6Kip; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="USXO6Kip"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gKSKn6fShz9v16;
	Tue, 19 May 2026 10:20:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779178846; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQfaAnbU3FNLooD1DsvIeItu9adpCmZtOJCbvFgPeek=;
	b=USXO6Kipz2iYG1/Y8VHZ3ADJpNbbf3zB6UBJhW4VK0YEzVzhblZgP4uPS8FfqkRHGWnBb/
	9QxNKjWHa2SfQ036Tlji0JeFoKcj0HK9AOqAEgZP8JtAaxcNynnj4zL1LvRKJmeiIyCA3w
	gtuHSg+grlRsOlXJyzmqqC1KhRVoW8Z4in+PlvnjNgW3+7+/LqZClCGunbP86+VOnaZBEb
	FoX2/BLL7/CU6fPrcATVTLc3BIFa3Kio7koRToyWHkUAbU5QQT5Uvu8D2gQ/PyS13BzZ84
	hxvEQ+vodHEUNwH2hxkoA3q48PzVKyv2Vqu/nVT0FaYx0fl6Yr0hLHIHDTOY2g==
Message-ID: <7a477885c58709f287f6c1440fb7e31331227d10.camel@mailbox.org>
Subject: Re: [PATCH net-next v3 02/14] libie: add PCI device initialization
 helpers to libie
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com,  andrew+netdev@lunn.ch, netdev@vger.kernel.org, Phani
 R Burra <phani.r.burra@intel.com>, larysa.zaremba@intel.com, 
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com, 
 sridhar.samudrala@intel.com, anjali.singhai@intel.com, 
 michal.swiatkowski@linux.intel.com, maciej.fijalkowski@intel.com, 
 emil.s.tantilov@intel.com, madhu.chittim@intel.com, joshua.a.hay@intel.com,
  jacob.e.keller@intel.com, jayaprakash.shanmugam@intel.com,
 jiri@resnulli.us,  horms@kernel.org, corbet@lwn.net,
 richardcochran@gmail.com,  linux-doc@vger.kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org,  Bharath R <bharath.r@intel.com>, Samuel Salin
 <Samuel.salin@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Philipp Stanner <phasta@kernel.org>
Date: Tue, 19 May 2026 10:20:27 +0200
In-Reply-To: <20260518215441.GA640516@bhelgaas>
References: <20260518215441.GA640516@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: bu4mq3maazu4tprzgcr66hucmwurcb8x
X-MBO-RS-ID: 8ab3abc5a08522f74bf

On Mon, 2026-05-18 at 16:54 -0500, Bjorn Helgaas wrote:
> [+cc Philipp]
>=20
> On Fri, May 15, 2026 at 03:44:26PM -0700, Tony Nguyen wrote:
> > From: Phani R Burra <phani.r.burra@intel.com>
> >=20
> > Add support functions for drivers to configure PCI functionality and ac=
cess
> > MMIO space.
>=20
> This looks kind of like what pcim_iomap_range() does, i.e., a way to
> ioremap (BAR-idx, offset, size) pieces of PCI BARs.=C2=A0 That sounds lik=
e
> useful functionality.
>=20
> Is there something Intel-specific or even ethernet-specific about
> this?=C2=A0 If devm_* and pcim_* don't do what you need, maybe they shoul=
d
> be extended or this could be made generic so any drivers could use it?
>=20
> This looks like a mix of managed (pcim_enable_device(),
> pcim_request_region()), and unmanaged (ioremap(), iounmap()) things.
> I haven't looked at how all this is used, but it's pretty easy to get
> things wrong when mixing models.
>=20
> > +++ b/drivers/net/ethernet/intel/libie/pci.c
> > @@ -0,0 +1,208 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (C) 2025 Intel Corporation */
> > +
> > +#include <linux/intel/libie/pci.h>
> > +
> > +/**
> > + * libie_find_mmio_region - find MMIO region containing a range
> > + * @mmio_list: list that contains MMIO region info
> > + * @offset: range start offset
> > + * @size: range size
> > + * @bar_idx: BAR index containing the range to search
> > + *
> > + * Return: pointer to a MMIO region overlapping with the range in any =
way or
> > + *	=C2=A0=C2=A0 NULL if no such region is mapped.
> > + */
> > +static struct libie_pci_mmio_region *
> > +libie_find_mmio_region(const struct list_head *mmio_list,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resource_size_t offset, resourc=
e_size_t size,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int bar_idx)
> > +{
> > +	resource_size_t end_offset =3D offset + size;
> > +	struct libie_pci_mmio_region *mr;
> > +
> > +	list_for_each_entry(mr, mmio_list, list) {
> > +		resource_size_t mr_end =3D mr->offset + mr->size;
> > +		resource_size_t mr_start =3D mr->offset;
> > +
> > +		if (mr->bar_idx !=3D bar_idx)
> > +			continue;
> > +		if (offset < mr_end && end_offset > mr_start)
> > +			return mr;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +/**
> > + * __libie_pci_get_mmio_addr - get the MMIO virtual address
> > + * @mmio_info: contains list of MMIO regions
> > + * @offset: register offset to find
> > + * @num_args: number of additional arguments present
> > + *
> > + * This function finds the virtual address of a register offset by ite=
rating
> > + * through the non-linear MMIO regions that are mapped by the driver.
> > + *
> > + * Return: valid MMIO virtual address or NULL.
> > + */
> > +void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_i=
nfo,
> > +					resource_size_t offset,
> > +					int num_args, ...)
> > +{
> > +	struct libie_pci_mmio_region *mr;
> > +	int bar_idx =3D 0;
> > +	va_list args;
> > +
> > +	if (num_args) {
> > +		va_start(args, num_args);
> > +		bar_idx =3D va_arg(args, int);
> > +		va_end(args);
> > +	}
> > +
> > +	list_for_each_entry(mr, &mmio_info->mmio_list, list)
> > +		if (bar_idx =3D=3D mr->bar_idx && offset >=3D mr->offset &&
> > +		=C2=A0=C2=A0=C2=A0 offset < mr->offset + mr->size) {
> > +			offset -=3D mr->offset;
> > +
> > +			return mr->addr + offset;
> > +		}
> > +
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(__libie_pci_get_mmio_addr, "LIBIE_PCI");
> > +
> > +/**
> > + * __libie_pci_map_mmio_region - map PCI device MMIO region
> > + * @mmio_info: struct to store the mapped MMIO region
> > + * @offset: MMIO region start offset
> > + * @size: MMIO region size
> > + * @num_args: number of additional arguments present
> > + *
> > + * Return: true on success, false on memory map failure.
> > + */
> > +bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
> > +				 resource_size_t offset,
> > +				 resource_size_t size, int num_args, ...)
> > +{
> > +	struct pci_dev *pdev =3D mmio_info->pdev;
> > +	struct libie_pci_mmio_region *mr;
> > +	resource_size_t pa;
> > +	void __iomem *va;
> > +	int bar_idx =3D 0;
> > +	va_list args;
> > +
> > +	if (num_args) {
> > +		va_start(args, num_args);
> > +		bar_idx =3D va_arg(args, int);
> > +		va_end(args);
> > +	}
> > +
> > +	if (offset + size > pci_resource_len(pdev, bar_idx))
> > +		return false;
> > +
> > +	mr =3D libie_find_mmio_region(&mmio_info->mmio_list, offset, size,
> > +				=C2=A0=C2=A0=C2=A0 bar_idx);
> > +	if (mr) {
> > +		pci_warn(pdev,
> > +			 "Mapping of BAR%u (offset=3D%llu, size=3D%llu) intersecting region=
 (offset=3D%llu, size=3D%llu) already exists\n",
> > +			 bar_idx, (unsigned long long)mr->offset,
> > +			 (unsigned long long)mr->size,
> > +			 (unsigned long long)offset, (unsigned long long)size);
> > +		return mr->offset <=3D offset &&
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mr->offset + mr->size >=3D offs=
et + size;
> > +	}
> > +
> > +	pa =3D pci_resource_start(pdev, bar_idx) + offset;
> > +	va =3D ioremap(pa, size);

I agree with Bjorn, this certainly looks like something that can be
covered by shared PCI infrastructure?

> > +	if (!va) {
> > +		pci_err(pdev, "Failed to map BAR%u region\n", bar_idx);
> > +		return false;
> > +	}
> > +
> > +	mr =3D kvzalloc_obj(*mr);
> > +	if (!mr) {
> > +		iounmap(va);
> > +		return false;
> > +	}
> > +
> > +	mr->addr =3D va;
> > +	mr->offset =3D offset;
> > +	mr->size =3D size;
> > +	mr->bar_idx =3D bar_idx;
> > +
> > +	list_add_tail(&mr->list, &mmio_info->mmio_list);
> > +
> > +	return true;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(__libie_pci_map_mmio_region, "LIBIE_PCI");
> > +
> > +/**
> > + * libie_pci_unmap_fltr_regs - unmap selected PCI device MMIO regions
> > + * @mmio_info: contains list of MMIO regions to unmap
> > + * @fltr: returns true, if region is to be unmapped
> > + */
> > +void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool (*fltr)(struct libie_mmio=
_info *mmio_info,
> > +					=C2=A0=C2=A0=C2=A0 struct libie_pci_mmio_region *reg))
> > +{
> > +	struct libie_pci_mmio_region *mr, *tmp;
> > +
> > +	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
> > +		if (!fltr(mmio_info, mr))
> > +			continue;
> > +		iounmap(mr->addr);
> > +		list_del(&mr->list);
> > +		kvfree(mr);
> > +	}
> > +}
> > +EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_fltr_regs, "LIBIE_PCI");
> > +
> > +/**
> > + * libie_pci_unmap_all_mmio_regions - unmap all PCI device MMIO region=
s
> > + * @mmio_info: contains list of MMIO regions to unmap
> > + */
> > +void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_inf=
o)
> > +{
> > +	struct libie_pci_mmio_region *mr, *tmp;
> > +
> > +	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
> > +		iounmap(mr->addr);
> > +		list_del(&mr->list);
> > +		kvfree(mr);
> > +	}
> > +}
> > +EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_all_mmio_regions, "LIBIE_PCI");
> > +
> > +/**
> > + * libie_pci_init_dev - enable and reserve PCI regions of the device
> > + * @pdev: PCI device information
> > + *
> > + * Return: %0 on success, -%errno on failure.
> > + */
> > +int libie_pci_init_dev(struct pci_dev *pdev)
> > +{
> > +	int err;
> > +
> > +	err =3D pcim_enable_device(pdev);
> > +	if (err)
> > +		return err;
> > +
> > +	for (int bar =3D 0; bar < PCI_STD_NUM_BARS; bar++)
> > +		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
> > +			err =3D pcim_request_region(pdev, bar, pci_name(pdev));

So mappings are handled manually, and region requests automatically
through devres?

In case you can use (or add) a pcim_iomap_region() function for that,
you would get consistent automatic devres management.


Greetings,
P.

> > +			if (err)
> > +				return err;
> > +		}
> > +
> > +	err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > +	if (err)
> > +		return err;
> > +
> > +	pci_set_master(pdev);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(libie_pci_init_dev, "LIBIE_PCI");
> > +
> > +MODULE_DESCRIPTION("Common Ethernet PCI library");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/intel/libie/pci.h b/include/linux/intel/libi=
e/pci.h
> > new file mode 100644
> > index 000000000000..effd072c55c8
> > --- /dev/null
> > +++ b/include/linux/intel/libie/pci.h
> > @@ -0,0 +1,56 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright (C) 2025 Intel Corporation */
> > +
> > +#ifndef __LIBIE_PCI_H
> > +#define __LIBIE_PCI_H
> > +
> > +#include <linux/pci.h>
> > +
> > +/**
> > + * struct libie_pci_mmio_region - structure for MMIO region info
> > + * @list: used to add a MMIO region to the list of MMIO regions in
> > + *	=C2=A0 libie_mmio_info
> > + * @addr: virtual address of MMIO region start
> > + * @offset: start offset of the MMIO region
> > + * @size: size of the MMIO region
> > + * @bar_idx: BAR index to which the MMIO region belongs to
> > + */
> > +struct libie_pci_mmio_region {
> > +	struct list_head	list;
> > +	void __iomem		*addr;
> > +	resource_size_t		offset;
> > +	resource_size_t		size;
> > +	u16			bar_idx;
> > +};
> > +
> > +/**
> > + * struct libie_mmio_info - contains list of MMIO regions
> > + * @pdev: PCI device pointer
> > + * @mmio_list: list of MMIO regions
> > + */
> > +struct libie_mmio_info {
> > +	struct pci_dev		*pdev;
> > +	struct list_head	mmio_list;
> > +};
> > +
> > +#define libie_pci_map_mmio_region(mmio_info, offset, size, ...)	\
> > +	__libie_pci_map_mmio_region(mmio_info, offset, size,		\
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
> > +
> > +#define libie_pci_get_mmio_addr(mmio_info, offset, ...)		\
> > +	__libie_pci_get_mmio_addr(mmio_info, offset,			\
> > +				=C2=A0=C2=A0 COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
> > +
> > +bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
> > +				 resource_size_t offset, resource_size_t size,
> > +				 int num_args, ...);
> > +void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_i=
nfo,
> > +					resource_size_t offset,
> > +					int num_args, ...);
> > +void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_inf=
o);
> > +void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool (*fltr)(struct libie_mmio=
_info *mmio_info,
> > +					=C2=A0=C2=A0=C2=A0 struct libie_pci_mmio_region *reg));
> > +int libie_pci_init_dev(struct pci_dev *pdev);
> > +
> > +#endif /* __LIBIE_PCI_H */
> > --=20
> > 2.47.1
> >=20

