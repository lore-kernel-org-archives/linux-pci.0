Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D62ECE91;
	Mon, 20 Jul 2026 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784588729; cv=none; b=JJID82zsAMegXU1Q69twXAyLfdX29sPlXU4dtEZaW/JMZ2z/Rr3Fk+vGJYMMTf7QmJz6CTeyUjHkvN+uDgkVKzbCVLVbDmY5EnmyEnMtqymCqc9FU0kKN6R0wBW7cuUGkNK3W5X8/bDDtS0qd4mQjn1/l5CjYrzBbqUJuCC2Sbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784588729; c=relaxed/simple;
	bh=8ww8aQhPpDoaqU/Qov5sc08O31g1RZF1Tr58KvZE1Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeGHRRu4nALIOOMa3CkvyHeZlbEE9fllbnV0JYM06oZID1mx6uURO8I+DrdZZ2a/aOUt4S9lif5WPeLhyCkuq2HBZjdl9rmyJau66vqH/8TahMsqtbgJVNNkrvFqXULMBfvoQjOd16t7SYI5jxKrbvfxhfSrD4ydKrf8/L7DgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGbbjpW6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGbbjpW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F791F00A3A;
	Mon, 20 Jul 2026 23:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784588727;
	bh=Xckd9LlJcGnoo5QPMrsdi207dxXBfcdM5AJKhzN03vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QGbbjpW67WmAg0euoY5rBVXDrKHaFF+B5cMM+1l6kDrgsX2uR6t5EFa+5AFpBBjKV
	 Px5rdf/tGZKQFRcJBMzrkgZE1n1gLrACRVvngV07tv//BcxSO47qduEQPIhltVoNI6
	 XjisgSP/UgzEkCtZJ+YepHWCVmx00ZlhKn7XSbISIMsqAyoFrcxqmvHPeFVX2Ps/u3
	 cZ2G4QdSEc+yOLWZj5H3aQDHfT3JBD6gVmmxAzZSmdPZMcydaEMB8w5LjD1GqH7mT9
	 q39tpJL5OdaaKGVpYhpOIPH3lpymdxW4IbpWxOBmaqIymedawW/Vrae35/BvIA4g5D
	 V8yfdXIXxLJOQ==
Date: Tue, 21 Jul 2026 00:05:20 +0100
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
 Shuah Khan <skhan@linuxfoundation.org>, Shuai Xue
 <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 06/13] PCI: Establish common CXL Port protocol error
 flow
Message-ID: <20260721000520.00339b52@jic23-huawei>
In-Reply-To: <20260717222706.3540281-7-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-7-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:26:59 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Add CXL protocol error dispatch in handle_error_source() using
> is_cxl_error() and cxl_forward_error() to route errors through the
> AER-CXL kfifo. Expand is_cxl_error() from Endpoint-only to include
> Root Port, Upstream Port, and Downstream Port device types. The
> producer and consumer go live in the same commit to avoid silently
> dropping CXL errors during bisect.

Take a stab at making this description a lot more concise. I'd like
to just be seeing a very brief summary of flow + clearly highlighting
of potentially controversial choices.

> 
> For uncorrectable events, call cxl_proto_err_flush() to ensure CXL RAS
> registers are read, panic policy is applied, and CXL state is cleared
> before pci_aer_handle_error() drives PCIe recovery. Without the flush,
> AER recovery can tear down drivers and unmap the CXL RAS iomaps while
> the kfifo consumer is still reading them. Correctable events do not
> need the flush and run asynchronously. RCH kfifo support is added in
> the following patch ("PCI/CXL: Add RCH support to CXL handlers").
> 
> Add cxl_handle_proto_error() to dispatch correctable and uncorrectable
> errors through the CXL RAS helpers. Add cxl_do_recovery() to coordinate
> uncorrectable recovery. Panic when a UCE is confirmed by a successful
> CXL RAS status register read. If the RAS registers cannot be read the
> UCE cannot be confirmed and panic is not triggered. Gate error handling
> on the port driver being bound to avoid processing errors on disabled
> devices.
> 
> The kfifo consumer holds guard(device)(&port->dev) and checks
> port->dev.driver before accessing RAS registers, serializing against
> driver unbind and devm iomap teardown. For UCE, cxl_proto_err_flush()
> runs the worker synchronously before AER recovery, ensuring the device
> is present during RAS register access.
> 
> Add to_ras_base() to centralize RAS base lookup: dport->regs.ras for
> Root/Downstream Ports, port->regs.ras for Upstream Ports and Endpoints.
> Use to_ras_base() to access the CXL devices' RAS registers as it will
> provide an avenue to inject status simulation during testing.
> 
> Add CXL RAS logging in cxl_handle_cor_ras() and cxl_handle_ras(). The
> existing cxl_cor_error_detected() and cxl_error_detected() AER
> callbacks remain for all Endpoints and are reworked to use
> find_cxl_port_by_uport() and to_ras_base(), with UCE now triggering
> panic unconditionally. These callbacks are further updated in the
> following patch ("PCI/CXL: Add RCH support to CXL handlers").
> 
> Fix a pre-existing race for cxlds between cxl_handle_rdport_errors() and
> cxl_memdev_shutdown() by holding a cxlmd device scoped_guard() around
> the rdport call. Release the lock before taking the Port lock to avoid
> the lock inversion.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
A few minor things about the code inline.

Thanks,

Jonathan

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 135f1997e6f4f..b190e69c2d415 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -77,6 +77,36 @@ static int match_memdev_by_parent(struct device *dev, const void *uport)
>  	return 0;
>  }
>  
> +
> +/**
> + * find_cxl_port_by_dev - Use @dev as hint to do a _by_dport or _by_uport lookup
> + * @dev: generic device that may either be a companion of port or target dport
> + * @dport: output parameter; set to the matched dport for dport-class

I'd state this is optional.

> + * lookups (Root Port, Downstream Port), NULL otherwise.
> + *
> + * Return a 'struct cxl_port' with an elevated reference if found. Use
> + * __free(put_cxl_port) to release.
> + */
> +static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dport **dport)
> +{
> +	if (dport)
> +		*dport = NULL;
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	switch (pci_pcie_type(to_pci_dev(dev))) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		return find_cxl_port_by_dport(dev, dport);
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_RC_END:
> +		return find_cxl_port_by_uport(dev);
> +	}
> +
> +	return NULL;
> +}


...

> @@ -270,22 +326,32 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  
>  void cxl_cor_error_detected(struct pci_dev *pdev)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlds->cxlmd->dev;
> +	guard(device)(&pdev->dev);
> +	if (!pdev->dev.driver)
> +		return;
> +
> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +	if (!port)
> +		return;
> +
> +	if (is_cxl_restricted(pdev)) {
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +		struct cxl_memdev *cxlmd = cxlds->cxlmd;
>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> +		scoped_guard(device, &cxlmd->dev) {
> +			cxl_handle_rdport_errors(cxlds);
> +		}

Unless this gets more complex later you can just use a guard() as exits
scope here anyway.

> +	}
> +
> +	scoped_guard(device, &port->dev) {

Similar here. I haven't read on though for this one so if it's needed
later just ignore me.

> +		if (!port->dev.driver) {
>  			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> +				 "%s: port disabled, abort error handling\n",
> +				 dev_name(&port->dev));
>  			return;
>  		}
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
> +		cxl_handle_cor_ras(port->uport_dev, to_ras_base(port, NULL));
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> @@ -293,42 +359,53 @@ EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
...
>  
> +	/*
> +	 * CXL.mem UCE means cache coherency is lost. Continuing risks
> +	 * silent data corruption across interleaved HDM regions.

It is a problem whether interleave or not.  So maybe just stop
at corruption.

> +	 */
> +	if (ue)
> +		panic("CXL cachemem error");

...

> @@ -338,3 +415,67 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,

...

> +static void __cxl_proto_err_work_fn(struct cxl_proto_err_work_data *wd)
> +{
> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&wd->pdev->dev, NULL);
> +	if (!port) {
> +		dev_err_ratelimited(&wd->pdev->dev,
> +				    "Failed to find parent port device in CXL topology\n");
> +		return;
> +	}

I'd put a blank line here.

> +	guard(device)(&port->dev);
> +	if (!port->dev.driver) {
> +		dev_err_ratelimited(&port->dev,
> +				    "Port device is unbound, abort error handling\n");
> +		return;
> +	}
> +
> +	struct cxl_dport *dport = cxl_find_dport_by_dev(port, &wd->pdev->dev);
> +	if (!dport && (pci_pcie_type(wd->pdev) == PCI_EXP_TYPE_ROOT_PORT ||
> +		       pci_pcie_type(wd->pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		dev_err_ratelimited(&wd->pdev->dev,
> +				    "Failed to find dport device in CXL topology\n");
> +		return;
> +	}
> +
> +	cxl_handle_proto_error(wd->pdev, port, dport, wd->severity);
> +}

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c5bce25df51cb..2d9d40528e709 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1185,7 +1185,20 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> +	bool cxl_pending = false;
> +
>  	cxl_rch_handle_error(dev, info);
> +
> +	if (is_cxl_error(dev, info))
> +		cxl_pending |= cxl_forward_error(dev, info);

> +
> +	/*
> +	 * Wait for UCE CXL work to complete before AER recovery
> +	 * tears down the device. CE can run asynchronously.
> +	 */
> +	if (cxl_pending && info->severity != AER_CORRECTABLE)
> +		cxl_proto_err_flush();
This kind of makes me wonder if the naming of _flush() is clear.
Normally I'd kind of expect that to be dumping any queued up errors.

Perhaps cxl_proto_err_wait_for_empty() or something like that?

I guess flush_work() set the precedent so I'm too later on this one!

Jonathan
