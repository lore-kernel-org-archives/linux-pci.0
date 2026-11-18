Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994164;
	b=IMxaA6rF7ejst7Q/3SS2IGtzuA5rBrg2B50WBUs1T3HVO3t2TmB2k1+eivzxwy2sKk82
	 j63n+zNa7rWVTWNVB39YXo2EtQoN3PqjL+hSgGdtxn7Os8ulUehbae6ivNxJQ3r/UA+7a
	 AazUKSEQH1R4fqatppSHsVsmF2Hg5zDU3Pssm3AMnYaMMR2IoagKuL+9cXqX9zKopKFBq
	 3h12rjGeYtkYs7BU9qrrnkwQZIHejzpo6OjUiJFKUR3EKQw73O3ycwTIc5ZPW76RP1c+0
	 hNkp6gdh9pzyIqcqmIRDefhsGKjGd8d9474jWRWrfTIA3PYqYIaclRrrgMXI/VOfKbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KuDhDI8W/IShNvRXLHlgEMdk9zEvBiDXGCBjCnJIi68=;
	b=lnqs0yumiySyWnUqnj9bJ+IAR9swxhd1sCvJpsl4yDrGR+LCWJbakjDhwRU7uCIOxrGu
	 xm7hrn7vgIgCYaEPgK+bFObq6ifuBpr6bfIS1xzwfD0kYHv3RumG0eNhIjKoXiQ5jxdbc
	 fl5cO/9PrqWrjSQYdVZvGJ2L9yqAlo/RwOHjt5ZO9zApjsyoLL6vuTUB1CCWTxCynTh0Q
	 OslNi3X6JdRznH5Q2qGj+de0oCYmJi9IMGIh8dSSNA6H4E1O7Ud+FnFK37Gil/ZT3iam7
	 9ZOu8LlnTekRLz2wbda4runz8IYTEtuwblCjtzHWk6OjDFJ4BaLCsX8XERawqfWrERg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEgqUPHG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B53606A31C;
	Wed, 18 Nov 2026 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEgqUPHG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF1C1F000C4;
	Wed, 18 Nov 2026 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794994164;
	bh=KuDhDI8W/IShNvRXLHlgEMdk9zEvBiDXGCBjCnJIi68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QEgqUPHGGvyMOUfG4DDalRPzHTF197b0gTycqIp5n0psxc24BYKflKQDLjdQ8xwnS
	 nhVQHcawITdHmhlF40ofSBIt6f9q/n41Pxku0wFz7hgorB4wCe6tB20cQajfChidcb
	 HcbqrttoWoV1qazjcLLtOfD0rLb1GflUod2pSz1yBddP+t/FdF84e3i7c8akiP26vu
	 XuIznb0PmxSrcMdQsvZJ+PADL6E+0XzxEgFVDlfTbvC0iIVXpmmlFbpvE6ASDbS0kN
	 Dmyu+fOSFSKy34n+ZHrLlsltRf4xNGKBr4CtQQaTJcppj4TJ8C0pUWk11GkxZwoeb2
	 mb87AC94qnoTA==
Message-ID: <sashiko-outbox-220561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 01/13] PCI/TPH: Fix pcie_tph_get_st_table_loc()
 field extraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-2-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:29:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] PCI/TPH: undeclared PCI_TPH_LOC_NONE in pci-tph.h when
  !CONFIG_PCIE_TPH
- [Low] PCI/TPH: inaccurate Fixes trailer in commit message
--

commit 47bc8345d31e14953151f380f2af4f107d3d65ae
Author: Chengwen Feng <fengchengwen@huawei.com>

> PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
>
> pcie_tph_get_st_table_loc() incorrectly uses FIELD_GET(), which shifts the
> field value to bit 0. But the function is designed to return raw
> PCI_TPH_LOC_* values as defined in the function comment.
>
> This causes incorrect ST table location detection. Fix it by using bitwise
> AND with PCI_TPH_CAP_LOC_MASK to return the unshifted field value matching
> the function specification.
>
> This doesn't make a difference to mlx5_st_create(), the lone external
> caller, because it only checks for PCI_TPH_LOC_NONE (0), but will be need=
ed
> for callers that check for PCI_TPH_LOC_CAP or PCI_TPH_LOC_MSIX.
>
> Also add tph_cap validation for pcie_tph_get_st_table_loc() to prevent
> invalid PCI configuration space access when TPH is not supported. Add stub
> functions for pcie_tph_get_st_table_size() and pcie_tph_get_st_table_loc()
> when !CONFIG_PCIE_TPH.
>
> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

[Severity: Low]
In d2e8a34876ce ("PCI/TPH: Add Steering Tag support"), get_st_table_loc()
and get_st_table_size() were static helpers whose internal callers already
validated pdev->tph_cap and shifted the return value with FIELD_PREP().
Should the Fixes: tags point to the commits that exported these functions
without stubs or pdev->tph_cap checks instead:

  Fixes: 0a61ec9cc51b ("PCI/TPH: Expose pcie_tph_get_st_table_size()")
  Fixes: 7b8a8ec20cfc ("PCI/TPH: Expose pcie_tph_get_st_table_loc()")

[ ... ]

> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index be68cd17f2f83..159ffb82b34ec 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -41,6 +41,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *=
dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
> +{ return 0; }
> +static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> +{ return PCI_TPH_LOC_NONE; }
>  #endif
> =20
>  #endif /* LINUX_PCI_TPH_H */

[Severity: High]
Does this break the build when CONFIG_PCIE_TPH is disabled?

include/linux/pci-tph.h uses PCI_TPH_LOC_NONE here without including
linux/pci.h or uapi/linux/pci_regs.h.  Because include/rdma/ib_verbs.h
includes linux/pci-tph.h before any header that pulls in pci_regs.h,
translation units such as drivers/infiniband/core/mr_pool.c and
drivers/infiniband/hw/mlx5/dmah.c fail to compile with PCI_TPH_LOC_NONE
undeclared.

A later patch in the series, commit "PCI/TPH: Add macros to check standard
and extended TPH support", adds #include <linux/pci.h> to this header,
leaving earlier commits in the series and standalone stable backports of
this patch broken when CONFIG_PCIE_TPH is disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D1
