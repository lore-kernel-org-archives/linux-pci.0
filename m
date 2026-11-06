Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998390;
	b=JfdaEoF/OrNH8NRjvA4/IYQ7bB2i0KqF8xk/rA9k+vpFkDr9vcx53m2qA7diHoZLFsO4
	 CsjNUmz0G+o/8KJPgOdCr44/p2ykHBuYgtrkoQoxn5stbsA91N8KGHucskYWGCQQgyQee
	 Jb2T+HCkCTDFmmhOt3ZEHykIqLaBz4FvGFcSltrCBmWaaTbFVYWGxbUEmxsE6FHaOe4BW
	 uZvM+cquYatjFPR8gkhLwXDFpUDBW7irxSq9fzztzDkAbqtHSr99jCBX91QKUFNDAt7vp
	 1+iLaOrwdZeJ9DP5Bf8i3RoGPdSNoweJSLqas4aGeP/wjHZWeQGq6Q1zBzXewlqtJwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998390;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=UqZGICjbPKpeigSQ643DTY8AHzN2Hzb/tfF09ufw/Ig=;
	b=2YiOmbmpW5laByh578tNt73l6kslLIW2X9zb1sz8fmvv2TK2x9jNOytkefQAGCf0NZxx
	 lL/ihUV698/zGRWPC2Yi9zaFdMlmmQscf6gvusTFCOThVjqAOlZ5k6O6Qzfrx+4UrNXba
	 BdsHWlNEI9neKehkD83NLRUrlrUfMRaOk/WPZVu9DXtqvNSdRejQV4LhZSzgM5Z2sIRoD
	 umd2pOnqjl09Cs/WqMF9xweSCZMxDjVMO6N5aGR2pOBH0rNs/0THzQiummTKfIlnJclDW
	 qxPBAwfs0zsUwJeYOoIFm/qiUOsnv9jjulTDKA4qxkGd0gHuXt2Zlf6wYiw1/TwpC0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MioSDFDD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2377606A32F;
	Fri,  6 Nov 2026 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MioSDFDD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C651F0089F;
	Fri,  6 Nov 2026 20:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998389;
	bh=UqZGICjbPKpeigSQ643DTY8AHzN2Hzb/tfF09ufw/Ig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MioSDFDDTpsBojBwRiJdF+2Qdun27Q2pmc7mAF7CrD4Gge5apAeVzSLy/CJwm/+Nn
	 rzDX303z42Ys2XY9XFzBJfMTqLGNxyNO5Y4dzZry+T0ByPdA7Er60Hy1zTyA6PK7j/
	 kN3382uQGW673lq0vA+RH88E5IYfY0QM4ewZc2YfOdfKFukGXoVy9ae67mrz5S0QX8
	 RnW0CxnxnkKdBW6AFuK58sIqxF1ssNuAIIHKfTC/kOfpSkOZet+i7JunQ+jzfDow5n
	 MJHG9tk5tGqFtp8ykLO3e5LOf/Qb3mYOtZXyMKIHaTdZmSbAinGbQHI7HNGgPlRnco
	 pHlkmFE53wzng==
From: Thomas Gleixner <tglx@kernel.org>
To: Keith Busch <kbusch@meta.com>, bhelgaas@google.com
Cc: maz@kernel.org, lrizzo@google.com, hch@lst.de,
 changfengnan@bytedance.com, namjain@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
In-Reply-To: <20261106173448.34794-3-kbusch@meta.com>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-3-kbusch@meta.com>
Date: Fri, 06 Nov 2026 21:53:06 +0100
Message-ID: <87wlqpwukt.ffs@fw13>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 06 2026 at 09:34, Keith Busch wrote:
> -static inline void pci_msix_mask(struct msi_desc *desc)
> +/* Posted write only: the device may still send an interrupt after return */
> +static inline void pci_msix_mask_noflush(struct msi_desc *desc)
>  {
>  	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
> +	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> +}
> +
> +static inline void pci_msix_mask(struct msi_desc *desc)
> +{
> +	pci_msix_mask_noflush(desc);

That's before the offline check now, which looks more than wrong.

>  	if (pci_channel_offline(msi_desc_to_pci_dev(desc)))
>  		return;
>  
> -	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
>  	/* Flush write to device */
>  	readl(desc->pci.mask_base);
>  }
