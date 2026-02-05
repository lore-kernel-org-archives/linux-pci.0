Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9021255A;
	Thu,  5 Feb 2026 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311795; cv=none; b=OHmQ7Uwx1/bPSLFBIsvIwpQ1XT8HJWd+r/prIS57x98mV2OcC7ae1Uf2n2zfFoxh1jEqqEqa1v5LSlck3QpuCAtVbsdmqQHTel5JBMuQ/dL7fxZ6tNfnRuSY0TdecWQ+LbIIb7ywfpwlxsb0JKXAOtJS/Qzl15dM6jPxcpvAeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311795; c=relaxed/simple;
	bh=y4zs2xlDJBVx1X7XurCgpTImEe3FTPJ7jBu721A32UY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyEznBz1wLSxCSBlYdvuWwp6WVw9ANcixYfeYtqI3fQYxCirIZ8GmKBfqeW12u6V9e01lx64FJuAimjf85TUwzXcDC1LFLO8+g8dMTo8Ueebwx6BY2MhgK6Zrvmn6GEH1sWFODEgzAkhCqiLl3swlyxDSmCyjzNn3q2lRb78f/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6P4W41KzzJ46BP;
	Fri,  6 Feb 2026 01:15:39 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 83DBC4056A;
	Fri,  6 Feb 2026 01:16:30 +0800 (CST)
Received: from localhost (10.48.151.164) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Feb
 2026 17:16:29 +0000
Date: Thu, 5 Feb 2026 17:16:27 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
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
Message-ID: <20260205171627.000013da@huawei.com>
In-Reply-To: <e296e48e-40d1-483b-9f49-78e8bd3b885f@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
	<20260203025244.3093805-6-terry.bowman@amd.com>
	<20260203154039.000001ae@huawei.com>
	<e296e48e-40d1-483b-9f49-78e8bd3b885f@amd.com>
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

On Tue, 3 Feb 2026 12:21:56 -0600
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 2/3/2026 9:40 AM, Jonathan Cameron wrote:
> > On Mon, 2 Feb 2026 20:52:40 -0600
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> >> Introduce CXL Port protocol error handling callbacks to unify detection,
> >> logging, and recovery across CXL Ports and Endpoints, including RCH
> >> downstream ports. Establish a consistent flow for correctable and
> >> uncorrectable CXL protocol errors.
> >>
> >> Provide the solution by adding cxl_port_cor_error_detected() and
> >> cxl_port_error_detected() to handle correctable and uncorrectable handling
> >> through CXL RAS helpers, coordinating uncorrectable recovery in
> >> cxl_do_recovery(), and panicking when the handler returns PCI_ERS_RESULT_PANIC
> >> to preserve fatal cachemem behavior. Gate endpoint handling on the endpoint
> >> driver being bound to avoid processing errors on disabled devices.
> >>
> >> Centralize the RAS base lookup in cxl_get_ras_base(), selecting the
> >> downstream-port dport->regs.ras for Root/Downstream Ports and port->regs.ras
> >> for Upstream Ports/Endpoints.
> >>
> >> Export pcie_clear_device_status() and pci_aer_clear_fatal_status() to enable
> >> cxl_core to clear PCIe/AER state in these flows.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >> Reviewed-by: Dave Jiang dave.jiang@intel.com  
> > 
> > Hi Terry,
> > 
> > A few comments inline.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> Thanks for reviewing.
> 
> >>
> >> ---
> >>
> >> Changes in v14->v15:
> >> - Update commit message and title. Added Bjorn's ack.
> >> - Move CE and UCE handling logic here
> >>
> >> Changes in v13->v14:
> >> - Add Dave Jiang's review-by
> >> - Update commit message & headline (Bjorn)
> >> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
> >>   one line (Jonathan)
> >> - Remove cxl_walk_port() (Dan)
> >> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
> >>   sufficient (Dan)
> >> - Remove device_lock_if()
> >> - Combined CE and UCE here (Terry)
> >>
> >> Changes in v12->v13:
> >> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
> >>   patch (Terry)
> >> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
> >> - Remove check for dport->dport_dev (Dave)
> >> - Remove whitespace (Terry)
> >>
> >> Changes in v11->v12:
> >> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
> >>   pci_to_cxl_dev()
> >> - Change cxl_error_detected() -> cxl_cor_error_detected()
> >> - Remove NULL variable assignments
> >> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
> >>   port searches.
> >>
> >> Changes in v10->v11:
> >> - None
> >> ---
> >>  drivers/cxl/core/ras.c | 134 +++++++++++++++++++++++++++++++++++++++++
> >>  drivers/pci/pci.c      |   1 +
> >>  drivers/pci/pci.h      |   2 -
> >>  drivers/pci/pcie/aer.c |   1 +
> >>  include/linux/aer.h    |   2 +
> >>  include/linux/pci.h    |   2 +
> >>  6 files changed, 140 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> >> index a6c0bc6d7203..0216dafa6118 100644
> >> --- a/drivers/cxl/core/ras.c
> >> +++ b/drivers/cxl/core/ras.c
> >> @@ -218,6 +218,68 @@ static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
> >>  	return NULL;
> >>  }
> >>  
> >> +static void __iomem *cxl_get_ras_base(struct device *dev)
> >> +{
> >> +	struct pci_dev *pdev = to_pci_dev(dev);
> >> +
> >> +	switch (pci_pcie_type(pdev)) {
> >> +	case PCI_EXP_TYPE_ROOT_PORT:
> >> +	case PCI_EXP_TYPE_DOWNSTREAM:
> >> +	{
> >> +		struct cxl_dport *dport;  
> > 
> > 		struct cxl_dport *dport = NULL;
> >   
> >> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);  
> > 
> > as if this failed, dport is not written. Alternative is check port, not dport as port
> > will always be initialized whether or not failure occurs in find_cxl_port()
> >   
> 
> Ok.
> 
> >   
> >> +
> >> +		if (!dport) {
> >> +			pci_err(pdev, "Failed to find the CXL device");
> >> +			return NULL;
> >> +		}
> >> +		return dport->regs.ras;
> >> +	}
> >> +	case PCI_EXP_TYPE_UPSTREAM:
> >> +	case PCI_EXP_TYPE_ENDPOINT:
> >> +	{
> >> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> >> +
> >> +		if (!port) {
> >> +			pci_err(pdev, "Failed to find the CXL device");
> >> +			return NULL;
> >> +		}
> >> +		return port->regs.ras;
> >> +	}
> >> +	}
> >> +	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
> >> +	return NULL;
> >> +}  
> >   
> >>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> >>  {
> >>  	void __iomem *addr;
> >> @@ -288,6 +350,60 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> >>  	return true;
> >>  }
> >>  
> >> +static void cxl_port_cor_error_detected(struct device *dev)
> >> +{
> >> +	struct pci_dev *pdev = to_pci_dev(dev);
> >> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> >> +
> >> +	if (is_cxl_endpoint(port)) {
> >> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> >> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >> +
> >> +		guard(device)(&cxlmd->dev);  
> > 
> > Maybe add a comment on why this lock needs to be held and then why the dev->drvier
> > below needs to be true.
> >   
> This can be removed. This was added to ensure the EP's RAS registers remained accessible 
> during handling. This was when when the mapped RAS registers were owned by the CXL memory 
> device. This has changed such that the EP RAS registers are now owned by the EP Port. And, 
> the Endpoint Port is already locked in cxl_proto_err_work_fn() before calling this funcion.
> 
> >> +
> >> +		if (!dev->driver) {
> >> +			dev_warn(&pdev->dev,
> >> +				 "%s: memdev disabled, abort error handling\n",
> >> +				 dev_name(dev));  
> > 
> > Same question as below on why pdev->dev / dev_name(dev) here.
> > Maybe pci_warn() is more appropriate.
> >   
> 
> I believe the driver check can be removed but would like your input. The check 
> for the driver is another piece of code specifically for when the handler was accessing 
> the memdev's RAS registers. It was a last check to make certain the device is bound 
> to a driver before accessing. EP RAS is now owned by the Endpoint Port.

Sounds fine to me to drop this check if we don't need anything that
belongs to that driver any more.

Jonathan
