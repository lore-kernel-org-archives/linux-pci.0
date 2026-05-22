Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A54028D8;
	Fri, 22 May 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459004; cv=none; b=qI61uGHFpbkH1uxm5N3xOImJQmTgsO9bnvWU9u8jHOtkAYNcrdBxdg8De0JZmkSusKtqQtbByFU4wDa5MT6YDCzJbdeQNq5xmUNgOYvjP9nItC1Ir+/Vlev/wSZgWclhZ/4k+Foq9nEukGVz+rapvE0ukChRqP8SZu6Q2Z1DdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459004; c=relaxed/simple;
	bh=GZ/PiKv+EB4iuUEP1ftEYn4iTyedAWdYcFyHmFvZv6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWLkaN9mmHa+wTM5yUjcc4ubS6WtfEOthyxiBogsH8ijLtPM4vP63F/X8ieBvCnt7NaU12o5iOTqOy7Mj750XzuTiVYioK7NbpAKg0FiWmTiL30zqtyD0xZUQnH1Z+3yH+nbq3wSIS6eAP+YUBaE+dLXlToRWiwYPqUGPHWhL7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=srz0Pnry; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FYO/zI6f; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="srz0Pnry";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FYO/zI6f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F71FEC01E1;
	Fri, 22 May 2026 10:09:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 22 May 2026 10:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779458995;
	 x=1779545395; bh=uaPYxTRX3ADB9uuG8H0VGKPu10SMf94usZxtBguPvyc=; b=
	srz0PnryN6vqhvgLMeJG+R6eHGrDS44XZlSgLd60NEm4CFaTNlOteH4EJwdVYL8p
	MFC0m7o8hpHMIlm6zkStE3cc3Ty5yVRLnYb8vT6JfPrBvEUXLfSyxQXWVoZX2UcK
	NCn6c/NyWE+uePscS8Ifo4D+PB/d+RKN8pHUvQ/XUjYWxk/GT1AvTzq8oqUExwm6
	w3OSV/2k43vi4CRMGYPbYcV7YYP2KsBSLCw6up2/1pZ0IaBRHyL4k540ouCYgucb
	EXuwOuJRsjFaO/vb+kKKBZ+hS98oaZ4noekVswx1DQ8F8eOVwoldwN2CzgeJ93Kn
	pw1DXDt9XmAPxU3ihsK1Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779458995; x=
	1779545395; bh=uaPYxTRX3ADB9uuG8H0VGKPu10SMf94usZxtBguPvyc=; b=F
	YO/zI6fF1HXfE+bKYD9ka1v4clAJxTQHvWweG05/N/8Y4jcS1705eWboT0DMFiT2
	9ryNqSH7PpIQovn9utoD3/lp0qDQcnkigSBXiAEFGkn4adKhao/kdoxLSDwP5ZgL
	9pPQLbs+JeX+K6uii7bjmZDNTWV/Fqb5fl/1BCot773o0SpWfB+2dfTWPZ3vk/4R
	aCMQ7WDK9gyK7YS+eIgzPI52i/piKo2yCBpPtqlKmtCPEhC9Eao+FG1KEOW4JSsm
	4oOb08MHPGjkDrWCCBbJlA73dd7Ets1itRwxsq2I1UZ9pZbOm5bpCpHm27IseYk4
	FGYIpGQTrTJdQmWtUm+gw==
X-ME-Sender: <xms:smMQasfLRwDtrEP704yAiOym1jIBvGLdpYZGwJDL4N3wGXQYx21ptw>
    <xme:smMQascTk28DNU09sSuAGWKOExBetboETDMF_EkJCK7fnjlHAB0onlqmCjS6JVfXu
    bRGyNdRMKegUTdpDfd8SUlLrwsqVV2nmxZsS6SgfsdMB2BkXG3Y>
X-ME-Received: <xmr:smMQam15Jmqbm1hzthffy2Basf9Pc6LXAFwKeLIUqk5lULRJWr6ZJDiojs0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgvnhhg
    tghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehjghhgseiiihgvph
    gvrdgtrgdprhgtphhtthhopeifrghthhhsrghlrgdrvhhithhhrghnrghgvgesrghrmhdr
    tghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopeifvghirdhhuhgrnhhgvdesrghmugdrtghomhdprhgtphhtthhopeifrghnghiihhho
    uhdusehhihhsihhlihgtohhnrdgtohhmpdhrtghpthhtohepfigrnhhghihushhhrghnud
    dvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehlihhuhihonhhglhhonhhgsehhuhgr
    figvihdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:smMQak902jAn0KnurDjbG4Vw1GeXUoGVha3jrtLhK5nJbMz_oRP0fQ>
    <xmx:smMQar6aIZwvJV3-nSOp0HFM5wSbW1Upyz3lv2isxxXw50sY42e3ww>
    <xmx:smMQassBr9Oabs-zJelZLdfuTADuVCZkVJCtyp6pNhwHfMT2CFIjuA>
    <xmx:smMQat1eldY6sG9sBaxzIJ210VcE0vjCq6YP6GKj4KeXyDeUsWjjtw>
    <xmx:s2MQapIuq_yILYdbLks-BmnZ0_HNfcTZo42-Jl_WOKcwZ_44dp4lQ4n2>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 10:09:53 -0400 (EDT)
Date: Fri, 22 May 2026 08:09:51 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
 <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v11 4/5] vfio/pci: Add PCIe TPH configuration space
 virtualization
Message-ID: <20260522080951.455eb8ef@shazbot.org>
In-Reply-To: <60e77af2-557c-4a6c-8235-ab7142da77f5@huawei.com>
References: <20260518071701.25177-1-fengchengwen@huawei.com>
	<20260518071701.25177-5-fengchengwen@huawei.com>
	<20260521221015.73a17820@shazbot.org>
	<60e77af2-557c-4a6c-8235-ab7142da77f5@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 17:39:09 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> On 5/22/2026 12:10 PM, Alex Williamson wrote:
> > On Mon, 18 May 2026 15:17:00 +0800
> > Chengwen Feng <fengchengwen@huawei.com> wrote:
> > 
> >> Add support for virtualizing the PCIe TPH (Transaction Processing Hints)
> >> control register. TPH may break platform isolation, so add a module
> >> parameter "enable_unsafe_tph" to allow administrators to globally control
> >> this feature.
> >>
> >> TPH control register writes are mediated to only allow valid mode settings,
> >> and TPH is automatically disabled when VFIO takes ownership of the device
> >> or when userspace closes the device file descriptor.
> >>
> >> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> >> ---
> >>  drivers/vfio/pci/vfio_pci.c        | 13 ++++++++++++-
> >>  drivers/vfio/pci/vfio_pci_config.c | 28 ++++++++++++++++++++++++++++
> >>  drivers/vfio/pci/vfio_pci_core.c   | 16 +++++++++++++++-
> >>  include/linux/vfio_pci_core.h      |  4 +++-
> >>  4 files changed, 58 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> >> index 0c771064c0b8..6d73668459cf 100644
> >> --- a/drivers/vfio/pci/vfio_pci.c
> >> +++ b/drivers/vfio/pci/vfio_pci.c
> >> @@ -60,6 +60,12 @@ static bool disable_denylist;
> >>  module_param(disable_denylist, bool, 0444);
> >>  MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
> >>  
> >> +#ifdef CONFIG_PCIE_TPH
> >> +static bool enable_unsafe_tph;
> >> +module_param(enable_unsafe_tph, bool, 0444);
> >> +MODULE_PARM_DESC(enable_unsafe_tph, "Enable PCIe TPH (Transaction Processing Hints) support. It may break platform isolation. If you do not know what this is for, step away. (default: false)");
> >> +#endif
> >> +
> >>  static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
> >>  {
> >>  	switch (pdev->vendor) {
> >> @@ -257,12 +263,17 @@ static int __init vfio_pci_init(void)
> >>  {
> >>  	int ret;
> >>  	bool is_disable_vga = true;
> >> +	bool is_enable_unsafe_tph = false;
> >>  
> >>  #ifdef CONFIG_VFIO_PCI_VGA
> >>  	is_disable_vga = disable_vga;
> >>  #endif
> >> +#ifdef CONFIG_PCIE_TPH
> >> +	is_enable_unsafe_tph = enable_unsafe_tph;
> >> +#endif
> >>  
> >> -	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
> >> +	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3,
> >> +				 is_enable_unsafe_tph);
> >>  
> >>  	/* Register and scan for devices */
> >>  	ret = pci_register_driver(&vfio_pci_driver);
> >> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> >> index a10ed733f0e3..6da35c2313b9 100644
> >> --- a/drivers/vfio/pci/vfio_pci_config.c
> >> +++ b/drivers/vfio/pci/vfio_pci_config.c
> >> @@ -22,6 +22,7 @@
> >>  
> >>  #include <linux/fs.h>
> >>  #include <linux/pci.h>
> >> +#include <linux/pci-tph.h>
> >>  #include <linux/uaccess.h>
> >>  #include <linux/vfio.h>
> >>  #include <linux/slab.h>
> >> @@ -35,6 +36,8 @@
> >>  	((offset >= PCI_BASE_ADDRESS_0 && offset < PCI_BASE_ADDRESS_5 + 4) || \
> >>  	 (offset >= PCI_ROM_ADDRESS && offset < PCI_ROM_ADDRESS + 4))
> >>  
> >> +extern bool enable_unsafe_tph;
> >> +
> >>  /*
> >>   * Lengths of PCI Config Capabilities
> >>   *   0: Removed from the user visible capability list
> >> @@ -313,6 +316,30 @@ static int vfio_virt_config_read(struct vfio_pci_core_device *vdev, int pos,
> >>  	return count;
> >>  }
> >>  
> >> +static int vfio_pci_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
> >> +				     int count, struct perm_bits *perm,
> >> +				     int offset, __le32 val)
> >> +{
> >> +	u32 data = le32_to_cpu(val);
> >> +
> >> +	guard(mutex)(&vdev->tph_lock);
> >> +
> >> +	if (!enable_unsafe_tph)
> >> +		return count;
> >> +
> >> +	if (offset != PCI_TPH_CTRL)
> >> +		return count;
> >> +
> >> +	/* Only permit write TPH mode. */
> >> +	data &= PCI_TPH_CTRL_MODE_SEL_MASK;
> >> +	if (data == PCI_TPH_ST_IV_MODE || data == PCI_TPH_ST_DS_MODE)
> >> +		pcie_enable_tph(vdev->pdev, data);
> >> +	else if (data == PCI_TPH_ST_NS_MODE)
> >> +		pcie_disable_tph(vdev->pdev);
> >> +
> >> +	return count;
> >> +}
> > 
> > I don't understand the virtualization here, the Requester Enable bits
> > control what's actually enabled, not the Mode Selection bits.  All
> > three of these are valid modes that can be enabled, why aren't they
> > toggled by the value written to PCI_TPH_CTRL_REQ_EN_MASK?
> 
> OK, will fix in next version
> {
> 	...
> 	mode = data & PCI_TPH_CTRL_MODE_SEL_MASK;
> 	req_en = data & PCI_TPH_CTRL_REQ_EN_MASK;
> 	if (req_en && (mode == PCI_TPH_ST_IV_MODE || mode == PCI_TPH_ST_DS_MODE))
> 		pcie_enable_tph(vdev->pdev, data);
> 	else if (!req_en)
> 		pcie_disable_tph(vdev->pdev);
> 	...
> }

Again, NS_MODE is a valid enabled mode of TPH.


> > Isn't this patch ordering wrong, why are we allowing tph to be enabled
> > and disabled before we've provided a mechanism to set/get steering tags?
> 
> Regarding patch order: TPH must be enabled first before accessing steering tag entries.
> The tag query interfaces rely on runtime TPH state and request type info stored in device struct,
> which is only initialized after successful TPH enabling. So current order is functional necessary.

As discussed in the next patch, I disagree with the direction of the
uAPI proposed here.

> >> +
> >>  static struct perm_bits direct_ro_perms = {
> >>  	.readfn = vfio_direct_config_read,
> >>  };
> >> @@ -1121,6 +1148,7 @@ int __init vfio_pci_init_perm_bits(void)
> >>  	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
> >>  	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
> >>  	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
> >> +	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_pci_tph_config_write;
> >>  	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
> >>  
> >>  	if (ret)
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >> index 050e7542952e..0d0140202280 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -29,6 +29,7 @@
> >>  #include <linux/sched/mm.h>
> >>  #include <linux/iommufd.h>
> >>  #include <linux/pci-p2pdma.h>
> >> +#include <linux/pci-tph.h>
> >>  #if IS_ENABLED(CONFIG_EEH)
> >>  #include <asm/eeh.h>
> >>  #endif
> >> @@ -41,6 +42,7 @@
> >>  static bool nointxmask;
> >>  static bool disable_vga;
> >>  static bool disable_idle_d3;
> >> +bool enable_unsafe_tph;
> >>  
> >>  static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
> >>  {
> >> @@ -771,6 +773,11 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
> >>  #endif
> >>  	vfio_pci_dma_buf_cleanup(vdev);
> >>  
> >> +	/* Disable TPH when userspace closes the device FD */
> >> +	mutex_lock(&vdev->tph_lock);
> >> +	pcie_disable_tph(vdev->pdev);
> >> +	mutex_unlock(&vdev->tph_lock);
> >> +
> > 
> > We generally don't need to lock on device close, there's nothing it can
> > race with.  Also this should happen in the below function after the
> > device is known to be back in D0.
> 
> I'll remove unnecessary mutex lock in device close path as there is no concurrent race risk.
> Also adjust TPH disable invocation to after device returns to D0 state.
> 
> > 
> > In general the tph_lock seems more like it's protecting PCI-core since
> > tph enable/disable doesn't serialize itself.
> 
> The tph_lock is designed to serialize all userspace triggered TPH operations on the same device.

I'm not sure it's our job to serialize everything.  Serializing to
protect PCI-core from entering an inconsistent state is perhaps valid.

> >>  	vfio_pci_core_disable(vdev);
> >>  
> >>  	mutex_lock(&vdev->igate);
> >> @@ -2132,6 +2139,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
> >>  	mutex_init(&vdev->igate);
> >>  	spin_lock_init(&vdev->irqlock);
> >>  	mutex_init(&vdev->ioeventfds_lock);
> >> +	mutex_init(&vdev->tph_lock);
> >>  	INIT_LIST_HEAD(&vdev->dummy_resources_list);
> >>  	INIT_LIST_HEAD(&vdev->ioeventfds_list);
> >>  	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
> >> @@ -2151,6 +2159,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
> >>  	struct vfio_pci_core_device *vdev =
> >>  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> >>  
> >> +	mutex_destroy(&vdev->tph_lock);
> >>  	mutex_destroy(&vdev->igate);
> >>  	mutex_destroy(&vdev->ioeventfds_lock);
> >>  	kfree(vdev->region);
> >> @@ -2240,6 +2249,9 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
> >>  	if (!disable_idle_d3)
> >>  		pm_runtime_put(dev);
> >>  
> >> +	/* Disable TPH when taking over ownership of the device */
> >> +	pcie_disable_tph(pdev);
> >> +
> > 
> > Seems like a vfio_pci_core_enable() operation, why do we care if it's
> > enabled here?  Thanks,
> 
> For TPH disable during device takeover: VFIO ownership transfer triggers device reset,
> which clears hardware TPH registers and ST tables. We call pcie_disable_tph to synchronize
> software state with hardware reset status.

So why wouldn't we do that prior to giving the device to userspace
rather than upon registering the device?  We try not to modify the
device state more than necessary on probe.  Thanks,

Alex
