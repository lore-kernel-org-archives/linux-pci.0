Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D77263B;
	Tue,  3 Mar 2026 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772515339; cv=none; b=DgXYS2kkBYZzQIUMk2XQ3fUDB7DT2fKG+lCSJwBoxCk6JL4qgEZ7r88dihx9P/u4cj0I43PxRQH9pDMbHNHbx07nuv0IT3m+mXI4Wkd/HSvWJy3ZxLdHqY67k9Jz6TjEJdmFp/1AU9yO6DQ8DQ0J2+CRkLQ28ggQ4ygaTzJaqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772515339; c=relaxed/simple;
	bh=NOYylHBlMQbBtXZu0UXpu7/CxXYgpOwYxTWB01e2VtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0znDQcXhUa2OauuXo/Z5pPX4pO70Xup46Y5VyXaaU+obXWFbSMoFOpMUWpPW72FP4vW0EAZ3lkpsgRb1iIvfSW0pxrPxZRzGCR0R5duk7PqgZwPpROawVu+0jNW5SiXP7fZNuNHZGcn1LRSHk29aS9rwlI69FUCcxRTmbouyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJidQr7l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJidQr7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7880C116C6;
	Tue,  3 Mar 2026 05:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772515338;
	bh=NOYylHBlMQbBtXZu0UXpu7/CxXYgpOwYxTWB01e2VtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJidQr7lbI7MwqVGxs6gOFoxIKSz0XZON46GUida+Q/M83iCU3tp5QaA/DlXULXTl
	 KW5A3vx2Vj59z7FROiFQ+JV9W1d10AqD0sZz4unS0KNlHRCmgyCP54GzjzgJIEuQk2
	 Jbc8jTBqhUktmv9jFqlDr5EnDj7i5wAg2eN7yXo/4nXpHFBUf87+A/f6TIT0W70E46
	 TdIdVy428vZ0d7HC8Wy7L5XQCliI3+NmZZ4XBOhjgv8v/WDwxMD4+6lySOZhn4hJdT
	 ioUpifJfmYIHKHuVf4QL9Mj/V+JG6onZJeAWyXz0eELetuqzyzVT3jJgUDw/AoXqk7
	 2B+T7SW1MbUcQ==
Date: Tue, 3 Mar 2026 10:52:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, kwilczynski@kernel.org, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ye Bin <yebin10@huawei.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: endpoint: pci-epf-vntb: manage ntb_dev
 lifetime and fix vpci bus teardown
Message-ID: <f3tt2dt63el5v7lzqabgnjcs2vrcj44xot2nrbkxjnqcpmyivs@o6xdl2aarsbi>
References: <20260226084142.2226875-1-den@valinux.co.jp>
 <20260226084142.2226875-6-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226084142.2226875-6-den@valinux.co.jp>

On Thu, Feb 26, 2026 at 05:41:42PM +0900, Koichiro Den wrote:
> Currently ntb_dev is embedded in epf_ntb, while configfs allows starting
> or stopping controller and linking or unlinking functions as you want.
> In fact, re-linking and re-starting is not possible with the embedded
> design and leads to oopses.
> 
> Allocate ntb_dev with devm and add a .remove callback to the pci driver
> that calls ntb_unregister_device(). This allows a fresh device to be
> created on the next .bind call.
> 
> With these changes, the controller can now be stopped, a function
> unlinked, configfs settings updated, and the controller re-linked and
> restarted without rebooting the endpoint, as long as the underlying
> pci_epc_ops .stop() operation is non-destructive, and .start() can
> restore normal operations.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v4:
>   - Adjusted context due to commit:
>     dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")
> 
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 53 ++++++++++++++-----
>  1 file changed, 40 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index f353e9a57194..41a2f42e8a39 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -120,7 +120,7 @@ struct epf_ntb_ctrl {
>  } __packed;
>  
>  struct epf_ntb {
> -	struct ntb_dev ntb;
> +	struct ntb_dev *ntb;
>  	struct pci_epf *epf;
>  	struct config_group group;
>  
> @@ -147,10 +147,16 @@ struct epf_ntb {
>  	void __iomem *vpci_mw_addr[MAX_MW];
>  
>  	struct delayed_work cmd_handler;
> +
> +	struct pci_bus *vpci_bus;
>  };
>  
>  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> -#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> +
> +static inline struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)

Nit: No need of 'inline' keyword in a .c file.

- Mani

> +{
> +	return (struct epf_ntb *)ntb->pdev->sysdata;
> +}
>  
>  static struct pci_epf_header epf_ntb_header = {
>  	.vendorid	= PCI_ANY_ID,
> @@ -176,7 +182,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  	else
>  		ntb->reg->link_status &= ~LINK_STATUS_UP;
>  
> -	ntb_link_event(&ntb->ntb);
> +	ntb_link_event(ntb->ntb);
>  	return 0;
>  }
>  
> @@ -264,7 +270,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
>  		if (ntb->epf_db[i]) {
>  			atomic64_or(1 << (i - 1), &ntb->db);
> -			ntb_db_event(&ntb->ntb, i);
> +			ntb_db_event(ntb->ntb, i);
>  			ntb->epf_db[i] = 0;
>  		}
>  	}
> @@ -333,7 +339,7 @@ static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
>  	for (i = 1; i < ntb->db_count; i++)
>  		if (irq == ntb->epf->db_msg[i].virq) {
>  			atomic64_or(1 << (i - 1), &ntb->db);
> -			ntb_db_event(&ntb->ntb, i);
> +			ntb_db_event(ntb->ntb, i);
>  		}
>  
>  	return IRQ_HANDLED;
> @@ -1237,6 +1243,7 @@ static int vpci_scan_bus(void *sysdata)
>  		pr_err("create pci bus failed\n");
>  		return -EINVAL;
>  	}
> +	ndev->vpci_bus = vpci_bus;
>  
>  	pci_bus_add_devices(vpci_bus);
>  
> @@ -1281,7 +1288,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	int ret;
>  	struct device *dev;
>  
> -	dev = &ntb->ntb.dev;
> +	dev = &ntb->ntb->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
>  	epf_bar->phys_addr = addr;
> @@ -1381,7 +1388,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
>  	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
>  				PCI_IRQ_MSI, interrupt_num + 1);
>  	if (ret)
> -		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
> +		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
>  
>  	return ret;
>  }
> @@ -1468,9 +1475,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
>  	struct device *dev = &pdev->dev;
>  
> -	ndev->ntb.pdev = pdev;
> -	ndev->ntb.topo = NTB_TOPO_NONE;
> -	ndev->ntb.ops =  &vntb_epf_ops;
> +	ndev->ntb = devm_kzalloc(dev, sizeof(*ndev->ntb), GFP_KERNEL);
> +	if (!ndev->ntb)
> +		return -ENOMEM;
> +	ndev->ntb->pdev = pdev;
> +	ndev->ntb->topo = NTB_TOPO_NONE;
> +	ndev->ntb->ops = &vntb_epf_ops;
>  
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
> @@ -1478,7 +1488,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return ret;
>  	}
>  
> -	ret = ntb_register_device(&ndev->ntb);
> +	ret = ntb_register_device(ndev->ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
>  		return ret;
> @@ -1488,6 +1498,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return 0;
>  }
>  
> +static void pci_vntb_remove(struct pci_dev *pdev)
> +{
> +	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> +
> +	if (!ndev || !ndev->ntb)
> +		return;
> +
> +	ntb_unregister_device(ndev->ntb);
> +	ndev->ntb = NULL;
> +}
> +
>  static struct pci_device_id pci_vntb_table[] = {
>  	{
>  		PCI_DEVICE(0xffff, 0xffff),
> @@ -1499,6 +1520,7 @@ static struct pci_driver vntb_pci_driver = {
>  	.name           = "pci-vntb",
>  	.id_table       = pci_vntb_table,
>  	.probe          = pci_vntb_probe,
> +	.remove         = pci_vntb_remove,
>  };
>  
>  /* ============ PCIe EPF Driver Bind ====================*/
> @@ -1581,10 +1603,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
>  {
>  	struct epf_ntb *ntb = epf_get_drvdata(epf);
>  
> +	pci_unregister_driver(&vntb_pci_driver);
> +
> +	pci_lock_rescan_remove();
> +	pci_stop_root_bus(ntb->vpci_bus);
> +	pci_remove_root_bus(ntb->vpci_bus);
> +	pci_unlock_rescan_remove();
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

-- 
மணிவண்ணன் சதாசிவம்
