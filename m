Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008675;
	b=y7YfhUK0hMfyFWxy+cy5CoyWNlqWjQPtwRAckYYO0kA4FQ4q5nbn7MJZyFsFbRosHAqB
	 QftC0TrwejbkOXRQkGvC2IEatoI6ISdgav1ARQFb0v0WMqd2knIP3nRfUhYgf4Xvf88Vd
	 VbdPBUS18BCasSAAHYP9H/FqOOLoHyCFELGLHReHvZAHm8nCds07lZ5HuXrMaSJCkEp0s
	 FtLRsUXip95lz4xmB0Hp5NXdsfxOiCWHBjtTBDsWGK3c+Y+fJAonSrP8zs+qE/vuNIIxX
	 WUhnRUmJRVjZOoa2gJo0Z+4m+F3zUdgkJYHxrVy/OeRxOqcf21C5oxSH4G5KRuwr+yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008675;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pwNJvF77RsCqXKKSO1r9McqQJUqNDZB2lGQ2+//mQr8=;
	b=tedzd46yQ1+zgmSUy9eQWR7ysRB3F2PAmr/NmfuuDEeldeXPr9dInTVZfjjufu5RprIL
	 lHL7FKwMf+3hjrg4wbzEUvul/fzT8/e8ZwSkrgCBPH9Nu0CgGP1gJXF1G1VVV9MIRIoxf
	 XFLVAGunWGHJ8BzcO5kzKDsrBayaM18iprVfa0GQbOBrD4wWa5QgXTyhXgW0Grfne+0Qg
	 IqGD9Ft1iyoID7ZRfK5kh2OHtOEe4MK+vUWgCMOxFI7WFKa94q+qSGAoeeOgR+W7TkkmA
	 tooP5fFBE8PR1QYWu4Z47deyb1TGZnurcQu1RlV5lnHbLhkaH2V1psC4f/xhNlLuYag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=v7n32bA9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cvi6X5oU;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3E606A32E
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 23:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8E3E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=v7n32bA9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cvi6X5oU
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 02A4CEC01A3
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 18:44:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 18:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794008672;
	 x=1794095072; bh=pwNJvF77RsCqXKKSO1r9McqQJUqNDZB2lGQ2+//mQr8=; b=
	v7n32bA90Ui+sF3pnso+aBklNIeXEimD6ViR+ZK4nA/rxO+zZAu8foy934ioYKbS
	+Cpi8GMul8/zZ3d/u6y1s4FBnG48yjtoaseQUNNo5GtAG/5nR/Uzol9//+9Hlqfs
	fQJS5jP7tQUZKuiWfjt3uWghzGg8BNl2XyE8Ot+qCt6ypQ9HkTPDlJXOEUdUV9l2
	/1uDu/A1kmaqJT3wbJKs4/WOwwOX8EXspIdoWcCr2aMpxBhkaRikLtiCyQnPT9WQ
	PCzmyNGLP/CpKD1SIjQI3CLX9J2J1Y+9ltyDGBOK8qt0ctGcV9es08zst2Ymd9Mz
	jt/9V4qQcM+FsIhCv2Aigw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794008672; x=
	1794095072; bh=pwNJvF77RsCqXKKSO1r9McqQJUqNDZB2lGQ2+//mQr8=; b=c
	vi6X5oUqu/exy2iOS8RUeeD+q0exHMuuiqv7jC4fuQQaanU9Kut5KrWflgh8N1Pi
	CRiP9Ls1WA1dJKnvXLcc96SKYaVi1v4U10AF5EKuS24/MoFGhHT2bvXtXm0r3YQY
	o0GrAQiwIJWzODgFbe+9uVRNClRL734t2HMm/AwUl4EI6rJgrAnn7UkcrGITHSgW
	b+fwZsBe3pMuxvWSQEhYuagr568z0wRKiBZRM33a73pJ/a2APpDQuMXkJoOkBYuy
	uyzDLqUPeV6Hjt9nI4KH2+r3hwo0G3b4BxBvtdbaAjVEbUr2EgYrpAv6WE3OW8QU
	U8Up3qJ6T8oqjIeOWS+5g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794008672; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:S8I8tEX/y/JpbNDoq+5ANx58thD/GOxyz9/zSBdZfyyZdD+
	kO9qX8qfeOpjxiVkhUrwSjV5h1GGV+ZUAkS19GFGxfLL9/Cpc/GD43Nk65rGi10W
	uKRFUHd0cmHqvxuVzjScPWZKwbTMyhksIa9wgxMcA/oCNdS7IZT9O2BBZ0mwRKNb
	iPsZWm973LMSMT+cKzKFllbWEcTH3CtXVn8lN3pVgSDc2+izo5ZGYgCD4sYPTYya
	U89H3jn5xyrhomHCkbvKzpHSkv/BKat28UF3o7Rxj5kfpcmwU9yuRAaICc4o+0j0
	hLheJgEwm14xOYpbABjsy0xe26cHElx7AJERNxw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vl3ChElWQhWiP0RH5dPBVXsCs+W5yXXF70pDuoqZwkQ=:uCjEbMkD8BICG+qDu/bI37upjAwZRxAZHs212cHm04g=;
X-ME-Sender: <xms:YGbualiQQGDqGB9PS2bJ2JOf0iKJooke3iBMCVxJRL6o1AO5UNHe3w>
    <xme:YGbuanpA7Ks0MGZuflsHs-vTQP_PyH2XKJhX4xPUOWAgOfqD38_8WxukX1yYO4N0r
    yroC92bbB2W07KGkOQd0N5V62LlaOTZVdNBj16CSLszGK31CnuOLhA>
X-ME-Received: <xmr:YGbuasehNYE1Y3jubK4o79zuPC7M1hTD0LAV6MswS_WeCBrfeXPGvNY49iuqmA>
X-ME-Proxy-Cause: dmFkZTEPPl/L2TueGpgOKH2Pc/PVVfcsASMNk8+TM7gB7BwwBLimkrKuB+VUfxK7scBl7R
    SoQitvfLjMHEKd5PVUF2/3LeJoHq/3kx/poxLfs2hclGviTfeefHYSvUGcKRB9t0K04VF8
    wEypdwZTp3UUcj6p26pzoOMMyPPD+ny/HLXJqUH4Gi4FtAo7e6M3KUHbLL5hlx8rn3bSj1
    UeHoKSJTAlNnAsJpe4WA1Xw9fhmyfh9M910+ekCHoEeHcWJzZ7urhlMJFxNn0WA9V4AgUy
    ZutkmztxAX29hiY4R1RBiSHw3tMO9NjY/4miRmyzosZhk0lsf7MMx49ppt5NHHFqEbmZJh
    ow9yJ8uOk/1Qzhf4BpYeP4yYb7oCLtbByu+IJKcFmtHhBYYKd6WPmr1/PjcX8rH1gu/p6u
    HcD2d34V2XjgHvDBUYwW6hnsd20DVzB2ejEgSxpEbKnkKCUx99FP6FtXAJDCUqLGAmVljU
    0yENvx4gsQsueiohB/zpJdFU9VcLHrsTpxTgnqGdjGWLHQqOMI+VxtC/+tGAIfxcZg4vMS
    QeItWGlSyfLdtLnDp6xbvVS2eOMScPck4sxxHPBLmfZaQAb3dnzFRFHudBdRkkusrFaWCO
    P3EO+7dQc7l5tozyBZqEcPwe1EwfGuMjbG2heWIBxKFDaG8zAF04U4K3nHMA
X-ME-Proxy: <xmx:YGbuaid4yrryo7FGQmnvZgdU3qV_Jo1_v8R80mbYWubtDrm4pnVLcw>
    <xmx:YGbuaqfqAxDdemEMfPf5FURXDI-qG45Zqe1KaB2GsajA_DBKPJr3oQ>
    <xmx:YGbuagp0AF7e1GEqQAOdEKqWWb3z2IzNsodb0hsH95YlFFIrOy6wfA>
    <xmx:YGbuaiyviB6wILySUO7iHfytPKTDSEuhnRl98E9vo-aRPmVXt3V5mA>
    <xmx:YGbuaoeTgrRE4RhT7ftSWb4WoHyhGMtXXLZAF4mDczvELdbrJ5UCj6jE>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 18:44:30 -0500 (EST)
Date: Fri, 6 Nov 2026 16:44:27 -0700
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v6 13/31] vfio/pci: Bracket PCI resets with the CXL
 reset hooks
Message-ID: <20261106164427.51791193@shazbot.org>
In-Reply-To: <20261016161839.2765592-14-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-14-mhonap@nvidia.com>
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

On Fri, 16 Oct 2026 21:48:20 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL Type-2 device must quiesce its coherent link before any reset and
> restore its HDM decoder state afterward, or a reset can leave the device
> mastering the bus over decoders that are no longer valid. This has to
> happen around every reset the PCI core drives for the device, not only
> the ones VFIO issues directly, and around AER and DPC recovery, which
> can reset the link without the reset callbacks.
> 
> Add:
> - reset_prepare
> - reset_done
> - an optional error_resume to the CXL ops
> 
> Export:
> - vfio_pci_core_reset_prepare()
> - vfio_pci_core_reset_done()
> - vfio_pci_core_error_detected()
> - vfio_pci_core_error_resume()
> which take the vfio device.
> 
> vfio-pci calls them from its own pci_error_handlers, which resolve the
> driver data it owns. A variant driver that binds CXL devices calls them
> from its own handlers the same way; a driver without reset_prepare,
> reset_done, error_detected and resume callbacks gets no CXL support.
> 
> The provider hooks run with memory_lock held for write: vfio-pci-core
> already holds it across its own hot reset, and
> vfio_pci_core_reset_prepare() takes it for a reset started anywhere else
> until vfio_pci_core_reset_done(). The hot reset records its task, so a
> reset that another task starts meanwhile waits for memory_lock instead
> of skipping it. pci_dev_lock() blocks user config access, which a
> PCI_COMMAND write can be waiting for while it holds memory_lock, so
> reset_prepare lets config access through while it waits. reset_done
> returns an error when the provider could not restore its device, and
> VFIO_DEVICE_PCI_HOT_RESET returns that error; for any other reset the
> provider logs it.

Cryptic.  Seems like we're skipping updating all the variant drivers to
make use of the new reset and error hooks, which seems wrong.

This also needs to be rebased to the the new drvdata handling in
v7.4-rc.

I'm also not sure why the "provider" terminology has snuck into this
series with this level of prevalence.  There's only one cxl ops
"provider", it's vfio-cxl.

> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci.c      |  39 +++++++-
>  drivers/vfio/pci/vfio_pci_core.c | 154 +++++++++++++++++++++++++++++++
>  include/linux/vfio_pci_core.h    |  22 +++++
>  3 files changed, 214 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 830369ff878d..286244059569 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -223,13 +223,50 @@ static const struct pci_device_id vfio_pci_table[] = {
>  
>  MODULE_DEVICE_TABLE(pci, vfio_pci_table);
>  
> +static void vfio_pci_reset_prepare(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> +
> +	vfio_pci_core_reset_prepare(vdev);
> +}
> +
> +static void vfio_pci_reset_done(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> +
> +	vfio_pci_core_reset_done(vdev);
> +}
> +
> +static pci_ers_result_t vfio_pci_error_detected(struct pci_dev *pdev,
> +						pci_channel_state_t state)
> +{
> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> +
> +	vfio_pci_core_error_detected(vdev);
> +	return vfio_pci_core_aer_err_detected(pdev, state);
> +}
> +
> +static void vfio_pci_error_resume(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> +
> +	vfio_pci_core_error_resume(vdev);
> +}
> +
> +static const struct pci_error_handlers vfio_pci_err_handlers = {
> +	.error_detected = vfio_pci_error_detected,
> +	.reset_prepare = vfio_pci_reset_prepare,
> +	.reset_done = vfio_pci_reset_done,
> +	.resume = vfio_pci_error_resume,
> +};
> +
>  static struct pci_driver vfio_pci_driver = {
>  	.name			= "vfio-pci",
>  	.id_table		= vfio_pci_table,
>  	.probe			= vfio_pci_probe,
>  	.remove			= vfio_pci_remove,
>  	.sriov_configure	= vfio_pci_sriov_configure,
> -	.err_handler		= &vfio_pci_core_err_handlers,
> +	.err_handler		= &vfio_pci_err_handlers,
>  	.driver_managed_dma	= true,
>  };
>  
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3d4e01eea7b1..f1e1ec36eec7 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2462,6 +2462,7 @@ static bool vfio_pci_is_cxl_type2(struct pci_dev *pdev)
>   */
>  static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
>  {
> +	const struct pci_error_handlers *err_handler;
>  	const struct vfio_cxl_ops *ops;
>  	int ret;
>  
> @@ -2473,6 +2474,23 @@ static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
>  	if (!ops)
>  		return IS_BUILTIN(CONFIG_VFIO_CXL) ? -EPROBE_DEFER : 0;
>  
> +	/*
> +	 * The provider must see every PCI core reset of the device and every
> +	 * AER or DPC recovery. A driver without reset_prepare, reset_done,
> +	 * error_detected and resume callbacks gets no CXL support; the driver's
> +	 * callbacks must call vfio_pci_core_reset_prepare(), _reset_done(),
> +	 * _error_detected() and _error_resume().
> +	 */
> +	err_handler = vdev->pdev->driver ? vdev->pdev->driver->err_handler : NULL;
> +	if (!err_handler || !err_handler->reset_prepare ||
> +	    !err_handler->reset_done || !err_handler->error_detected ||
> +	    !err_handler->resume) {
> +		pci_info(vdev->pdev,
> +			 "driver lacks PCI reset or error recovery hooks, continuing without CXL support\n");
> +		vfio_pci_put_cxl_ops(ops);
> +		return 0;
> +	}
> +

Just implement them in all the variant drivers and make them validated
in vfio_pci_core_register_device().

>  	ret = ops->init(vdev);
>  	/*
>  	 * A provider that is not ready yet (for example its CXL port has not
> @@ -2759,6 +2777,128 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
>  
> +/*
> + * Take memory_lock for a reset that the PCI core runs on a locked device.
> + * pci_dev_lock() also blocks user config access, and vfio_basic_config_write()
> + * holds memory_lock while its pci_user_*_config() calls wait for that block
> + * to clear. Waiting for memory_lock with config access blocked would hang
> + * both tasks, so let user config access through while waiting: the PCI core
> + * calls reset_prepare before it saves or touches the device. The caller holds
> + * the device lock, so a block found set is the caller's own.
> + */
> +static void vfio_pci_reset_lock_memory(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +
> +	if (down_write_trylock(&vdev->memory_lock))
> +		return;
> +
> +	/* The caller did not block config access: nothing to release. */
> +	if (pci_cfg_access_trylock(pdev)) {
> +		pci_cfg_access_unlock(pdev);
> +		down_write(&vdev->memory_lock);
> +		return;
> +	}
> +
> +	pci_cfg_access_unlock(pdev);
> +	down_write(&vdev->memory_lock);
> +	pci_cfg_access_lock(pdev);
> +}
> +
> +/**
> + * vfio_pci_core_reset_prepare() - prepare a device for a PCI core reset
> + * @vdev: vfio PCI device about to be reset
> + *
> + * Call from the driver's pci_error_handlers.reset_prepare callback.
> + */
> +void vfio_pci_core_reset_prepare(struct vfio_pci_core_device *vdev)
> +{
> +	if (!vdev->cxl_ops)
> +		return;
> +
> +	/*
> +	 * vfio-pci-core holds memory_lock across its own hot reset. Hold it
> +	 * across a reset started anywhere else too, until reset_done. Test
> +	 * the owner, not just a flag: another task can reset the device while
> +	 * a hot reset holds memory_lock and has not yet locked the device.
> +	 */
> +	if (READ_ONCE(vdev->hot_reset_task) != current)
> +		vfio_pci_reset_lock_memory(vdev);
> +
> +	vdev->cxl_ops->reset_prepare(vdev);
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_reset_prepare);


This is all super sketchy.  Sashiko triggers multiple critical issues.
Having different locking behavior across CXL vs non-CXL device is not
acceptable.  These callbacks occur even if the device is reset through
sysfs or AER while the device is not opened.  Inferring whether the
lock is held or not is very hacky.  Thanks,

Alex

> +
> +/**
> + * vfio_pci_core_reset_done() - restore a device after a PCI core reset
> + * @vdev: vfio PCI device that was reset
> + *
> + * Call from the driver's pci_error_handlers.reset_done callback.
> + */
> +void vfio_pci_core_reset_done(struct vfio_pci_core_device *vdev)
> +{
> +	int ret;
> +
> +	if (!vdev->cxl_ops)
> +		return;
> +
> +	ret = vdev->cxl_ops->reset_done(vdev);
> +
> +	/*
> +	 * hot_reset_task cannot change since reset_prepare: setting it needs
> +	 * memory_lock, which this task or the hot reset task holds.
> +	 */
> +	if (READ_ONCE(vdev->hot_reset_task) == current) {
> +		/* VFIO_DEVICE_PCI_HOT_RESET returns the error. */
> +		vdev->reset_done_err = ret;
> +		return;
> +	}
> +
> +	/*
> +	 * Nobody waits for the result of a reset started elsewhere. A provider
> +	 * that failed has logged it and keeps its device memory out of use
> +	 * until a later reset restores the device.
> +	 */
> +	up_write(&vdev->memory_lock);
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_reset_done);
> +
> +/**
> + * vfio_pci_core_error_detected() - prepare a device for AER or DPC recovery
> + * @vdev: vfio PCI device the recovery reports an error on
> + *
> + * Call from the driver's pci_error_handlers.error_detected callback. The
> + * recovery may reset the device without reset_prepare and reset_done, so a
> + * provider takes its device memory out of use here.
> + */
> +void vfio_pci_core_error_detected(struct vfio_pci_core_device *vdev)
> +{
> +	if (!vdev->cxl_ops)
> +		return;
> +
> +	guard(rwsem_write)(&vdev->memory_lock);
> +	vdev->cxl_ops->reset_prepare(vdev);
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_error_detected);
> +
> +/**
> + * vfio_pci_core_error_resume() - resume a device after AER or DPC recovery
> + * @vdev: vfio PCI device the recovery resumes
> + *
> + * Call from the driver's pci_error_handlers.resume callback. A provider puts
> + * its device memory back if the device still decodes it; otherwise the memory
> + * stays out of use until the user resets the device.
> + */
> +void vfio_pci_core_error_resume(struct vfio_pci_core_device *vdev)
> +{
> +	if (!vdev->cxl_ops || !vdev->cxl_ops->error_resume)
> +		return;
> +
> +	guard(rwsem_write)(&vdev->memory_lock);
> +	vdev->cxl_ops->error_resume(vdev);
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_error_resume);
> +
>  const struct pci_error_handlers vfio_pci_core_err_handlers = {
>  	.error_detected = vfio_pci_core_aer_err_detected,
>  };
> @@ -2915,6 +3055,8 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  			ret = -EBUSY;
>  			break;
>  		}
> +		WRITE_ONCE(vdev->hot_reset_task, current);
> +		vdev->reset_done_err = 0;
>  
>  		vfio_pci_dma_buf_move(vdev, true);
>  		vfio_pci_zap_bars(vdev);
> @@ -2940,6 +3082,17 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  
>  	ret = pci_reset_bus(pdev);
>  
> +	/* A provider that could not restore its device fails the hot reset. */
> +	if (!ret) {
> +		list_for_each_entry(vdev, &dev_set->device_list,
> +				    vdev.dev_set_list) {
> +			if (vdev->reset_done_err) {
> +				ret = vdev->reset_done_err;
> +				break;
> +			}
> +		}
> +	}
> +
>  	vdev = list_last_entry(&dev_set->device_list,
>  			       struct vfio_pci_core_device, vdev.dev_set_list);
>  
> @@ -2948,6 +3101,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  					 vdev.dev_set_list) {
>  		if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vdev))
>  			vfio_pci_dma_buf_move(vdev, false);
> +		WRITE_ONCE(vdev->hot_reset_task, NULL);
>  		up_write(&vdev->memory_lock);
>  	}
>  
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 6520a2dcfd4a..881e51c42414 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -72,6 +72,21 @@ struct vfio_cxl_ops {
>  	void	(*release)(struct vfio_pci_core_device *vdev);
>  	int	(*open_device)(struct vfio_pci_core_device *vdev);
>  	void	(*close_device)(struct vfio_pci_core_device *vdev);
> +	/*
> +	 * Optional. Called with memory_lock held for write when AER or DPC
> +	 * recovery resumes the device, after reset_prepare was called for the
> +	 * error. Config space is as the recovery left it.
> +	 */
> +	void	(*error_resume)(struct vfio_pci_core_device *vdev);
> +	/*
> +	 * Called around a PCI core reset of the device with memory_lock held
> +	 * for write; reset_prepare also when AER or DPC recovery reports an
> +	 * error. reset_done returns an error if the provider could not
> +	 * restore the device; VFIO_DEVICE_PCI_HOT_RESET returns it, and for
> +	 * any other reset the provider logs it.
> +	 */
> +	void	(*reset_prepare)(struct vfio_pci_core_device *vdev);
> +	int	(*reset_done)(struct vfio_pci_core_device *vdev);
>  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
>  	struct module *owner;
>  };
> @@ -166,6 +181,9 @@ struct vfio_pci_core_device {
>  	struct vfio_pci_core_device	*sriov_pf_core_dev;
>  	struct notifier_block	nb;
>  	struct rw_semaphore	memory_lock;
> +	/* Task running VFIO_DEVICE_PCI_HOT_RESET while it holds memory_lock */
> +	struct task_struct	*hot_reset_task;
> +	int			reset_done_err;
>  	struct list_head	dmabufs;
>  	/*
>  	 * Excluded BAR sub-ranges, one list per BAR, sorted by start and not
> @@ -207,6 +225,10 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
>  int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev);
>  void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev);
>  extern const struct pci_error_handlers vfio_pci_core_err_handlers;
> +void vfio_pci_core_reset_prepare(struct vfio_pci_core_device *vdev);
> +void vfio_pci_core_reset_done(struct vfio_pci_core_device *vdev);
> +void vfio_pci_core_error_detected(struct vfio_pci_core_device *vdev);
> +void vfio_pci_core_error_resume(struct vfio_pci_core_device *vdev);
>  int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
>  				  int nr_virtfn);
>  long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,

