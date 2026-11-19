Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048633;
	b=GIaqqn5XyWd6JQ+NIB5v3fULyaYqIh61042iyCkzbbkJMvW2Ot/kfeQWNytyF7wfCYph
	 +MA1QbvGs8+0ZmR9prW9B6PGI1gNGLezvXLa4bFisy/lv3kxNN+ncGotkTyzFQQOMiZpG
	 3aT/sdZ74L/VPyB8X6gPOOFH4LBtk/Dw5DIq8nA8sOSmZtF0lFmJTwIGKhstcYFf5PnBX
	 QaI8YyLvly73IuHGWDGQpqkcebQsj8thCc8i/TnkYPsdYqT/3B7fU2P1bbUpC98Qe61Pu
	 XxQ2HZ2qi1Fvvw2eyh1MEcYjb6jabjSkvyIZJE4SudE9iA02DgAS1IZnKQDbDmDJJ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048633;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qpIpwK9XpX5/GXTayDyB/zpYQosbDeDg7lgyOZwSIWA=;
	b=2UIqn5AYGEp8wx1Z+Ja/wPI5+cn6wuKxLLZg4urtyF5F+rIUk7zjpY+p8Elhubze72gB
	 huzmMz97jxmL+u+f7yBoJofytXkgwxwpcY6/FS9YV329lycPN7Kq4I3irwJqwOHylWko9
	 dh8GRdy7FwK6yFwc9AY9O/w99upVpTYtsw9xXcAVd6vUDncByhKINUGJA7SDp6vsQiX4W
	 ADoaOmhcoNQjaeuR8Lke2tWAzqCv3R3TkhV3STGxb83lckOIJfcBmVZ8xONe6l2QKicKZ
	 Jzz0c1qmbujBW7YY+xPqIa/qA6oc2tO7rKnnZGXDz7Eow7KulUF9Dx0LWI5gvghOd3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=rnnMjSiE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Mcm3y5EF;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00935606A325
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 00:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00935606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=rnnMjSiE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Mcm3y5EF
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 14179EC08AA
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 19:37:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 19:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795048631;
	 x=1795135031; bh=qpIpwK9XpX5/GXTayDyB/zpYQosbDeDg7lgyOZwSIWA=; b=
	rnnMjSiEWU1AOPLY9OYHeS6d+S+bRpylNEcgpjJ/TJoLYwsIZ0I3O5zndcxxAhat
	Djo+TQXWU2bChqKsToejSPf9jLM1jHgQytGu5Y/fqVLD9sWIMqC01ZdGOcK4NzL3
	yqqEU0cWFHUUrwxbPCOBQNwQ+Rtqe+0HBgOPT3gCCM/HPrd33E0CMBP3cCX/q0J1
	xvCbanyZ7vmUpfMtdpZnqsLs2IKWJNflQfEGgmWD8pA0tYoMJf8+MiUAe3vQcrc4
	1m1IOO+DrQuxdXCNaT5RlKhyLMu0p2Iipt3uhul9IPnFzfosAZCeII18UWWmp0M7
	U7lu4jTUAC0XF29g7auFCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795048631; x=
	1795135031; bh=qpIpwK9XpX5/GXTayDyB/zpYQosbDeDg7lgyOZwSIWA=; b=M
	cm3y5EF+AH7IuZjgZ1KLAC2sZBtr6lnKXEzjq9iU5YpKUjmvndlwrzVN2n1yKxqh
	zJoQ36S3xA/bEOWGMfBqq+q0nTxMgqqu5/qNsMM/DQnj2b7RJApfxixQpmGnw7lO
	y4HeqpI4cWIpgZ/nxqft2W5PjnCeLyc6bUJXKOEqh9lt4EMEXjhUiWfhEat48VNR
	AO2g/RO5KoX2fRbgoXsLGLb88mXC3inUnjFW/4TbyTU6+yKJ3tf5vK6u14afpcg/
	PA906xkw0NIpH5NvQS1ioKzJ6IYZpcmIovTgJ5YKUXQkGucC6ctqBw9zbowTDHS0
	nCTO/j3w8GcldrhqHHQ7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795048631; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZHvHN5T+8HHm0UK70RmC/dsHtYugnf1CIHH85LBjaziXuqg
	0xCyvqOhrAUDdRUNQSFSCbS0/G6XuDLcalASMFUZ8NWGC3WZsx1l1TgC53l/7OAn
	OCyJHXE2nkG4OblSzb+sc+oDguVGufzDQenzCO3HdCnxK4+2Hb+OQze3XjacSOhn
	9yDQ8yZIWVKC67Dc+CU7UXRF4b5crVuzXh/8dplzaIEhzC4MzypT01QIvIlLUVBu
	5ZkPCNwI1Ro32oMLPVAIlBxlodL/vxcShnOgPJ1kvkjklgoK6Mu6no631GWLUyJE
	St/FvpWka8TnJLsW7VO10thiGlF863IPQoWb2BA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Cl8OXxmcCEAdRYan5CeUap1qnNrhJ0yy3z+nON3YliE=:9cvHxKZg+asX8ehKkhLJPZdP2WAjU/8Zzk5ApZCkuk8=;
X-ME-Sender: <xms:tkT-ama6x7b8k052Fm_BhU13d1cQWKEq-Id-qvkAewmKSfZdsh4mbQ>
    <xme:tkT-avx_9OBWxvr09IyyjX38K7iyq21zU-o3W2YJtx_ZbMSAsNNIcyHqYavZ11uzg
    TcZV_6cWgL_P3RieEpx03DQAjcW_5qc3RvbL7OlQXw9RfEl63t9Z1A>
X-ME-Received: <xmr:tkT-atMHV3TmlWlONYw3v7QsBY64IvRPyRzOrn54q8Fks7cm-0Ntr0CqwBjVpg>
X-ME-Proxy-Cause: dmFkZTEPC5mauUjeYZHtjsRY6AjwwCMgO7qscRFz4rjP/wC6GkjGAlT/otJM7HQfG+d2+l
    IGQUpbGx1SNIRj9iMI5+o+FJUIuMmIccN9ILK5cpXM9+43i8VqmyhF/1MtEyPHSnyUTuCl
    52H3rdeqlcZAmSRsrnl3GOMI7cXX1RdwccQNqVC6zv5SNPwETB96QwEdLd7VEETgXKFesq
    onleEJEi4cuoaz/QVma2f8XsbOPYnQXDe/X1HfV4kFdPmvmx7RlHnDzIlwarVfHHC9OsOf
    CPFlOSOGAabR2hD+t4AzvRNKFnK3aCiL/JiVLcCHAJOTitsExJau7lwT8OULuwp/X2DhUZ
    w05R3/9XPP3lwyY8RcdAs3Q8BxTi1BHzUWDYkuz+RmYnjYckGeeiG9uNMGW0DBnpwztnmq
    U24ptAYNISnVKfhx1u6AlGSh+x7ERXSjhIL6eAMvxaju8zukGJaGqgDEFV4RR5FwqVdfZJ
    MtrYtNDufkzhvx818ip2CzHUo0nIRrGiLbWLB4TqzDFqjpUT8M1d+7e0nMZHmcKgPq6rfp
    hw7LbpWlZpRgYKvp5/AX8+PF/6i0W80vrRaEL+urHbQ0Xjldhpt33S+zP6nvuke4XZWRTk
    6Y59dnB761Wndy53YUjjdKSeSMGNBoRQXpguDRodrQi9Ob8yrhVIKmWOg0tA
X-ME-Proxy: <xmx:tkT-ameGB1AQK_6qWCFsbiAnTWD3TqsKohclbFp7j8tSfYQYVmJWKQ>
    <xmx:tkT-aqTO0qf6Xsl5nrhv0x3LNUUGcz4rFNKUpP-EpnH0Rljpu1h2zA>
    <xmx:tkT-asefQ5_RFySHvl1TM8fjHModUmeP3XKOuTwHAQJ0WUOc3j4LSQ>
    <xmx:tkT-aru0uej0XqvKwvNeipTanoDj76ARQPoxqMYXCVJmA91SSXOE_w>
    <xmx:t0T-aqHhzTNtlcs9qs1pvgtatdOaKRAkWL2ak28rplVpgYsVmiFT3i9_>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 19:37:09 -0500 (EST)
Date: Wed, 18 Nov 2026 16:37:06 -0800
From: Alex Williamson <alex@shazbot.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Anthony Pighin <anthony.pighin@nokia.com>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset
 may need it
Message-ID: <20261118163706.7138d246@shazbot.org>
In-Reply-To: <20261112235700.2029562-1-skhawaja@google.com>
References: <20261112235700.2029562-1-skhawaja@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 23:57:00 +0000
Samiullah Khawaja <skhawaja@google.com> wrote:

> Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
> vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
> upstream bridge before resetting the device, and skips the reset if the
> trylock fails.
> 
> All VFs of a PF have the same upstream bridge. Take a device with two
> VFs, both used by one process. When the process is killed, both VFs can
> be released at the same time. The first one takes the bridge lock and
> does its FLR, the second one fails the trylock and is never reset.
> 
> The bridge lock is only needed for a bus reset, which is done through
> the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
> resets the bus for it because the PF and the other VFs are on the same
> bus.
> 
> Add pci_reset_needs_bridge_lock(), which returns true if any reset
> method enabled for the device is a bus reset, and only lock the bridge
> in vfio_pci_core_disable() when it does.
> 
> Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
> Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
> with two VFs. Both VFs are opened through VFIO and then closed from two
> threads at the same time, counting FLRs with a kprobe on pcie_flr().
> Without this patch one VF missed its FLR in 50 of 50 rounds, with it
> both VFs were reset in every round. I will send a VFIO selftest for this
> separately.
> ---
>  drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
>  include/linux/pci.h              |  1 +
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba8144..c44e4d4d8774 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5256,6 +5256,34 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
>  
> +/**
> + * pci_reset_needs_bridge_lock - check whether a reset of @dev may need the
> + * upstream bridge to be locked
> + * @dev: PCI device to check
> + *
> + * A bus reset of @dev is done through its upstream bridge, so the caller must
> + * hold the bridge lock. The other reset methods only access @dev itself.
> + *
> + * Return: true if any of the reset methods enabled for @dev is a bus reset.
> + */
> +bool pci_reset_needs_bridge_lock(struct pci_dev *dev)
> +{
> +	int i, m;
> +
> +	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
> +		m = dev->reset_methods[i];
> +		if (!m)
> +			break;
> +
> +		if (pci_reset_fn_methods[m].reset_fn == pci_reset_bus_function ||
> +		    pci_reset_fn_methods[m].reset_fn == cxl_reset_bus_function)

This looks like a maintenance nightmare.  What if instead we did
something like:

bool pci_parent_bus_reset_possible(struct pci_dev *dev)
{
	struct pci_dev *pdev;
   
	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
		return false;

	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
		if (pdev != dev)
			return false;

	return true;
}
EXPORT_SYMBOL_GPL(pci_parent_bus_reset_possible);
  
static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
{
	if (!pci_parent_bus_reset_possible(dev))
		return -ENOTTY;

	if (probe)
		return 0;

	return pci_bridge_secondary_bus_reset(dev->bus->self);
}

Where we'd then condition acquiring the bridge lock on whether it's
even possible for a function scoped reset to perform a bus reset.

It's a bit broader of a test than whether we actually have the necessary
methods in our reset_fn list, but since we're not locking the reset_fn
list between test and function-reset, it's also safer.  Thanks,

Alex

> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pci_reset_needs_bridge_lock);
> +
>  /**
>   * pci_init_reset_methods - check whether device can be safely reset
>   * and store supported reset mechanisms.
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index fcbb2da860e2..ba3dfdadae39 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -777,7 +777,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  	 * overwrite the previously restored configuration information.
>  	 */
>  	if (vdev->reset_works) {
> -		bridge = pci_upstream_bridge(pdev);
> +		bridge = pci_reset_needs_bridge_lock(pdev) ?
> +			 pci_upstream_bridge(pdev) : NULL;
>  		if (bridge && !pci_dev_trylock(bridge))
>  			goto out_restore_state;
>  		if (pci_dev_trylock(pdev)) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96..cb2856f444ca 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1486,6 +1486,7 @@ void pcie_print_link_status(struct pci_dev *dev);
>  int pcie_reset_flr(struct pci_dev *dev, bool probe);
>  int pcie_flr(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev);
> +bool pci_reset_needs_bridge_lock(struct pci_dev *dev);
>  int pci_reset_function(struct pci_dev *dev);
>  int pci_reset_function_locked(struct pci_dev *dev);
>  int pci_try_reset_function(struct pci_dev *dev);
> 
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb

