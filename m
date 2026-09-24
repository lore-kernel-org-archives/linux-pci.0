Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46461DE8AE;
	Thu, 24 Sep 2026 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212956; cv=none; b=LO8XoGBRukp/NvGt2AfR/KCr4hbO9/BGKAXKpptGc+AqK+xx8a08V37/TZWqaMs18irSOz3qrctvm5yjKuQ28Z4I1sOy/qOvFzXXweG8IKFWHhkhXNu8zezt6ugWzQxsyJZRKu4iJS0hX1ElGiRn1e3ISAuEv2jOuGmJbmOZGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212956; c=relaxed/simple;
	bh=tKL0I6IQu5gDyR3fqNkcnr910cBnvCSvyjqe+A92hnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgqTHY25Sv4kANmQ+urD6g5sIDnfynL3r5EaxI7mtB+CMx6M3ZmnuYjv2w4QP7K4g0gasBAf4own/H8ks3r3uKJQLt+6EfQ3hZo+PqoyYCCNVpN0y+JPPnD4VT6h4UE6TAENETPeF1MOPNGaDqDILZGDiH2J4O+2XEBBuNF3yoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYe46IFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYe46IFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794621F000FF;
	Thu, 24 Sep 2026 01:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790212954;
	bh=PZwOQfhMfe3UovideYsPTOd82tSH8HJLhFCb/I5bcV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SYe46IFTXuEvO21SoJ0Uq9+p1VsXGFVZo3SHHywSYLQrWqeNdkjsS2ks1h0J/Fh1k
	 JKzaagxG03lLiQ2kA9JyhwRyPoTSMDv+DHM7+Nlbd8+6MrFXQ8C7lspFDq+9ZnFJvU
	 nRq9yHT7/kTcSrdgaykQ5N0VVIfR7DS7xsbwJvTvcZOz2Il8IZAz813oRXdPbnd2/3
	 9hbE+LhtrvprrnTXbn3hg3zoRFHxn4ODmCukiSxKSC2qcb1+I68W25IRwjOf/BqnK2
	 tGTgAD7ygEmwk0cqtU7UoBnc7JF7MjIp893zZDg8aIYMk08EtewhIPu4CruMgKn+Zt
	 R3BVnAor849Aw==
Date: Thu, 24 Sep 2026 02:22:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
 <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v13 02/15] cxl: Share CXL port upstream PCI device
 lookup
Message-ID: <20260924022228.50fac1ad@jic23-hlaptop>
In-Reply-To: <20260922083924.2451158-3-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-3-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 08:39:11 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> read_cdat_data() resolves a CXL port's upstream device to its backing PCI
> device. HDM cache updates need the same mapping.
> 
> Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
> PCI device to make caller ownership explicit.

We don't need that here, so maybe briefly state that you will do in
new users coming shortly.

> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assuming this is the only instance (as Ben asks) and you do
what I suggested about not having the good path follow a goto,
then
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/core.h |  1 +
>  drivers/cxl/core/pci.c  | 23 ++++++-----------------
>  drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..983d7690c3a5 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -157,6 +157,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
>  
>  static inline struct device *port_to_host(struct cxl_port *port)
>  {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..bf7fc77626d9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -564,26 +564,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>   */
>  void read_cdat_data(struct cxl_port *port)
>  {
> -	struct device *uport = port->uport_dev;
> +	struct pci_dev *pdev = cxl_port_get_uport_pci_dev(port);
>  	struct device *dev = &port->dev;
>  	struct pci_doe_mb *doe_mb;
> -	struct pci_dev *pdev = NULL;
> -	struct cxl_memdev *cxlmd;
>  	struct cdat_doe_rsp *buf;
>  	size_t table_length, length;
>  	int rc;
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
>  	if (!pdev)
>  		return;
>  
> @@ -591,14 +578,14 @@ void read_cdat_data(struct cxl_port *port)
>  				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
>  	if (!doe_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
> -		return;
> +		goto out;
>  	}
>  
>  	port->cdat_available = true;
>  
>  	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
>  		dev_dbg(dev, "No CDAT length\n");
> -		return;
> +		goto out;
>  	}
>  
>  	/*
> @@ -625,11 +612,13 @@ void read_cdat_data(struct cxl_port *port)
>  	port->cdat.table = buf->data;
>  	port->cdat.length = length;
>  
> -	return;
> +	goto out;
>  err:
>  	/* Don't leave table data allocated on error */
>  	devm_kfree(dev, buf);
>  	dev_err(dev, "Failed to read/validate CDAT.\n");
> +out:
> +	pci_dev_put(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..5dc2815d82d8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -34,6 +34,32 @@
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
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
>  /*
>   * The terminal device in PCI is NULL and @platform_bus
>   * for platform devices (for cxl_test)

