Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9E3769F4;
	Wed,  8 Jul 2026 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553650; cv=none; b=Ba/tKPZPaqqpulFXSRlT4spNjvRcXTtRhHUk6r9tGKJ+jPSIn0Lx+D75LohDI8csDP0i9AOOVWHw0mTvdzm/og6xeBXPZYJtap/hMdMxdN3G13RVlJ5peKI6ICGWrV+gAFg9XkSmxQoo4CHpQD2x/J8gPa3PNQOFh7TFkWS8EPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553650; c=relaxed/simple;
	bh=V/1oIO3/0Ak+1Qlrz6/PZwwERHrJ2/eKOBEP61p4OSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfQD6LwyFtxFQHEFb9nMPevyjnJiq/UuwCT57/FY+fWCpNgrrV0U+169Qr/NdeeOlyxWAgodiBcu8Qq0RGrzLVmvt6BIEu4mb1wcnUdQz84cg16a4tkZLm3gWQzOJjK2A/pW4pUV61RWUczELJDSL++CPV+ATEd/jcGfM5mrH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=TyqlnHxh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jLE/M+WZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="TyqlnHxh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jLE/M+WZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C2315EC0185;
	Wed,  8 Jul 2026 19:34:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 19:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553644;
	 x=1783640044; bh=Gn4wqgf12A1PnG9l0ziZsW3kRn2x+AzGdsqM5ax8CLc=; b=
	TyqlnHxhlYOB5z3WpClZ3JJhS1d9UmM46I/bTADIAfgW/IdEWsj0Fe//5+NtAj7k
	yvROQsvIl8kbUkItkSzNmNxGpp7hgC0q7vyf2KVwdPXuHCHmyC5WETs5QVDN+VRi
	H7jXBhwtHy4zTGpiVb+XQmktUbo7iklQGc+bLGPy5L157cg7iI8GWyg7DFNnGKjc
	znSIj1DlJCK0kzXXqg4MsgH8nfAnn0CIP1SwuSbfbFCxWR7/OgaQYd+8E8V+bL+7
	3WU3SFCcHGJpBU4+Arsq2qDk/JSDrMe9xb+fG0UIherb9Pu4jJGD7/IJ7hFPeGU3
	B2rD1QAgM4GWaaRRLmv6OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553644; x=
	1783640044; bh=Gn4wqgf12A1PnG9l0ziZsW3kRn2x+AzGdsqM5ax8CLc=; b=j
	LE/M+WZ5ovSySaTcV2HGo9Liz5yRpzJoNGGayhJJxblX6rPYsF3kqRz69TGrwksI
	knYkpos05OeWDKjBrqpf5sbKtuQwatfECQrTBGV5SiZGAVjhFiHDd96TJfOztt7U
	r+ipx5RK1cUiF/450SNhtJ0k+8CN5jqzG87Om3X1FflAf+63ACo7u7YtPPZf3O2f
	knGnZUdngz4sdsvfBfg+DhVIJinqHuvtsV2HA/XrTfaNpEjm4yAfaKR7oa9SJiDr
	qYL7SgZV05Cgv9sxeIpLtSNsrpUc0NokeKxCQqRC499UokmmeC+l3Q38fdV8vQs9
	A33Tnj1JfGP9rGfhyHwTA==
X-ME-Sender: <xms:bN5Oapv8-o95kxHfXvbs5CWmXzJnfy1FiLFoUIrrDvioAsqxXjPESQ>
    <xme:bN5OakANY0ggJtz29zjWxFMoXQ__aQIE18QaUNo_Sj-yHLPzFJFlocOn3EdcBazQQ
    dt7S4QMNUWFoJ9uxnnoXGuZmgQYXohHeHOXyppio6OM1NnFzPxZTQ>
X-ME-Received: <xmr:bN5OasC6ns3FTpmUWy9z8_MtbUmYrp2z5kc4epAcQ9E0xPgA2sY0isMV-rw>
X-ME-Proxy-Cause: dmFkZTFk66Tr4PZ1RpoJ2yXE2BF2dN68DoODhH+NgpAxw/zva66bqnWHxfSCYuZR+JyEHm
    flF4GbtFnt8bLxJgMnCN6nvmLvaELOEEjMTryq/TRPaGVQdVxjfdjdFdCfsRXGWtaOQPLj
    vzEmEj9I22CJ/UbhUOEd0yW0tDBXwpjK6Sjvuhsts1Pkn254JZLVYCPz1f8XdQrd79LQIU
    jMi262mhG4so7FIUMKsu10QFKFjSCejJBkuIBhOwSViFF1N3o2bNmiSB1Bnpugtb4NhQFP
    ywoiS6dLdLko78Xju90QoFu5L4u4/khGmtDl8gm0o7afMlgiE6wqGIDcb9T/cN8hCOZMZ4
    g2VDdQo+WUPYtOUQY5WxtFI9ZqbhZmAWoeNALoHkMYKr6GstuKlw4zAqs5V12Hnz8lAvKn
    PxVJbgcA/laGizro6+fxj2HdBlrSdZIIV2vNQqomx1dug9VL5q+lJN0vDhOxRsqfxSDDOp
    ftWTTWjxnnFcQo9q0nM3Fbq7UbmHXEOUoMy2RneJ+RQWHOFbjZT98CTWyDIDK3mamWQEIR
    KDfkKqkwFLgTR1KxOtEuJSelw+JReM+FKx8UgG0joNnaN+CMPY+65eOQS2cb7jEafZF9fd
    z/GRFPH9yB50UXPsioQ1BCXH+zbyjCf3U/nDifkAX4LiUfE2q3C/SORxwR8g
X-ME-Proxy: <xmx:bN5OamrVXPz0CKvHVS9aiv4tL1DxYhsSpzvYVnVPl4aoiZtVjirTyw>
    <xmx:bN5OavEnlU6P4QCykNQrEvfj1mX0D2l3it2ThVCmuL1SQlZvBuT12w>
    <xmx:bN5OaisG-5nuSAJ-zcCAsBP4XalQy0zc9PSUJuYKjMHU2T38d1GbpQ>
    <xmx:bN5OatZjAI7hH0a-ypf6e_PSKiqYqXw3hy9Ku29N2Lazvb9LhFYicw>
    <xmx:bN5Oagxo1UT_OhkSRzUszuHbu4FdN3JcUoGVKuPJbkRzTO3d_1_6U0CT>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:34:03 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:32:13 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 09/18] vfio/pci: Hide TPH capability when TPH is
 unsupported
Message-ID: <20260708173213.1173162c@shazbot.org>
In-Reply-To: <20260702124224.57168-10-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-10-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:15 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Check the device negotiated TPH support status before parsing the TPH
> extended capability. Return zero length to hide the capability from
> userspace if TPH is disabled during topology negotiation.

This doesn't match the proposal and introduces an ABI incompatibility
to the user.  A device that includes a TPH capability and supports
migration would break if the source and target systems disagree about
whether the capability is present, even if read-only.

The proposal did not suggest hiding the TPH capability, instead it used
SET on the device feature ioctl as the opt-in mechanism to introduce
virtualization of the TPH capability and control registers.  Nak to
this change.  Thanks,

Alex

> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index a10ed733f0e3..5c6ab172df6c 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -22,6 +22,7 @@
>  
>  #include <linux/fs.h>
>  #include <linux/pci.h>
> +#include <linux/pci-tph.h>
>  #include <linux/uaccess.h>
>  #include <linux/vfio.h>
>  #include <linux/slab.h>
> @@ -1450,6 +1451,8 @@ static int vfio_ext_cap_len(struct vfio_pci_core_device *vdev, u16 ecap, u16 epo
>  		byte &= PCI_DPA_CAP_SUBSTATE_MASK;
>  		return PCI_DPA_BASE_SIZEOF + byte + 1;
>  	case PCI_EXT_CAP_ID_TPH:
> +		if (!pcie_tph_supported(pdev, false))
> +			return 0;
>  		ret = pci_read_config_dword(pdev, epos + PCI_TPH_CAP, &dword);
>  		if (ret)
>  			return pcibios_err_to_errno(ret);

