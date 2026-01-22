Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7613B319870;
	Thu, 22 Jan 2026 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106730; cv=none; b=ZPq7qONL59f8g7OcHE1Aoqpu4b0pt3u8/YXssh5Lmn4o3kjsXxoPq2WRMKS9pbNs04yMP6azsT1Qu0ZSBcWLq73OtXE/M6zlf7ZqDiLMZDAtNxfEIKwi6+nJfMMg+632YAiHlS6az/S4SlgXNDZVK7zxsNldY+03DJOU1BUuvAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106730; c=relaxed/simple;
	bh=EdtpGx1UHhrAGig3YNfiewCQ0GDmEQUPyGnPC8vfAts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KOtJLfdMkXj+W16sp2itodG1wA8oF2UMhqBbzAnkaUBkljnSA7fijwTVvT9yGIXzCYKGk1WOvnxOm9UbDaxsYyjhrZWDwJkHqO5XcjrvxXoIw/Ou6dYrgbPxNLG7BbBMWxj/R/A8RlLSkUAURv+g6/a7NXOREQ+4pekfhmuZ1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGRRZTvw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGRRZTvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E235CC116C6;
	Thu, 22 Jan 2026 18:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769106728;
	bh=EdtpGx1UHhrAGig3YNfiewCQ0GDmEQUPyGnPC8vfAts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NGRRZTvwNo3+i6RWboTgQFHZ5EzBTeSS/Yf21d0YquLRdPVWk3B5WsrWXEUJZ0F4U
	 MR0uqlaIwFv+nY3wpZkRX4iW7gIfWqDaWWS+T4nRVqF2J0sMhJkQQEdwZm29uRTvNm
	 /V4DYJcKPTV0tybKeqXtOotKgKh6i4VeNPsfszveGRqpUy+SeLqCL9gVwu/tOS0cOC
	 UXdTC6A6bmIX8yHoe8iGtZTt6NXRa8TcSBXkQru/gMSenhV7CtxTP0SMsdHk/UOw9I
	 lwnCfmAS4cAGgnSPK4d8an9uLz8aTyW8ScDC+eVvRR0//bGvY6uOkSldm0lIAQQnF9
	 xE0mSFD2WbHcw==
Date: Thu, 22 Jan 2026 12:32:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 30/34] PCI/AER: Dequeue forwarded CXL error
Message-ID: <20260122183206.GA17240@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-31-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:51PM -0600, Terry Bowman wrote:
> The AER driver now forwards CXL protocol errors to the CXL driver via a
> kfifo. The CXL driver must consume these work items and initiate protocol
> error handling while ensuring the device's RAS mappings remain valid
> throughout processing.
> 
> Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
> AER service driver. Lock the parent CXL Port device to ensure the CXL
> device's RAS registers are accessible during handling. Add pdev reference-put
> to match reference-get in AER driver. This will ensure pdev access after
> kfifo dequeue. These changes apply to CXL Ports and CXL Endpoints.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I suppose you used a "PCI/AER" prefix just so I would look at this
patch :)  Like the other one, this only touches drivers/pci
incidentally, so I don't think it really merits "PCI/AER".  Might just
have to poke me directly if you want my ack on things like this.

>  drivers/cxl/core/core.h       |  3 ++
>  drivers/cxl/core/port.c       |  6 +--
>  drivers/cxl/core/ras.c        | 98 +++++++++++++++++++++++++++++++----
>  drivers/pci/pcie/aer_cxl_vh.c |  1 +
>  4 files changed, 94 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 306762a15dc0..39324e1b8940 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -169,6 +169,9 @@ static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>  #endif /* CONFIG_CXL_RAS */
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
>  
>  struct cxl_hdm;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index a535e57360e0..0bec10be5d56 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1335,8 +1335,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> @@ -1578,7 +1578,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
>   * Function takes a device reference on the port device. Caller should do a
>   * put_device() when done.
>   */
> -static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>  {
>  	struct device *dev;
>  
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index bf82880e19b4..0c640b84ad70 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -117,17 +117,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> -int cxl_ras_init(void)
> -{
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> -}
> -
> -void cxl_ras_exit(void)
> -{
> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> -	cancel_work_sync(&cxl_cper_prot_err_work);
> -}
> -
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>  {
>  	struct cxl_register_map *map = &dport->reg_map;
> @@ -173,6 +162,44 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>  
> +/*
> + * Return 'struct cxl_port *' parent CXL Port of dev
> + *
> + * Reference count increments returned port on success
> + *
> + * @pdev: Find the parent CXL Port of this device
> + */
> +static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
> +{
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	{
> +		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port;
> +	}
> +	}
> +	pci_warn_once(pdev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -316,3 +343,52 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +
> +static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
> +{
> +}
> +
> +static void cxl_proto_err_work_fn(struct work_struct *work)
> +{
> +	struct cxl_proto_err_work_data wd;
> +
> +	while (cxl_proto_err_kfifo_get(&wd)) {
> +		struct pci_dev *pdev __free(pci_dev_put) = wd.pdev;
> +
> +		if (!pdev) {
> +			pr_err_ratelimited("NULL PCI device passed in AER-CXL KFIFO\n");
> +			continue;
> +		}
> +
> +		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +		if (!port) {
> +			pr_err_ratelimited("Failed to find parent Port device in CXL topology.\n");
> +			continue;
> +		}
> +		guard(device)(&port->dev);
> +
> +		cxl_handle_proto_error(&wd);
> +	}
> +}
> +
> +static struct work_struct cxl_proto_err_work;
> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
> +
> +int cxl_ras_init(void)
> +{
> +	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
> +		pr_err("Failed to initialize CXL RAS CPER\n");
> +
> +	cxl_register_proto_err_work(&cxl_proto_err_work);
> +
> +	return 0;
> +}
> +
> +void cxl_ras_exit(void)
> +{
> +	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> +	cancel_work_sync(&cxl_cper_prot_err_work);
> +
> +	cxl_unregister_proto_err_work();
> +	cancel_work_sync(&cxl_proto_err_work);
> +}
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index 2189d3c6cef1..0f616f5fafcf 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -48,6 +48,7 @@ void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
>  	};
>  
>  	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
> +	pci_dev_get(pdev);
>  	if (!cxl_proto_err_kfifo.work || !kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
>  		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo error");
>  		return;
> -- 
> 2.34.1
> 
