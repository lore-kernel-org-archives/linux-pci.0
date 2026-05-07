Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEBB2DECBF;
	Thu,  7 May 2026 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178146; cv=none; b=a1DZGNHwtOYYco7kAjNaLyMIV5lIqAx5JcKU/xJDjtTAoTHoaMfTMMeAV20pgJpZddd5jWnoTGsGjurrnKJDC5tUIMiwoa7owbLE6k1jeW+k/3eb9tRRS/rj6k3G69Wsb99kHRLeS8I9AkmGO0gTlbeBC29+UlRoMi4zu3xnzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178146; c=relaxed/simple;
	bh=0W+ZsekoTxcgfyklGmZMS7rKNnmw2pmUheslWTYG0n8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nml0+j53jQMbBhJZn6CTl809c+8mfbSaToPYCRUoABSiQKkYJG1ukX3xH9Qb37OVy0wazLLR6keyb/xEZr5Fv26l+ImTRe8Bp+GwRRC1fazfelh869wfyQB7BivVZaoBvzukDfosCzkeOpQ8dJg8Sl2fUWgr0Ce5VDJlGBdFcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZHZ5b+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZHZ5b+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81146C2BCB2;
	Thu,  7 May 2026 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778178145;
	bh=0W+ZsekoTxcgfyklGmZMS7rKNnmw2pmUheslWTYG0n8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aZHZ5b+sPLaTMdnR0f+scK9jeHcb+ZD307ThWgBoiq3AkPS74Ogf0bZzgcpxhGVE+
	 vZTkGp66zmMPksDOzz2UXUrbihomKmfTgHcXDuzCFhFGsBE7yvxdOGb6jMWG3MuAAI
	 kpNMGsfMqOViUTbj9wJNKbb2PdciNdXvaVZw1JYYblG4RV/AmRp31yTQawufETVIh8
	 Jc2sudlVtI/cHG4cGQYfQXsFkxAs15ADa5bbG5f0gR0eUQC40xfSUWMjM+0BxD+6AI
	 Dm9u2SupA0MQwcenMyahiTvQePUpfS1a9yh4w31XJyTRkfYu9DiLUOUND2MhIXMFCL
	 oAhBZ7qUHPR2A==
Date: Thu, 7 May 2026 19:22:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: <dave@stgolabs.net>, <dave.jiang@intel.com>,
 <alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
 <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
 <Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
 <dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
 <lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
 <sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
 <alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
 <rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v17 06/11] PCI: Establish common CXL Port protocol error
 flow
Message-ID: <20260507192210.766d54fd@jic23-huawei>
In-Reply-To: <20260505173029.2718246-7-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
	<20260505173029.2718246-7-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 12:30:24 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Add CXL Port protocol error handling callbacks to unify detection,
> logging, and recovery across CXL Ports and Endpoints. Establish a
> common flow for correctable and uncorrectable CXL protocol errors.
> RCH Downstream Port error handling is added in a following patch.
> 
> Add cxl_handle_proto_error() to dispatch correctable and uncorrectable
> errors through the CXL RAS helpers. Add cxl_do_recovery() to coordinate
> uncorrectable recovery. Panic via panic() on any uncorrectable CXL RAS
> error. CXL.cachemem traffic cannot be safely recovered from an
> uncorrectable protocol error in software, so panic regardless of the
> AER severity reported. Gate error handling on the port driver being
> bound to avoid processing errors on disabled devices.
> 
> Panic explicitly on pci_dev_is_disconnected() before accessing the RAS
> registers. A CXL device disconnecting during an uncorrectable error event
> is itself unrecoverable, particularly for devices in interleaved HDM
> regions. Relying on the status readl() returning ~0u to trip the existing
> panic path leaves the cause ambiguous.
> 
> The panic policy applies to the RAS register block of the device whose
> error triggered the recovery: Root/Downstream Port RAS for VH Ports,
> Endpoint Port RAS for VH Endpoints and RCDs. Upstream RCH Downstream
> Port RAS UEs handled via cxl_handle_rdport_errors() are logged only, as
> before this series. Only the RCD Endpoint's own RAS UE drives the panic.
> 
> Add to_ras_base() to centralize the RAS base lookup. It selects
> dport->regs.ras for Root/Downstream Ports and port->regs.ras for
> Upstream Ports and Endpoints.
> 
> Export pcie_clear_device_status() and pci_aer_clear_fatal_status() so
> cxl_core can clear PCIe/AER state during recovery.
> 
> Wire the AER core to the kfifo in this commit by adding the
> is_cxl_error() switch in handle_error_source() alongside the consumer
> registration. This way the producer and consumer go live in the same
> commit, so CXL errors are not silently dropped during bisect.
> 
> The correctable AER status is cleared by the producer in
> cxl_forward_error().
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
A few trivial things inline. With those tidied up
Reviewed-by: Jonathan Cameron <jic23@kernel.org>

> + * find_cxl_port_by_dev - Use @dev as hint to do a _by_dport or _by_uport lookup
> + * @dev: generic device that may either be a companion of port or target dport
> + * @dport: output parameter; set to the matched dport for dport-class
> + * lookups (Root Port, Downstream Port), NULL otherwise.
> + *
> + * Return a 'struct cxl_port' with an elevated reference if found. Use
> + * __free(put_cxl_port) to release.
> + */
> +static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dport **dport)
> +{
> +	struct pci_dev *pdev;
> +
> +	*dport = NULL;
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	pdev = to_pci_dev(dev);

Only used once. So little point in this step...

> +
> +	switch (pci_pcie_type(pdev)) {
	switch (pci_pcie_type(to_pci_dev(dev))) {

looks readable enough to me.

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

> +
> +static void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	struct device *dev = &pdev->dev;
> +	bool ue;
> +
> +	if (pci_dev_is_disconnected(pdev))
> +		panic("CXL cachemem error: device disconnected during UE recovery");
> +
> +	ue = cxl_handle_ras(dev, pci_get_dsn(pdev),
> +			    to_ras_base(port, dport));

My lazy (or maybe busy) nature means I haven't checked, but if this remains
the same for rest of series it fits on one line of around 78 chars.

> +	if (ue)
> +		panic("CXL cachemem error.");
> +
> +	pcie_clear_device_status(pdev);
> +	pci_aer_clear_nonfatal_status(pdev);
> +	pci_aer_clear_fatal_status(pdev);
> +}

> +int cxl_ras_init(void)
> +{
> +	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	cxl_register_proto_err_work(&cxl_proto_err_work);
> +
> +	return 0;

void cxl_ras_init() as per earlier suggestion still looks good ;)

> +}
> +
> +void cxl_ras_exit(void)
> +{
> +	cxl_cper_unregister_prot_err_work();
> +	cxl_unregister_proto_err_work();
> +}
