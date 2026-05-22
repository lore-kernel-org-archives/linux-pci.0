Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFC2E889C;
	Fri, 22 May 2026 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779423050; cv=none; b=BRh2puMii99/6WhWBT4XWHRzyyQEO8eWXJwi8Ojyh7cqIZZxYOkq0IaQFxHQMjcLPr45KWlt97RNf5vhZ7gT5O5rv37vWImn0lf0bpNWCY24P+0H4YJyKDG22Tkbq+L1Bs1AjxkH/ikxK11jCknjbn1fHjT2qC6lo0/AzYedUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779423050; c=relaxed/simple;
	bh=nGp8cfDlKp7quoA7yLGxVFHAs6cU3j3WHC9u6x7eUGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPx+QQ+TlEA5EnRYZcMbbZj7aVhiXIXnMwMmE/b6tRJooa3gLD4Lps+jx+5wynNEEYjCaH9uCHkh+Zr3JUyF8p+IhlBLWWx6AtVVftCZBjlIpdpPoizpUnba0/J/sDwsihZHNSf8UxB6irSrWzb7aB8DjdKFTIZ/Y4ACqZz8GPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=foyBucyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHl10YZk; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="foyBucyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHl10YZk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AC35FEC00F2;
	Fri, 22 May 2026 00:10:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 22 May 2026 00:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779423047;
	 x=1779509447; bh=40mpPYP9F3lB1sh3je3/ae1J8NBD0BA25slDaB8kCrA=; b=
	foyBucylQSnlkrEomi/M4rF9y9ULY/6gae+7co1RzgCpSJv9iUAMRapxzgWgfIou
	XqEOXcZpqUD+Kr9Hps18NpRS2x3ridOeNDT9ov3whqEfVrgfHOU3+x8fA/mX26nZ
	ierbSyiCQulPfrrXc2CJ07nNKjER1LuemVzGoSF3vsu3/EE8vzIs7bXZhtvKwnh2
	F2eh7+M3AzzGecxK8NRqGoNeLcvigGOcnC6bO1lnDgmP7goqgqGwStSJicgE/AIT
	7XllFjnOm2E3bF7lBzMcnDqKjyi/cIYwyZlhY++Pb0u9mKGpRBuzny+qTCODQLVp
	/8Vysz3QlxGcXdiQipSKdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779423047; x=
	1779509447; bh=40mpPYP9F3lB1sh3je3/ae1J8NBD0BA25slDaB8kCrA=; b=A
	Hl10YZkjGBB/kK2P80acvgOwCSdqErHV/vo80L40FAXFsSdaLBDCa6nWeM043iA5
	1pRaslcXipnoPRq1bwerTYjQh1HNCY8UdNv8iB0jljNJWi0FN9VyG1n41I/SEU9K
	fXo3uB5UaqyymSXvY2L4hJO4J/glE76r2jYz3/kdmjoYhWCSCfoVfVyiAJGSoNEM
	Q1/VA9PBVbHj62mGKU7zZ/DsOVePhoi5p+9fP74IpmdURUyiHwxm7sxVgc6yaOmb
	PM32bqjAu5wJHLRPBUkwriAXed/bKuwIp0RqxzUbp362hMmJtvZWnNj5rHagx/CI
	24ct2E6czNUFgFOa9gJXw==
X-ME-Sender: <xms:R9cPauoWnTs8QakfVuBHbifz7iDs1tcxh7B4eDs4QmIPjiWQHQ4G9w>
    <xme:R9cPaq6DqfIcTQB9ercGdLi5v8mChH6zpI6A7FqC9-tAIh2XKkU4ETSYNWvvo-mAJ
    wDnkwOuJXf2YH73I3CQFoB1ZI3ZsqneV2rbVtLQrx2Jxg40UCxfIvc>
X-ME-Received: <xmr:R9cPasioMd4hd2kjDlaVpNRPeB9MeE4kHXj5Ds5NMuwTWmorj2wYQPH43YI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurgifvghird
    gtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohepfigrthhh
    shgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrg
    grsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfigvihdrhhhurghnghdvsegrmhgu
    rdgtohhmpdhrtghpthhtohepfigrnhhgiihhohhuudeshhhishhilhhitghonhdrtghomh
    dprhgtphhtthhopeifrghnghihuhhshhgrnhduvdeshhhurgifvghirdgtohhmpdhrtghp
    thhtoheplhhiuhihohhnghhlohhngheshhhurgifvghirdgtohhmpdhrtghpthhtohepkh
    hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:R9cPag5gDTgjmjqBFN4pMVkWg3tdJQmdPBkdQBhkN2VeL3I8tXRphw>
    <xmx:R9cPahGVsWJtcApKtCNKpomZ3mgUJSqj70pf_w27Qhz69fKATfwHng>
    <xmx:R9cPaiIpZ3igKworYa7W6FBWB31_ouC0MFiLJei-b1kWs1uirEmtKQ>
    <xmx:R9cPauhIiiIa548l0dYVolAHDerROgaiqpx5H8R494DL36EnZWvkyA>
    <xmx:R9cPaiX_pIqLyTfDVXTABGBMXJY8a2T_OB-B7CkRR-8TOLmqRcuUAe5h>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 00:10:46 -0400 (EDT)
Date: Thu, 21 May 2026 22:10:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
 <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v11 4/5] vfio/pci: Add PCIe TPH configuration space
 virtualization
Message-ID: <20260521221015.73a17820@shazbot.org>
In-Reply-To: <20260518071701.25177-5-fengchengwen@huawei.com>
References: <20260518071701.25177-1-fengchengwen@huawei.com>
	<20260518071701.25177-5-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 15:17:00 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Add support for virtualizing the PCIe TPH (Transaction Processing Hints)
> control register. TPH may break platform isolation, so add a module
> parameter "enable_unsafe_tph" to allow administrators to globally control
> this feature.
> 
> TPH control register writes are mediated to only allow valid mode settings,
> and TPH is automatically disabled when VFIO takes ownership of the device
> or when userspace closes the device file descriptor.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci.c        | 13 ++++++++++++-
>  drivers/vfio/pci/vfio_pci_config.c | 28 ++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c   | 16 +++++++++++++++-
>  include/linux/vfio_pci_core.h      |  4 +++-
>  4 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 0c771064c0b8..6d73668459cf 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -60,6 +60,12 @@ static bool disable_denylist;
>  module_param(disable_denylist, bool, 0444);
>  MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
>  
> +#ifdef CONFIG_PCIE_TPH
> +static bool enable_unsafe_tph;
> +module_param(enable_unsafe_tph, bool, 0444);
> +MODULE_PARM_DESC(enable_unsafe_tph, "Enable PCIe TPH (Transaction Processing Hints) support. It may break platform isolation. If you do not know what this is for, step away. (default: false)");
> +#endif
> +
>  static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
>  {
>  	switch (pdev->vendor) {
> @@ -257,12 +263,17 @@ static int __init vfio_pci_init(void)
>  {
>  	int ret;
>  	bool is_disable_vga = true;
> +	bool is_enable_unsafe_tph = false;
>  
>  #ifdef CONFIG_VFIO_PCI_VGA
>  	is_disable_vga = disable_vga;
>  #endif
> +#ifdef CONFIG_PCIE_TPH
> +	is_enable_unsafe_tph = enable_unsafe_tph;
> +#endif
>  
> -	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
> +	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3,
> +				 is_enable_unsafe_tph);
>  
>  	/* Register and scan for devices */
>  	ret = pci_register_driver(&vfio_pci_driver);
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index a10ed733f0e3..6da35c2313b9 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -22,6 +22,7 @@
>  
>  #include <linux/fs.h>
>  #include <linux/pci.h>
> +#include <linux/pci-tph.h>
>  #include <linux/uaccess.h>
>  #include <linux/vfio.h>
>  #include <linux/slab.h>
> @@ -35,6 +36,8 @@
>  	((offset >= PCI_BASE_ADDRESS_0 && offset < PCI_BASE_ADDRESS_5 + 4) || \
>  	 (offset >= PCI_ROM_ADDRESS && offset < PCI_ROM_ADDRESS + 4))
>  
> +extern bool enable_unsafe_tph;
> +
>  /*
>   * Lengths of PCI Config Capabilities
>   *   0: Removed from the user visible capability list
> @@ -313,6 +316,30 @@ static int vfio_virt_config_read(struct vfio_pci_core_device *vdev, int pos,
>  	return count;
>  }
>  
> +static int vfio_pci_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
> +				     int count, struct perm_bits *perm,
> +				     int offset, __le32 val)
> +{
> +	u32 data = le32_to_cpu(val);
> +
> +	guard(mutex)(&vdev->tph_lock);
> +
> +	if (!enable_unsafe_tph)
> +		return count;
> +
> +	if (offset != PCI_TPH_CTRL)
> +		return count;
> +
> +	/* Only permit write TPH mode. */
> +	data &= PCI_TPH_CTRL_MODE_SEL_MASK;
> +	if (data == PCI_TPH_ST_IV_MODE || data == PCI_TPH_ST_DS_MODE)
> +		pcie_enable_tph(vdev->pdev, data);
> +	else if (data == PCI_TPH_ST_NS_MODE)
> +		pcie_disable_tph(vdev->pdev);
> +
> +	return count;
> +}

I don't understand the virtualization here, the Requester Enable bits
control what's actually enabled, not the Mode Selection bits.  All
three of these are valid modes that can be enabled, why aren't they
toggled by the value written to PCI_TPH_CTRL_REQ_EN_MASK?

Isn't this patch ordering wrong, why are we allowing tph to be enabled
and disabled before we've provided a mechanism to set/get steering tags?

> +
>  static struct perm_bits direct_ro_perms = {
>  	.readfn = vfio_direct_config_read,
>  };
> @@ -1121,6 +1148,7 @@ int __init vfio_pci_init_perm_bits(void)
>  	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
>  	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
>  	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
> +	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_pci_tph_config_write;
>  	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
>  
>  	if (ret)
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 050e7542952e..0d0140202280 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/iommufd.h>
>  #include <linux/pci-p2pdma.h>
> +#include <linux/pci-tph.h>
>  #if IS_ENABLED(CONFIG_EEH)
>  #include <asm/eeh.h>
>  #endif
> @@ -41,6 +42,7 @@
>  static bool nointxmask;
>  static bool disable_vga;
>  static bool disable_idle_d3;
> +bool enable_unsafe_tph;
>  
>  static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
>  {
> @@ -771,6 +773,11 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>  #endif
>  	vfio_pci_dma_buf_cleanup(vdev);
>  
> +	/* Disable TPH when userspace closes the device FD */
> +	mutex_lock(&vdev->tph_lock);
> +	pcie_disable_tph(vdev->pdev);
> +	mutex_unlock(&vdev->tph_lock);
> +

We generally don't need to lock on device close, there's nothing it can
race with.  Also this should happen in the below function after the
device is known to be back in D0.

In general the tph_lock seems more like it's protecting PCI-core since
tph enable/disable doesn't serialize itself.

>  	vfio_pci_core_disable(vdev);
>  
>  	mutex_lock(&vdev->igate);
> @@ -2132,6 +2139,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  	mutex_init(&vdev->igate);
>  	spin_lock_init(&vdev->irqlock);
>  	mutex_init(&vdev->ioeventfds_lock);
> +	mutex_init(&vdev->tph_lock);
>  	INIT_LIST_HEAD(&vdev->dummy_resources_list);
>  	INIT_LIST_HEAD(&vdev->ioeventfds_list);
>  	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
> @@ -2151,6 +2159,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
>  	struct vfio_pci_core_device *vdev =
>  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
>  
> +	mutex_destroy(&vdev->tph_lock);
>  	mutex_destroy(&vdev->igate);
>  	mutex_destroy(&vdev->ioeventfds_lock);
>  	kfree(vdev->region);
> @@ -2240,6 +2249,9 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
>  	if (!disable_idle_d3)
>  		pm_runtime_put(dev);
>  
> +	/* Disable TPH when taking over ownership of the device */
> +	pcie_disable_tph(pdev);
> +

Seems like a vfio_pci_core_enable() operation, why do we care if it's
enabled here?  Thanks,

Alex

>  	ret = vfio_register_group_dev(&vdev->vdev);
>  	if (ret)
>  		goto out_power;
> @@ -2605,11 +2617,13 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
>  }
>  
>  void vfio_pci_core_set_params(bool is_nointxmask, bool is_disable_vga,
> -			      bool is_disable_idle_d3)
> +			      bool is_disable_idle_d3,
> +			      bool is_enable_unsafe_tph)
>  {
>  	nointxmask = is_nointxmask;
>  	disable_vga = is_disable_vga;
>  	disable_idle_d3 = is_disable_idle_d3;
> +	enable_unsafe_tph = is_enable_unsafe_tph;
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
>  
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 89165b769e5c..741d5bcc7ba3 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -142,6 +142,7 @@ struct vfio_pci_core_device {
>  	struct notifier_block	nb;
>  	struct rw_semaphore	memory_lock;
>  	struct list_head	dmabufs;
> +	struct mutex		tph_lock;
>  };
>  
>  enum vfio_pci_io_width {
> @@ -157,7 +158,8 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>  				      const struct vfio_pci_regops *ops,
>  				      size_t size, u32 flags, void *data);
>  void vfio_pci_core_set_params(bool nointxmask, bool is_disable_vga,
> -			      bool is_disable_idle_d3);
> +			      bool is_disable_idle_d3,
> +			      bool is_enable_unsafe_tph);
>  void vfio_pci_core_close_device(struct vfio_device *core_vdev);
>  int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
>  void vfio_pci_core_release_dev(struct vfio_device *core_vdev);

