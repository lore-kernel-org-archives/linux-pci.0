Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A15390229;
	Wed,  8 Jul 2026 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553634; cv=none; b=mvvGNlNvinp/FlRn8qCmFox/Ws8i7b5iIbGPPPR2zuRAA5Hm9zTScMrsftgEUWtl5bpxMqxKS/5ujtVfKGt/QjHGtfKcNy4x0PPmC/Zdx/vtqZN+hD0ShAz2tztQTzilL9YiLG1D1MmoBrz2wgR+SOk2l3qqfB/71EwMGQCY2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553634; c=relaxed/simple;
	bh=LKWIN9WRi7crT7BoxzJTXQ1ActnkeWtB1lwfglrHIxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtJOLEYMOHec9RXmCFsikBsJOUNSsZqAbde6u5uZSGmoa+jcIp+kp8ABIECsvxGBZ5NBon3AST0F17X38XZWThkVuOGvftf+7lJ5kQLoiQzyxFy9fDRJQ1iI6XAtNmSYdyc7bLvfEw+v6wIRWihVQWzhoYN3bD03C6OW0h/+520=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=TG5OMlTi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UsKZzwli; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="TG5OMlTi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UsKZzwli"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EFF6AEC0091;
	Wed,  8 Jul 2026 19:33:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jul 2026 19:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553630;
	 x=1783640030; bh=gT/23BYyCsA/H8+coZUl5bfCGGf7WbZsNkEZzQ+pnKw=; b=
	TG5OMlTi4Xlkc0Bdfgc7SZnsMoPItaB+vWxLuryiAqEzl+rTZ3kQ8lUPTtPMzgrW
	KUxDXkc/oXSfZOa0WQdp/1sEFg1FkqKrXPcVg1WQRx72LbssowMvRAQuMZPtu5+o
	VBLFfXVSuJI3UpGrGO2fLb+wip15m3GqSMMVlAXm6QY2HIW/gGRDaH5wY6Qcbsu/
	cXUJLhlavh29GpLSoYJropAHpY3Eqxhene4XgqAQ1CvWi/bDc9gkpIIW8mmHPadI
	KqCBY0dmeTjWCF7W+ThAuC/wrCpqIVaUCYxDA6C1J+Htr1AGZwEpFmujEK1W0u1m
	sKBh+d+JsQYClLh0/h8wAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553630; x=
	1783640030; bh=gT/23BYyCsA/H8+coZUl5bfCGGf7WbZsNkEZzQ+pnKw=; b=U
	sKZzwli1oHywRe8m/TdMu27J+5SkxCGUHR9RO7JgNsBGLM+GelPfuo7e6WdEaxAE
	2pQtOMAEFp/SS4my2EzYNcmCETq4es0+XUwsEJtHZpSn5KE5T+jDjpdEUxBWUWeC
	FULKhM7uv7ljhAYcJsF/Qq77q0qtuLqsCkZWzuqB6xO6+KKmfCcs4+BS1S3YAMIC
	l6A+evmnIHh20B7mUjx2xlASYI9Tieakez2+Yq3qJ49nwP9M8XuYlFt8Hq2T2hMe
	+k9gEkuVnYnmcVA61ZbXuo/nOwZ3Vndx2aQ0kgmmjT/vJNUQRbBBhaCsFo5IfrND
	RlvmzcZyK2sd6yQ/sqILQ==
X-ME-Sender: <xms:Xt5OaqqU50lcllxiFvOK3erze0jY8aPDFJ3ST7r0vOISXHADp2tILw>
    <xme:Xt5OaqNFkTJ-V7aY4cwoNhU-ijSItYfuJNJbl4drZpQtOTRlzeh9X9cR-QcgC_gLf
    JgBaHXpEPA5DDzAe7feATRLkbgQnz72ogCdOtlPgTvS4cF_9mXtLhA>
X-ME-Received: <xmr:Xt5OaueuOd9_zESjYUoAbNnH3GBU7yNb7AHeH1BBaPN7XoxPE9nzgCQBqkI>
X-ME-Proxy-Cause: dmFkZTFk66Tr4PZ1RpoJ2yXE2BF2dN68DoODhH+NgpAxw/zva66bqnWHxfSCYuZR+JyEHm
    flF4GbtFnt8bLxJgMnCN6nvmLvaELOEEjMTryq/TRPaGVQdVxjfdjdFdCfsRXGWtaOQPLj
    vzEmEj9I22CJ/UbhUOEd0yW0tDBXwpjK6Sjvuhsts1Pkn254JZLVYCPz1f8XdQrd79LQIU
    jMi262mhG4so7FIUMKsu10QFKFjSCejJBkuIBhOwSViFF1N3o2bNmiSB1Bnpugtb4NhQFP
    ywoiS6dLdLko78Xju90QoFu5L4u4/khGmtDl8gm0o7afMlgiE6wqGIDcb9T/cN8hCOZMSv
    ArbaEE4vVGBLJWJt6B3aKlzB/7ieO5FfQoLfKqezNYpRbAvBS5YE6cvKBrwQVsSGXojrBJ
    0YtO1vO+RyV9UoyzS0KwhUO2Wfl4D57VSsrbWrLXpVtqkUrg7Mfu/9kCXZh1xr/kvcDKWs
    EPfEhRmIvbl8JkP2fNRM9kIvDinR0o7cF6zkZDF20px49qJXXAN3uHhlkeDsPa6BIJPcud
    wCeGtRY+nocT+abctp27w/Pjm7OkiEkZCMmOYxEO7qkLpzXKOEDEoPFYwaptVRb7JHzwyQ
    v5a3UxVvyuEOxC/ovpzhuh1IOarFPcMhMptbOyDI+PFOymqcX+4cNYgzjx/Q
X-ME-Proxy: <xmx:Xt5OagXUpZiJYOKxksUHsrzreDlK1eMgwPb33uSXIHAsfsXkg3SuvQ>
    <xmx:Xt5OavDRTI9wNzEW0rK7UTm4RlzUjRGYytZVtzVSoeWQKy5oeQxs7A>
    <xmx:Xt5Oar6B_QO3UanOdz58YzCDmLoUdGsSM_NLOyvp12PiaYH4xR9K4w>
    <xmx:Xt5Oam0TmVGBFKzXT9g0b8HkgcIHLr4YST_Lqw-G938wfNL9rzeIig>
    <xmx:Xt5Oap_EPIh_SYUvnvKQpW-sdpE2nfsbiVd8x8C9THUq6KuMx92zguHb>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:33:49 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:29:44 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 17/18] vfio/pci: Reset hardware TPH state on device
 enable/disable
Message-ID: <20260708172944.685c3cea@shazbot.org>
In-Reply-To: <20260702124224.57168-18-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-18-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:23 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> VFIO allows user space to enable and modify PCI TPH state, but device
> reset only clears hardware TPH registers, while the software TPH state
> maintained in pci/tph.c remains stale.

It's saved and restored, why is it "stale"?  It seems more that the
interface simply doesn't meet our use case.

What about resets through vfio-pci interfaces, should TPH be
automatically disabled?  Thanks,

Alex 

> Fix the stale state leakage by explicitly disabling TPH in core enable
> and disable paths:
> - In vfio_pci_core_enable(), clear leftover TPH state from previous
>   user sessions before device initialization.
> - In vfio_pci_core_disable(), revert any user-modified TPH state
>   when releasing the device.
> 
> This ensures consistent TPH hardware and software state for each
> user session and avoids residual state contamination.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 7251e251824a..5a14439d1ccb 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -612,6 +612,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  
>  	vdev->reset_works = !ret;
>  	vdev->tph_permit = false;
> +	/* Reset TPH status on new user session */
> +	pcie_disable_tph(vdev->pdev);
>  	pci_save_state(pdev);
>  	vdev->pci_saved_state = pci_store_saved_state(pdev);
>  	if (!vdev->pci_saved_state)
> @@ -759,6 +761,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  
>  	vfio_pci_zdev_close_device(vdev);
>  
> +	/* Reset TPH status on exit user session */
> +	pcie_disable_tph(vdev->pdev);
> +
>  	/*
>  	 * If we have saved state, restore it.  If we can reset the device,
>  	 * even better.  Resetting with current state seems better than

