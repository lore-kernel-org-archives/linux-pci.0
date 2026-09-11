Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3C470EB5;
	Fri, 11 Sep 2026 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163110; cv=none; b=r4GSG4Isx02BL0vCRA8xQ/3xCkyRlp2C2hOiLA5lXRbq1/92jRM2ZyKkkabaet+y33P4l6tEfW/A987v8Hc7VlGpCTyra6GTkP5fgRTURf3aiK7z2kgXpfNQWMNwC85zqJ4/3aepaxxqA4/13zt01PiqZCbgROnr3jBVJ38I7AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163110; c=relaxed/simple;
	bh=XR7WX+1I4Qa8NKpz57XIbSye0B7ZlJcCBbh/8m0OVx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BWDqqSdFSVi2iAi+pv7hBY0xlpwgpImjB5wYBnzTmt6V0Tb4wPFaT9QEpH/36AmLSbJ6p77dp3TG1be7vFRCcyVRNZDSM4EZBdq6h9qtTwVXjI7tuncrtF3UJ8isaxlf02Rorr3sEhzJfuiguZ+/6dC+Txrgx70MjDlIl61WeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVsSCJ6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVsSCJ6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6663C1F000FF;
	Fri, 11 Sep 2026 21:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789163108;
	bh=p53Rp6J0AXK78MBfUyw1lAHpyXwJ7o0RR05tJbr3i3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MVsSCJ6OkXjvKudIW7k3VHTHH4ni4zUYvWI5wMiDtnA+kGjDfTR13e+AUE3jCU8f0
	 fycEDxvTUKUdiB/huYlWV0KmujqOrAoTntb9KtWmkmy/qY0JypyMsbwI8ksphVQDkt
	 RSETsodXnSsJKqfp/jFpRWgELdtcFwp5SkIMFN/PDJm/2JNqVc5uUG2MpBPurIkKLn
	 7vmaapLJH69yNZ19fDkiJAF1iIx0OjICkCnsEg+ecMUAHP71i8P5sKmIlAo+z/Jg+2
	 UTRxIYavYVCs2EV1BghMrod2Rgfi6KUgU9luhDLAaaUXt5EwcIwy3ubJ8aclzY88Ht
	 EWciKm/9rXbGg==
Date: Fri, 11 Sep 2026 16:45:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI: endpoint: pci-epf-vntb: Manage virtual NTB
 and PCI bus lifetime
Message-ID: <20260911214507.GA582865@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901063238.631166-3-den@valinux.co.jp>

On Tue, Sep 01, 2026 at 03:32:38PM +0900, Koichiro Den wrote:
> The virtual PCI driver registers an ntb_dev but has no remove callback.
> Unbinding the endpoint function can therefore free BARs while the NTB
> device and its client still use them. It also leaves the virtual PCI
> devices and root bus allocated.
> 
> Allocate an ntb_dev for each virtual PCI probe and unregister it from the
> matching remove callback. Start command processing only after registration.
> Publish the device for doorbell IRQs at the same point. During remove, stop
> the command work and drain IRQ handlers before unregistering the device.
> 
> Retain the root bus returned by pci_scan_bus() so it can be removed on
> unbind. Unregister the virtual PCI driver before releasing endpoint
> resources. Stop and remove the root bus under the PCI rescan/remove lock,
> then release its host bridge.
> 
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Cc: stable@vger.kernel.org # 6.0+
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v6:
>   - Rework v5 patch 5 on v7.3-rc1.
>   - Publish ntb_dev only after registration, and tie command work and
>     doorbell delivery to its lifetime.
>   - Retain and remove the virtual root bus, then release its host bridge.
>   - Drop v5 patch 4; f7245901de89 ("PCI: Check parent for NULL in
>     of_pci_bus_release_domain_nr()") fixed the bug it worked around.
>     v5: https://lore.kernel.org/r/20260226084142.2226875-6-den@valinux.co.jp/
> 
> @Frank, the code changed substantially since v5, so I did not carry your
> R-b tag. I would appreciate another look.
> 
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 85 +++++++++++++++----
>  1 file changed, 70 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 412e8cc6fb1d..992f5e7f8d4a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -132,7 +132,7 @@ struct epf_ntb_ctrl {
>  } __packed;
>  
>  struct epf_ntb {
> -	struct ntb_dev ntb;
> +	struct ntb_dev *ntb;
>  	struct pci_epf *epf;
>  	struct config_group group;
>  
> @@ -166,10 +166,15 @@ struct epf_ntb {
>  	void __iomem *vpci_mw_addr[MAX_MW];
>  
>  	struct delayed_work cmd_handler;
> +	struct pci_bus *vpci_bus;
>  };
>  
>  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> -#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> +
> +static struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
> +{
> +	return ntb->pdev->sysdata;
> +}
>  
>  static struct pci_epf_header epf_ntb_header = {
>  	.vendorid	= PCI_ANY_ID,
> @@ -195,7 +200,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  	else
>  		ntb->reg->link_status &= ~LINK_STATUS_UP;
>  
> -	ntb_link_event(&ntb->ntb);
> +	ntb_link_event(ntb->ntb);
>  	return 0;
>  }
>  
> @@ -284,7 +289,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  	     i++) {
>  		if (ntb->epf_db[i]) {
>  			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
> -			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
> +			ntb_db_event(ntb->ntb, i - EPF_IRQ_DB_START);
>  			ntb->epf_db[i] = 0;
>  		}
>  	}
> @@ -348,12 +353,18 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
>  {
>  	struct epf_ntb *ntb = data;
> +	struct ntb_dev *ndev;
>  	int i;
>  
> +	/* Pair with smp_store_release() in pci_vntb_probe(). */
> +	ndev = smp_load_acquire(&ntb->ntb);
> +	if (!ndev)
> +		return IRQ_HANDLED;
> +
>  	for (i = EPF_IRQ_DB_START; i < ntb->db_count; i++)
>  		if (irq == ntb->epf->db_msg[i].virq) {
>  			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
> -			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
> +			ntb_db_event(ndev, i - EPF_IRQ_DB_START);
>  		}
>  
>  	return IRQ_HANDLED;
> @@ -985,7 +996,6 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  	}
>  
>  	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
> -	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
>  
>  	atomic64_set(&ntb->peer_db_pending, 0);
>  	enable_work(&ntb->peer_db_work);
> @@ -1340,6 +1350,7 @@ static int vpci_scan_bus(void *sysdata)
>  		pci_unlock_rescan_remove();
>  		return -EINVAL;
>  	}
> +	ndev->vpci_bus = vpci_bus;
>  
>  	pci_bus_add_devices(vpci_bus);
>  
> @@ -1425,7 +1436,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	int ret;
>  	struct device *dev;
>  
> -	dev = &ntb->ntb.dev;
> +	dev = &ndev->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
>  	epf_bar->phys_addr = addr;
> @@ -1563,7 +1574,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>  			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
>  						PCI_IRQ_MSI, interrupt_num);
>  			if (ret)
> -				dev_err(&ntb->ntb.dev,
> +				dev_err(&epf->dev,
>  					"Failed to raise IRQ for interrupt_num %u: %d\n",
>  					interrupt_num, ret);
>  		}
> @@ -1681,13 +1692,18 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>  
>  static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> -	int ret;
>  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
>  	struct device *dev = &pdev->dev;
> +	struct ntb_dev *ntb;
> +	int ret;
> +
> +	ntb = devm_kzalloc(dev, sizeof(*ntb), GFP_KERNEL);
> +	if (!ntb)
> +		return -ENOMEM;
>  
> -	ndev->ntb.pdev = pdev;
> -	ndev->ntb.topo = NTB_TOPO_NONE;
> -	ndev->ntb.ops =  &vntb_epf_ops;
> +	ntb->pdev = pdev;
> +	ntb->topo = NTB_TOPO_NONE;
> +	ntb->ops = &vntb_epf_ops;
>  
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
> @@ -1695,16 +1711,41 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return ret;
>  	}
>  
> -	ret = ntb_register_device(&ndev->ntb);
> +	ret = ntb_register_device(ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
>  		return ret;
>  	}
>  
> +	/* Publish after ntb_register_device() succeeds. */
> +	smp_store_release(&ndev->ntb, ntb);
> +	queue_delayed_work(kpcintb_workqueue, &ndev->cmd_handler, 0);
> +
>  	dev_dbg(dev, "PCI Virtual NTB driver loaded\n");
>  	return 0;
>  }
>  
> +static void pci_vntb_remove(struct pci_dev *pdev)
> +{
> +	struct epf_ntb *ndev = pdev->sysdata;
> +	struct ntb_dev *ntb;
> +	unsigned int i;
> +
> +	/* Stop the work reader, then close and drain the IRQ gate. */
> +	cancel_delayed_work_sync(&ndev->cmd_handler);
> +
> +	ntb = xchg(&ndev->ntb, NULL);
> +
> +	if (ndev->msi_doorbell)
> +		for (i = 0; i < ndev->db_count; i++) {
> +			if (epf_ntb_db_irq_is_duplicated(ndev->epf, i))
> +				continue;
> +			synchronize_irq(ndev->epf->db_msg[i].virq);
> +		}
> +
> +	ntb_unregister_device(ntb);
> +}
> +
>  static struct pci_device_id pci_vntb_table[] = {
>  	{
>  		PCI_DEVICE(0xffff, 0xffff),
> @@ -1716,6 +1757,7 @@ static struct pci_driver vntb_pci_driver = {
>  	.name           = "pci-vntb",
>  	.id_table       = pci_vntb_table,
>  	.probe          = pci_vntb_probe,
> +	.remove         = pci_vntb_remove,
>  };
>  
>  /* ============ PCIe EPF Driver Bind ====================*/
> @@ -1796,12 +1838,25 @@ static int epf_ntb_bind(struct pci_epf *epf)
>   */
>  static void epf_ntb_unbind(struct pci_epf *epf)
>  {
> +	struct pci_host_bridge *bridge;
>  	struct epf_ntb *ntb = epf_get_drvdata(epf);
>  
> +	pci_unregister_driver(&vntb_pci_driver);
> +
> +	if (ntb->vpci_bus) {
> +		bridge = to_pci_host_bridge(ntb->vpci_bus->bridge);

Where was this host bridge allocated?

> +		pci_lock_rescan_remove();
> +		pci_stop_root_bus(ntb->vpci_bus);
> +		pci_remove_root_bus(ntb->vpci_bus);
> +		ntb->vpci_bus = NULL;
> +		pci_unlock_rescan_remove();
> +
> +		pci_free_host_bridge(bridge);
> +	}
> +
>  	epf_ntb_epc_cleanup(ntb);
>  	epf_ntb_config_spad_bar_free(ntb);
> -
> -	pci_unregister_driver(&vntb_pci_driver);
>  }
>  
>  // EPF driver probe
> -- 
> 2.51.0
> 
