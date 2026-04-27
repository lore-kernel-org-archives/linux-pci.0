Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62D93A9D8B;
	Mon, 27 Apr 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323392; cv=none; b=P3g1iFbLwv79Lit6CHDeB8Pv8g0+JHpf1JqWNz1h/zlqA9z/U8z30qGNgDWO1NFzc8xo0xFlRx8yjJRxrXNN+wLzAyv0UZlusSrDcdWPXYDHiw2uCA5YkBsYi+hH/dLVznULANSVZYITri1kK6f+745kamtN9FMvMV3bGIn6LQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323392; c=relaxed/simple;
	bh=Sc3eIFNVvhEoZXn/JdBRF/OA3UoVeO6ICBTHeMO+Wk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMDCGwouYbFd8RLGIrRHpwRZ20LheXxy46GmgnrrcGPH4CDkkYsHeIiNmcQ7nGvgK8CuFP34u0hZCVXljHMr7G4cTOsS+a6vOgWhKaBWe5ckknCrnKOynyod6sKXrA37rAMD2RTLpBfzOBiQ8FfgOIVW0llgxwm6305Cy7D5dwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g3klIaNv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g3klIaNv"
Received: from localhost (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 80A2820B716A;
	Mon, 27 Apr 2026 13:56:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80A2820B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777323389;
	bh=w4+T1q5j1gjl12AzNykoZ9kgKNsM0AyLqJTGq2x4mJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g3klIaNv0aZDwiuY6aSr9d1ovw1UNaC1yS0v955Li3fu510xl6luT8FxEwoEqgsV9
	 qO5XgODem35nBKQSBw1Y/oPQwo73ezTIvaKLd6m9LDkmCPmXDtkuNmar6v6P8E4uZZ
	 NJTPwgA90pNAQX3lXJdDUBe1VtE8QmuErhznSO4I=
Date: Mon, 27 Apr 2026 13:56:25 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex
 Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris
 Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet
 <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky
 <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport
 <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja
 <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Will Deacon
 <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu
 <yi.l.liu@intel.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
Message-ID: <20260427135625.0000413e@linux.microsoft.com>
In-Reply-To: <20260423212316.3431746-9-dmatlack@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
	<20260423212316.3431746-9-dmatlack@google.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi David,

On Thu, 23 Apr 2026 21:23:12 +0000
David Matlack <dmatlack@google.com> wrote:

> Restrict support for preserving PCI devices across Live Update to
> devices in immutable singleton IOMMU groups. A device's group is
> considered immutable if all bridges upstream from the device up to the
> root port have the required ACS features enabled.
> 
> Since ACS flags are inherited across a Live Update for preserved
> devices and all the way up to the root port, the preserved device
> should be in a singleton IOMMU group after kexec in the new kernel.
> 
> This change should still permit all the current use-cases for PCI
> device preservation across Live Update, since it is intended to be
> used in Cloud enviroments which should have the required ACS features
> enabled for virtualization purposes.
> 
> If a device is part of a multi-device IOMMU group, preserving it will
> now fail with an error. This restriction may be lifted in the future
> if support for preserving multi-device groups is desired.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/iommu/iommu.c    | 35 +++++++++++++++++++++++++++++++++++
>  drivers/pci/liveupdate.c |  6 ++++++
>  include/linux/iommu.h    |  7 +++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 61c12ba78206..782e73a9d45f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1664,6 +1664,41 @@ struct iommu_group *pci_device_group(struct
> device *dev) }
>  EXPORT_SYMBOL_GPL(pci_device_group);
>  
> +bool pci_device_group_immutable_singleton(struct pci_dev *dev)
> +{
> +	struct iommu_group *group;
> +	struct group_device *d;
> +	struct pci_bus *bus;
> +	int nr_devices = 0;
> +
> +	group = iommu_group_get(&dev->dev);
> +	if (!group)
> +		return false;
This may not work for noiommu mode where we could have a null group.
Maybe I can add special case later?

> +	mutex_lock(&group->mutex);
> +
> +	for_each_group_device(group, d)
> +		nr_devices++;
> +
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
nit:
	scoped_guard(mutex, &group->mutex) {
        	for_each_group_device(group, d)
                	nr_devices++;
 	}
> +
> +	if (nr_devices != 1)
> +		return false;
> +
> +	for (bus = dev->bus; !pci_is_root_bus(bus); bus =
> bus->parent) {
> +		if (!bus->self)
> +			continue;
> +
> +		if (!pci_acs_path_enabled(bus->self, NULL,
> REQ_ACS_FLAGS))
> +			return false;
> +
> +		break;
> +	}
> +
> +	return true;
> +}
> +
>  /* Get the IOMMU group for device on fsl-mc bus */
>  struct iommu_group *fsl_mc_device_group(struct device *dev)
>  {
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index a9a89f7bd3e5..54a90ff02bdd 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -133,6 +133,7 @@
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
>  
>  #include <linux/io.h>
> +#include <linux/iommu.h>
>  #include <linux/kexec_handover.h>
>  #include <linux/kho/abi/pci.h>
>  #include <linux/liveupdate.h>
> @@ -359,6 +360,11 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
>  	if (dev->is_virtfn)
>  		return -EINVAL;
>  
> +	if (!pci_device_group_immutable_singleton(dev)) {
> +		pci_warn(dev, "Device preservation limited to
> immutable singleton iommu groups\n");
> +		return -EINVAL;
> +	}
> +
>  	if (dev->liveupdate_outgoing)
>  		return -EBUSY;
>  
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e587d4ac4d33..6f5d1dec3f89 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1096,6 +1096,8 @@ extern struct iommu_group
> *generic_device_group(struct device *dev); struct iommu_group
> *fsl_mc_device_group(struct device *dev); extern struct iommu_group
> *generic_single_device_group(struct device *dev); 
> +bool pci_device_group_immutable_singleton(struct pci_dev *dev);
> +
>  /**
>   * struct iommu_fwspec - per-device IOMMU instance data
>   * @iommu_fwnode: firmware handle for this device's IOMMU
> @@ -1528,6 +1530,11 @@ static inline int
> pci_dev_reset_iommu_prepare(struct pci_dev *pdev) static inline void
> pci_dev_reset_iommu_done(struct pci_dev *pdev) {
>  }
> +
> +static inline bool pci_device_group_immutable_singleton(struct
> pci_dev *dev) +{
> +	return false;
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  #ifdef CONFIG_IRQ_MSI_IOMMU

