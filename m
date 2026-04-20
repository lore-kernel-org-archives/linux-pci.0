Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355163783D0;
	Mon, 20 Apr 2026 04:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776660482; cv=none; b=Zy3WNMJ+pxaPNflMFDdqYp9yXV99QDs09XKylW5NlYmX/0y3ee8Ja4Bh9KDSqkDcR2vbK+kEvOOTaY/Ec59TglZ95muyP5Dhj6yDD38KKW2c1nxetOsvy7l1jdFpxs4L1iG0FAiqrMI2ADAZrehIbJnYQLME+kFhKuUyjBphYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776660482; c=relaxed/simple;
	bh=XT8sREQpVBa49QotSmJ5J0WOI6v8PbKibYNmcfVxnAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bh/mwbRj4bG2gTG7NiqPfqs1Rk3zHoPWCibW+nWptBF1+QtVZaoaCDJwQqZVri71oBpfJM01bGgEAE62FZAaN8N1WU9n7CYqlvKCKONZLO4CC67oyQtgQaMa9RGrOFBbmoFL7YL4xXTNCq6cpobYwshNyKCYDUaStthVaUOlffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C1q/4KAn; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C1q/4KAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=pEUieLBQ4Kwa60UOZD4+xJNKj/Rv2EJ/8lbOK4yzsx8=;
	b=C1q/4KAn44fzyyoZJXCUuSvDiG05U++ZXzXzR3Rjg+XL5WwRnY5vtcBAOIJoCW
	096cZfuijr+5/hX65A883AFiIkOZnmo3yXvzF8EbF7lncUXPc3BfogTEczMpd+st
	l+6yPS4zP7BQByiYDWVai0YxsdSDo0eI5QHUMrs7GLYZA=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnHwHkr+VpjVHSAg--.3663S2;
	Mon, 20 Apr 2026 12:47:33 +0800 (CST)
Message-ID: <2caa071e-85ee-4e76-bb33-8f27a4579fac@163.com>
Date: Mon, 20 Apr 2026 12:47:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/MSI: Fix memory leak in
 pci_alloc_irq_vectors_affinity INTx path
To: neilfsun <loyou85@gmail.com>, bhelgaas@google.com,
 shawn.lin@rock-chips.com, hans.zhang@cixtech.com, tglx@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: neilfsun <neilfsun@tencent.com>
References: <20260420040940.14824-1-neilfsun@tencent.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260420040940.14824-1-neilfsun@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnHwHkr+VpjVHSAg--.3663S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1xtF15ZF4fWr1DGFWUXFb_yoW8WrW5pr
	WIgF4UAry8Xw45XF45Cw4fJFy3Xa9aq347CF4fC34xurW29FZYqry3KFy7Xws7tFWDCF4a
	qr4DAF18JF13trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsJ5wUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AX4nGnlr+UDZAAA3s



On 4/20/26 12:09, neilfsun wrote:
> In the INTx fallback path of pci_alloc_irq_vectors_affinity(),
> affinity masks are created and never freed.
> 
> Signed-off-by: neilfsun <neilfsun@tencent.com>
> Signed-off-by: Sun Feng <loyou85@gmail.com>
> ---
>   drivers/pci/msi/api.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index c18559b6272c..c1377f74b8f3 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -280,14 +280,17 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>   	/* use INTx IRQ if allowed */
>   	if (flags & PCI_IRQ_INTX) {
>   		if (min_vecs == 1 && dev->irq) {
> +			struct irq_affinity_desc *masks = NULL;
> +
>   			/*
>   			 * Invoke the affinity spreading logic to ensure that
>   			 * the device driver can adjust queue configuration
>   			 * for the single interrupt case.
>   			 */
>   			if (affd)
> -				irq_create_affinity_masks(1, affd);
> +				masks = irq_create_affinity_masks(1, affd);

Hi,

Suggestion:

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index c18559b6272c..0ce34db2b2bf 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -286,7 +286,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev 
*dev, unsigned int min_vecs,
                          * for the single interrupt case.
                          */
                         if (affd)
-                               irq_create_affinity_masks(1, affd);
+                               struct irq_affinity_desc *masks 
__free(kfree) =
+                                       irq_create_affinity_masks(1, affd);
                         pci_intx(dev, 1);
                         return 1;
                 }


Best regards,
Hans

>   			pci_intx(dev, 1);
> +			kfree(masks);
>   			return 1;
>   		}
>   	}

