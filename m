Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22003D3486;
	Wed, 21 Jan 2026 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989796; cv=none; b=Fck3q7qcVr1hGLjosYRJgDkKPNKfZfbmIT3PkPbq87D4hDqwceYn0+Zj9wD5PhTbL1YB0Omak3oTowDvipEQsdUD+uiD3b+e2mmemCF7thb4BtU85MEgu6+ovCJJSCJujn3IOoZop5yYco9SmfNwMPSNrGRms6i+eFSmv+IfQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989796; c=relaxed/simple;
	bh=SJDG0zKTxQAYGuRzI2QN/I/f6dS+vRmyBTh9Gqbke2k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVaOwA6MbEvwPKFdYsB4tzH6mG6R/tprMsnESCXPm11jIF1ilblCs9oa7D+SlH43H0LQbNI1MWbGs8qIznRrbjrkngiM8FEUI+7nZuBJsQBCCEsRwKkINE1XW/IY0+21juXn5FFjtRbX/kzG0wTJyfUTuBFUKoz+63gPLITsfzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx09m32w0zHnHCX;
	Wed, 21 Jan 2026 18:02:36 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id E48EE40570;
	Wed, 21 Jan 2026 18:03:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 10:03:09 +0000
Date: Wed, 21 Jan 2026 10:03:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260121100307.00004e60@huawei.com>
In-Reply-To: <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
	<d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
	<BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 21 Jan 2026 08:01:36 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> +Dan. I recalled an offline discussion in which he raised concern on
> having the kernel blindly enable ATS for cxl.cache device instead of
> creating a knob for admin to configure from userspace (in case
> security is viewed more important than functionality, upon allowing
> DMA to read data out of CPU caches)...
> 

+CC Linux-cxl

Jonathan


> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, January 17, 2026 12:57 PM
> > 
> > Controlled by the IOMMU driver, ATS is usually enabled "on demand", when
> > a
> > device requests a translation service from its associated IOMMU HW running
> > on the channel of a given PASID. This is working even when a device has no
> > translation on its RID, i.e. RID is IOMMU bypassed.
> > 
> > On the other hand, certain PCIe device requires non-PASID ATS, when its RID
> > stream is IOMMU bypassed. Call this "always on".
> > 
> > For instance, the CXL spec notes in "3.2.5.13 Memory Type on CXL.cache":
> > "To source requests on CXL.cache, devices need to get the Host Physical
> >  Address (HPA) from the Host by means of an ATS request on CXL.io."
> > In other word, the CXL.cache capability relies on ATS. Otherwise, it won't
> > have access to the host physical memory.
> > 
> > Introduce a new pci_ats_always_on() for IOMMU driver to scan a PCI device,
> > to shift ATS policies between "on demand" and "always on".
> > 
> > Add the support for CXL.cache devices first. Non-CXL devices will be added
> > in quirks.c file.
> > 
> > Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  include/linux/pci-ats.h       |  3 +++
> >  include/uapi/linux/pci_regs.h |  5 ++++
> >  drivers/pci/ats.c             | 44 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 52 insertions(+)
> > 
> > diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> > index 75c6c86cf09d..d14ba727d38b 100644
> > --- a/include/linux/pci-ats.h
> > +++ b/include/linux/pci-ats.h
> > @@ -12,6 +12,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps);
> >  void pci_disable_ats(struct pci_dev *dev);
> >  int pci_ats_queue_depth(struct pci_dev *dev);
> >  int pci_ats_page_aligned(struct pci_dev *dev);
> > +bool pci_ats_always_on(struct pci_dev *dev);
> >  #else /* CONFIG_PCI_ATS */
> >  static inline bool pci_ats_supported(struct pci_dev *d)
> >  { return false; }
> > @@ -24,6 +25,8 @@ static inline int pci_ats_queue_depth(struct pci_dev *d)
> >  { return -ENODEV; }
> >  static inline int pci_ats_page_aligned(struct pci_dev *dev)
> >  { return 0; }
> > +static inline bool pci_ats_always_on(struct pci_dev *dev)
> > +{ return false; }
> >  #endif /* CONFIG_PCI_ATS */
> > 
> >  #ifdef CONFIG_PCI_PRI
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 3add74ae2594..84da6d7645a3 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -1258,6 +1258,11 @@
> >  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
> >  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> > 
> > +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> > +#define CXL_DVSEC_PCIE_DEVICE				0
> > +#define   CXL_DVSEC_CAP_OFFSET				0xA
> > +#define     CXL_DVSEC_CACHE_CAPABLE			BIT(0)
> > +
> >  /* Integrity and Data Encryption Extended Capability */
> >  #define PCI_IDE_CAP			0x04
> >  #define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > index ec6c8dbdc5e9..1795131f0697 100644
> > --- a/drivers/pci/ats.c
> > +++ b/drivers/pci/ats.c
> > @@ -205,6 +205,50 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
> >  	return 0;
> >  }
> > 
> > +/*
> > + * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source
> > requests on
> > + * CXL.cache, devices need to get the Host Physical Address (HPA) from the
> > Host
> > + * by means of an ATS request on CXL.io.
> > + *
> > + * In other world, CXL.cache devices cannot access physical memory
> > without ATS.
> > + */
> > +static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
> > +{
> > +	int offset;
> > +	u16 cap;
> > +
> > +	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > +					   CXL_DVSEC_PCIE_DEVICE);
> > +	if (!offset)
> > +		return false;
> > +
> > +	pci_read_config_word(pdev, offset + CXL_DVSEC_CAP_OFFSET,
> > &cap);
> > +	if (cap & CXL_DVSEC_CACHE_CAPABLE)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +/**
> > + * pci_ats_always_on - Whether the PCI device requires ATS to be always
> > enabled
> > + * @pdev: the PCI device
> > + *
> > + * Returns true, if the PCI device requires non-PASID ATS function on an
> > IOMMU
> > + * bypassed configuration.
> > + */
> > +bool pci_ats_always_on(struct pci_dev *pdev)
> > +{
> > +	if (pci_ats_disabled() || !pci_ats_supported(pdev))
> > +		return false;
> > +
> > +	/* A VF inherits its PF's requirement for ATS function */
> > +	if (pdev->is_virtfn)
> > +		pdev = pci_physfn(pdev);
> > +
> > +	return pci_cxl_ats_always_on(pdev);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ats_always_on);
> > +
> >  #ifdef CONFIG_PCI_PRI
> >  void pci_pri_init(struct pci_dev *pdev)
> >  {
> > --
> > 2.43.0  
> 
> 

