Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6208126C02
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503694; cv=none; b=SKbNA3ANpAORGB4EqqVq5DFdWKqoS9CnTeLvhnxJ3af3Oq20QO+O+VTqbZKNIZCHM/GBT7SSULXaG+atJujGRm1TY1qEIfh3F1cGl9D7JpHkn1L45lVzQY97wx6EvLuXmB3djftyamyGjBXHufHyc+NboaT87Um96LeHOP3EtAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503694; c=relaxed/simple;
	bh=sQFZughKibq2ffZvLKEJ60EvoiyGMGgTXsIka3Ut3nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA+LBrvMqaq4ZuVtwlp29RdxC8ddkweqbqdrpYvY3deL0ACzdrSjQAGY0n34/mZgh6Hb5OeVVdeMwbRymaJdt+4iMmgL+i+hEw0w9ISMTww87r9j+KJY7WCfH/E+hAz71orEnoqcoUhtkkfOwAnoQ7LLDKeK2e3CYi/nsRPMtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF9C2227AAE; Tue, 27 Jan 2026 09:48:08 +0100 (CET)
Date: Tue, 27 Jan 2026 09:48:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qinyun Tan <qinyuntan@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <20260127084807.GA342@lst.de>
References: <20260127073344.2489873-1-qinyuntan@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127073344.2489873-1-qinyuntan@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
> The NVMe PCI driver exports the sriov_configure callback via
> pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
> VFs through sysfs. However, when the PF driver is unbound, the driver
> does not disable SR-IOV, leaving VFs orphaned in the system.

That sounds dangerous.

> According to Documentation/PCI/pci-iov-howto.rst, PCI drivers that
> support SR-IOV should call pci_disable_sriov() in their remove callback
> to properly clean up VFs before the driver is unloaded.

Bjorn and other PCI folks: is there any reason to not do this in
the PCI code and leave a landmine for the drivers?

> Fix this by disabling SR-IOV in nvme_remove(). If VFs are not assigned
> to a guest, disable SR-IOV. If VFs are still assigned, emit a warning
> since forcibly disabling would disrupt the guest.

Well, I think we have to distrupt it, at least for hot unplug.  This
sounds like we need some better handling in the core code as well.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 58f3097888a7..4f2dc13de48b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3666,6 +3666,15 @@ static void nvme_remove(struct pci_dev *pdev)
>  	nvme_stop_ctrl(&dev->ctrl);
>  	nvme_remove_namespaces(&dev->ctrl);
>  	nvme_dev_disable(dev, true);
> +
> +	if (pci_num_vf(pdev)) {
> +		if (pci_vfs_assigned(pdev))
> +			dev_warn(&pdev->dev,
> +				 "WARNING: Removing PF while VFs are assigned - VFs will not be deallocated!\n");
> +		else
> +			pci_disable_sriov(pdev);
> +	}
> +
>  	nvme_free_host_mem(dev);
>  	nvme_dev_remove_admin(dev);
>  	nvme_dbbuf_dma_free(dev);
> -- 
> 2.43.5
---end quoted text---
