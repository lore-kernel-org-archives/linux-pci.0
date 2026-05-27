Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83293EE1D0;
	Wed, 27 May 2026 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889648; cv=pass; b=NRXs61HXs1kSqii3ZTG2oAn4Ru52WJdTnZ+bNgcDa1UFUO+oB/uUBX/aj8ST0v7u1tDm353/S5LX2uwoXS0TVmTeHKBAsvqwyNWSHbViiiPNeZkI4NjEc2fCOU6/Q8dDSWn5FIQ1KPRXX5HUhAuW+uXNgSZuPaHeYFjcI6ltL7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889648; c=relaxed/simple;
	bh=FKDOQZWRVPuFrSLbzbr5r6irAJprU3nMHZtx7Iikv70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G26wqo2SdesTb1yqvAy/Xl5OTCKmGBfrU+p9qs8tBIT2rWc9AoMTk453HLRC65MdIaeroPqmdYH5/nrOxw1rYMCdK8TUE/tM7ursv2gKCflCrY/lsOasEUMADQXL2vsQmI2uostc+zwf8MW2f8/J9L6lt7fE3L8lUbKAldFCzxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=FGRTv+lZ; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="FGRTv+lZ"
ARC-Seal: i=1; a=rsa-sha256; t=1779889637; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j9I/HMIF04PE2YVzZkcifqrOTmuuXoSr/bJRyrO56e6Uo7bWlviwmuAcgACBI/yHlADQz1MvtLWRh0avn//AFvWrhgbsb4a+1RO+R9D4SKn0AAKl+D/cYM3jYA3Zvk5RpRyzd6k51jHNdzA6A00SvSH5rdlVvJnZochfM1ZZz4g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779889637; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OrUy8xROCnILGgIy/Yq3KNp0pC2flvaMyDE2u6t01bg=; 
	b=jjJHf1CbSkXJWzNlbzDnH3/RYfoqBWqRTasFJoMRgylXob4hVqDw5UZvJUD2WwB+sN/uY/Gm7+J9QfAJJmZ00z9NSQyjLtv6GJ96VZJNBceoFfJSydA8Z6Ovaeku6WPu2acaURhVYYiekCGOvPac6uZ05T0upFe+4Gz4Qh2XrIw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779889637;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=OrUy8xROCnILGgIy/Yq3KNp0pC2flvaMyDE2u6t01bg=;
	b=FGRTv+lZXP/bjR3jGw0PznkQgHLoF/I/1rEDtAPgBypDkKi3BMfbxY6PzGZfGGJt
	FvHPj0H4yFt1ZJv6IIsmUm18ZLjBqTuueLNhkOR8gjUc9mfRLxV5J+GRESm7ke2INrN
	I18Fe0g0BnB0iTDgD0RBDkU2xCzEruGjtoeQjNsc=
Received: by mx.zohomail.com with SMTPS id 1779889634909567.695257599686;
	Wed, 27 May 2026 06:47:14 -0700 (PDT)
Message-ID: <2a448110-569d-4296-8430-19a115d7d651@zohomail.com>
Date: Wed, 27 May 2026 21:47:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] PCI/CXL: Enable usage of RDPAS to shortcut error
 device discovery
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: terry.bowman@amd.com, bhelgaas@google.com, jic23@kernel.org,
 djbw@kernel.org
References: <20260526182334.1010870-1-dave.jiang@intel.com>
 <20260526182334.1010870-3-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260526182334.1010870-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112278ceaabbc429b0ab2b6c21c940000b405874c7349be97be95be42aa48e62be90079df1b06c47bc4:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/5/27 02:23, Dave Jiang 写道:
> The RDPAS allows the CXL RCH error handler to find the device directly
> instead of iterating through a set number of RCiEP in order to discover
> which device triggered an error. For the CXL.io protocol, the base
> address provided from the cxl_rdpas xarray points to the RCRB of the
> device. The RCRB mirrors the configuration space of the device via MMIO.
> The error handler can walk the RCRB to find the AER capability block and
> therefore read the root status as well as the error source in order
> to determine the BDF of the error device.
>
> Change the current RCH error handler behavior so it will probe the
> RCRB first to see if the error device can be discovered quickly
> before falling back to the current method of iterating through RCiEPs.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/pci/pcie/aer_cxl_rch.c | 103 +++++++++++++++++++++++++++++++--
>   1 file changed, 99 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index 37bbecf495af..0fd6c4234856 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -80,7 +80,7 @@ int cxl_parse_rdpas(union acpi_subtable_headers *header, void *arg,
>   }
>   EXPORT_SYMBOL_FOR_MODULES(cxl_parse_rdpas, "cxl_acpi");
>   
> -static int __maybe_unused cxl_get_rdpas_by_rcec(struct pci_dev *rcec, u64 *dsp_addr)
> +static int cxl_get_rdpas_by_rcec(struct pci_dev *rcec, u64 *dsp_addr)
>   {
>   	u64 index;
>   	u64 *addr;
> @@ -134,6 +134,94 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>   	return 0;
>   }
>   
> +static u16 rcrb_to_aer(void __iomem *rcrb)
> +{
> +	u16 offset;
> +	u32 cap_hdr;
> +
> +	/* Start from PCIe extended capabilities at offset 0x100 */
> +	offset = PCI_CFG_SPACE_SIZE;
> +	cap_hdr = readl(rcrb + offset);
> +	if (cap_hdr == 0 || cap_hdr == ~0u)
> +		return 0;
> +
> +	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
> +		offset = PCI_EXT_CAP_NEXT(cap_hdr);
> +		if (!offset)
> +			return 0;
> +
> +		if (offset >= SZ_4K)
> +			return 0;
> +
> +		cap_hdr = readl(rcrb + offset);
> +	}
> +
> +	return offset;
> +}
> +
> +DEFINE_FREE(iounmap, void __iomem *, if (_T) iounmap(_T))
> +static u16 cxl_rch_get_err_src_id(u64 rcrb_base)
> +{
> +	u32 root_status, err_src;
> +	void __iomem *aer_base;
> +	u16 aer_offset;
> +
> +	void __iomem *rcrb __free(iounmap) = ioremap(rcrb_base, SZ_4K);
> +	if (!rcrb)
> +		return 0;
> +
> +	aer_offset = rcrb_to_aer(rcrb);
> +	if (!aer_offset)
> +		return 0;
> +
> +	aer_base = rcrb + aer_offset;
> +
> +	root_status = readl(aer_base + PCI_ERR_ROOT_STATUS);
> +	if (!(root_status & (PCI_ERR_ROOT_COR_RCV | PCI_ERR_ROOT_UNCOR_RCV)))
> +		return 0;
> +
> +	err_src = readl(aer_base + PCI_ERR_ROOT_ERR_SRC);
> +
> +	if (root_status & PCI_ERR_ROOT_UNCOR_RCV)
> +		return FIELD_GET(GENMASK(31, 16), err_src);
> +
> +	if (root_status & PCI_ERR_ROOT_COR_RCV)
> +		return FIELD_GET(GENMASK(15, 0), err_src);
> +
> +	return 0;
> +}
> +
> +static bool cxl_rch_handled_error_by_rdpas(struct pci_dev *rcec,
> +					   struct aer_err_info *info)
> +{
> +	u8 bus, devfn;
> +	u64 dsp_addr;
> +	u16 segment;
> +	u16 src_id;
> +	int rc;
> +
> +	rc = cxl_get_rdpas_by_rcec(rcec, &dsp_addr);
> +	if (rc)
> +		return false;
> +
> +	src_id = cxl_rch_get_err_src_id(dsp_addr);
> +	if (!src_id)
> +		return false;
> +
> +	/* Try uncorrectable error source first, then correctable */

I am a little bit confused about this comment and 
cxl_rch_get_err_src_id(). I think aer_err_info->severify idendifies 
current ERR is a correctable error or not.

In cxl_rch_get_err_src_id() always handles UNCOR_ERR before COR_ERR, is 
it possible that getting an UNCOR_ERR src id for a COR_ERR aer_err_info?

E.g. aer_err_info is created for a COR_ERR, but the RCH DSP masks 
PCI_ERR_ROOT_UNCOR_RCV after the aer_err_info created.

Maybe I misunderstand something, please correct me if I am wrong.

Ming

> +	segment = pci_domain_nr(rcec->bus);
> +	bus = FIELD_GET(GENMASK(15, 8), src_id);
> +	devfn = FIELD_GET(GENMASK(7, 0), src_id);
> +
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_get_domain_bus_and_slot(segment, bus, devfn);
> +	if (!pdev)
> +		return false;
> +
> +	cxl_forward_error(dev, info);
> +	return true;
> +}
> +
>   void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>   {
>   	/*
> @@ -141,9 +229,16 @@ void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>   	 * RCH's downstream port. Check and handle them in the CXL.mem
>   	 * device driver.
>   	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> -	    is_aer_internal_error(info))
> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)
> +		return;
> +
> +	if (!is_aer_internal_error(info))
> +		return;
> +
> +	if (cxl_rch_handled_error_by_rdpas(dev, info))
> +		return;
> +
> +	pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>   }
>   
>   static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
