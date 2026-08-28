Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0033B0584;
	Fri, 28 Aug 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957814; cv=none; b=gpV6H8ncndfbAb8AfewpKQJ+GHO4lRLBcyzL9bGmCeH+vFuF5YJmNCRf7PwdG1Zxz3lmQdZlG4e3R1MvT8gDlTXZUHoCu9jabiEpt17ptgGkONzxDUf10fMYwHibstuLYTuxrMQgMMcVonPL4qz6VYmxuWBRD7CJXh3zIGDUdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957814; c=relaxed/simple;
	bh=WgSZH6NNpSChURme3PUpCafzgQh7Kg405gcFwErTqaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGh3pbv44tOekkBJYvrJg1YugcCrGF5SK6+lM6v3F76zMeTxRIB9CEd2P+yJjFyTRScmDtMRSAwatbIkh+2SrNYCpzggDMIq25EOCAz1CliUJiCFC6imwHhatSI0qUFXdKViEwUN69Ivz9BiYdwvfKEOOjK03Kdk5/DGMjUuaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=REk4Qh6t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L17FW+JX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="REk4Qh6t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L17FW+JX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 577017A0135;
	Fri, 28 Aug 2026 18:56:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 28 Aug 2026 18:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787957810;
	 x=1788044210; bh=KKLW8cJOO3AnGkQYNhT+Vc3CEkCeTPPhftnLE/+1Ae4=; b=
	REk4Qh6t0VL0UDQ6osCEp/b1ympUZ+5JyunEW/SJEccB54w1GnrRCfNAGl+4PCEJ
	k+WBQ2bJMZxK/3OA4Y3uslCEytGfOaNxVbmd3k6E0HyKw9hPTk3XZ/lZwzpf3F+O
	D4axy6M7gXpArRhkJkC95NLQZhnCbS78zvPxHGWumQge+vpt+fFWBLQxMV0w7T0R
	I/Dbg6z+ckVNjIXvOwgh1xMLfyv07MpkM0CwjyDiFcj+kjNULKHUqNPFsWWW+Pxv
	oHsv+E5AJvOTVrUKYpIaTIL8UOzzIXSxHj9n6MsKzR+d6TwR5UrWMKxxlYMzEYON
	Qqfaidgd4DWZAp95XDwGwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787957810; x=
	1788044210; bh=KKLW8cJOO3AnGkQYNhT+Vc3CEkCeTPPhftnLE/+1Ae4=; b=L
	17FW+JXCrXY/0/cyuPw84RmpsvLF4Ur8MttGunqIhhlpO4OjxlK4aFWnCn0fLQ0a
	FLpRW6swAij8NBbfH8p/5CNM0zzwu1CdSkWgAn34eQ4UJge87GY3ZW2XGsh2pM4m
	eVWR600S012cmSHvSz9Hs51s3Y5/zAtfRX9XDSu5RgdNvt+q/q81xS8yZ12vFi9q
	t8BijnLwG7HxQR+2VS385WVmC9ojhuY1WYYZ+K0roy1OqMMnJel/TA0q/g7y7hm3
	a4WVYfX1VBU/8egY4XLCMnie3m7obl7nThLnVqSq2RUy5hwr2f3nrt24/xgNONjD
	/EHW4NcPyEDTrBcWJBziA==
X-ME-Sender: <xms:MRKSaiRLJjtIu7aIp554sjq6qbwVMJgYWgnGHHO7slaktQ7-afUtvw>
    <xme:MRKSalYRoGGHEiDHKF-wyXGhe7AjddUQCPW4XkPnpcbyWJwxfZT2N3VYqwgu__nbp
    08F-3tDTGETyhjjthLHqr7EblBhTIS-eQxuZ9qqLgVhJMZ04-FUmw>
X-ME-Received: <xmr:MRKSanM3O7-uPhm3W4slpT57VYmGH3iUOOOssF3WzPrCSZhlaDCbCi5klxmWNw>
X-ME-Proxy-Cause: dmFkZTFLGzvkUr5Q+EZ5kOtLvIKlBrEDdYI9l7Awoc8Gq71l6lia3UAsMpqRe49/uwy36X
    pf3wEUeGiDxiNcHq0cGhYA8UVaFVPV1RIIx5r4LRjEFvEt2Fnp8nkxEfFQCcRsmyKf97qg
    KSbXPBAtZt0XIBDEGmoERd4ML1CaCxJpqpoTQ7iQhwZ7YrYoN2WtbcF2BIasXK/3zFgGiJ
    8UxFE5HpYqDQU+6FjOTEyxGJrC83784v32WttMih1yhylE8rQvu6VBjjEbXKKsff6ahZVE
    B7woNvalxCjeN91ADtoMGYDwXQUMCnXl+NbM/elK+rTRvNYD7spbuFAkptwbpvAKqwybf1
    Wcv++3S585yQR3Q2EgcXQBoo6fOBDOkffgdFD5Dl5xJP3iCWiVMmgK1XGhXPDnwQPLNP1e
    KkZVXXJB8KMUbFvPTiqQimezfF7PrbkBySaoYgHYmDtSD+QPGo//dAXlxJlHmx/u+jJZS0
    pneTx20onV6Rf8XTSKknYaGCDSRduX4zCoBlGgZ1PJ2c3aNnrNpUukfCMbWW2zW1wG/6VP
    tk8r1w2MTsWSoFIi4PeexS7xTThLLhNvHOUVypa/3y6TB5IyA6wk7/1h/vgiTDZSdCUlsE
    TnacV+CulHFIoi4W2Y4tr3FkkIofqWNOVQU/eBAJL4kDWuuhakCByuZPy9Fg
X-ME-Proxy: <xmx:MRKSamO6M0ok5lrfhM9bgYLSI-8EprUs67HGnb61yswNShX8bNasMg>
    <xmx:MRKSajMGp8j24Yee7PwzLf4TRe6LnyxQHCu3EwOoqVx_f-XcdbD87g>
    <xmx:MRKSaqb2QlOcfEFtf1vuIkWDIPxzKM7X0Zv3nQVnBy67ewpnyqlz0g>
    <xmx:MRKSaphzAv2FklB1swsvOyRPMf4hBeZplxDgVRzi1Out11uvF82kKQ>
    <xmx:MhKSaiZDDI7HgWr2V4Z9dRI2rFqPC6VQXw4k-nLk6Iwmqu0fJBhST_pa>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:56:47 -0400 (EDT)
Date: Fri, 28 Aug 2026 16:56:45 -0600
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
Subject: Re: [PATCH v4 25/27] vfio/pci: Provide an opt-out for the CXL
 Type-2 extensions
Message-ID: <20260828165645.03aed778@shazbot.org>
In-Reply-To: <20260813093631.2288172-26-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-26-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:29 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Add an opt-out so users can keep vfio-pci's CXL extensions out of the
> path for individual devices or for an entire vfio-pci instance. The
> runtime gates are:
> 
>   - Module parameter vfio_pci.disable_cxl (bool, 0444). Setting
>     disable_cxl=1 at modprobe time makes vfio_pci_probe() set
>     vdev->disable_cxl on every device it binds.
> 
>   - Variant drivers (nvgrace, mlx5, and others) may set vdev->disable_cxl
>     in their own probe for per-device control without the module
>     parameter. The bit lives on struct vfio_pci_core_device so it is
>     reachable from any variant.
> 
> vfio_pci_core_init_dev() consults vdev->disable_cxl before it probes for
> a CXL device, so a device that opts out is driven as plain vfio-pci:
> vfio-cxl is not loaded, init_device() never runs, and the device gets no
> VFIO_DEVICE_FLAGS_CXL, no HDM or component-register regions, and no DVSEC
> virtualization.
> 
> The module parameter is built only when CONFIG_VFIO_CXL is enabled; the
> disable_cxl bit itself is unconditional so a variant driver can set it
> regardless. This mirrors the long-standing disable_denylist opt-out.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci.c      | 9 +++++++++
>  drivers/vfio/pci/vfio_pci_core.c | 8 +++++---
>  include/linux/vfio_pci_core.h    | 1 +
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 830369ff878d..0ad041fffe48 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -60,6 +60,12 @@ static bool disable_denylist;
>  module_param(disable_denylist, bool, 0444);
>  MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
>  
> +#if IS_ENABLED(CONFIG_VFIO_CXL)
> +static bool disable_cxl;
> +module_param(disable_cxl, bool, 0444);
> +MODULE_PARM_DESC(disable_cxl, "Disable CXL Type-2 extensions for all devices bound to vfio-pci. A variant driver may instead set vdev->disable_cxl in its own .init callback.");

The latter sentence isn't module parameter description material, it's
aimed at users.  Why does this need to be read-only since it's
following the latch-at-init flow?  Thanks,

Alex

> +#endif
> +
>  static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
>  {
>  	switch (pdev->vendor) {
> @@ -142,6 +148,9 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
>  #ifdef CONFIG_VFIO_PCI_VGA
>  	vdev->disable_vga = disable_vga;
>  #endif
> +#if IS_ENABLED(CONFIG_VFIO_CXL)
> +	vdev->disable_cxl = disable_cxl;
> +#endif
>  
>  	return vfio_pci_core_init_dev(core_vdev);
>  }
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 0fed8e00bc1d..4b51a0f1e847 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2423,10 +2423,12 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  	xa_init(&vdev->ctx);
>  
>  	/*
> -	 * Load vfio-cxl on demand for a CXL device. If it is absent, drive the
> -	 * device as plain vfio-pci rather than failing the bind.
> +	 * Load vfio-cxl on demand for a CXL device unless the user opted out.
> +	 * If it is opted out or absent, drive the device as plain vfio-pci
> +	 * rather than failing the bind.
>  	 */
> -	if (pcie_is_cxl(vdev->pdev) && vfio_pci_is_cxl_type2(vdev->pdev)) {
> +	if (!vdev->disable_cxl && pcie_is_cxl(vdev->pdev) &&
> +	    vfio_pci_is_cxl_type2(vdev->pdev)) {
>  		const struct vfio_cxl_ops *ops;
>  
>  		request_module("vfio-cxl");
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 18e206a35d8c..8e3723a55c17 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -158,6 +158,7 @@ struct vfio_pci_core_device {
>  	bool			disable_idle_d3:1;
>  	bool			nointxmask:1;
>  	bool			disable_vga:1;
> +	bool			disable_cxl:1;
>  	/* Flags modified at runtime - dedicated storage unit */
>  	bool			needs_reset;
>  	bool			pm_intx_masked;

