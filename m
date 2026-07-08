Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACF3769F4;
	Wed,  8 Jul 2026 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553640; cv=none; b=C8tZWfl4khq+FaynZvXmYKIa5rnyt7r5NPRLwhjvdl7KoNVAsuEq22Jarn2/8gAc77kV2id5Xkl8HbIRymWQV58X5aZc4ntofDMspGDMnAvKCYVOqC6aG3b9AlxozKM5rFJVYewr0EXv8aiduYQllhOelrW1sVGNtvkJf72SOm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553640; c=relaxed/simple;
	bh=Zybq89HipI5f+MItKuCc02J+2ua28gSDkFBXHnbQR+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcmvQkIUOPVG4wcGIVM4F7NpuKiN9KXvW/7uOmsfcQUQjCMkcY4WuBsMWCGSlVJFbhJrIffsAuKzXsTwtIdR9vIRve8Ezaypz6RMtVM02TRG83VM0QR5JaHLnE2r6IP5As75KtpbD+Hpwm5P3+wrAttoWTcnLWj+1ZR+GELPTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=iJJMs0xC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rIuf0tyi; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="iJJMs0xC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rIuf0tyi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D2261400106;
	Wed,  8 Jul 2026 19:33:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jul 2026 19:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553638;
	 x=1783640038; bh=Kcm+izkj2XFh3+dN3yFA1kL5FJMrgVLg2rXYN4Bfdyc=; b=
	iJJMs0xCRxNN4QXZqDAAxP/pPw+NLX4IvbMzJsdPL9dfYfIdkAiJmpcogqI0Z8J/
	lr+fzYwFGnbz9ypxdiJa+DYyBWl30cEO2+l7Na3x8y0Sf+loLuBBA5+W4p4QwlJO
	Cun6Rm4M+F3yG3aymCQG1nU2PtSSCozugNh7prXZGoE5nOGtzuQbJHA6fC825yMi
	Ur/f/T41447wBH+y6wVrGGzyopABMgxiBucWKMcszuoo1qn2mETaS4RJxitOsCZD
	k2EuaQgtD81ABJ3NB7EPw5Gt4gFx+uS6r2TLZQevHfOk3ktBNbuSdHmbguEKSInR
	Nd3fK8na7IFOsUatfOK3Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553638; x=
	1783640038; bh=Kcm+izkj2XFh3+dN3yFA1kL5FJMrgVLg2rXYN4Bfdyc=; b=r
	Iuf0tyiOV0NYdSTr0k92JVXcE6mlXsEgq0szgwAow73HC6uEIReXMzpQnzerijFH
	+Xf2my8NsmmUyH/bYhDm6bCT147s+PjmDhxHspHnpWMxoYigeupDzp3lfRov9VZf
	fojbBXuiXrKJhTLwHj2XxJpAOIWNR3boY7Qb53hd3Ex3dA9sDD00cApkSnT6I5Fm
	TcM1dgfFeLnlRVBqykm6INr7V2/VcWJpvN9q6obADfwWgRKmu5gAnx8Xirw8mriS
	hU4vRg5Ghhns/hXMBsHsNthxMGmHq/YxkZE6uEUlzM7zVf9ToZIus0+HcS/KhMHB
	sbg64Q4mJPNIAt2DLp1BA==
X-ME-Sender: <xms:Zt5OaockD5A8PZWm1p-PKPzmOWjkPCiDYuRE9BUoUKjy7jSOINz-wA>
    <xme:Zt5OarwUZuIGV_cgIUed7OY5Tb3k4udVpFcgtxTeKsiTCSVYvDbLjHApDUv5At_uO
    Uwa5iQM2N-6Dmm6QRziu_h_r0EdWw1O2AzAmFidaOOub9K9ElpL2w>
X-ME-Received: <xmr:Zt5OaoxS8oerF6VXi6sU7auwkVuIRZVnpCZvZRYGRhJQWCAnZCwBZfF93lI>
X-ME-Proxy-Cause: dmFkZTFte9WprN0NxcJROcfQFoEYm4B20MOLRP0aieXCyUdPRt+dzeE8Foerkd28PADnVQ
    Q2OHQyexbOYRg0rBSNOhchlTE+r/ewb9pSaPJb36wKXVH9KGO8zOd2ACKSAkP71biec0nW
    AiYi6lJEcJuY92jHX23f2U7Qb1Dg05BGKYh0T/ac7eHxqJqxnMLvbEkhPqn19+QJmg51Bi
    R83/qttr1Zc3Z5ixxRe9NSaWY+LnlyEwiLj4EwFEmOG4Lb+4OmLVuoXmcpjG+fAzjJwsof
    el3RyOoiWDxEYOLUI/eLpV38WJAiH7Apu9E5tR2zCkAGUlL+0Ao0YBSWPfngxFwsSk3Ule
    ZVSkMqkXEXb3/YLwn4hpCjSuvNtA+7hhP2wP1Eq8alHjI26hvppiHzpo3oKeouSQNW6tG4
    zhZcB2iOJtQk7adwlU+jJyL6/v920+Zh3llTy3HJH45nofQYY6ZyVaxpmPTqclnjJ5m7Yv
    5+ixfiv010QlSOu6mUuYMV1apT+fyAhiyaNucX22l8PmiQXR032VLmurngtryL5GCbpUV3
    WSoo5uFdZCqPv7CkkP5BKXiF+6Hwjn66q8iho/Dium/brVywwSLWj9BxBj5TUvyvV7Qbd/
    ay6dID7NLGN0xcVNKa/C4XXqO4r2/MENn9pLpqVmGs2ycfeSdWgUiT1+bmZw
X-ME-Proxy: <xmx:Zt5Oaka_ZUTvIZ-xGGtMHfROP5gEfVzo-UWJNzjAYFI_jnDK8Gh8IQ>
    <xmx:Zt5Oap1iTFv2JHO475Gvtv_nUTXUuQ88n1pwCf1R_OiTuhMdb6a_MQ>
    <xmx:Zt5OameJReE-MrrvOo6p5QHCT_SRWidhBvr0Y9h_-5WuWfJrzen-jQ>
    <xmx:Zt5OamIs8t23aqMFoZDMqHuEilG1CYX9WmOPkkUw2UNK2HeoPoAR1g>
    <xmx:Zt5Oaki_Jt8lbrH4-nvR34icJGXKI4ej48Is-6l9OXc05T0dTQHHa8RK>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:33:57 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:33:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 06/18] PCI/TPH: Expose the enabled TPH requester
 type
Message-ID: <20260708173315.1d89a131@shazbot.org>
In-Reply-To: <20260702124224.57168-7-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-7-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:12 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> From: Zhiping Zhang <zhipingz@meta.com>
> 
> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> requester mode without reaching into pci_dev internals.

This has no callers in your series, why did you include it?  Just for
the context diff?  Don't do that.

It seems dubious even in Zhiping's series, I don't know why we need a
wrapper to abstract this struct field.  Thanks,

Alex

> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/pci/tph.c       | 12 ++++++++++++
>  include/linux/pci-tph.h |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 70273c44e8fd..ea777cc33ae6 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -479,6 +479,18 @@ int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended)
>  }
>  EXPORT_SYMBOL(pcie_enable_tph_explicit);
>  
> +/**
> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester type
> + * @pdev: PCI device to query
> + *
> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_TPH.
> + */
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{
> +	return pdev->tph_req_type;
> +}
> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> +
>  void pci_restore_tph_state(struct pci_dev *pdev)
>  {
>  	struct pci_cap_saved_state *save_state;
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index 1a508b3d511f..e4f7045fc152 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -33,6 +33,7 @@ int pcie_tph_get_cpu_st_explicit(struct pci_dev *pdev,
>  void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>  int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended);
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>  #else
> @@ -47,6 +48,8 @@ static inline int pcie_tph_get_cpu_st_explicit(struct pci_dev *pdev,
>  				enum tph_mem_type mem_type,
>  				bool extended, unsigned int cpu, u16 *tag)
>  { return -EINVAL; }
> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{ return PCI_TPH_REQ_DISABLE; }
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }

