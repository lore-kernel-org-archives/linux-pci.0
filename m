Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836515;
	b=kDth51s/9lwRwJ2JV/FXxITyShsWOZUUFm2mHG7JFAHB9DgmU8R6kuR0trBzR6AysSh4
	 NhbmX7zrA+b/lzaFC8dSn/GNmt0A3jALgWtFL5oCQAg7nvP452I/LBDziGjChWEY3onPh
	 1cOuRFnS+zCI7TgujT2k9DxPQ6PmBd65oyU6Tm+BeJx9NH+t4AFCKgOKsSi97J8AHEep8
	 2z/008mBIjL4Tg1Qwf3ZTPC1OidlBdldrmWuSgMBJ3Kp62Csg1/e/mv/XFqTMbGIonqRl
	 0E+zrNiKyfXIU+uJQ9yMO+SX4Mbs5uRNNK+y9SwHFraeA18Fn1yk8uPzr8WxWQalrOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836515;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xyvNsYmFNsUNSiZ3/Smohdj7Psl5Ao/dpxmOcpWvGGs=;
	b=dF8VmdX6QyTc9PdjE8yns0UwCC7hcCaLJr179gLpAhV+6aCdxfVdwcD16DiSEYL2y6EM
	 cuo3a9JCOv/x035nZU/MFjt/fyira5vY7uDKe+zToXTsHOQblOxgbPAkXx+Fj0vZjrZOV
	 AG1PJ7MTSNamGRk2nV5qDsdTwaxZT59abpWAhTnY/KjUjDL/ceGerLEKc7IjzxAR29xF9
	 f/ZJqkMrgvZMyUB/IgzHYjn6oL1xiijdj9M1o+OkwpSH4ipLgNeXvAAlNSUv4CLPtXW78
	 iZRps01Zjxgx26CeiN1esW9m3KJsSKcBO1cELH6s+phlUrOvuFv2fKGNkifBpaQvIuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=ra4LhgH+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4jePVdpi;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCFF606EE8B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DCFF606EE8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=ra4LhgH+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4jePVdpi
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF7BA14001D4
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 18:55:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 04 Nov 2026 18:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793836513;
	 x=1793922913; bh=xyvNsYmFNsUNSiZ3/Smohdj7Psl5Ao/dpxmOcpWvGGs=; b=
	ra4LhgH+nnm9HL0r4Kq59C62hb3VYK40doxbMOXHOEKcj7TDDYwyaz3Dy4hPg37o
	Yv/0FIWZjqiMNhwkSth9pPFPd1TGgknkeStau0MmW3Fz7lOut6SKdogCHQEngGBi
	VxSPpQlXm7ZwitmMSLfj/dRFXLAu4ghaoEbPw6+hTaSNTe+c+USqeAZKb1QzfYZ+
	2qIBBeyPQV+1/yEBJTpt8uLK6PtkFztkST1foKlZEV5+sitVMCHlZDgg7dcrqqPm
	0bVmLJayHbl3FChqVlRMUXdt+IFBPB4a0FX+l2mE2QosfNZdJnvIXR6q3jQ3435K
	fVZn+xPyXxvAgYUoOZS9Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793836513; x=
	1793922913; bh=xyvNsYmFNsUNSiZ3/Smohdj7Psl5Ao/dpxmOcpWvGGs=; b=4
	jePVdpiHXZ+OlWMIA/eiDp2le+x9kR18UoXQigTFASWeLiktFCWP1YsTW93/ZYmk
	Kj7N+6owOSq+oEW5ydT8FI1TPwp4n6ci3iuuycuWkPOPbooTnyNDVpdRYv7ubN4G
	YPjYzWke6LFCxtA5b1SAsRLn3y1QB3OLTmIa6+r+s2UJWV3i1V/JMgW/A21sMiLZ
	UU+ut/kjoW20xPNqb6e+wUbe5RpdqgJLNxp/o/z3PNZtled6HXnUqs75srlYny2l
	CnK/tWQvkFaqeizZBu+obABK1zuLeMg1TKpNzeIEnZ1wm6DAxNcbhFW2Sw0ASCG7
	fM3eiGp9hc/mqUueHpT1w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793836513; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ntqHxcFauRMmJGMyoNc7ShbgMbpRfPOZSCiRVLU2iXLqJeo
	EOyVKLrGBEKjvOS6IGh3hkBv2gKdA3DZzYLwfmAAKUaWD+r2N8B6SytQL7JVB4vm
	kHt5E+ANFy5AdbeX2YyDa48d3n9Bg/WSIjyW8MPFWWT+t0Nt+yNkdR570m7AxfrP
	GIdGvFCmnTkWgC726ex1HkrmPHx0FokHy1zMBR2nmWFp65sQMnO5lEjIF0KA6wXU
	uoKQbqA46FyTRyq9O+qcOjDzPOv//V7dB/9+KydCoLYC4YZL8HeQJof/JiFL8BG+
	2W6U42d1kXJ+I9XAsmtJc3ej7I8xPYdjORam17A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BFA6DzJRVbejRPsMtMGO7th9U5+CnPb9AdCAKmA81Dw=:eDJ673P+K7pXjeoYHUiCjGcd3eSJ7KyiyH+Qd3kASlc=;
X-ME-Sender: <xms:4cXramENO_fsgYYYuY_qLyUUCvMfItdpol56Z9DQ6pn6-t-lwWCyQw>
    <xme:4cXrak-TNRM0gzoJSsjhoeDIxvP3k6c_EJQWi3yais9qouyMO8zYSFi1X4avJTB8-
    BeQo7b4sWOG9dd_LxXVlkiYsgiRB7vsZuATwHlT7ntY_ZMa0n6c2Q>
X-ME-Received: <xmr:4cXranhENW5uJ8QSrF27bPfQ1FQsp2rAm8A1EQcCEa0KOhW8my2EzRWOc1BBvQ>
X-ME-Proxy-Cause: dmFkZTEUHmheM4TcN+Ui8oQAaPhaKxerACcrI4xYNFFZjMdVkcrl+kfgjT+qjdO+axagJl
    de8mhNEJkxV2kzZBLKbQndIfVb5IFJ/p6vurCUW/JOVryts3u07cSI8Gb/5xUPlmB1m/YV
    4K9RW+A4z0s1YhrvlG7ljI0lSgm6afsSqoALqBtHK4gkQg0hCi50liWNSoS/3Ck7T5mFCy
    r1UCn0YFuxZx8X7Od33cVvVcSc9v8K1ilBB81b/UpFkHTQ1ZoBceS3Zjt8L+EzU7VUYIWD
    GrEoDZTARxtu0PWDLP8UjMDxfvkZ1iJrKvbH20hKIKapvnjQJUBDfz0t3IV0KAHcwHnqTA
    pe33gmFL0p+HSniZZd7T4wQmk81p5kyxFaBQ/As17Tzx9CFPdnhtFVilc95eWQCz6AqULE
    +3XQpVAHWG1hL0L4LBSmI4h+01J5odaMpMjj9YNtaemeWO/o/nfNh99Gjs1D2GqM4fXLqr
    2S8oTnLqX7jnyMF4Rei1eMsELeE94SiCAnjjkg1B8CLaCTcZMW0oChMgE+5RHuL6ddphea
    d3z3zpmBkYCX0D2feByiU9aTqZtST65+BO4RQ8IUg15G2d+UbHYLYzGFPfWWd4tCRED3aF
    fk37t7mZA2uf9NbuBMqudK4/ZduN64NoO9BNU9+Ud5+uzXxFLPmn63G1opjQ
X-ME-Proxy: <xmx:4cXraoTD-cidcQ4ZNNowVdLS6QAn67oi4M4wfCaE2bRi8MpUOr4yOg>
    <xmx:4cXrakCPmLdRtZHG_FdxG2UvyRII_KGk59zo2FUobaau1Gih13NsKw>
    <xmx:4cXrai__N69Pv4ISasF0w9Wg3JOmJgvCbgoJhZH5kqXh9-u3Ou0pfQ>
    <xmx:4cXrau0rTvb7Ilg2MEaHZpImAWPvETHvaV5sYW6_C1TLKK-j4oR6cg>
    <xmx:4cXragMf-31R0NJ7Mlj8baVQS7eamMC_96fwP5v6eWAMW8nxsj8M9kbj>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 18:55:10 -0500 (EST)
Date: Wed, 4 Nov 2026 16:53:04 -0700
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
Subject: Re: [PATCH v6 07/31] vfio/pci: Detect CXL devices and load the CXL
 provider on demand
Message-ID: <20261104165304.2563f4ae@shazbot.org>
In-Reply-To: <20261016161839.2765592-8-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-8-mhonap@nvidia.com>
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

On Fri, 16 Oct 2026 21:48:14 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL device needs the vfio-cxl callbacks, but pulling vfio-cxl and the
> CXL core in unconditionally would bloat every vfio-pci setup. Detect a
> CXL Type-2 device at bind and request_module("vfio-cxl") only then, then
> hand the device to the registered ops.
> 
> Each bound CXL device pins the provider through
> vfio_pci_get_cxl_ops() (try_module_get) and drops it with
> vfio_pci_put_cxl_ops() at release, so vfio-cxl can unload once no CXL
> device is bound.
> 
> If the provider is absent the device is bound without the CXL
> extensions. A built-in provider whose initcall has not run yet is waited
> for with -EPROBE_DEFER; the deferred-probe machinery will retry the bind
> once the provider registers.
> 
> The provider .init() can return -EPROBE_DEFER when the device is not
> ready yet, for example when its CXL port has not enumerated. Propagate
> it so the bind is retried later. Any other init failure is non-fatal: a
> CXL Type-2 device is also a valid vfio-pci device, so log the error, drop
> the provider reference, leave cxl_ops NULL and continue without CXL
> support.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 101 +++++++++++++++++++++++++++++++
>  include/linux/vfio_pci_core.h    |   3 +
>  2 files changed, 104 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 2cc5dd20396c..e50b36751d9a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2202,6 +2202,101 @@ void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
>  
> +static const struct vfio_cxl_ops *vfio_pci_get_cxl_ops(void)
> +{
> +	guard(rwsem_read)(&vfio_pci_cxl_ops_rwsem);
> +
> +	if (vfio_pci_cxl_ops && try_module_get(vfio_pci_cxl_ops->owner))
> +		return vfio_pci_cxl_ops;
> +
> +	return NULL;
> +}
> +
> +static void vfio_pci_put_cxl_ops(const struct vfio_cxl_ops *ops)
> +{
> +	module_put(ops->owner);
> +}
> +
> +/*
> + * A CXL Type-2 device advertises both CXL.cache and CXL.mem in its CXL DVSEC.
> + * pcie_is_cxl() is also true for Type-1 (cache only) and Type-3 (mem only)
> + * devices, which the vfio-cxl provider does not handle, so confirm the Type-2
> + * identity before engaging it.
> + */

Probably another AI comment, it's only describing what the function is
obviously doing.  Drop it.

> +static bool vfio_pci_is_cxl_type2(struct pci_dev *pdev)
> +{
> +	u16 dvsec, cap;
> +
> +	if (!pcie_is_cxl(pdev))
> +		return false;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
> +		(cap & PCI_DVSEC_CXL_MEM_CAPABLE);
> +}
> +
> +/*
> + * Load vfio-cxl on demand for a CXL Type-2 device and hand the device to its
> + * ops. If the provider is absent the device is bound without the CXL
> + * extensions; a built-in provider whose initcall has not run yet is waited for with
> + * -EPROBE_DEFER.
> + */
> +static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
> +{
> +	const struct vfio_cxl_ops *ops;
> +	int ret;
> +
> +	if (!vfio_pci_is_cxl_type2(vdev->pdev))
> +		return 0;
> +
> +	request_module("vfio-cxl");

A local sashiko run questions:
---
[Severity: High]
Could request_module() in vfio_pci_core_cxl_init(), in
 drivers/vfio/pci/vfio_pci_core.c, deadlock when a matching Type-2 device
is probed asynchronously and vfio-cxl is an unloaded module whose own
async_probe setting remains false?

Asynchronous probing can be selected with vfio-pci's async_probe=1 module
argument or driver_async_probe=vfio-pci. The resulting wait cycle is:

    __driver_attach_async_helper()
        vfio_pci_core_cxl_init()
            request_module("vfio-cxl")
                waits for modprobe to exit

    do_init_module() for vfio-cxl
        async_synchronize_full()
            waits for the outstanding vfio-pci probe

In kernel/module/main.c, do_init_module() performs this synchronization
after the provider initializer returns. Successfully registering the
operations therefore does not break the cycle. The provider's async_probe
setting is independent of vfio-pci's setting.

The warning in __request_module(), in kernel/module/kmod.c, does not
abort loading. Dispatch through pci_call_probe(), in
 drivers/pci/pci-driver.c, also preserves the cycle because the originating
async callback waits in flush_work(). The global async wait has no timeout.

The final series retains this synchronous request. Could provider loading
be moved outside the outstanding async probe, with binding deferred until
the operations are available?
---

AIUI, this could be resolved if we do the request_module() on bind and
the CXL init on open, but CXL expects that we use the devm interfaces
that have a bind->release lifetime.  But then...

> +	ops = vfio_pci_get_cxl_ops();
> +	if (!ops)
> +		return IS_BUILTIN(CONFIG_VFIO_CXL) ? -EPROBE_DEFER : 0;
> +
> +	ret = ops->init(vdev);
> +	/*
> +	 * A provider that is not ready yet (for example its CXL port has not
> +	 * enumerated) returns -EPROBE_DEFER. Propagate it so the bind retries
> +	 * rather than continuing without CXL support.
> +	 */
> +	if (ret == -EPROBE_DEFER) {
> +		vfio_pci_put_cxl_ops(ops);
> +		return ret;
> +	}
> +	/*
> +	 * Any other failure is non-fatal: a CXL device that cannot be brought
> +	 * up as Type-2 still works without the CXL extensions, so log and
> +	 * continue rather than failing the bind.
> +	 */
> +	if (ret) {
> +		pci_warn(vdev->pdev,
> +			 "CXL init failed (%d), continuing without CXL support\n",
> +			 ret);
> +		vfio_pci_put_cxl_ops(ops);
> +		return 0;
> +	}
> +
> +	vdev->cxl_ops = ops;
> +	return 0;
> +}
> +
> +static void vfio_pci_core_cxl_release(struct vfio_pci_core_device *vdev)
> +{
> +	if (!vdev->cxl_ops)
> +		return;
> +
> +	vdev->cxl_ops->release(vdev);
> +	vfio_pci_put_cxl_ops(vdev->cxl_ops);
> +}
> +
>  int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  {
>  	struct vfio_pci_core_device *vdev =
> @@ -2223,6 +2318,10 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  	init_rwsem(&vdev->memory_lock);
>  	xa_init(&vdev->ctx);
>  
> +	ret = vfio_pci_core_cxl_init(vdev);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
> @@ -2232,6 +2331,8 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
>  	struct vfio_pci_core_device *vdev =
>  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
>  
> +	vfio_pci_core_cxl_release(vdev);

Sashiko has a doozy regarding the resulting lifecycle teardown:

---
[Severity: Critical]
Can vfio_pci_core_release_dev(), in drivers/vfio/pci/vfio_pci_core.c,
invoke provider teardown after device-managed cleanup has freed vdev->cxl
when final object destruction is delayed during unbind?

In the final series, vfio_cxl_create_memdev(), in
 drivers/vfio/pci/cxl/vfio_cxl_core.c, allocates the provider state through
devm_cxl_dev_state_create() against pdev->dev. This release hook instead
runs at final vfio object destruction, which can follow driver removal
and device-managed cleanup.

Device-cdev close and unbind can interleave as follows:

    vfio_device_fops_release()
        drops the last registration reference
        completes the unregister wait

    vfio_pci_remove()
        finishes unregistering
        drops its vfio device reference
        returns while the cdev still retains the vfio object

    device_unbind_cleanup()
        devres_release_all() frees the provider state

    __fput()
        cdev_put() drops the remaining parent reference
        vfio_pci_core_release_dev() calls provider teardown

Enabling delayed kobject release provides another path without an open
file. The module pin preserves the provider callback text, but does not
preserve its device-managed state.

vfio_cxl_release_device(), in drivers/vfio/pci/cxl/vfio_cxl_core.c, then
reads the freed cxl->hpa_range and cxl->hdm to release the reservation and
free the decoder snapshot. Reuse of that allocation can cause an incorrect
reservation release or an invalid free. The final series retains both the
managed allocation and this final-release hook.

Could provider teardown run before device-managed cleanup, or could the
provider state remain allocated through final vfio release?
---

So perhaps trying to shoehorn CXL's devm lifecycle into vfio-pci is
biting us anyway.  Thanks,

Alex
