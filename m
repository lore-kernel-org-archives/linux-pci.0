Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD41EEC3;
	Fri,  1 May 2026 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777672749; cv=none; b=LolYFe+VhxTHRGYb7qRp3fTB0rzDdMxoxHXsEuYE+sPyspXy4gvnYDK5f/yjnrCHfL1sEof1fg1iTTy3AaLXBKizfQGQlFNiNEUW7MZzxbtaFcEViCK7AU6SFdr2UStQCMRelFjBZ+7Jo9T6Law8qfpllNdB5jqLOsyza2gCmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777672749; c=relaxed/simple;
	bh=PGLbM1CLRSz9m/4TlhBr2xxQfIuz38mtYNhHxoGRA70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTVAhtbmfMurCLNT5/zESVhDg7wYZpfLR3LCaHVawMcbKSFtZQN62ePugByg5CiMGZD64W2fw2QxOc6fZM0p2TDsULiipyp2Pk9DqqsmF9oZMNNAhTy4FcdFbEOvfs7eCWYVaYA9CRWSXFtj8pZpdY4riNdKh9CMOo9kJ7LWnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aACT0Uin; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aACT0Uin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777672747; x=1809208747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PGLbM1CLRSz9m/4TlhBr2xxQfIuz38mtYNhHxoGRA70=;
  b=aACT0UinXNdAiovAtgAq1mtoVNppySiICdkeEy/fLt6mPHfzwRjI5eRz
   ErszxTmV+5Ecxwln61fWacaKM75Q9Ie2e8HAmYgNwopD1qnAqpTXVFFha
   lc6P5nToUUPJGeMGMzecSh2Bb9rDwqkPnFwt+pnjXmkNWKDhSGK/MeQM4
   yTu5igN4NN1i+Gp07ySREBlHMjdB6XlYnBjsV0VYde0egW8hPvtK8f0vZ
   a14S3SR45nfbd2ZAklmk++Ruz3CkJ6EYIXfRYzfmozJlljhGfBpsKarvL
   ijKot588w5OgXFEHGVr419l/4yzrQ0JJvfO0igsm+Cfj3lO7V5TARm8ui
   g==;
X-CSE-ConnectionGUID: 1XlJcdIjTBi89DQ+wdXjZA==
X-CSE-MsgGUID: B5T1SsatRGmZCHsIL9pMsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="78735603"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="78735603"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 14:59:07 -0700
X-CSE-ConnectionGUID: NmYVyVIvSKObCeUw92RZxQ==
X-CSE-MsgGUID: CcU2YgLaT12fFAJAneQzlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="238939601"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.150]) ([10.125.109.150])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 14:59:05 -0700
Message-ID: <29e1fb6f-19b4-4aa8-9475-5feb10c60c71@intel.com>
Date: Fri, 1 May 2026 14:59:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cxl/core: Recover from PM Init failure via
 cxl_reset_bus_function()
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260428182454.464655-1-fabio.m.de.francesco@linux.intel.com>
 <20260428182454.464655-3-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260428182454.464655-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/26 11:24 AM, Fabio M. De Francesco wrote:
> CXL r4.0 sec 8.1.5.1 Implementation Note describes a scenario in which a
> Secondary Bus Reset, a Link Down, or Downstream Port Containment on a
> CXL Downstream Port prevents Port PM Init from completing when ACS
> Source Validation is enabled.
> 
> During CXL enumeration, for each CXL Downstream Port in a memdev's
> ancestry, check whether PM Init has completed. If it has not, invoke
> cxl_reset_bus_function() which is exported for use by CXL.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/pci.c        | 30 ++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c       | 22 ++++++++++++++++++++++
>  drivers/cxl/cxlpci.h          |  3 +++
>  drivers/pci/pci.c             |  3 ++-
>  include/linux/pci.h           |  1 +
>  include/uapi/linux/pci_regs.h |  2 ++
>  6 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..de6a317df650 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -926,3 +926,33 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +
> +/**
> + * cxl_port_pm_init_is_complete - check the downstream port's PM Init Complete
> + * @pdev: downstream port
> + *
> + * Read the Port Power Management Initialization Complete bit in the
> + * Downstream Port's CXL DVSEC Port Extended Status register.
> + *
> + * Return: false only when the bit is observably clear. Return true when PM
> + * init is complete, when @pdev is not a CXL port (no Port DVSEC), or when
> + * the status register cannot be read.
> + */
> +bool cxl_port_pm_init_is_complete(struct pci_dev *pdev)
> +{
> +	u16 status;
> +	u16 dvsec;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_PORT);
> +	if (!dvsec)
> +		return true;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_PORT_EXT_STATUS,
> +				  &status);
> +	if (rc || PCI_POSSIBLE_ERROR(status))
> +		return true;
> +
> +	return !!FIELD_GET(PCI_DVSEC_CXL_PORT_EXT_STATUS_PM_INIT_COMP, status);
> +}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c5aacd7054f1..a91841855d3b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1825,6 +1825,28 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		if (is_cxl_host_bridge(dport_dev))
>  			return 0;
>  
> +		/*
> +		 * Check the downstream port's PM init status, and if it has
> +		 * failed retry PM init according to CXL Spec. 4.0 Sect. 8.1.5.1
> +		 * - Implementation Note
> +		 */
> +		if (dev_is_pci(dport_dev) && dev_is_pci(iter->parent)) {
> +			struct pci_dev *dport_pdev = to_pci_dev(dport_dev);
> +
> +			if (!cxl_port_pm_init_is_complete(dport_pdev)) {
> +				dev_dbg(&cxlmd->dev,
> +					"PM init failed for %s, retrying PM init\n",
> +					dev_name(dport_dev));
> +
> +				cxl_reset_bus_function(to_pci_dev(iter->parent), false);
> +
> +				if (!cxl_port_pm_init_is_complete(dport_pdev))
> +					dev_dbg(&cxlmd->dev,
> +						"PM init failed retry for %s\n",
> +						dev_name(dport_dev));
> +			}
> +		}

Make this a helper function and move it to core/pci.c. Also pass 'struct device' and not 'struct pci_dev' to that function.

I do wonder if you reset it here, maybe you need to restart enumeration from the endpoint instead of just continuing as if nothing happened.

DJ

> +
>  		uport_dev = dport_dev->parent;
>  		if (!uport_dev) {
>  			dev_warn(dev, "at %s no parent for dport: %s\n",
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index b826eb53cf7b..c66ff2ce82a3 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -114,4 +114,7 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
>  
>  int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		       struct cxl_register_map *map);
> +
> +bool cxl_port_pm_init_is_complete(struct pci_dev *pdev);
> +
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 047d3b4508a5..ae30da22daf4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4974,7 +4974,7 @@ static void cxl_restore_acs_sv_bme(struct pci_dev *bridge, u16 saved_cmd,
>   * Return: 0 on success, -ENOTTY if the reset cannot be issued, or an
>   * errno from the reset path.
>   */
> -static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
> +int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
>  	struct pci_dev *bridge;
>  	u16 dvsec, reg, val;
> @@ -5023,6 +5023,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	pci_dev_reset_iommu_done(dev);
>  	return rc;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_reset_bus_function, "CXL");
>  
>  void pci_dev_lock(struct pci_dev *dev)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c11..1fb1360d41e8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1477,6 +1477,7 @@ int pci_probe_reset_slot(struct pci_slot *slot);
>  int pci_probe_reset_bus(struct pci_bus *bus);
>  int pci_reset_bus(struct pci_dev *dev);
>  void pci_reset_secondary_bus(struct pci_dev *dev);
> +int cxl_reset_bus_function(struct pci_dev *dev, bool probe);
>  void pcibios_reset_secondary_bus(struct pci_dev *dev);
>  void pci_update_resource(struct pci_dev *dev, int resno);
>  int __must_check pci_assign_resource(struct pci_dev *dev, int i);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350..7e2579f89041 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1369,6 +1369,8 @@
>  
>  /* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
>  #define PCI_DVSEC_CXL_PORT				3
> +#define  PCI_DVSEC_CXL_PORT_EXT_STATUS			0x0A
> +#define   PCI_DVSEC_CXL_PORT_EXT_STATUS_PM_INIT_COMP	_BITUL(0)
>  #define  PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define   PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>  

