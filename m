Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D653BE62F;
	Thu, 12 Mar 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320488; cv=none; b=ZhJof4MGr+fhFeu0pyd5BzgwvP9SCEK5ewvprECxjmlHOHR4rLp18cqRrsDi1KPJ7+L1ExMK1NcyN2dQ6lNcW9DeL1kBGhskBg0Crd4KAYEpfnT3fkqhoOJqlCJpf6xYItE4lQ2D2Pea35OKSXAjcuEtwCtJe3cWreb/AOxwmiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320488; c=relaxed/simple;
	bh=nj6vi5kyv5gs2YRmJnfboC3GxyNkX1Hv8kAnZZ+y5Js=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajtO9+lShDZS5EuEWXB1jbbWjkJO7mhhjUMyuPZfblHOkkdVOxciOHtdb+Ghli1oADEK1AK3d5JHnLvOHoPB09K8M21piZlB36H6vux0xpnK1zldlMjfoZHd0u9Xfqm+vw7cRlC21XYoShVy0NlpoYh+wi/AVdgsRakkFT8XxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWnlv4Mf7zJ46BP;
	Thu, 12 Mar 2026 21:00:27 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7850B40086;
	Thu, 12 Mar 2026 21:01:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 13:01:14 +0000
Date: Thu, 12 Mar 2026 13:01:13 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <smadhavan@nvidia.com>
CC: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <alwilliamson@nvidia.com>,
	<jeshuas@nvidia.com>, <vsethi@nvidia.com>, <skancherla@nvidia.com>,
	<vaslot@nvidia.com>, <sdonthineni@nvidia.com>, <mhonap@nvidia.com>,
	<vidyas@nvidia.com>, <jan@nvidia.com>, <mochs@nvidia.com>,
	<dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/7] cxl: Add cxl_reset sysfs interface for PCI
 devices
Message-ID: <20260312130113.00006ee2@huawei.com>
In-Reply-To: <20260306092322.148765-7-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
	<20260306092322.148765-7-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 6 Mar 2026 09:23:21 +0000
<smadhavan@nvidia.com> wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Add a "cxl_reset" sysfs attribute to PCI devices that support CXL
> Reset (CXL r3.2 section 8.1.3.1). The attribute is visible only on
> devices with both CXL.cache and CXL.mem capabilities and the CXL
> Reset Capable bit set in the DVSEC.
> 
> Writing "1" to the attribute triggers the full CXL reset flow via
> cxl_do_reset(). The interface is decoupled from memdev creation:
> when a CXL memdev exists, memory offlining and cache flush are
> performed; otherwise reset proceeds without the memory management.
> 
> The sysfs attribute is managed entirely by the CXL module using
> sysfs_create_group() / sysfs_remove_group() rather than the PCI
> core's static attribute groups. This avoids cross-module symbol
> dependencies between the PCI core (always built-in) and CXL_BUS
> (potentially modular).

The side effect being the races that tend to come with dynamic creation
of sysfs. Not sure we can avoid that though.

> 
> At module init, existing PCI devices are scanned and a PCI bus
> notifier handles hot-plug/unplug. kernfs_drain() makes sure that
> any in-flight store() completes before sysfs_remove_group() returns,
> preventing use-after-free during module unload.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

A few trivial things inline.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c758b3f1b3f9..3a53d4314f24 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1293,3 +1293,116 @@ static int cxl_do_reset(struct pci_dev *pdev)
> 
>  	return rc;
>  }
> +
> +/*
> + * CXL reset sysfs attribute management.
> + *
> + * The cxl_reset attribute is added to PCI devices that advertise CXL Reset
> + * capability. Managed entirely by the CXL module via subsys_interface on
> + * pci_bus_type, avoiding cross-module symbol dependencies between the PCI
> + * core (built-in) and CXL (potentially modular).
> + *
> + * subsys_interface handles existing devices at register time and hot-plug
> + * add/remove automatically. On unregister, remove_dev runs for all tracked
> + * devices under bus core serialization.
> + */
> +
> +static bool pci_cxl_reset_capable(struct pci_dev *pdev)
> +{
> +	int dvsec;
> +	u16 cap;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))

Whilst it's a nonsensical setup to have a CXL device with no
CXL features, is there a reason we need this explicit check?

> +		return false;
> +
> +	return !!(cap & PCI_DVSEC_CXL_RST_CAPABLE);

Technically the !! not needed as the cast will deal with it.
If you want to force a 0/1 I'd prefer FIELD_GET()

> +}
> +
> +static ssize_t cxl_reset_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc;
> +
> +	if (!sysfs_streq(buf, "1"))
> +		return -EINVAL;
> +
> +	rc = cxl_do_reset(pdev);
> +	return rc ? rc : count;
> +}
> +static DEVICE_ATTR_WO(cxl_reset);
> +
> +static umode_t cxl_reset_attr_is_visible(struct kobject *kobj,
> +					  struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	if (!pci_cxl_reset_capable(pdev))
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +static struct attribute *cxl_reset_attrs[] = {
> +	&dev_attr_cxl_reset.attr,
> +	NULL,

No comma on a terminating entry. We don't want to make it easy to
add stuff after this!

> +};


