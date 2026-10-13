Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E55563FC0
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933291; cv=none; b=u4KyVSP0jHI2Wu23dM1dNgLTrtv7Y8X7ttEdtaT54s95zgu5I3OlVtW+YI0Fwc8c2bL5jcYkQFieTzzAQh+9EBol0KuMh3SEDtjmdIH18u48OpLqAeKYK60JqwmarOHG1Ti6HkMK/kH757dgeaSEMvTUY2BHnDT6GgPBRd9v4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933291; c=relaxed/simple;
	bh=eRPoX+cvghqiMrqus0n9Qybh3O85l6XeVOQrj+10NLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJ3aqh+MdVHwmS+0wJ9m0Q8TN0LYxQfFUod4dXQzz2l+123HqTSCxVuToHtMIi189N/JzObaH2eKNpsKDJxCaKkqDfyPZ6U9Afh+1V9uu6htNvJi1iMZScMasl56rWJ6bcMWs64xfpfpBoEIKW8j4sn/bHStq+1nbDY2Se6bDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=rw10vX/3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uGs+/jBZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="rw10vX/3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uGs+/jBZ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 595CA7A026E
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 19:14:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 13 Oct 2026 19:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791933286;
	 x=1792019686; bh=2DfpwWFq1HOra+MrNUUfPOhw7Qi6lGgc7bfsPMNOQOM=; b=
	rw10vX/3EztxiCLfuAPaQYIqpIQOR8P+AcSB4BcUl7V14lz4tRwDnSJ7JnodaO5r
	mGDDOk8WPjj10H4xxzr7hMCvXrMk/T4k4immzjUjXshPjjZfERoDDmamE/SsPRGM
	fK3tAzpTuxexxoO27IxwBtKb9Q8Z5DLHHYXgXqtJew08YfwGMZW4LNy9zApp+e+p
	OJA+ahQwuJASMmX+3P2g4tk6vNkK1hswUOYHczBfYTaSZwoQRmPtRqCTijI/f6Hu
	KPyrPYHjBcvN1EyeY4MPOUf7gLLaB23xmMycA68ywKPBtk+TyZia1tqkGSVHcCGb
	jqWpQsFHBTeKZewgS6ocOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791933286; x=
	1792019686; bh=2DfpwWFq1HOra+MrNUUfPOhw7Qi6lGgc7bfsPMNOQOM=; b=u
	Gs+/jBZ7hZPKJuAGnY8LVLfwEHA9aJ+94581k1+GmS3gmwfgeDX+Gf9QIEGEgzFo
	XQ5YzbJd30nlrFr5CjBpXCQ0RuwkNgfuQOKBUm/whRlLYzB3Lvl7Hni+wGcagHIn
	t+23a4z+8gZd6izV0xEs5v4fap/IUtIfrPPdtJBMiNmE4QyPk5D+Ry1ThuftF4jL
	CJlhi5vdQ30FXAkVFXs516U7wAH660Oc/rttfLE+0PCIfFcGrtRHPhWK4VjtqDiZ
	V3XlOrV5Lecw7IXlkaaFq9eo3o3kUj4tzGSsYC/t96RbwkFIBtJ7lDAc/ioyhV0K
	s+4jcXkdb2iEVgUmxbMXA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791933286; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:cLlrnJXg1WeqHfb+bmXKgjkxIQarxvHaAqH4XtYuLfXapmm
	6wwbVhh0NesGsJsIr29mFxoegwHcBN4SvRxrT/0wrVgd10HnI+BKR2fMeUvE8VgZ
	cvZWMsA/1Von4+yoGIsichobaShiSwIYN9qG/SxZSlf6/kBfZYDS/RmEGuzJfsQN
	vnC+lls2URdlXR+A2LQ+gHq0IYftr0iGT5rRcVNAFxo2H9+fg7Cxu1XUi8rwfEPE
	/s1Mhkn1z10jE1VbEOXO35GChPC5AiqvSldP8AbUSGD2D5w4+KNFTl/whD+uj4Z5
	JymuLsyFzVrzHVPzjnkcB67Ae4VEvNK86T4AWQA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kkU8cm0X3UdsSi7fY2qIUOqaXcxT0ngc1PD+8exrdjc=:eRPoX+cvghqiMrqus0n9Qybh3O85l6XeVOQrj+10NLw=;
X-ME-Sender: <xms:ZbvOapUWIsZr6AOj_Zfzu6erFKgFZ9Rrddg4U-qc-5J0DbXhsdRDSw>
    <xme:ZbvOarOC8hnDZmdJQX8hUDpVx62QilWUPO6Ng4d3gyA968anCZMXkBVwL_SF6j4sy
    7ENNO8NPi41DFQKnFQO-pmW-v13b7YZOOit7IPOoKr3B4zML-w5>
X-ME-Received: <xmr:ZbvOapdddAsoEMwNyAkA6ojg51ws4TwIs_IFtfMPnKtokUA9c7lkz1pgR9zr1g>
X-ME-Proxy-Cause: dmFkZTGh5K968C2Cl84ptSi+4y/RZ/kVjRI/KuhQFT9EdVF+wlBRkUV3+MnA4Bw8USczqh
    K75Ks9fzzqoUpxb7GlBjbnkhjHyFx4/Ig31C73IxKiEP0jiid6Tlem7NohMXSaR+5FMEhK
    ifHB8gtzfUTonlinprF4mw7WPTut7T/J1hPsQXDLSJK0xqaYcZbKfDVq23wYMjW2iywqpO
    ZIPaJ4ce5Zm6PCb9LkghPIarZYc8Qnu+WxwoCZiOXCKojQi16QdbuVc39mEboH71fqwON2
    cQwxZsIGEE5+oDvRemv0bEM6otLHIcNZE8FD2rvXxw3NzcIK91ZKa9ZQuG1p86j7bXidbN
    bTt2lMDWBc72Ycb2zfdXeYr8tOieQM+emlz06TGu4mwTOBMAeH/bYdIObNhlmvQ2NOcZYg
    cNBGBqigPaupTMhTkhD4IQvoWYJDI65SwzwWtAutEgzZaUxZFmZM2BpiWjda7sWrsvqhw5
    lIABPrgE0lVg1eFk7slpb+3GC9Ky2XqeIL2mFEfGwGbrUAA7idIENWnzP9BdjZQsHQANAg
    OlAI8UpCeKEqrMIqXOTeSw2mGhTQO70D9PZIJlMiQKs2t1auwCWngeSkV/diVoEF/CJ3NJ
    ULSmsbW8OmioGjZ9Rk9TYwK3D/Q2NqIexOsljbhnaFsvbSEMAQYIRW+SeQug
X-ME-Proxy: <xmx:ZbvOaiwq52t9HXF6eFHOfjMuIJSTZinnngBmNRUCGkZpzp_CHbwIxA>
    <xmx:ZbvOaigZ23ftU_khOfV2sY_5E0-WRVOj-6qE1INLK2lpQ3r_CFWIbA>
    <xmx:ZbvOan6ZFMQv-gzYsomTliFhUsTlIHdulpOZLmDT1GMrydK3irnLLA>
    <xmx:ZbvOanqfABu8eeghP49yPsMuBtSSHbEyHh4xNHB62iHrK8VvMyzGww>
    <xmx:ZrvOak2eHEpA6LjkO93bVb5sV_XQt-KzJ064oJW3ignpTMxNU8LM3LRs>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 19:14:44 -0400 (EDT)
Date: Tue, 13 Oct 2026 17:13:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v8 7/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <20261013171352.1c467040@shazbot.org>
In-Reply-To: <20261006193643.76330-8-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
	<20261006193643.76330-8-matt@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 20:36:35 +0100
Matt Evans <matt@ozlabs.org> wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index cb0e4865d110..986852b1d44f 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1337,13 +1338,18 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	 * have NoSoftRst-, the reset function can cause the PCI config space
>  	 * reset without restoring the original state (saved locally in
>  	 * 'vdev->pm_save').
> +	 *
> +	 * The zap is done after making the device accessible in D0,
> +	 * because a DMABUF importer could access the device as part
> +	 * of its revocation cleanup.

Nit, s/zap/revoke/

Thanks,
Alex

>  	 */
>  	vfio_pci_set_power_state(vdev, PCI_D0);
>  
> -	vfio_pci_dma_buf_move(vdev, true);
> +	vfio_pci_revoke_bars(vdev);
> +
>  	ret = pci_try_reset_function(vdev->pdev);
>  	if (__vfio_pci_memory_enabled(vdev))
> -		vfio_pci_dma_buf_move(vdev, false);
> +		vfio_pci_unrevoke_bars(vdev);
>  	up_write(&vdev->memory_lock);
>  
>  	return ret;
