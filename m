Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9A378805;
	Mon,  9 Mar 2026 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060349; cv=none; b=Denl3cziwaRUIq5cSsqfWzh3grSlTBVZ42EoNo/tu5QVHGa+BnYMilo0tFMRLPIgl6soGvD0CrRIF95+I8jgesEAIRLhQiVl5KBPJItZVOxuhhP7KpjeL2I8Bv4LDtokXpHM7ugrCwckDc6eAJEaMpDAYlneb6RWrkAOAWmDKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060349; c=relaxed/simple;
	bh=+UI6EKa+EgAYparqRT9nD4bBj5vMZ53PZOz681Jg60Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYjyfNAlFYxcNfsTWgO0t5P4We56dIcDXXSLtQoEqeKQEl2M7a05923FrwT3Kj7ZAvdZfYH2Z1FBduHP7tvnAoVImnPoPebLamIYGf+/Lc1HPcCOzwkmAHl647jdbNJD6oVUSdwWXw6yEC5+kYU/P/LAdEXFe+cfnyr5Tb44pb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTxZD08HdzHnHPd;
	Mon,  9 Mar 2026 20:45:40 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id BAF0A40587;
	Mon,  9 Mar 2026 20:45:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 12:45:42 +0000
Date: Mon, 9 Mar 2026 12:45:41 +0000
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
Subject: Re: [PATCH v16 05/10] PCI: Establish common CXL Port protocol error
 flowUIRE
Message-ID: <20260309124541.000006e8@huawei.com>
In-Reply-To: <20260302203648.2886956-6-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
	<20260302203648.2886956-6-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 2 Mar 2026 14:36:43 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> Introduce CXL Port protocol error handling callbacks to unify detection,
> logging, and recovery across CXL Ports and Endpoints. Establish a consistent
> flow for correctable and uncorrectable CXL protocol errors. Support for RCH
> Downstream Port error handling will be added in a future patch.
> 
> Provide the solution by adding cxl_port_cor_error_detected() and
> cxl_port_error_detected() to handle correctable and uncorrectable handling
> through CXL RAS helpers, coordinating uncorrectable recovery in
> cxl_do_recovery(), and panicking when the handler returns PCI_ERS_RESULT_PANIC
> to preserve fatal cachemem behavior. Gate Endpoint handling on the Endpoint
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
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
Hi Terry,

It's been long enough I've pretty much forgotten what this does, so
fresh review.  Might well be commenting on things that have come up
before!

Jonathan

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 44791f6d7d50..1d4be2d78469 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

> +static u64 cxl_serial_number(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +	struct device *port_dev = port ? port->uport_dev : NULL;

Maybe someone else asked for this, but to my eyes it's too complex.
Would be simpler to drop this local variable and

> +	struct cxl_memdev *cxlmd;
> +

	if (!port || !port->uport_dev || !is_cxl_memdev(dev))
		return 0;

	cxlmd = to_cxl_memdev(port->uport_dev);
..

> +	if (!port_dev || !is_cxl_memdev(dev))
> +		return 0;
> +
> +	cxlmd = to_cxl_memdev(port_dev);
> +	return cxlmd->cxlds->serial;
> +}

> +static void cxl_do_recovery(struct pci_dev *pdev)
> +{
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +	struct device *dev = &pdev->dev;
> +	pci_ers_result_t status;
> +
> +	if (!port) {
> +		pci_err(pdev, "Failed to find the CXL device\n");
> +		return;
> +	}
> +
> +	status =  cxl_handle_ras(dev, cxl_serial_number(dev), cxl_get_ras_base(dev));
Extra space after = 

> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	if (pcie_aer_is_native(pdev)) {
> +		pcie_clear_device_status(pdev);
> +		pci_aer_clear_nonfatal_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
> +	}
> +}
> +
>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -327,3 +428,71 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,

> +
> +static void cxl_proto_err_work_fn(struct work_struct *work)
> +{
> +	struct cxl_proto_err_work_data wd;
> +
> +	/*
> +	 * Dequeue work forwarded from the AER driver
> +	 * See cxl_forward_error() for matching pci_dev_get()
> +	 */
> +	while (cxl_proto_err_kfifo_get(&wd)) {
> +		struct pci_dev *pdev __free(pci_dev_put) = wd.pdev;

I'm not particularly keen on the lack of constructor / destructor pairing this is giving
us but the alternatives are fiddly.  You could make cxl_proto_err_kfifo_get() return wd
/ ERR_PTR() and use a new DEFINE_FREE() for that structure. But it would require
memory allocation or a dance.


This would become something like
	struct cxl_proto_err_work_data scratch;

	whilst(true) {
		struct cxl_proto_err_work_data *wd __free(cxl_proto_err_work_d) =
			cxl_proto_err_kfifo_get(scratch);
		if (IS_ERR(wd))
			return;

		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(wd->pdev);

...


	}

Hmm. Also not exactly elegant. Unless others have a better idea, let us stick
to what you have.

> +		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +
> +		if (!port) {
> +			pr_err_ratelimited("%s: Failed to find parent port device in CXL topology\n",
> +					   pci_name(pdev));
> +			continue;
> +		}
> +
> +		guard(device)(&port->dev);
> +		if (!port->dev.driver) {
> +			pr_err_ratelimited("%s: Port device is unbound, abort error handling\n",
> +					    dev_name(&port->dev));
> +			continue;
> +		}
> +
> +		cxl_handle_proto_error(pdev, wd.severity);
> +	}
> +}


