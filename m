Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44826317709;
	Tue,  3 Feb 2026 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133249; cv=none; b=EY6nBY66Celh/z/0hyXnLrAaYwmPi9KEmuvEvrzoSG7aLOGROwjaC56hRqrgIzwsRoDrG7+PFMo7iZqt3f6LYpt7D1GG81NH1NJHLT/jXV26GB/9g95PPIDuc38eUeivCKIoaWiTaHZGmnklNGENMW38yG8KuS1F0LNRvPm3D14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133249; c=relaxed/simple;
	bh=okJWU55Et0XjAQiWJM11aAthsss+4RKSkp0giE1XpWo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNGOkfnNMaVUFBkEBvhW0GdlbJ6weU6Mqo9Dbwpp2SdTfSRj/bBRw6x5grnCb2TBFLiOnwA6iLk9TSRVxgijqh23nDpHY8Wn9P51QfJ9LdrHgtizhu8qNbqy0sPbposqmzOlkxvubbFmOIvDqJlAADlXesAiolAUxfoexi4TCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f572y69PHzJ46F7;
	Tue,  3 Feb 2026 23:39:54 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D16240565;
	Tue,  3 Feb 2026 23:40:42 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Feb
 2026 15:40:41 +0000
Date: Tue, 3 Feb 2026 15:40:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v15 5/9] PCI: Establish common CXL Port protocol error
 flow
Message-ID: <20260203154039.000001ae@huawei.com>
In-Reply-To: <20260203025244.3093805-6-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
	<20260203025244.3093805-6-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 2 Feb 2026 20:52:40 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> Introduce CXL Port protocol error handling callbacks to unify detection,
> logging, and recovery across CXL Ports and Endpoints, including RCH
> downstream ports. Establish a consistent flow for correctable and
> uncorrectable CXL protocol errors.
> 
> Provide the solution by adding cxl_port_cor_error_detected() and
> cxl_port_error_detected() to handle correctable and uncorrectable handling
> through CXL RAS helpers, coordinating uncorrectable recovery in
> cxl_do_recovery(), and panicking when the handler returns PCI_ERS_RESULT_PANIC
> to preserve fatal cachemem behavior. Gate endpoint handling on the endpoint
> driver being bound to avoid processing errors on disabled devices.
> 
> Centralize the RAS base lookup in cxl_get_ras_base(), selecting the
> downstream-port dport->regs.ras for Root/Downstream Ports and port->regs.ras
> for Upstream Ports/Endpoints.
> 
> Export pcie_clear_device_status() and pci_aer_clear_fatal_status() to enable
> cxl_core to clear PCIe/AER state in these flows.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Dave Jiang dave.jiang@intel.com

Hi Terry,

A few comments inline.

Thanks,

Jonathan

> 
> ---
> 
> Changes in v14->v15:
> - Update commit message and title. Added Bjorn's ack.
> - Move CE and UCE handling logic here
> 
> Changes in v13->v14:
> - Add Dave Jiang's review-by
> - Update commit message & headline (Bjorn)
> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>   one line (Jonathan)
> - Remove cxl_walk_port() (Dan)
> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>   sufficient (Dan)
> - Remove device_lock_if()
> - Combined CE and UCE here (Terry)
> 
> Changes in v12->v13:
> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>   patch (Terry)
> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
> - Remove check for dport->dport_dev (Dave)
> - Remove whitespace (Terry)
> 
> Changes in v11->v12:
> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>   pci_to_cxl_dev()
> - Change cxl_error_detected() -> cxl_cor_error_detected()
> - Remove NULL variable assignments
> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>   port searches.
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/ras.c | 134 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c      |   1 +
>  drivers/pci/pci.h      |   2 -
>  drivers/pci/pcie/aer.c |   1 +
>  include/linux/aer.h    |   2 +
>  include/linux/pci.h    |   2 +
>  6 files changed, 140 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index a6c0bc6d7203..0216dafa6118 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -218,6 +218,68 @@ static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
>  	return NULL;
>  }
>  
> +static void __iomem *cxl_get_ras_base(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;

		struct cxl_dport *dport = NULL;

> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);

as if this failed, dport is not written. Alternative is check port, not dport as port
will always be initialized whether or not failure occurs in find_cxl_port()


> +
> +		if (!dport) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return dport->regs.ras;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	{
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port->regs.ras;
> +	}
> +	}
> +	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
> +	return NULL;
> +}

>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -288,6 +350,60 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	return true;
>  }
>  
> +static void cxl_port_cor_error_detected(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +		guard(device)(&cxlmd->dev);

Maybe add a comment on why this lock needs to be held and then why the dev->drvier
below needs to be true.

> +
> +		if (!dev->driver) {
> +			dev_warn(&pdev->dev,
> +				 "%s: memdev disabled, abort error handling\n",
> +				 dev_name(dev));

Same question as below on why pdev->dev / dev_name(dev) here.
Maybe pci_warn() is more appropriate.

> +			return;
> +		}
> +
> +		if (cxlds->rcd)
> +			cxl_handle_rdport_errors(cxlds);
> +
> +		cxl_handle_cor_ras(dev, cxlds->serial, cxl_get_ras_base(dev));
> +	} else {
> +		cxl_handle_cor_ras(dev, 0, cxl_get_ras_base(dev));
> +	}
> +}
> +
> +static pci_ers_result_t cxl_port_error_detected(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +		guard(device)(&cxlmd->dev);
> +
> +		if (!dev->driver) {
> +			dev_warn(&pdev->dev,

Somewhat circular.  dev_warn() will print the device name anyway I think and
this pdev->dev == dev here so might as well use that.

Or was intent to use different devices?

> +				 "%s: memdev disabled, abort error handling\n",
> +				 dev_name(dev));
> +			return PCI_ERS_RESULT_NONE;
> +		}
> +
> +		if (cxlds->rcd)
> +			cxl_handle_rdport_errors(cxlds);
> +
> +		return cxl_handle_ras(dev, cxlds->serial, cxl_get_ras_base(dev));
> +	} else {
> +		return cxl_handle_ras(dev, 0, cxl_get_ras_base(dev));
> +	}
> +}

>  
>  static void cxl_proto_err_work_fn(struct work_struct *work)
