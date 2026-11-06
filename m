Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005504;
	b=wf5iSdEcy5fj+TQxNKUy30SJ1YttYHYolAWdrBjo3wl+WyOE31v/ADjD0kbSRW7ZUiTn
	 nGfRWId+Y+4IprYGCmX3eSYW1p49DfZDq4297p1YKSF+HmlqZ51NjzZwX7WlaLvUcJdTc
	 PzYz24VCVdc7f/WP1Xg7kANqs5EX1RZpe3Lf1HPvtKTiOvoEq+1t5FkqrodkMPcHGydLP
	 AoDUosR3sUOcbmQVxPKjB2TCcfyyhrE55YHs6oIkGXk1dJ0bb5m1ayYCRjj4LNi5hTSxk
	 TIYwK9lBnt3YgjpblZqOPVW/Lcii8s9OPKQZBj5eV654gxf0eHYgcjyuAWT5A+XLiHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005504;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pCINyycb2Yi7eXcN76C9p3VO8yXHWknwGqsZ4naX5E4=;
	b=v1l/RZcsU/8HV+lPG4cacuQoqZlpTZ5uKn3ZOyqsJSlEe7BlDeK8aSIcnTTOGPu89acP
	 6FFPC/3+eiw0SkETLdBP6QeUfMpqeRYkJfcOJINYV+VwqmmBLV80FTSOcAPzremf10nkn
	 Ym+CQngw30Eh+fnc7KiKYz14bVkjx9B370QKnI5wKlyDADuCT3iO1t9Vss/286zYzB9vq
	 4jus2KB0m08WvdNKI5UxgKiJ0z32tgiPqNOc71k37Lib7HTADFvaEaEIZP1k+q9NwzBQD
	 88HtdSJETKfwWtolky5V3ElHhzRWum8+/N0974vyaePKIjCxhnX8xgJKcN+X9S0KZsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=eXwYvvvp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="a/EV4SN3";
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80018606A330
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 22:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80018606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=eXwYvvvp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=a/EV4SN3
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C53B6140011F
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 17:51:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Nov 2026 17:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794005502;
	 x=1794091902; bh=pCINyycb2Yi7eXcN76C9p3VO8yXHWknwGqsZ4naX5E4=; b=
	eXwYvvvpQVKBaBpNbRUe/+3hYKCeOcbuVWiYmYLKEvLXtRoAGvUf8RbrmXwsx48p
	RMEOXPcOMIYiwlgJiG2tu6GhNLXDb72Rz1d/Z1gV4gjhVv9VROtq60SjULmH35ib
	PZVrZi6T4LBfl535OcFR2LdFMLf4CbQXL6pHnWFKuPquS9UGc9oQZsVTiFUgLCFO
	++dgLLlhCWRIaIzw48OyM5BEywklope1/SwKtMCifcb2M47t9hktfmi7eSt/M3UA
	7rwZSjQBVEa4VMwNCbH7KonnGQdnp8Hay/5XF84slGoGYXimieBUP8P7D3ZU/b2o
	1QG4Ab+IwWFzwNIrtne2Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794005502; x=
	1794091902; bh=pCINyycb2Yi7eXcN76C9p3VO8yXHWknwGqsZ4naX5E4=; b=a
	/EV4SN34LhFKeoYm6dLT3OPcpHdaXHaATWoVHjVvgCPGmJTb5pjnZxCvn7ukG+JG
	sLQeOwxldI5cEywnOf3f4YLOJoqeg3ghymFxn15lA9qe69MLo4CH2NozGNukA+8i
	j3L4X2Vu/aL2SxDhWHewSeAdY5047siA2UMT0W3qVXejXKCwHQRk28cPB/r0iB5e
	gYwQTPe9hbzlX34JPw9yzWAbqMnB4dSbHNt+X4NsJ2wEcplyKIrGlQM+h7vwDFyH
	Z/s5D5/h/AMuCYCTEbMCSHFl7X51iK8VERLJkDK6HasGlxqsOHSR3atmfynWe/Fo
	TMhS7FmeFF8DXAtm257Tw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794005502; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:a3neq/T74USYCeyl90Ucr8cOobqmg3asXMx8zCfw2Tg9Uwu
	chTD3Tm3NFH58LeMrP1TjMELwPjFr4AMfYqcCtqvwhosvlEbNIuk+wBMsxMqSU+4
	9I1grv+8SrksFwoy/0L2lLrQVrdHW5eS09UCVwCO4NL2jgs94zlnWdDjGnlJhXe5
	LcxfjRSOAyHgxYCS51Qt0YI/dyyyQhthQESwBShzJnaisE5Gi4p9K3cLE7UjMAlK
	TMGXnBgFVaOB2GFXnylHQZsOD1I8xvchIsFRAOWqtCRuV7Fbfle7SfSCkfM1G9qj
	OVj60+J+ZDp0u6fjhWrmc03r6E3/wXfI9EGSbzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RaomtIcuXvUIFwt+5sZpEeZA5wqZr6f0fW2ssedUVHc=:TOM4g+7xSqNy0WSFjfB2JfWoxxEEleNx6wst9aJJXmM=;
X-ME-Sender: <xms:_lnuasrUXba2FrX_QVudFK--ZVFTg4U3il0mSRvOBIMemZgedb16gA>
    <xme:_lnuagTR-JZN5SUaZs4jWkwPnnep0J1QxGJoPLO1ZKiHJzt3oisUygEk2CYWdEjQi
    kn6AEVtgCwNvxqoNeA5hKsRwEvOEySqBQnA_8Y4wUZpHOyj_6Dn4IQ>
X-ME-Received: <xmr:_lnuaokoo8q81RfRbxNYqIAseOSj28-drfG_yAOgxIVVx0ALfmNpvcnrHow0rg>
X-ME-Proxy-Cause: dmFkZTE6cr9qQxQy/NTdx2j4Uy5Tstc9ECcua64GU/0jH4N0I8lrKEWqW0lQfJCEnrS+FW
    gyx3ol9myKVUtTXCA9e+BjNluWF9Pe7xw62YCW5NHRrMlGafLSXEyWuu/BRNxfSmaaNYk3
    ehoFW8RAO9Lo2QPPkRc7SLF4DF8EkO0phNnJDBOrFkTdcKiJ1wl5a7GZTtFoVK5dKSI/Se
    QAzufhGQWi4yhKr6pr77YJ5raXlX+1ksTpMfWqQQAN9wbkNk72zgi+E5g2y54K+q2tyjLE
    Mbj4vpmCNPkzKYz9fyM4HMsfdMMUfYjpxN4v9LT2xRoZ6OeTk1TG0ide3UTnOQh3yMMdZ+
    3TJl5bkNUPm9aDoS0Y71plJGBC28Zx0F4P6vPaH82ObBxWqh1SwdHWnETNDfw1BXPNOL0M
    XeD+jGnmuSG7Fv9QHEoBl3VDJNBjaFcPBYKUn5hpg+f95Ka9UmSJvvCB9wKbxJ0Yysqy9w
    FeNhXvPq3VKx8yPfk+rkNwJgHtk9dl5/+VNboIkvc7Z8TZUJlAfcX/b0bRp8Gt0DM4ErT/
    8NovABCzt5qxLsbChHORU0PWnhIjppVCbJ76ra3OJz3PKFXWkZBS5TrqXD/Ad6Gmpgvom+
    JT3/5L0/Ke5nO6i2sYG95fXtvrgBuHmUDoINrVDtRLny7nYXAbRN2zE4+PGQ
X-ME-Proxy: <xmx:_lnuasEkV9zy_rdKjRXk4w0T4o0Yq0f5dU4bKCOuzR-TyNvkqkv_sw>
    <xmx:_lnuajnE82WfU-nm3AOPdykNkoAc96cZkOvAKNMdlXGNzqgB9jC--Q>
    <xmx:_lnuajRDMaG3gWHBcqQVfE8kK4lQAqaYCFH0b3kXUjn8tumL42oY1Q>
    <xmx:_lnuag6gKPuHTLIN96fk-wGeWaIaOqccowAhMFZ0bnSdh4_a-vjm8Q>
    <xmx:_lnuasGNzPibMYWZ8e9ucvV1agWqbApqR8cu9IgskTYC2TRgUOBPftzE>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 17:51:40 -0500 (EST)
Date: Fri, 6 Nov 2026 15:51:37 -0700
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
Subject: Re: [PATCH v6 12/31] vfio/pci: Call the CXL open and close hooks
 around device use
Message-ID: <20261106155137.5fcf7259@shazbot.org>
In-Reply-To: <20261016161839.2765592-13-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-13-mhonap@nvidia.com>
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

On Fri, 16 Oct 2026 21:48:19 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> vfio-pci-core frees device regions and excluded ranges on close and on a
> failed open, so a CXL provider must set them up at each open.
> 
> Add open and close to the CXL ops and call them from the common enable
> and close paths. A failed open unwinds the enable in reverse order:
> release the device regions, unmap the BARs, drop the excluded ranges,
> then free the virtual config.
> 
> Factor the device region release and the BAR unmap out of
> vfio_pci_core_disable() into helpers so the enable failure path and the
> disable path share them.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 57 +++++++++++++++++++++++---------
>  include/linux/vfio_pci_core.h    |  2 ++
>  2 files changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 211fff6045e2..3d4e01eea7b1 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -590,6 +590,31 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
>  
>  static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev);
>  
> +static void vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +
> +	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		int bar = i + PCI_STD_RESOURCES;
> +
> +		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
> +			continue;
> +		pci_iounmap(pdev, vdev->barmap[bar]);
> +		pci_release_selected_regions(pdev, 1 << bar);
> +		vdev->barmap[bar] = NULL;
> +	}
> +}
> +
> +static void vfio_pci_core_free_dev_regions(struct vfio_pci_core_device *vdev)
> +{
> +	for (int i = 0; i < vdev->num_regions; i++)
> +		vdev->region[i].ops->release(vdev, &vdev->region[i]);
> +
> +	vdev->num_regions = 0;
> +	kfree(vdev->region);
> +	vdev->region = NULL; /* don't krealloc a freed pointer */
> +}

Mechanical changes like this should be done in a separate patch.

> +
>  int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> @@ -691,8 +716,20 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  
>  	vfio_pci_core_map_bars(vdev);
>  
> +	if (vdev->cxl_ops) {
> +		ret = vdev->cxl_ops->open_device(vdev);
> +		if (ret)
> +			goto out_free_config;
> +	}
> +
>  	return 0;
>  
> +out_free_config:
> +	/* A failed first open never reaches vfio_pci_core_disable(). */
> +	vfio_pci_core_free_dev_regions(vdev);
> +	vfio_pci_core_unmap_bars(vdev);
> +	vfio_pci_free_excluded_ranges(vdev);
> +	vfio_config_free(vdev);

Raising again that this doesn't account for the code previously added
to this function that has its own unwind.

There also remains the question of whether excluded range setup should
be moved to init/release.

>  out_free_zdev:
>  	vfio_pci_zdev_close_device(vdev);
>  out_free_state:
> @@ -713,7 +750,6 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  	struct pci_dev *pdev = vdev->pdev;
>  	struct vfio_pci_dummy_resource *dummy_res, *tmp;
>  	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
> -	int i, bar;
>  
>  	/* For needs_reset */
>  	lockdep_assert_held(&vdev->vdev.dev_set->lock);
> @@ -759,24 +795,12 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  
>  	vdev->virq_disabled = false;
>  
> -	for (i = 0; i < vdev->num_regions; i++)
> -		vdev->region[i].ops->release(vdev, &vdev->region[i]);
> -
> -	vdev->num_regions = 0;
> -	kfree(vdev->region);
> -	vdev->region = NULL; /* don't krealloc a freed pointer */
> +	vfio_pci_core_free_dev_regions(vdev);
>  
>  	vfio_config_free(vdev);
>  	vfio_pci_free_excluded_ranges(vdev);
>  
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		bar = i + PCI_STD_RESOURCES;
> -		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
> -			continue;
> -		pci_iounmap(pdev, vdev->barmap[bar]);
> -		pci_release_selected_regions(pdev, 1 << bar);
> -		vdev->barmap[bar] = NULL;
> -	}
> +	vfio_pci_core_unmap_bars(vdev);
>  
>  	list_for_each_entry_safe(dummy_res, tmp,
>  				 &vdev->dummy_resources_list, res_next) {
> @@ -859,6 +883,9 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>  #endif
>  	vfio_pci_dma_buf_cleanup(vdev);
>  
> +	if (vdev->cxl_ops)
> +		vdev->cxl_ops->close_device(vdev);
> +

Mismatched in both naming and conventions.

vfio_pci_core_enable() -> cxl_ops->open_device()

vfio_pci_core_close_device() -> cxl_ops->close_device()

Some variant drivers unwind a failure after core_enable() with
core_disable(), so the placement in the close_device() path is not only
inconsistent, it's wrong.  The hooks should also be consistently named
relative to where they're called from the core.  Thanks,

Alex

>  	vfio_pci_core_disable(vdev);
>  
>  	mutex_lock(&vdev->igate);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index fd1ad0baf470..6520a2dcfd4a 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -70,6 +70,8 @@ struct vfio_pci_device_ops {
>  struct vfio_cxl_ops {
>  	int	(*init)(struct vfio_pci_core_device *vdev);
>  	void	(*release)(struct vfio_pci_core_device *vdev);
> +	int	(*open_device)(struct vfio_pci_core_device *vdev);
> +	void	(*close_device)(struct vfio_pci_core_device *vdev);
>  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
>  	struct module *owner;
>  };

