Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD02727FA;
	Thu,  5 Feb 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311632; cv=none; b=GK2Ey9FPX1Cr15I70hdB43H7EsubeWQiXl1CPoJXT9jut/Jr9nE3ej+h6yXyTpGOTf3OVZE3yQX+KjTC4Q4u7O9II2PU2k6CN1+EKrrym0AGYhT4A1XxqCtreYw8Q1onXPxLT2dnpyj4tahcxwIu+odomXQegcwnMECAwG4WD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311632; c=relaxed/simple;
	bh=7ZkXvkRhbvIImVLNVrlIGYVo9YAutyavgCoFsinUTe8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wnz43/11Cvw++1p1TfAwdt+qR1QyMV0l+auL79Y8rlp4OTfjm8tOir6BxY/FO1RVTatK5Y384pGuwytSFHL42wthPyn/p2DBHo84vpcrNQXvI4qh2MDmiKvdAXzisgZr/PflTeGZ+gs8wN4+qsGiBMT39Bd4KBPnud4oUih8HTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6P2L2qYSzHnGj5;
	Fri,  6 Feb 2026 01:13:46 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 3518D40570;
	Fri,  6 Feb 2026 01:13:49 +0800 (CST)
Received: from localhost (10.48.151.164) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Feb
 2026 17:13:47 +0000
Date: Thu, 5 Feb 2026 17:13:46 +0000
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
Subject: Re: [PATCH v15 4/9] PCI/AER: Dequeue forwarded CXL error
Message-ID: <20260205171346.00001e6b@huawei.com>
In-Reply-To: <59fb1a00-a9cb-482a-b8be-3982c515cd85@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
	<20260203025244.3093805-5-terry.bowman@amd.com>
	<20260203152609.00004b41@huawei.com>
	<59fb1a00-a9cb-482a-b8be-3982c515cd85@amd.com>
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

On Tue, 3 Feb 2026 11:00:40 -0600
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 2/3/2026 9:26 AM, Jonathan Cameron wrote:
> > On Mon, 2 Feb 2026 20:52:39 -0600
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> >> The AER driver now forwards CXL protocol errors to the CXL driver via a
> >> kfifo. The CXL driver must consume these work items and initiate protocol
> >> error handling while ensuring the device's RAS mappings remain valid
> >> throughout processing.
> >>
> >> Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
> >> AER service driver. Lock the parent CXL Port device to ensure the CXL
> >> device's RAS registers are accessible during handling. Add pdev reference-put
> >> to match reference-get in AER driver. This will ensure pdev access after
> >> kfifo dequeue. These changes apply to CXL Ports and CXL Endpoints.
> >>
> >> Update is_cxl_error() to recognize CXL Port devices with errors.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Acked-by: Bjorn Helgaas <bhelgaas@google.com>  
> > 
> > There are some small functional changes to existing paths (maybe)
> > that I think need explanations in this commit message.
> > 
> > Otherwise, one suggests small simplification.
> >   
> >> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> >> index 74df561ed32e..a6c0bc6d7203 100644
> >> --- a/drivers/cxl/core/ras.c
> >> +++ b/drivers/cxl/core/ras.c
> >> @@ -118,17 +118,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
> >>  }
> >>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
> >>  
> >> -int cxl_ras_init(void)
> >> -{
> >> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> >> -}
> >> -
> >> -void cxl_ras_exit(void)
> >> -{
> >> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> >> -	cancel_work_sync(&cxl_cper_prot_err_work);
> >> -}
> >> -
> >>  static void cxl_dport_map_ras(struct cxl_dport *dport)
> >>  {
> >>  	struct cxl_register_map *map = &dport->reg_map;
> >> @@ -185,6 +174,50 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
> >>  
> >> +/*
> >> + * get_cxl_port - Return the parent CXL Port of a PCI device
> >> + * @pdev: PCI device whose parent CXL Port is being queried
> >> + *
> >> + * Looks up and returns the parent CXL Port associated with @pdev. On
> >> + * success, the returned port has its reference count incremented and must
> >> + * be released by the caller. Returns NULL if no associated CXL port is
> >> + * found.
> >> + *
> >> + * Return: Pointer to the parent &struct cxl_port or NULL on failure
> >> + */
> >> +static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
> >> +{
> >> +	switch (pci_pcie_type(pdev)) {
> >> +	case PCI_EXP_TYPE_ROOT_PORT:
> >> +	case PCI_EXP_TYPE_DOWNSTREAM:
> >> +	{
> >> +		struct cxl_dport *dport;
> >> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);  
> > 
> > Can you pass NULL for dport?  Looks like it to me as that ultimately ends
> > up in match_port_by_dport() and 
> > if (ctx->dport)
> > 	*ctx->dport = dport;
> > 
> > where with this as null means ctx->dport == NULL.
> >   
> 
> Yes.
> 
> 
> >> +
> >> +		if (!port) {
> >> +			pci_err(pdev, "Failed to find the CXL device");
> >> +			return NULL;
> >> +		}
> >> +		return port;
> >> +	}
> >> +	case PCI_EXP_TYPE_UPSTREAM:
> >> +	case PCI_EXP_TYPE_ENDPOINT:
> >> +	{
> >> +		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
> >> +
> >> +		if (!port) {
> >> +			pci_err(pdev, "Failed to find the CXL device");
> >> +			return NULL;
> >> +		}
> >> +		return port;
> >> +	}
> >> +	}
> >> +
> >> +	pr_err_ratelimited("%s: Error - Unsupported device type (%#x)",
> >> +			   pci_name(pdev), pci_pcie_type(pdev));
> >> +	return NULL;
> >> +}  
> > 
> >   
> >> +int cxl_ras_init(void)
> >> +{
> >> +	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
> >> +		pr_err("Failed to initialize CXL RAS CPER\n");  
> > 
> > Why introduce a new error print?  I don't particularly mind
> > but wasn't obvious to me why one has become appropriate and why only
> > for the first call here.
> >   
> 
> This was introduced before v10. 
> 
> RAS initialization failure should not fail cxl_core probe.
> 
> OSfirst AER support was added in this series in this file next to CPER. 
> CPER initialization can fail and OSFirst can not is the reason for only 
> one log. 
> 
> When I look at this block of code I'm drawn to the return value. It looks 
> like it should be a void function. Thoughts?

I'd return an error code, then at caller decide to not treat that
as a failure case. That gives a clear place to add a print + maybe
a comment that says - yes it's an error, but for 'reasons' we carry on
anyway

Jonathan


> 
> - Terry
> 
> 
> > More importantly - if this failed it would previously have resulted
> > in cxl_core_init() failing and things getting torn down.
> >   
> >> +
> >> +	cxl_register_proto_err_work(&cxl_proto_err_work);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +void cxl_ras_exit(void)
> >> +{
> >> +	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> >> +	cancel_work_sync(&cxl_cper_prot_err_work);
> >> +
> >> +	cxl_unregister_proto_err_work();
> >> +	cancel_work_sync(&cxl_proto_err_work);
> >> +}  
> > 
> >   
> 
> 

