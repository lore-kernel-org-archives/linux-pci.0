Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE402D781B;
	Tue, 21 Jul 2026 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784592075; cv=none; b=hrkw7Br3Adji0ZTa46fXfUhQhwTJwTurguy9inDWQ4jPMYQEJNLu9mCJ8H7Dtl+7/SRIblguJVlPZZcYLG/E1V5dZSVLLuMadZPM+ogrnVh5ndy7Uar3FVupzl1oxuEiROirSCb+GQROllrBIGqUE3Le1R/N+7wewuXPbQRaQ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784592075; c=relaxed/simple;
	bh=wBYv0vwIjTSSsUO3mggSKmQptw0dnvqh/Xa6Aw7O79o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lr7T1SbvdblMRKc575J0EXENQ3yMnNeYiP6gaO1U7xK0ezhwhLi1SAfD6hGPUEj02BeGrMZs3ZBW6/q5HXEXmT/w8J+/nbTwMJ+whrQtdEGr1p5DnKXpLzqHAvTDsi1eIBv2C61ei0Gmd+Z56Mjuv8IERrgI/ZgxwRHv0dl61B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNKv5y3M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNKv5y3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716FA1F000E9;
	Tue, 21 Jul 2026 00:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784592054;
	bh=vHYxS/cn5Hl4hbMCYj/O7VBjSPJ+p6S8pVFZe00ks3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YNKv5y3MNvEhhlfT0wxcpewScGbd3dMjMgveLj8qGc5o2erRLDCQMNdVAhjN1TyUw
	 qI0rO2cv9ee2kcSbaOl/Gp1vSBHTdUc3G1luhMk/+/goR0q2rgaRGCUVO0gyrkSxp+
	 j/92PQ+xn0mFFJXbYeJzNvUugSXq7IcxCZ21vVrtnDw21RcumIh4V649LgE+fTJx3S
	 z4Qco0O3VlkNP8pLNOckF02Yyv9dERX+8bsFCaiY7p1eGVvXCrwt/kf99vlQ86IwDe
	 XDFI1lhLFURJkSlXWrQv+ihI/DCOvu+bvAGD1XUglkNJRuUfaq6CtB5oaUzAfTSmX/
	 TCmgJKxW1uPDg==
Date: Tue, 21 Jul 2026 01:00:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len
 Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert
 Richter <rrichter@amd.com>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "Alejandro Lucero" <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben Cheatham"
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno Leitao"
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 10/13] cxl: Add port and dport identifiers to CXL
 AER trace events
Message-ID: <20260721010050.7b5654fb@jic23-huawei>
In-Reply-To: <20260717222706.3540281-11-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-11-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:27:03 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <djbw@kernel.org>
> 
> Pass struct cxl_port * and struct cxl_dport * to the cxl_aer_*
> trace events instead of a plain struct device * derived at the
> caller. The trace event helpers then derive the right strings for
> endpoints, switch ports, root ports, and RCH downstream ports
> consistently across the CPER and native AER paths.
> 
> The unified cxl_aer_* events keep "memdev" as the legacy field
> (endpoint events populate it with the memdev name; non-endpoint
> events emit memdev="") and add new "port" and "dport" string fields
> populated for all CXL device classes. Updated userspace can key
> off "port" and "dport" without a parallel set of events.
> 
> Remove the separate cxl_port_aer_uncorrectable_error and
> cxl_port_aer_correctable_error trace events. All CXL AER events now
> use the unified cxl_aer_* events with port and dport fields.
> 
> Rework cxl_cper_handle_prot_err() to use find_cxl_port_by_dev() and
> the unified trace helpers, replacing the per-port-type branching and
> bus_find_device() memdev lookup.
> 
> The TP_printk format string places "port=%s dport=%s" between
> "memdev=%s" and "host=%s", changing the text-mode field order from
> the pre-patch output. This does not affect consumers such as
> rasdaemon that use libtraceevent to parse fields by name rather than
> by fixed text position.
> 
> For non-endpoint events (switch port, root port, RCH dport),
> "memdev" is empty and "port"/"dport" carry the topology information.
> 
> The serial number is retrieved via pci_get_dsn() which performs live
> PCI configuration space reads. A following patch ("PCI: Cache PCI
> DSN into pci_dev->dsn during probe") replaces these with a cached
> serial number to avoid config space access in error handlers and panic
> paths.
> 
> Below are examples of the different CXL devices' error trace logs
> after this patch:
> 
>      ---------------------
>      | CXL RP - 0C:00.0  |
>      ---------------------
>                |
>      ---------------------
>      | CXL USP - 0D:00.0 |
>      ---------------------
>                |
>      --------------------
>      | CXL DSP - 0E:00.0 |
>      --------------------
>                |
>      ---------------------
>      | CXL EP - 0F:00.0  |
>      ---------------------
> 
> Root Port:
> cxl_aer_correctable_error: memdev= port=port1 dport=0000:0c:00.0 \
>    host=pci0000:0c serial=0: status: 'Memory Data ECC Error'
> 
> cxl_aer_uncorrectable_error: memdev= port=port1 dport=0000:0c:00.0 \
>    host=pci0000:0c serial=0: status: 'Cache Address Parity Error'  \
>    first_error: 'Cache Address Parity Error'
> 
> Upstream Switch Port:
> cxl_aer_correctable_error: memdev= port=port2 dport= host=0000:0d:00.0 \
>    serial=0: status: 'Memory Data ECC Error'
> 
> UCE NA - Upstream Switch Port UCE's are handled in the portdrv driver's
> PCI AER callbacks that are not CXL aware.
> 
> Downstream Switch Port:
> cxl_aer_correctable_error: memdev= port=port2 dport=0000:0e:00.0 \
>    host=0000:0d:00.0 serial=0: status: 'Memory Data ECC Error'
> 
> cxl_aer_uncorrectable_error: memdev= port=port2 dport=0000:0e:00.0 \
>    host=0000:0d:00.0 serial=0: status: 'Cache Address Parity Error' \
>    first_error: 'Cache Address Parity Error'
> 
> Endpoint:
> cxl_aer_uncorrectable_error: memdev=mem1 port=endpoint4 dport= \
>    host=0000:0f:00.0 serial=0: status: 'Cache Address Parity Error' \
>    first_error: 'Cache Address Parity Error'
> 
> cxl_aer_correctable_error: memdev=mem1 port=endpoint4 dport= host=0000:0f:00.0 \
>    serial=0: status: 'Memory Data ECC Error'
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

One question inline about reference counts for the port.

> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index d5dc2c22565da..acf40b2396c3b 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
...
>  
> @@ -109,47 +77,34 @@ static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dpor
>  
>  void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  {
> +	struct cxl_dport *dport;
>  	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
>  				       data->prot_err.agent_addr.function);
> -	struct pci_dev *pdev __free(pci_dev_put) =
> -		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
> -					    data->prot_err.agent_addr.bus,
> -					    devfn);
> -	struct cxl_memdev *cxlmd;
> -	int port_type;
> -
> -	if (!pdev)
> -		return;
> -
> -	port_type = pci_pcie_type(pdev);
> -	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
> -	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
> -	    port_type == PCI_EXP_TYPE_UPSTREAM) {
> -		if (data->severity == AER_CORRECTABLE)
> -			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
> -		else
> -			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
> -
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
> +		data->prot_err.agent_addr.segment, data->prot_err.agent_addr.bus, devfn);
> +	if (!pdev) {
> +		pr_err_ratelimited("Failed to find CPER device in CXL topology\n");
>  		return;
>  	}
>  
> -	guard(device)(&pdev->dev);
> -	if (!pdev->dev.driver) {
> -		dev_warn_ratelimited(&pdev->dev,
> -				     "Device is unbound, abort CPER error handling\n");
> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, NULL);
> +	if (!port) {
> +		dev_err_ratelimited(&pdev->dev,
> +				    "Failed to find parent port device in CXL topology\n");
>  		return;
>  	}
>  
> -	struct device *mem_dev __free(put_device) = bus_find_device(
> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> -	if (!mem_dev)
> -		return;
> +	guard(device)(&port->dev);

Don't we have a reference for this from find_cxl_port_by_dev()?

Superficially scope looks the same.


> +
> +	/* dport is NULL for Endpoint and Upstream Port devices */
> +	dport = cxl_find_dport_by_dev(port, &pdev->dev);
>  
> -	cxlmd = to_cxl_memdev(mem_dev);
>  	if (data->severity == AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(port, dport, pci_get_dsn(pdev),
> +					     &data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(port, dport, pci_get_dsn(pdev),
> +					       &data->ras_cap);
>  }
>  EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
>  
> @@ -240,14 +195,14 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
>  		return;
>  	}
>  
> -	if (cxl_handle_ras(port, dport, ras_base))
> +	if (cxl_handle_ras(port, dport, ras_base, pci_get_dsn(pdev)))
>  		panic("CXL cachemem error");
>  
>  	dev_dbg(&pdev->dev,
>  		"CXL UCE signaled but no CXL RAS status bits set\n");
>  }
>  
> -void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base, u64 serial)
That's over even the modern 100 char limit. Needs a line break.
>  {

