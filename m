Received: from mail-m1973199.qiye.163.com (mail-m1973199.qiye.163.com [220.197.31.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7783385508;
	Tue, 21 Apr 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776753019; cv=none; b=g+GOAT06EBJg/Tw3eCQmbHLEJTZN9UjKWH2Vi0ipuCB3xzITHWWwS4L5d6oBICzvY/gGcgTEUOTK/2nLIz9zVpvaSu0C/fnFmbx/ZrurHplqInp5sWOCArvC5s5toT6Ebbcx9VH9aUufY6QtJBRhhkbIzM0dkHtZk1emhZXfTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776753019; c=relaxed/simple;
	bh=pMZi3EB8EJxPE7srGU/1U+XhvTKCBOfW1/luoVWtN1U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gNhNa7wqUQCtBM/YZCNmjT4j2kPbL2OEjfa+7GAxm7fOBDe3fYhfomg8Me3lrbD6riJbov6RD9fo27bIEdFJkvkfPKvKyF6jh8PYxcVq/Mn+ZO0AziY0xvTwaq77t0JcSpeP5oz5CTElwZe8BHrmV7Ggbm6UdRendfkfbxWbCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QMrIhxVu; arc=none smtp.client-ip=220.197.31.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QMrIhxVu"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b8458711;
	Tue, 21 Apr 2026 14:24:54 +0800 (GMT+08:00)
Message-ID: <85068e3d-2b80-fb63-ee06-0f1f668760f7@rock-chips.com>
Date: Tue, 21 Apr 2026 14:24:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, bhelgaas@google.com, hans.zhang@cixtech.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 neilfsun@tencent.com, tglx@kernel.org, 18255117159@163.com
Subject: Re: [PATCH v2 v2] PCI/MSI: Fix memory leak in
 pci_alloc_irq_vectors_affinity INTx path
To: neilfsun <loyou85@gmail.com>
References: <2caa071e-85ee-4e76-bb33-8f27a4579fac@163.com>
 <20260421032044.55948-1-neilfsun@tencent.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260421032044.55948-1-neilfsun@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9daeb692ca09cckunm2e6be9fcd1abc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8fT1YYSEpOHkpDGUlDGB1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
	pVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=QMrIhxVutDW05Una+5upa+xjlFcMFe18BgKKhnnWMBhrzlazbNW+3324x0luOmbP6UMv59L0zBbbgPpDiNlh1xJ+jHIT3NwxD0xqF7ndlgYGeEvTVJMsWjTcvKSOFJeUuHbaCSqLu8xTx/0l5L2pi4w43MgVf3fsgjV+huitvr0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=z4YuwEeVttqjnnmWRHhUoJiE4Wv1sD796VmCFtMQMO0=;
	h=date:mime-version:subject:message-id:from;

On 2026/04/21 Tuesday 11:20, neilfsun Wrote:
> In the INTx fallback path of pci_alloc_irq_vectors_affinity(),
> affinity masks are created and never freed.
> 
> Signed-off-by: neilfsun <neilfsun@tencent.com>
> Signed-off-by: Sun Feng <loyou85@gmail.com>
> Reviewed-by: Hans Zhang <18255117159@163.com>

I don't see when Hans provided his tag in v1.

> ---
> v2: use __free to auto-release pointers
> ---
>   drivers/pci/msi/api.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index c18559b6272c..994f12813ce3 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -285,8 +285,10 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>   			 * the device driver can adjust queue configuration
>   			 * for the single interrupt case.
>   			 */
> -			if (affd)
> -				irq_create_affinity_masks(1, affd);
> +			if (affd) {
> +				struct irq_affinity_desc *masks __free(kfree) =
> +					irq_create_affinity_masks(1, affd);


The __free() attribute is typically used for ensuring cleanup across
multiple exit paths​ within a function. In this case, the allocated masks
is not used and its scope ends immediately after creation. Why can't
we simply kfree(irq_create_affinity_masks(1, affd))...


> +			}
>   			pci_intx(dev, 1);
>   			return 1;
>   		}
