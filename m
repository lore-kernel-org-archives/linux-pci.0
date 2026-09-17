Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083349739D;
	Thu, 17 Sep 2026 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676267; cv=none; b=tBW8pgz5CMsiGHWEZlVNz2NIEL/GA3S7PiPWImjPCAap5eclo2/k3VPtqG5/Bv0SFFGoLhV2gUC7ks0u8lDjleDpo6bfSVzGLuQR9EgLFs9xa4+4uIU4hbLxS/UwC+9euK//XZbxS6OwHvXItK5FGM7JE71adOlECvb/51NG+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676267; c=relaxed/simple;
	bh=pSHrLFOLdJhOymuWsycPX3NAKxxuihciLly/eexYdlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zeol2HD1K8ILBYFKSE6rH5kdQCETBRdwuw2EFzJvFndavv5STSarX3Rzzp98E8O3/hN1Pa1qmt+6hnqaDSocKMoYyaCdJt31yFmE2svcJk1JfUPp7UenYQPE7Xck+RNE5zhnrl5qNoKdeitr+x54qEdZXABbfENn6IgYymsqNew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cifno/se; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cifno/se"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BD01F000FF;
	Thu, 17 Sep 2026 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789676258;
	bh=rAg/Yg/DqWx7Pxj9VVqEz4+jt8Yppr1YHw8Z6DY3rWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Cifno/seyID/kYnwEs9+FDv8lDl1iWkhIbTZOCPYv/Zl3U125NOEahqqxlcPptx84
	 Lp+WwS5UwXz/cE4pxyhTPmDq18IuA97tb6+2/EXTfb40xf7gXew560HWki//BNg5Md
	 H7BSt20m8+K0EtOHWRWg13d3vTanCYcfD/ZnAmCnqUvBVdF93rIQGxmXbUx+PpnZDU
	 crxNVg/ZxechdqZsl3il8cA/fsemgpg3ig+1w7IAHO7YmVWbOnOqiGbOl8yoGm3Ihh
	 Tqqfwyso+aUaiAND0Smu6s+0pb3Z1KrGeXCrJ14Q2T0e5PjzzsNNugJznZbfYTAcPi
	 Mpe8P3u+jQcjQ==
Date: Thu, 17 Sep 2026 15:17:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 10/12] PCI: liveupdate: Freeze preservation status
 during shutdown
Message-ID: <20260917201737.GA1047708@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-11-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:10:04PM +0000, David Matlack wrote:
> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown. This enables the PCI core and drivers to
> safely make decisions based on the device's preservation status during
> shutdown.
> 
> Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> than from drivers participating in Live Update so that all devices can
> have their status frozen (i.e. prevent non-preserved devices from
> getting preserved late).

This calls pci_liveupdate_freeze() from pci_device_shutdown(), the
pci_bus_type .shutdown() method, which I think is only called from
device_shutdown() in the kexec or restart paths.

Since there's no error exit after we get as far as device_shutdown(),
and this applies to all devices and dev->liveupdate.frozen is never
set to false (at least at this point in the series), is there benefit
to tracking this per-device?

> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/liveupdate.c       | 16 ++++++++++++++++
>  drivers/pci/liveupdate.h       |  4 ++++
>  drivers/pci/pci-driver.c       |  2 ++
>  include/linux/pci_liveupdate.h |  3 +++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 744513ee11ed..65bcecb1b64e 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -394,6 +394,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
>  {
>  	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
>  
> +	if (dev->liveupdate.frozen) {
> +		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
> +		return -EINVAL;
> +	}
> +
>  	if (!dev_ser) {
>  		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
>  		return -EINVAL;
> @@ -447,6 +452,11 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
>  		return -EINVAL;
>  	}
>  
> +	if (dev->liveupdate.frozen) {
> +		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
> +		return -EINVAL;
> +	}
> +
>  	if (dev->liveupdate.outgoing) {
>  		if (!dev->liveupdate.outgoing->refcount) {
>  			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
> @@ -718,6 +728,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
>  		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
>  }
>  
> +void pci_liveupdate_freeze(struct pci_dev *dev)
> +{
> +	guard(rwsem_write)(&pci_liveupdate.rwsem);
> +	dev->liveupdate.frozen = 1;

Nit, the series assigns "true" to other booleans
(preserve_bus_numbers, was_preserved).

> +}
> +
>  static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
>  {
>  	if (!dev->liveupdate.incoming) {
> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> index ccc23031e99d..49d07fd02132 100644
> --- a/drivers/pci/liveupdate.h
> +++ b/drivers/pci/liveupdate.h
> @@ -13,6 +13,7 @@
>  #ifdef CONFIG_PCI_LIVEUPDATE
>  void pci_liveupdate_setup_device(struct pci_dev *dev);
>  void pci_liveupdate_cleanup_device(struct pci_dev *dev);
> +void pci_liveupdate_freeze(struct pci_dev *dev);
>  bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
>  					 struct pci_dev *dev);
>  void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
> @@ -28,6 +29,9 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
>  {
>  }
>  
> +static inline void pci_liveupdate_freeze(struct pci_dev *dev)
> +{
> +}
>  static inline bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
>  						       struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f36778e62ac1..51616e4327d3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -21,6 +21,7 @@
>  #include <linux/acpi.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/iommu.h>
> +#include "liveupdate.h"
>  #include "pci.h"
>  #include "pcie/portdrv.h"
>  
> @@ -536,6 +537,7 @@ static void pci_device_shutdown(struct device *dev)
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct pci_driver *drv = pci_dev->driver;
>  
> +	pci_liveupdate_freeze(pci_dev);
>  	pm_runtime_resume(dev);
>  
>  	if (drv && drv->shutdown)
> diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
> index 04a2b2a3102a..31898685a406 100644
> --- a/include/linux/pci_liveupdate.h
> +++ b/include/linux/pci_liveupdate.h
> @@ -24,6 +24,8 @@
>   * @was_preserved: True if this struct pci_dev was preserved by the previous
>   *                 kernel. Unlike @incoming, this field is not cleared after
>   *                 the device is finished participating in Live Update.
> + * @frozen: True if the outgoing preservation status of this device is frozen
> + *          and thus cannot be changed.
>   */
>  struct pci_liveupdate {
>  	struct pci_dev_ser *outgoing;
> @@ -31,6 +33,7 @@ struct pci_liveupdate {
>  	u16 acs_ctrl;
>  	bool preserve_bus_numbers;
>  	bool was_preserved;
> +	bool frozen;
>  };
>  
>  struct pci_dev;
> -- 
> 2.55.0.487.gaf234c4eb3-goog
> 
