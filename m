Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5D1A8F7B
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678064; cv=none; b=QTZ4HpRRgF8E+vV5DUU3UCSuZwhVe8mTJqtMarAvtfsN9JPXdZYMoPz8Op/MuIlRCJi5J2tBfPWJfJE2/MVm3eRGz7wNH1Z2b5WUdFNHLpLLiw/ooX1d5z7uW/1M3FcEXV99lougGaJOu++5uB5SKCGzzut+sykpg37R4F1Gljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678064; c=relaxed/simple;
	bh=2k5q00p8L2SCLrIAB5imsL6AkKQY6Gzh059g+5BeG2w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RQAKWKQLz8M38bX1afeZMkGNc3DN3Fd9aNq03UT/vGDPLM+p/FiM96O0IH87C14Xk50QAWUDfahthGIiekfyFuVR3bVlHKBEc7YDFZpGFTK0VdldGlHGxnnqLiQhiD52LQlxnWJu36coeBZ1IUi94wnuu/GDNd0BC0HK+GVtRis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpK1WTsd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpK1WTsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D28AC2BCB4;
	Fri,  1 May 2026 23:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678063;
	bh=2k5q00p8L2SCLrIAB5imsL6AkKQY6Gzh059g+5BeG2w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GpK1WTsdYFhkQb0stH7wNNsrKIrKqEtaXpi9/uDZCt6BTrZQ/He5NU6QAwLlnoLwC
	 guztffc7OZxlBaMIA9GgkUmNak6mZ0l6v/SH2BubVjYHSapzqR07sJtenDlLjb0Vrf
	 v7E19++DWZxAQljDbzWC2g6cDaNL4h2ZNp3GUom+nSceiT02UMxYF1c7bzVKCQJi7w
	 LhZSFokhuaklTiveWalu1i9UIbtf7EzuBvHSl6Tn8WpWJECAmwOOkZeG2+YOFpRNQC
	 FdFRSQyOL7IBFs1To1+z1lE46+H5yQFJkQZMV7pLy8Zey+hDZ/6QYdNFDysU++zY6d
	 NTW4EPoONmbRA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id A88FDF40068;
	Fri,  1 May 2026 19:27:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 01 May 2026 19:27:42 -0400
X-ME-Sender: <xms:7jb1acHY-tPHMvyM98Jqckvdort1JVM99gSyfPMsEDUEEqUbN5gJcQ>
    <xme:7jb1acZG05AiWaobmeQsjEXn-98j1WHrGb-VSSRg-QhDdU4c6ZbZ71W-zZCFNzgcP
    hsATR-XUCjE1wPvKH-tsF2n5eZQAociU5IiwePTIZ6RMgI-mJkYng4K>
X-ME-Received: <xmr:7jb1ad0n3Xd6f7-Z65FKboAL6YNLzkFObSdXGqjzz9Ahin0-X8SPDiE_MFwfOjxAph1BtznRROZL2BxS1XNUm2Ti32Gg4nCO8Zc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeludehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpedfffgrnhcuhghi
    lhhlihgrmhhsucdlnhhvihguihgrmddfuceoughjsgifsehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepvdegheeikeetleeuffeuheefjeejvdejvdevteefgfffveeh
    vdeuvdffveffvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepughjsgifodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqddujeej
    vdeftdegheehqdeffeefleegtdegjedqughjsgifpeepkhgvrhhnvghlrdhorhhgsehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehnihgtohhlihhntgesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
    epughjsgifsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjghhgsehnvhhiughirgdr
    tghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprh
    hosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghs
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpd
    hrtghpthhtohepphhrrggrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggrohhl
    uhdrlhhusehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:7jb1aUc7xep8-XO8N2WGdSLCmHALigT1u79gu81zGLEbTP19kskZDg>
    <xmx:7jb1afAUat8iHAecyPX4xjpsjKHL7MLEgoZRwuNvZJIdGN1dLsSPFw>
    <xmx:7jb1aW07DHrU6-JbKte1wiE-7EtcH2ze9v0pvjWzc_PNyAFr1HPPzg>
    <xmx:7jb1afM_RN63IDbTfXgJndsz4SEIBN-UAnwcJ9lMdpGEKCGKX38t5A>
    <xmx:7jb1aUc0Q01sB9YnmfYzZ1DP9YbWSwcXE7IeewNI6Ru4D3cN50Vq79pG>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 19:27:42 -0400 (EDT)
Date: Fri, 01 May 2026 16:27:41 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: jgg@nvidia.com, 
 will@kernel.org, 
 robin.murphy@arm.com, 
 bhelgaas@google.com, 
 joro@8bytes.org, 
 praan@google.com, 
 baolu.lu@linux.intel.com, 
 kevin.tian@intel.com, 
 miko.lenczewski@arm.com, 
 linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 dan.j.williams@intel.com, 
 jonathan.cameron@huawei.com, 
 vsethi@nvidia.com, 
 linux-cxl@vger.kernel.org, 
 nirmoyd@nvidia.com
Message-ID: <69f536ed263dd_3291a910017@djbw-dev.notmuch>
In-Reply-To: <afPlkW5zlTSHwQCT@Asurada-Nvidia>
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
 <69f3cc82926_3291a910039@djbw-dev.notmuch>
 <afPlkW5zlTSHwQCT@Asurada-Nvidia>
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Nicolin Chen wrote:
> On Thu, Apr 30, 2026 at 02:41:22PM -0700, Dan Williams (nvidia) wrote:
> > > +static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
> > > +{
> > > +	int offset;
> > > +	u16 cap;
> > > +
> > > +	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > > +					   PCI_DVSEC_CXL_DEVICE);
> > > +	if (!offset)
> > > +		return false;
> > > +
> > > +	if (pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap))
> > > +		return false;
> > > +
> > > +	return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
> [...]
> > Apologies for coming to this late and forgive me if the following has
> > already been asked and answered. Why not check for actual CXL.cache
> > protocol on the wire being present?
> 
> Actually it would make the patch smaller. The thing is that this
> is_cxl property wasn't added when I started the series. So, it's
> not using it. :)
> 
> > @@ -1733,9 +1733,8 @@ static void set_pcie_cxl(struct pci_dev *dev)
> >  	pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS,
> >  			     &cap);
> >  
> > -	dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_CACHE, cap) ||
> > -		FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_MEM, cap);
> > -
> > +	dev->is_cxl_cache = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_CACHE, cap);
> > +	dev->is_cxl_mem = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_MEM, cap);
> 
> One caveat is that:
> 
> Here it checks the cap from:
> 	PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS (0xE) via
> 		PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS (0x7)
> 
> On the other hand, mine checks from:
> 	PCI_DVSEC_CXL_CAP (0xA) via
> 		PCI_DVSEC_CXL_DEVICE (0x0)
> 
> The spec mentions in 8.2.1.3.1 DVSEC Flex Bus Port Capability: "
>   Note: The Mem_Capable, IO_Capable, and Cache_Capable fields are
>   also present in the DVSEC Flex Bus for the device [which is the
>   legacy name for DVSEC 0x0]. This allows for future scalability
>   where multiple devices, each with potentially different
>   capabilities, may be populated behind a single Port.
> "
> 
> Not arguing that set_pcie_cxl() is wrong, but I am not sure if there
> would be any side effect to rely on the "legacy name" over DVSEC 0x0.
> 
> Is there any CXL expert who can help confirm?

You appear to be confusing Cache_Capable and Cache_Enabled.

"8.2.1.3.1 DVSEC Flex Bus Port Capability" != "8.2.1.3.3 DVSEC Flex Bus Port Status"

Cache_Capable is only a capability. To check that the device has
actually trained the CXL.cache alternate protocol you need to look at
the status register.
