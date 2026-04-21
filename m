Received: from mail-m3286.qiye.163.com (mail-m3286.qiye.163.com [220.197.32.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02751D5CE0;
	Tue, 21 Apr 2026 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739125; cv=none; b=U1WdzXGNqntD3hF8qQ6nvb5TD4AQiFjpyFVzusV3RhgFkz6UW28HY7qtZl0oLZypDQ34aJu/st3myZjXJK30i1g8lVxlo5WQxSR6CKObK9XCST1OaYKGOq/iiC/iixIi0TKxDjPLy0Wxm7xdObu60Y/I/UqLvB9Qtspqx8zx56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739125; c=relaxed/simple;
	bh=JFhQ9eS307aoASJMXZjEXduN3hJhk2lOgWQP8TXF7gs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gN+YZEqafs4twsgzW9lA4ueNnPpxZdUOUxs5oCNkawv3vOOKpsn7NWQVQuUYk8Z7bB141rpD8SmfHJhjl8wp2ARBGbw0x4esKS1RrjKqlwWWPUKo6ue4DWn+fNWPOFoFjGYzYSr4Gu2947NX9C+Uii9JaAHz4REaPZ4IrW1lMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HFTUVuKF; arc=none smtp.client-ip=220.197.32.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HFTUVuKF"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b7964d53;
	Tue, 21 Apr 2026 09:22:47 +0800 (GMT+08:00)
Message-ID: <68f9def1-5828-aa30-8887-4b6594595bad@rock-chips.com>
Date: Tue, 21 Apr 2026 09:22:43 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Initialize pp->lock before MSI domain
 registration
To: Yadu M G <yadu.mg@oss.qualcomm.com>, jingoohan1@gmail.com, mani@kernel.org
References: <20260414065214.3085209-1-yadu.mg@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260414065214.3085209-1-yadu.mg@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9dada1fbf509cckunmda2d5f7c8999d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUwdGlZDTxhCTUMeHU1JHk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HFTUVuKFPCzdxKsABvy82iK1bbW1IorxuM9WVeXodGQEmGkpAXQ56LRbxv5/4YIKmVcV/mWP6EuN5mOu4TRlsgPBV97RREuDaTjmDBYKIb/XHORl2QmA6Z7MRm4TIfE6qQdTwxuOrWRGV3wVsQKjs1Q/3oVw2mfibux7DewZhtE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=dJaE3Wn3IfhoI0exjApvqtC03SMDFDnp0AnNhW9LRxs=;
	h=date:mime-version:subject:message-id:from;


在 2026/04/14 星期二 14:52, Yadu M G 写道:
> A lockdep warning is observed during boot on a Qcom firmware managed
> platform:
> 
>    INFO: trying to register non-static key.
>    The code is fine but needs lockdep annotation, or maybe
>    you didn't initialize this object before use?
>    turning off the locking correctness validator.
>    ...
>    Call trace:
>     register_lock_class+0x128/0x4d8
>     __lock_acquire+0x110/0x1db0
>     lock_acquire+0x278/0x3d8
>     _raw_spin_lock_irq+0x6c/0xc0
>     dw_pcie_irq_domain_alloc+0x48/0x190
>     irq_domain_alloc_irqs_parent+0x2c/0x48
>     msi_domain_alloc+0x90/0x160
>    ...
> 
> dw_pcie_irq_domain_alloc() takes pp->lock while allocating MSI
> interrupts. pp->lock was initialized in dw_pcie_host_init(). However,
> some DWC glue drivers like those on Qcom firmware managed platforms
> allocate MSI domains from their .msi_init callback by calling
> dw_pcie_allocate_domains() directly, bypassing dw_pcie_host_init(). This
> leaves pp->lock without a lockdep key and triggers the warning when MSI
> vectors are later allocated.
> 
> Initialize pp->lock in dw_pcie_allocate_domains() immediately before
> registering the MSI IRQ domain so the lock is always initialized for
> every caller path.
> 

If pci_msi_enabled()returns false in dw_pcie_host_init()(e.g., via the
pci=nomsi), the call to dw_pcie_allocate_domains() is skipped entirely,
leaving pp‑>lock uninitialized. Since the same lock is also used to
protect legacy INTx interrupts in some glue drivers (pcie‑sophgo.c or
pcie‑uniphier.c), could those drivers attempt to acquire an
uninitialized lock when unmasking or handling INTx interrupts? If so, we
would need to ensure the lock is initialized regardless of the MSI
enable state.

Moreover, sophgo_pcie_host_init() calls sophgo_pcie_msi_enable() which
need to acquires pp->lock with a uninitialized lock with your patch now.
That could possible break all other variant drivers which need this lock
in the .init() callback.

> Signed-off-by: Yadu M G <yadu.mg@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index c9517a348836..8acd671bbc8c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -215,6 +215,14 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
>   		.host_data	= pp,
>   	};
>   
> +	/*
> +	 * Initialize the lock here rather than in dw_pcie_host_init() so that
> +	 * drivers using a custom msi_init() callback that call
> +	 * dw_pcie_allocate_domains() directly also have the lock properly
> +	 * initialized before dw_pcie_irq_domain_alloc() can be invoked.
> +	 */
> +	raw_spin_lock_init(&pp->lock);
> +
>   	pp->irq_domain = msi_create_parent_irq_domain(&info, &dw_pcie_msi_parent_ops);
>   	if (!pp->irq_domain) {
>   		dev_err(pci->dev, "Failed to create IRQ domain\n");
> @@ -573,8 +581,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   	struct pci_host_bridge *bridge;
>   	int ret;
>   
> -	raw_spin_lock_init(&pp->lock);
> -
>   	bridge = devm_pci_alloc_host_bridge(dev, 0);
>   	if (!bridge)
>   		return -ENOMEM;
