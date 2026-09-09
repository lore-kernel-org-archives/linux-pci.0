Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7E37AA70;
	Wed,  9 Sep 2026 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941652; cv=none; b=ipLOt617Qst8t0uMCiTDxXEkJd07ZLKx99X3IjiAcjXkkSRyBSnYuLRHV+Nrt5A5iutnvQfYPJEltea62IagH4Em4+//Bm618M+hzScfismByJPx3/PWp4BGGBFhmkije+aQ8i3MfNjWb032VTtn7vA6kLnH2JRDiaMGnLQqtsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941652; c=relaxed/simple;
	bh=ihZOp4oyeZS4Z2ZWTgGV2B7VCxDptNH5JQRKp4U+Ysw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+vBe68o3c7Tle8LoZ/pLgKl445T3iltpT34l2aeJYdov3D3+nuxFG/DqJbFzyMrqEVxyFh66EfgDsl3k4kpY4L1nplUNXdegUU3WBg1SxGCSYTXjnLDS4PR2Nsixcbhb3ajbmrXfu9YLyyhhndtadTOH0Ylhhr6i5Da+4NIk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id EAC9018D3;
	Wed, 09 Sep 2026 10:14:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 94F4A627236D; Wed,  9 Sep 2026 10:14:06 +0200 (CEST)
Date: Wed, 9 Sep 2026 10:14:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
	alison.schofield@intel.com, bhelgaas@google.com,
	shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	PradeepVineshReddy.Kodamati@amd.com, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
Message-ID: <aqEVTjjAtLYX19Rk@wunner.de>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-11-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-11-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:31PM -0600, Terry Bowman wrote:
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -123,4 +123,13 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
>  #endif /* !CONFIG_PCIE_PME */
>  
>  struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
> +
> +struct aer_err_info;
> +
> +#ifdef CONFIG_PCIEAER_CXL
> +bool is_aer_internal_error(struct aer_err_info *info);
> +#else
> +static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
> +#endif /* CONFIG_PCIEAER_CXL */
> +
>  #endif /* _PORTDRV_H_ */

This has no relation to portdrv and so it's unclear and confusing
why it was placed in portdrv.h.

In your pending CXL AER v20 series, you're adding more declarations here.

We keep declarations that are internal to the PCI core in
drivers/pci/pci.h.  However since this is just an interface
between aer.c and aer_cxl_rch.c, maybe drivers/pci/pcie/aer_cxl.h
would make sense.

Thanks,

Lukas
