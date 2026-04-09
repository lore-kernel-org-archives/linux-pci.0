Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69173296BAF;
	Thu,  9 Apr 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759460; cv=none; b=H1e7Ep3YHx7TFsEhfa5mrHdFb3Wiuw6RMVySOXmrTO79/CIKlgX1VxA23n0jTdq0pDp7p80lbbYBf4/lz5tNF/jOyA0+QkL0poIEKK4QxKtfjAX+d4ck8r0GBtE5Xt/Jut7HLRmVrEgT4ohVrQcFiVGdPY73jFQhyrY7yWO/zO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759460; c=relaxed/simple;
	bh=s21/iICOfgS4PQH3e9VfF/zirOs9dwtgCi0+dUzZy9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IL9v/tOcA4pMB/FZrq12U+S/Lc4Cc5Kzc5aJHGliRG6PgOM5UvcLC4Q3mmo7Y3Z1mqoVpDovKEVeyuji27kfT1LUf5gk2J81cNIVsIZw7xRR5Ubm7Jc/h3p2WZjGLNrDHMvbD8rdgc0lv+Fu2V9/CLeZxqGnR64hgp/7Nhd/U+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ms7M6ePs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIPBni0N; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ms7M6ePs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIPBni0N"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E49814002AB;
	Thu,  9 Apr 2026 14:30:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 14:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775759456;
	 x=1775845856; bh=ABOAmFwOdQ1RvMMRK07TWzUTed6xOOr5FsPWYBl2G4Q=; b=
	ms7M6ePsFxTWfknoQwAI/xlJS49cBkwGUhV+s8IAOfNmBd/dIIk0EvsGaTMduh2J
	k6jbvjigPk8J833VVkpB14a+o3xv5maxy1vgVHh+jrMCELgRsIB45rdNDrQytyne
	4w7tirQQL9UEzefjmA9ywYXR5fWlsUwl9VDAOOe0FH1xWgJRvZwiJodMTlcVKnuU
	Q71RTvMtZs4UVdvVeyQ5Nx8RlpYWekPAvfIKSJ+bwaS7Ljrm2bp8OIJUhB0HAEtz
	oiwYbTZvgmu+2pmGbzcnJ7dl5Ttm87X2aYQQbacuCcUWiCWrvFrTlLbYGij008Wx
	wfOaOZx/+AkPgkJkXz0UdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775759456; x=
	1775845856; bh=ABOAmFwOdQ1RvMMRK07TWzUTed6xOOr5FsPWYBl2G4Q=; b=L
	IPBni0NlfFPMqU2ToDEU8fC92IbZO2K7HuAvqmDmkUQNDASfM/LDnqaGqI4YcmYa
	O6+ZGjlRAUMtE/EHrDSTHv3vFl5xSPDx1ij5wui989HH7WZZ8AAjhdAsGHnVVC9M
	WmjJE0hgbxaOyjqDpkb+SIO3MrHsF+DMHn1bwCQSOYcuzC4dgvS7i5SPvNU6DgmK
	e3s4LsSue3AXCm/3bMArMKz0V4CQMqkyUz3ZKgxE1p1hvo5WH4CgczsNzrcppQ/n
	jIn3PM6iu9/809czxoNxFepAvtmSWt4CuDVIeRU4ZU86k/BLwi7nvkZrOilvT2l4
	MqTbmYGLohtqWjeFNfgnQ==
X-ME-Sender: <xms:X_DXaUtdtBLxa3fOag9cZ-PZUEMCLlz3Dx8tu0NhLpuX-WJtBXlbww>
    <xme:X_DXaXeSw-b6G7BFWvKJGiQhXvEt_r1CdFHNyaKvI6edALN19eHd-aJRv_VilWvSG
    1tWAFsFIyc86linWr8ZUW50Wf-wsfgeNnfj58kEhIYxiUDO-kO-Rw>
X-ME-Received: <xmr:X_DXaamvUMLmQ-NeYsJAxHp5izUH-l4yABd0nnK66zO96Pn9Bc2rprZYrjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghnkhhithgrsehnvhhiughirgdrtghomhdprhgtph
    htthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhgghes
    iihivghpvgdrtggrpdhrtghpthhtohephihishhhrghihhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepshhkohhlohhthhhumhhthhhosehnvhhiughirgdrtghomhdprhgtphht
    thhopehkvghvihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopegshhgvlh
    hgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:X_DXaaCxanqVKUY8-3NLn9LlpVzHkgFjdBJksYZOvOSP6KrrvU4i1g>
    <xmx:X_DXaUMj_gPPKq0jC58XbO4IHFBOY1mSZC-Xy7dCzFvFYjNsjlKR-w>
    <xmx:X_DXaZO7HwUt4xtgDeB44ADV5KuV8BDXLcsf7CbXxIqH0USzUb-low>
    <xmx:X_DXaUkz2w1BkQXKqGcfNhIiY-SEtBU9vmp42xbnDsgis9Vqzt8bUA>
    <xmx:YPDXaUaWUHgD4FlPpQan4HF6qKP2WZALzBrK9kU8lr-utPN0ruefzbk->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 14:30:54 -0400 (EDT)
Date: Thu, 9 Apr 2026 12:30:53 -0600
From: Alex Williamson <alex@shazbot.org>
To: Ankit Agrawal <ankita@nvidia.com>, <bhelgaas@google.com>
Cc: <kvm@vger.kernel.org>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v2 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Message-ID: <20260409123053.55c407fd@shazbot.org>
In-Reply-To: <20260409133651.92580-1-ankita@nvidia.com>
References: <20260409133651.92580-1-ankita@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Apr 2026 13:36:51 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
> the existing legacy BAR0 polling path. On probe and after reset, the
> driver reads the CXL Device DVSEC capability to determine whether the
> GPU memory is valid. This is checked by polling on the Memory_Active bit
> based on the Memory_Active_Timeout.
> 
> A static inline wrapper dispatches to the appropriate readiness check
> based on whether the CXL DVSEC capability is present.
> 
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 75 ++++++++++++++++++++++++++---
>  include/uapi/linux/pci_regs.h       |  1 +
>  2 files changed, 68 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index fa056b69f899..52f7e3a3054a 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -64,6 +64,8 @@ struct nvgrace_gpu_pci_core_device {
>  	bool has_mig_hw_bug;
>  	/* GPU has just been reset */
>  	bool reset_done;
> +	/* CXL Device DVSEC offset; 0 if not present (legacy GB path) */
> +	int cxl_dvsec;
>  };
>  
>  static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_vdev)
> @@ -242,7 +244,7 @@ static void nvgrace_gpu_close_device(struct vfio_device *core_vdev)
>  	vfio_pci_core_close_device(core_vdev);
>  }
>  
> -static int nvgrace_gpu_wait_device_ready(void __iomem *io)
> +static int nvgrace_gpu_wait_device_ready_legacy(void __iomem *io)
>  {
>  	unsigned long timeout = jiffies + msecs_to_jiffies(POLL_TIMEOUT_MS);
>  
> @@ -256,6 +258,59 @@ static int nvgrace_gpu_wait_device_ready(void __iomem *io)
>  	return -ETIME;
>  }
>  
> +/*
> + * Decode the 3-bit Memory_Active_Timeout field from CXL DVSEC Range 1 Low
> + * (bits 15:13) into milliseconds. Encoding per CXL spec r4.0 sec 8.1.3.8.2:
> + * 000b = 1s, 001b = 4s, 010b = 16s, 011b = 64s, 100b = 256s,
> + * 101b-111b = reserved (clamped to 256s).
> + */
> +static inline unsigned long nvgrace_gpu_cxl_mem_active_timeout_ms(u8 timeout)
> +{
> +	return 1000UL << (2 * min_t(u8, timeout, 4));
> +}
> +
> +static int nvgrace_gpu_wait_device_ready_bw_next(struct nvgrace_gpu_pci_core_device *nvdev)
> +{
> +	struct pci_dev *pdev = nvdev->core_device.pdev;
> +	int pcie_dvsec = nvdev->cxl_dvsec;
> +	unsigned long timeout;
> +	u32 dvsec_memory_status;
> +	u8 mem_active_timeout;
> +
> +	pci_read_config_dword(pdev, pcie_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
> +			      &dvsec_memory_status);
> +
> +	if (!(dvsec_memory_status & PCI_DVSEC_CXL_MEM_INFO_VALID))
> +		return -ENODEV;

Nit, if MEM_ACTIVE is already set, we still read it twice rather than
exit here:

	if (dvsec_memory_status & PCI_DVSEC_CXL_MEM_ACTIVE)
		return 0;


> +
> +	mem_active_timeout = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT,
> +				       dvsec_memory_status);
> +
> +	timeout = jiffies +
> +		  msecs_to_jiffies(nvgrace_gpu_cxl_mem_active_timeout_ms(mem_active_timeout));
> +
> +	do {
> +		pci_read_config_dword(pdev,
> +				      pcie_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
> +				      &dvsec_memory_status);
> +
> +		if (dvsec_memory_status & PCI_DVSEC_CXL_MEM_ACTIVE)
> +			return 0;

Do we need to monitor PCI_DVSEC_CXL_MEM_INFO_VALID in the loop too?

> +
> +		msleep(POLL_QUANTUM_MS);
> +	} while (!time_after(jiffies, timeout));
> +
> +	return -ETIME;
> +}
> +
> +static inline int nvgrace_gpu_wait_device_ready(struct nvgrace_gpu_pci_core_device *nvdev,
> +						void __iomem *io)
> +{
> +	return nvdev->cxl_dvsec ?
> +		nvgrace_gpu_wait_device_ready_bw_next(nvdev) :
> +		nvgrace_gpu_wait_device_ready_legacy(io);
> +}
> +
>  /*
>   * If the GPU memory is accessed by the CPU while the GPU is not ready
>   * after reset, it can cause harmless corrected RAS events to be logged.
> @@ -275,7 +330,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>  	if (!__vfio_pci_memory_enabled(vdev))
>  		return -EIO;
>  
> -	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
> +	ret = nvgrace_gpu_wait_device_ready(nvdev, vdev->barmap[0]);
>  	if (ret)
>  		return ret;
>  
> @@ -1146,8 +1201,9 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
>   * Ensure that the BAR0 region is enabled before accessing the
>   * registers.
>   */
> -static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
> +static int nvgrace_gpu_probe_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>  {
> +	struct pci_dev *pdev = nvdev->core_device.pdev;
>  	void __iomem *io;
>  	int ret;
>  
> @@ -1165,7 +1221,7 @@ static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
>  		goto iomap_exit;
>  	}
>  
> -	ret = nvgrace_gpu_wait_device_ready(io);
> +	ret = nvgrace_gpu_wait_device_ready(nvdev, io);
>  
>  	pci_iounmap(pdev, io);
>  iomap_exit:
> @@ -1183,10 +1239,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
>  	u64 memphys, memlength;
>  	int ret;
>  
> -	ret = nvgrace_gpu_probe_check_device_ready(pdev);
> -	if (ret)
> -		return ret;
> -
>  	ret = nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
>  	if (!ret)
>  		ops = &nvgrace_gpu_pci_ops;
> @@ -1198,6 +1250,13 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
>  
>  	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
>  
> +	nvdev->cxl_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +						     PCI_DVSEC_CXL_DEVICE);
> +
> +	ret = nvgrace_gpu_probe_check_device_ready(nvdev);
> +	if (ret)
> +		goto out_put_vdev;
> +
>  	if (ops == &nvgrace_gpu_pci_ops) {
>  		nvdev->has_mig_hw_bug = nvgrace_gpu_has_mig_hw_bug(pdev);
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350..718fb630f5bb 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1357,6 +1357,7 @@
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT		__GENMASK(15, 13)

Bjorn, please ack if this is ok to go through vfio.  Thanks,

Alex

>  #define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
>  #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))

