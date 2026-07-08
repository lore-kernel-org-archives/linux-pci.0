Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41526346E7A;
	Wed,  8 Jul 2026 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553633; cv=none; b=uYnynB4uORp2lp2G53Mku/6eyi2EHcD2DeMIIZeTBh5ejKntx7kUno1W9hK6pwN8um3RwXQe3xdnJ03mK44WPIHOg086s4kTmR+waIisxfhTC7j+q8M89+uL0XtO7syJvrSTZMg20OXcdczvtBlV71t0+zFAsWKTCfWchNnCJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553633; c=relaxed/simple;
	bh=RfrT32G1hd20i1qcYY+mMJhrU2H9qCa1cMVaLgwu20k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ni9v1Z0cRa75BEU5mK8DL2DshcRxDP8GYnKGWHQawQmRqhmcftIOzAjc2VV+fbrfQqt3lRjaXfpJDcuo4kr4pFC+WATgLvsoGdm78u2qsAa+RSAebTXWQI6i1UVPvKR5cQu0ey4i4TagF0YCz40V7qMp2vNmvECqbPxdjUeKezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=bAXZ813+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MuXIFVKm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="bAXZ813+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MuXIFVKm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 407CCEC007B;
	Wed,  8 Jul 2026 19:33:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jul 2026 19:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553629;
	 x=1783640029; bh=jycFkUEU+EWsbNBTlcMiSw8oZ+CeyWMY6jFUi7NKCTY=; b=
	bAXZ813+7RpNaw63wsUkM1YX28iQgvrDeZFKF1pUDgNL6HA026n766wvEhtNMlQd
	vC0IharNNDtQNxLG3AcLj+Lby42R3bKYga+B1wS89I45kmSzXgewh2cWJ7MkSptp
	dpBrE1SAS0jsFPKnwHei1+iEBUYHM/evpuwMuFHIx3JYnq7/wusIAiuHusFGg+na
	s7NOR7Lw1UXF9MULRhSrGWeEukxgrcF5nqgl4Q9cvmhBf2ouSesszTDocDb2r2JQ
	VoFcDzmU98LDgrmtdOqguSolTojKWURnq/2f2a2pMoEBoS/XS/JpqYGpErSL/QvC
	BYGG/w35qB9aPOVE+UB1+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553629; x=
	1783640029; bh=jycFkUEU+EWsbNBTlcMiSw8oZ+CeyWMY6jFUi7NKCTY=; b=M
	uXIFVKm6m2Y2oW8l4DEFUusrPb8+pe/fDft2yn88M6ZfQ0Dt480S8ybWshTzThPO
	s0KlCFILB4pNSP7zPMnNydVIPlm4yrbwZr5jo+gxOw9fgr32nBFs0ij/5d6scO4i
	PB/nrL8wlbnCIpz9FseOh5zTzr/ukf7b/QXqBWfpa9OwxVX38oLxVBHXLArb22JO
	PRm5snV1AwoMj59Oh+a9V2bmzvL8effQLtYHOJCGPBmzZzkthf2GZV54iRF4/FyR
	liNegcTAXAOKotu7AMWbeX8z79R5plKgObivBOSzPsf4JKepkRAqq7jeDbzKIQsG
	NaADnWkb5JRTpqhWN2KTg==
X-ME-Sender: <xms:W95OaqCCXGvRsI8kYQaNWTZpx5Juxb-31O9yVJNkUTjZlThj0xTl8w>
    <xme:W95OamGb7TF_0V3qCoObmKRExXxoExqjDI_yPhgsgy4DLLyld1Ss3ynxjwoaKCGBq
    aVMS4nW8AWa34aXudWHV48TqH51famb44IVtj1zQmVy-Tl88uU6n3A>
X-ME-Received: <xmr:W95Oas3kul1tJe5K3JYQelwl4Qz3smFav89uL3FM80wptCgqAYkVAUjN4kQ>
X-ME-Proxy-Cause: dmFkZTFk66Tr4PZ1RpoJ2yXE2BF2dN68DoODhH+NgpAxw/zva66bqnWHxfSCYuZR+JyEHm
    flF4GbtFnt8bLxJgMnCN6nvmLvaELOEEjMTryq/TRPaGVQdVxjfdjdFdCfsRXGWtaOQPLj
    vzEmEj9I22CJ/UbhUOEd0yW0tDBXwpjK6Sjvuhsts1Pkn254JZLVYCPz1f8XdQrd79LQIU
    jMi262mhG4so7FIUMKsu10QFKFjSCejJBkuIBhOwSViFF1N3o2bNmiSB1Bnpugtb4NhQFP
    ywoiS6dLdLko78Xju90QoFu5L4u4/khGmtDl8gm0o7afMlgiE6wqGIDcb9T/cN8hCOZMTP
    Xag8AmYRJj85zgwGw8xfwkd5fkd7ZQxkLre2hhcQH1L2yPqy5fenT7Lnz8s0cQdAOvoHdd
    lhxXNziWkqSv1YZQJzeQYnUkAh3nHfaO6lGTOmiHfziCk8GxEHtTUSzkgqOycLR/4GrhEL
    y7wcO0NSFfQIPfD+0qmBkvvuQuaCdjGGiPBwOJD+3hkTYo71S3IyP4nlxztM7JxNKkBVKO
    5FfyxguNGswqMe8/ezT2qgSXWRE+17VRXv/odFHO1gqAxobLVJtzTal/7mIKwedd0M2NKn
    2yiOn7UVUmADdtmHNZ/gmgoaXVGOQ+ksbWunWt80C4yAT8SKXeoD/Mb+QTVg
X-ME-Proxy: <xmx:W95OavNqHrDOCo7HHobdANC3ukaGc2bdTfi44f445AKq6_ymdSn6dw>
    <xmx:W95OakbppmwmN_k3WcckO0PARJdHbjshjJYy3_A6GJ5tJNzJCpMwOA>
    <xmx:W95Oaly1mEu8Sq6A9tGSdHMKJP1fNSRvI_EDYcue3Qe7oF3QW32kpQ>
    <xmx:W95OarMBtti7Q7mUEL6CHPES2k_giwN-t8oTtsqqpNy2JdKJqT0xyQ>
    <xmx:Xd5Oaj1iISQXJuRGje60a10IwejuEyViKbtTMFgD3ufvZ-N5B26Vx8Hp>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:33:46 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:31:41 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 10/18] vfio/pci: Introduce tph policy parameter for
 staged TPH feature enablement
Message-ID: <20260708173141.31aae027@shazbot.org>
In-Reply-To: <20260702124224.57168-11-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-11-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:16 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Add a module parameter 'tph' to implement staged TPH feature enabling
> policy. The parameter accepts a value from 0 to 3 to progressively enable
> TPH capabilities:
> 
> 0 = No-ST mode: RESOLVE only returns PH for DMABUF source;
>                 ST programming unavailable
> 1 = Add IV mode: RESOLVE only returns PH for DMABUF source;
>                  ST program supports NONE/DMABUF/CPU sources
> 2 = Add DS mode: RESOLVE returns PH+ST for DMABUF/CPU sources;
>                  ST program supports NONE/DMABUF/CPU sources
> 3 = Add LITERAL: RESOLVE returns PH+ST for DMABUF/CPU sources;
>                  ST program supports NONE/DMABUF/CPU/LITERAL sources
> 
> This commit only adds parameter plumbing and state storage, no
> functional TPH logic is introduced yet.

This adds module options for a feature that doesn't exist yet.  That's
the wrong ordering.  The module option is the only introspection that
the administrator has to the capabilities of the driver.

The intention of the proposal was also that support is added
incrementally, ie. "an incremental support path".

We should start with adding No-ST support to the driver, concluding
with the module parameter infrastructure that essentially advertises
the driver support on the host, 0 (default) is the only accepted value.

The next step would be incrementally revising the driver support to
include IV mode, concluding with exposing it and configuring it through
the driver option. Repeat for DS mode.  Repeat for LITERAL mode.

This is what allows us to decide where to stop in the implementation.
For example, we've designed LITERAL mode, but if no VMM intends to
support it, why implement it?

Also, this module option is being defined on vfio_pci.  Are we
intending that this is a feature that each variant driver would
opt-in to via their own module options?  LITERAL mode is incompatible
with migration, so it's possible each variant driver would define what
level of support they expose.  Thanks,

Alex

 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci.c      | 25 +++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_priv.h |  7 +++++++
>  include/linux/vfio_pci_core.h    |  1 +
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 830369ff878d..7ef82b445722 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -60,6 +60,28 @@ static bool disable_denylist;
>  module_param(disable_denylist, bool, 0444);
>  MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
>  
> +static unsigned int tph_policy;
> +static int tph_set(const char *val, const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, VFIO_PCI_TPH_POLICY_NO_ST,
> +				     VFIO_PCI_TPH_POLICY_LITERAL);
> +}
> +static const struct kernel_param_ops tph_param_ops = {
> +	.set = tph_set,
> +	.get = param_get_uint,
> +};
> +module_param_cb(tph, &tph_param_ops, &tph_policy, 0644);
> +MODULE_PARM_DESC(tph,
> +	"Global TPH policy level (0=default No-ST):\n"
> +	"0 = No-ST mode: RESOLVE only returns PH for DMABUF source;\n"
> +	"                ST programming unavailable\n"
> +	"1 = Add IV mode: RESOLVE only returns PH for DMABUF source;\n"
> +	"                 ST program supports NONE/DMABUF/CPU sources\n"
> +	"2 = Add DS mode: RESOLVE returns PH+ST for DMABUF/CPU sources;\n"
> +	"                 ST program supports NONE/DMABUF/CPU sources\n"
> +	"3 = Add LITERAL: RESOLVE returns PH+ST for DMABUF/CPU sources;\n"
> +	"                 ST program supports NONE/DMABUF/CPU/LITERAL sources\n");
> +
>  static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
>  {
>  	switch (pdev->vendor) {
> @@ -142,6 +164,9 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
>  #ifdef CONFIG_VFIO_PCI_VGA
>  	vdev->disable_vga = disable_vga;
>  #endif
> +#ifdef CONFIG_PCIE_TPH
> +	vdev->tph_policy = tph_policy;
> +#endif
>  
>  	return vfio_pci_core_init_dev(core_vdev);
>  }
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index fca9d0dfac90..c997cc9bf330 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -11,6 +11,13 @@
>  /* Cap maximum number of ioeventfds per device (arbitrary) */
>  #define VFIO_PCI_IOEVENTFD_MAX		1000
>  
> +enum vfio_pci_tph_policy {
> +	VFIO_PCI_TPH_POLICY_NO_ST = 0,
> +	VFIO_PCI_TPH_POLICY_IV_ST = 1,
> +	VFIO_PCI_TPH_POLICY_DS_ST = 2,
> +	VFIO_PCI_TPH_POLICY_LITERAL = 3,
> +};
> +
>  struct vfio_pci_ioeventfd {
>  	struct list_head	next;
>  	struct vfio_pci_core_device	*vdev;
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 9a1674c152aa..a0641286dd90 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -149,6 +149,7 @@ struct vfio_pci_core_device {
>  	struct notifier_block	nb;
>  	struct rw_semaphore	memory_lock;
>  	struct list_head	dmabufs;
> +	u8			tph_policy;
>  };
>  
>  enum vfio_pci_io_width {

