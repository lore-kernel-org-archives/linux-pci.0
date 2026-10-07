Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6033B3C1F;
	Wed,  7 Oct 2026 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375760; cv=pass; b=h8iUCGJgJdQ336RVfSKt/y84fzuFT7kUYmwi6vgPV1+HOezwgJHH+CTkD0jng7zbQxGNHjYOtzu4HEtAW7lnurZlYXKbSCcbizuonk0IAc1n+POSLAFfUBPmnwYuMBbPJEIP20HjFznBeKNTHqzNDlBsldAgAHCpC5vgtUyMT9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375760; c=relaxed/simple;
	bh=5Hu7k3zor8Y0oaxsc5i78N1awXT+GQwHIa9Znf6Wu+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUIUXkqa7uQHYlYmm1FVSjyZbfp8JAaW9KPrfjmRHgtCLP9QoX40TfOS6P4A/S4pJMnOD8qLGl8ZIaSCgouRalsWY4d8CK8v5DgRfzemlnN4VQmx2tyca/iVus2mhfQoOhcs+x2UAMdLdJSC8B2bNZvfhKuQr+OsZK+AnAxIRXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=NyNxBEep; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="NyNxBEep"
ARC-Seal: i=1; a=rsa-sha256; t=1791375741; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ae66PRcMLrO4V8kRLZLDcKWgQMdLohkasluzHz6OC3/J+Frx17aj9b0X7RSTOsEbY1FGavVXr12RIgYGNmI5Recy27bpNdjahtGtGP3WiLhZoLrZZ8ySB0NJvlse9zWpEFXMUZ+YxgEi0MJ91CsDERHUvn4jZ2oHAbpZVHmGz6w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791375741; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kWUH5zCnwtHKT9DajdHooYjxbLxwc75pG2nsy2b/FaQ=; 
	b=Yzl2gUuxKLbK/pPdYMogUcQPVJwSWxIUJvSFaMLxGs9MQ+DCG0pO1y7+Br6O5VbNvL2iJ+EoasgcdUWIUff1F0BLF1UxI7Uk5X+L1yj3Zw/sws0cuAFXoEaa7TmnN1JJOZu1MokzIbMJUaTjDbnUN/l6D/mSX4+3sTB7f9wRoBs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791375741;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=kWUH5zCnwtHKT9DajdHooYjxbLxwc75pG2nsy2b/FaQ=;
	b=NyNxBEepNGx7dDQmV+4mgPHNbkV8krL7gUZEz0D42t63fhpWzNzMWwLsqjAIqjfB
	4H+HqTKBg4cJ6iCkfTVfmm6n3XzT0XEvl8uqYo2Qio/3yrf14NI6aDLbisib3WrHPBv
	/yv8aQFOSQThUKYyvrjtWQvyYMTOIMCEVpfWtX4A=
Received: by smtp.zohomail.com with SMTPS id 1791375740669490.5174696368306;
	Wed, 7 Oct 2026 05:22:20 -0700 (PDT)
Message-ID: <4d2c765a-0d77-49f9-8e6e-4d80137df513@zohomail.com>
Date: Wed, 7 Oct 2026 20:22:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/16] cxl: Share CXL port upstream PCI device lookup
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-3-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261001092227.3004747-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227bd73bd4de56559d6cf118e6a000083ad411aff8fb21b81e6504122147652043bead2f787d0c34e:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/1 17:22, Srirangan Madhavan 写道:
> read_cdat_data() resolves a CXL port's upstream device to its backing PCI
> device. HDM cache updates need the same mapping.
>
> Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
> PCI device to make caller ownership explicit.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>


pci.h provides a __free() based cleanup function for pci_dev_put().

I think you can use "struct pci_dev *pdev __free(pci_dev_put) = 
cxl_port_get_uport_pci_dev(port);" and drop all pci_dev_put() below.

> ---
>   drivers/cxl/core/core.h |  1 +
>   drivers/cxl/core/pci.c  | 19 +++++--------------
>   drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
>   3 files changed, 32 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..983d7690c3a5 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -157,6 +157,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
>   int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>   int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>   					struct access_coordinate *c);
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
>   
>   static inline struct device *port_to_host(struct cxl_port *port)
>   {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..99c8b02d42e5 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -564,26 +564,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>    */
>   void read_cdat_data(struct cxl_port *port)
>   {
> -	struct device *uport = port->uport_dev;
> +	struct pci_dev *pdev = cxl_port_get_uport_pci_dev(port);
>   	struct device *dev = &port->dev;
>   	struct pci_doe_mb *doe_mb;
> -	struct pci_dev *pdev = NULL;
> -	struct cxl_memdev *cxlmd;
>   	struct cdat_doe_rsp *buf;
>   	size_t table_length, length;
>   	int rc;
>   
> -	if (is_cxl_memdev(uport)) {
> -		struct device *host;
> -
> -		cxlmd = to_cxl_memdev(uport);
> -		host = cxlmd->dev.parent;
> -		if (dev_is_pci(host))
> -			pdev = to_pci_dev(host);
> -	} else if (dev_is_pci(uport)) {
> -		pdev = to_pci_dev(uport);
> -	}
> -
>   	if (!pdev)
>   		return;
>   
> @@ -591,6 +578,7 @@ void read_cdat_data(struct cxl_port *port)
>   				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
>   	if (!doe_mb) {
>   		dev_dbg(dev, "No CDAT mailbox\n");
> +		pci_dev_put(pdev);
>   		return;
>   	}
>   
> @@ -598,6 +586,7 @@ void read_cdat_data(struct cxl_port *port)
>   
>   	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
>   		dev_dbg(dev, "No CDAT length\n");
> +		pci_dev_put(pdev);
>   		return;
>   	}
>   
> @@ -625,11 +614,13 @@ void read_cdat_data(struct cxl_port *port)
>   	port->cdat.table = buf->data;
>   	port->cdat.length = length;
>   
> +	pci_dev_put(pdev);
>   	return;
>   err:
>   	/* Don't leave table data allocated on error */
>   	devm_kfree(dev, buf);
>   	dev_err(dev, "Failed to read/validate CDAT.\n");
> +	pci_dev_put(pdev);
>   }
>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>   
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..5dc2815d82d8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -34,6 +34,32 @@
>   static DEFINE_IDA(cxl_port_ida);
>   static DEFINE_XARRAY(cxl_root_buses);
>   
> +/**
> + * cxl_port_get_uport_pci_dev - get the PCI device for a port's upstream device
> + * @port: CXL port to map to a PCI device
> + *
> + * Return: A referenced PCI device, or NULL if the upstream device is not PCI.
> + * The caller must release the returned reference with pci_dev_put().
> + */
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
> +{
> +	struct device *uport = port->uport_dev;
> +	struct device *host;
> +
> +	if (is_cxl_memdev(uport)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
> +
> +		host = cxlmd->dev.parent;
> +	} else {
> +		host = uport;
> +	}
> +
> +	if (!host || !dev_is_pci(host))
> +		return NULL;
> +
> +	return pci_dev_get(to_pci_dev(host));
> +}
> +
>   /*
>    * The terminal device in PCI is NULL and @platform_bus
>    * for platform devices (for cxl_test)
