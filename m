Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106701;
	b=DV5pZo0VKE7AFr6yUDC29l82f02/D9Cph0Od9VZGWEeh3zTomjri41am5MJYhzQCUtV4
	 WHJk6gAEQpFqg/GMT37Qwlh71BboYp/sqn1dEqebJzQ1KACCqwgegcjC6IRdKqavwdfXM
	 ZgUDbt0IVLW6CEa7m4rh35OboGSbh1jGsIsoWWa4KNrdgdYBJWuctm3U2diH0Uy6eJg8l
	 mNprogzCEybDmlc8Xfe8iH0B74f/2K3SUhgEMXFix+/U3Z8BEjDlg/xk4FbMKMoDlouZq
	 pAxMqYNhjC7+HqRwiPRnF/wFBgtFYtsHu1EXdJfkc01L/2Ad9+mG+H1d+DAc/9uooxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106701;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6T5qHszoT5KAnaMFtpj3HuHEDlbDw72PARLkg2WqNwI=;
	b=0OE82RBVJkbupvAUrpomROroJWrhgt3H0zy5FbMrh/r5SGKj8wG+uxOF1bPnWJRry12Z
	 7Pb/ZnZqk/iQqE+1S9vIrd//LRs/alOi/Rx/7fYj5J+ZigeJEnGll27yJ7/JQaCKTdZGk
	 KzeY9AQ7dMLPWLTQgDRoOQtcxdCpCGaCk9gta8/x+4caSIBvCYxSuMCGEZGHWIFUW0yr9
	 /zH9sFjJ2wAReu5tXQpL8dKk1CY/AgW8jQhSyM6jDadVC8DFaMuS/YyEPXcWk40ZECDUz
	 gHJyrRBhx5qGoxjJkL+c26LboSQXwpuWaxFZQSxDfkytq3//njCloWR/enISYTwyxlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhFfP2Am;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB3606A31D;
	Tue, 27 Oct 2026 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhFfP2Am
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4FB1F01825;
	Tue, 27 Oct 2026 13:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106700;
	bh=6T5qHszoT5KAnaMFtpj3HuHEDlbDw72PARLkg2WqNwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NhFfP2AmkN8X7XELirt7qT1omsb7npj/zadplmlZ/ndbM/9QYLp2ZJCOJx+dWlUMH
	 WLIl9HcnEfz9gd3aqK4ZL7dj/jUrwFJl61kMEnfVFuO2eXjlv12kfExtfW8c22DCO1
	 XS6kqIuoyvE7I5lyuEi75AOr6i07VYF2vgUNRu3r4vV1u1gvqwDF2ZJeXWx3BzDdbk
	 wVX9EWBmnqqrIj3caxXblXv1sxbO8+kSSUkWMzV17NaqkEQBkQ8d4uTWltzWPvgaIL
	 D6FLOCVRYM4oXdPXNHM3BFSD/u5X3pnF+GwgfpzP9KZI3CWVnt3gWDgtHSzYZ0nv/y
	 brBln+2rf30pA==
Date: Tue, 27 Oct 2026 14:11:32 +0100
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?B?V2lsY3p5w4XigJ5za2k=?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] PCI: mediatek: Fix integer truncation and handle
 oversized resources
Message-ID: <kfnxuro5xf4mhokabg773zcyp7otcjxwpzcn3dlo6y3kpv4uv4@bne4qf3vcif5>
References: <20260930120539.4967-1-sreekuttan2156239@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930120539.4967-1-sreekuttan2156239@gmail.com>

On Wed, Sep 30, 2026 at 12:05:39PM +0000, Sreeraj S Kurup wrote:
> resource_size() returns a resource_size_t, which is 64-bit on 64-bit
> architectures or 32-bit systems with LPAE/PAE enabled. Passing this
> directly to fls(), which accepts an unsigned int, implicitly
> truncates the upper 32 bits.
> 
> Furthermore, AHB2PCIE_SIZE() uses a 5-bit mask GENMASK(4, 0). If a
> resource size exceeds 2 GiB (order > 31), the log2 size order
> overflows the 5-bit mask. Clamping the value silently truncates the
> hardware window while leaving the OS resource intact, causing bus
> errors when accessing BARs in the unmapped upper region.
> 
> Fix this by using fls64(size - 1) to accurately calculate log2 size
> orders without off-by-one errors and returning -EINVAL if the resource
> size exceeds the maximum supported 31-bit window order.
> 
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 29 ++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index a60d1ae076f8..639884b22ad7 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
> @@ -686,6 +687,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	const struct mtk_pcie_soc *soc = port->pcie->soc;
>  	u32 val;
>  	int err;
> +	resource_size_t size;
> +	int size_order;
>  
>  	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
>  	if (entry)
> @@ -753,8 +756,18 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		mtk_pcie_enable_msi(port);
>  
>  	/* Set AHB to PCIe translation windows */
> +	size = resource_size(mem);
> +	if (!size)
> +		return -EINVAL;

PCI core already rejects the zero sized MEM regions. So this check is a dead
code.

> +
> +	size_order = fls64(size - 1);

This is wrong. AHB2PCIE_SIZE() register needs the full size value to enable the
whole window. Check:

c61df57343bf ("PCI: mediatek: Fix memory mapped IO range size computation")

> +	if (size_order > 31) {
> +		dev_err(pcie->dev, "Memory resource size too large: %pa\n", &size);
> +		return -EINVAL;
> +	}
> +
>  	val = lower_32_bits(mem->start) |
> -	      AHB2PCIE_SIZE(fls(resource_size(mem)));
> +	      AHB2PCIE_SIZE(size_order);

Why can't you just do, fls64(resource_size(mem))?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
