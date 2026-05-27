Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5530C171;
	Wed, 27 May 2026 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889057; cv=pass; b=j1Sba4vlXsKGEnG0mNdoGoaiGsC63HX0eAP4RpBR1shFcocS6LJdbmsyaa9H8Ecm2oFzpOQPI0EZ/5OPyKuXWwPuIrsSY1kYGlxYRO9ENw6fD0xJ435eF4e4lRttHF0b94eKQDUjFQkfajoN18hOlGvnjeQNviCLFoeqKr/OVNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889057; c=relaxed/simple;
	bh=iiCwQSQj9XEY7v2c0C7IOre43ZqUuCWL32l0DXPXmCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6/gY1+Bl8fxc28XHQpTa4sGm7emBehy0x2ZeJn0Wm+A/YTdh2G0Pp3VIylA/XsOIYe/lV0ckEqeRGVCtDPXyINaqHfJJFouVNfe7sFn8cWb5svxfQAky5tM9PGh5PthwEL/FeOKel+hMp+rY23nnJJ9nCKI9uskGiWag8f/zcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=AitGdRnQ; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="AitGdRnQ"
ARC-Seal: i=1; a=rsa-sha256; t=1779889050; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gz3dLzYhGknAIf8CFY+TvjCC31Jk8A9vJPKPcxjvoVSYDhOifeXXvxaFvBgTasJJDSIbAuPAlXB1676qH4WpShaV87pRxCRWM5YHPnOtjLvoTrcWhywRP6GSsP9DrSmRN9WLDTDlNsEOn3mTTB/I9/9U6ISnxx4lX5dQR0dNivU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779889050; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WAVOwcUxGJhS2DUD8KtJbngHj7KEPm8W+Ld4oyz1amc=; 
	b=Vu7XVPutUWcWScR/49lJvXJ9tTFh3Ki07aSEHAKpJEuDTWkX15WIRNEYy629R9u3s19E0kfyk5vgGfYhKIrTqeXcr1pcfrDT+wkV3T3anZ0rxkw2P48gha4iX4+fyz4SYD4oHp8Qh5tER+eO8AibQdvYYO0Bax/mVSd9S4WZrLk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779889050;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=WAVOwcUxGJhS2DUD8KtJbngHj7KEPm8W+Ld4oyz1amc=;
	b=AitGdRnQAeCAkgpWmXApg/0ue+Z4KLigzduxbaH6PLx3LOCixLhplmOGWNAb1Of5
	OyJ0eifMETE85b4jlezjmJwst7ACQjr37Bo7+FrK6o4C2L7atyV2K/BurrYkwcSZPM1
	EVCSX7sE6IhYdtcUngVdHB9CAASZZHOEzz85lHOg=
Received: by mx.zohomail.com with SMTPS id 1779889047628773.4845996551059;
	Wed, 27 May 2026 06:37:27 -0700 (PDT)
Message-ID: <70d15a21-ff90-40b8-a01f-479f9c3a1d51@zohomail.com>
Date: Wed, 27 May 2026 21:37:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] PCI/CXL: Add RDPAS parsing support
To: Dave Jiang <dave.jiang@intel.com>
Cc: terry.bowman@amd.com, bhelgaas@google.com, jic23@kernel.org,
 djbw@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260526182334.1010870-1-dave.jiang@intel.com>
 <20260526182334.1010870-2-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260526182334.1010870-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227af599039e22c4c3179279c230000ab5103949d875689cbb1e89f310a916755973ec7e441827ae6:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/5/27 02:23, Dave Jiang 写道:
> Add parsing of the RCEC Downstream Port Association Structure (RDPAS),
> which is a structure defined in the CXL spec r4.0 9.18.1.5. This
> structure allows error handler to locate the downstream port(s)
> that report errors to a given Root Complex Event Collector (RCEC).
> The structure is part of CXL Early Discovery Table (CEDT) and can
> be parsed like other CEDT tables.
>
> A base address is provided in the RDPAS structure where depending on
> the protocol field, it is the RCRB base associated with the downstream
> port for CXL.io or the Component Base Register base associated with the
> downstream port for CXL.cachemem.
>
> The 64bit address of the base address field will be stored in an xarray
> indexed by the combination of the RCEC segment plus the BDF in a 32bit
> field. Currently only the CXL.io base address will be stored. If the
> protocol is CXL.cachemem, there is no way to retrieve a source id and
> therefore identifying the BDF of the error device.
>
> A helper is also added to retrieve the base address based on the segment
> and BDF of the RCEC.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[...]
> +static int __cxl_parse_rdpas(struct acpi_cedt_rdpas *rdpas, struct device *dev)
> +{
> +	unsigned long index;
> +	int rc;
> +
> +	/* Skip CXL.cachemem as the current RDPAS scheme only supports CXL.io */
> +	if (rdpas->protocol != CXL_RDPAS_PROTO_IO)
> +		return 0;
> +
> +	u64 *addr __free(kfree) = kzalloc(sizeof(*addr), GFP_KERNEL);
> +	if (!addr)
> +		return -ENOMEM;
> +
> +	*addr = rdpas->address;
> +
> +	index = __rdpas_index(rdpas->segment, rdpas->bdf);
> +	rc = xa_insert(&cxl_rdpas, index, addr, GFP_KERNEL);
> +	if (rc) {
> +		if (rc != -EBUSY)
> +			return rc;
> +
> +		dev_dbg(dev, "Duplicate RDPAS: PCI %04x:%02lx:%02lx.%ld\n",
> +			rdpas->segment, FIELD_GET(GENMASK(15, 8), rdpas->bdf),
> +			FIELD_GET(GENMASK(7, 3), rdpas->bdf),
> +			FIELD_GET(GENMASK(2, 0), rdpas->bdf));
> +		return 0;
> +	}
> +
> +	retain_and_null_ptr(addr);

Miss releasing implementation for the added entry?

Or should destroy xarray in cxl_acpi_exit()?

> +	dev_dbg(dev, "RDPAS entry: PCI %04x:%02lx:%02lx.%ld -> CXL addr %016llx\n",
> +		rdpas->segment, FIELD_GET(GENMASK(15, 8), rdpas->bdf),
> +		FIELD_GET(GENMASK(7, 3), rdpas->bdf),
> +		FIELD_GET(GENMASK(2, 0), rdpas->bdf),
> +		rdpas->address);
> +
> +	return 0;
> +}
> +
> +int cxl_parse_rdpas(union acpi_subtable_headers *header, void *arg,
> +		    const unsigned long end)
> +{
> +	struct acpi_cedt_rdpas *rdpas = (struct acpi_cedt_rdpas *)header;
> +	struct device *dev = arg;
> +
> +	return __cxl_parse_rdpas(rdpas, dev);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_parse_rdpas, "cxl_acpi");
> +
> +static int __maybe_unused cxl_get_rdpas_by_rcec(struct pci_dev *rcec, u64 *dsp_addr)
> +{
> +	u64 index;
> +	u64 *addr;
> +
> +	index = rdpas_index(pci_domain_nr(rcec->bus), rcec->bus->number,
> +			    PCI_SLOT(rcec->devfn), PCI_FUNC(rcec->devfn));
> +	addr = xa_load(&cxl_rdpas, index);
> +	if (!addr)
> +		return -ENOENT;
> +
> +	*dsp_addr = *addr;
> +
> +	return 0;
> +}
> +
>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>   {
>   	/*
