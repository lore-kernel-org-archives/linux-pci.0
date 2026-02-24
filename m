Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0EC1519B4;
	Tue, 24 Feb 2026 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949387; cv=none; b=bPZ3FF7japw4FhrWdED+2CSuZNR+w3EVDhWqaQNLCatJ6P7wwKVddeb5KV7HHwD1/SpprbXMD/MFBpP8Z3CCQu+OozgcFOtiULuogdhhkJcEIBx6YdPMwt+zWr5PMAR109CLRUyduK0ZDxdsKbJtMdJoWzyvRZU0mtva1+4pPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949387; c=relaxed/simple;
	bh=Zma/Bsxb2gYrxSYBtXCIAc8GnYxCZlqPhDfpInfmkI8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNKvLelxRK0v/Z8bGX0XkrLUcVRkx0JMJmlvFZaxG0CDCBB3b9ITlnHlw6GfEZw5gpBX/ZJlg1QO11GprqvN+0ZO+3hUNDBcAr2RrM62fgPuPTPFLwboJ8M8iz2u2wC63iuPKsk5Isi+V7WLjFNuj6BPWR+sS4LrkeS77u+O5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fL2jD2KGbzJ467G;
	Wed, 25 Feb 2026 00:09:20 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 23E5A40086;
	Wed, 25 Feb 2026 00:09:42 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 16:09:41 +0000
Date: Tue, 24 Feb 2026 16:09:40 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Philipp Stanner <phasta@kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 19/37] cxl/pci: Replace pci_alloc_irq_vectors() with
 pcim_alloc_irq_vectors()
Message-ID: <20260224160940.0000336c@huawei.com>
In-Reply-To: <1771861967-88542-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
	<1771861967-88542-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 23 Feb 2026 23:52:47 +0800
Shawn Lin <shawn.lin@rock-chips.com> wrote:

> pcim_enable_device() no longer automatically manages IRQ vectors via devres.
> Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
> pcim_alloc_irq_vectors() should be used.
> 
> To: Davidlohr Bueso <dave@stgolabs.net>
> To: Jonathan Cameron <jonathan.cameron@huawei.com>
> To: Dave Jiang <dave.jiang@intel.com>
> To: Alison Schofield <alison.schofield@intel.com>
> To: Vishal Verma <vishal.l.verma@intel.com>
> To: Ira Weiny <ira.weiny@intel.com>
> To: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
I am very much in favor of this change.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> 
>  drivers/cxl/pci.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index fbb300a..de5c9ff 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -565,13 +565,9 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  	 * Per CXL 3.0 3.1.1 CXL.io Endpoint a function on a CXL device must
>  	 * not generate INTx messages if that function participates in
>  	 * CXL.cache or CXL.mem.
> -	 *
> -	 * Additionally pci_alloc_irq_vectors() handles calling
> -	 * pci_free_irq_vectors() automatically despite not being called
> -	 * pcim_*.  See pci_setup_msi_context().
>  	 */
> -	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_DEFAULT_MAX_VECTORS,
> -				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +	nvecs = pcim_alloc_irq_vectors(pdev, 1, CXL_PCI_DEFAULT_MAX_VECTORS,
> +				       PCI_IRQ_MSIX | PCI_IRQ_MSI);
>  	if (nvecs < 1) {
>  		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
>  		return false;

