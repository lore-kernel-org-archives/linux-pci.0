Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819951A9F96;
	Tue, 26 May 2026 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779771102; cv=none; b=OIcFbTTM/IVXCWJtSloNlK7lfbL4IF3YDBaAPmOrMkwkREj9okD7JlSBvdYluenKvbHrQKvbGR+hH2JGGk1xfiemLuVn1PsXedsXRxuV7jYVKby/99qsztMvQXEUMFiB3U63w2u8Vn+xQZCumE02HYtCn9ImMtFvoNpAXEfXx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779771102; c=relaxed/simple;
	bh=E6vU5lgwKeEKE2mwJ4NAmrGFuosHctOk9K1ER3//Tp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VW69KnEd9Mg4xWnPTKlb6q38fKgPMPx15GFxbquIbBfYlQ+MGM40FstVS2ovZT0K4ibPtDR1ct3p0QcMebcaxGKlRe2CBLMCf7hRDxEfkza/rSlIpHea332uD2SIl2Vf1uQ+du6GzRqzt5RjalaHRujOvUx5lr4ow88ZBSuXpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGI1YRCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGI1YRCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26B11F000E9;
	Tue, 26 May 2026 04:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779771101;
	bh=7mTGzGG5/VYhUXsNwB4wVenYSoIzkokFFRwA4qEmCfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGI1YRCb+0avWVGU7PRP0cUNGOSfcX4YlW/6YzyD419SxWtu+Uju6ehkBiJYhBwd4
	 ENjs1CRZrxlyekrqBgiS0iF+0iX2sxrtc7PG26UD9mkJr3kF6SiYTcWEh2szGpYy+1
	 7tdSyk9K/yKlmR3Br6Y/Wer5BKh0Ocb0LkPCSDOCjez52I0ChwsuB5hrRy/j4ByhhD
	 BfeR2rJ/HFliMuupXvlnqbcf0zf0Qu0DCSi7XaSzXsGLkmsoouUWZNjW+zJYam7MXt
	 JjYjdfc2H5dzlYKUPPISXl2kBT7ZqnWMBJKjPzP02yYrZ7WtgOdutVOkqYoAAkfufl
	 0rN+3VqkDUzUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/6] PCI/TPH: Export pcie_tph_get_st_modes() for
 external use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260526040830.52854-3-fengchengwen@huawei.com>
References: <20260526040830.52854-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 04:51:40 +0000
Message-Id: <20260526045140.F26B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The header `<linux/pci-tph.h>` is not self-contained due to newly i=
ntroduced dependencies without corresponding `#include` directives.
--

commit 1f564e5018d91508967ee58123260567c2507196
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Export pcie_tph_get_st_modes() for external use

This commit exports pcie_tph_get_st_modes() to allow drivers like VFIO
to query PCIe TPH capabilities. It also adds stub functions for
!CONFIG_PCIE_TPH and tph_cap validation to prevent invalid configuration
space accesses.

> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h

[ ... ]

> @@ -41,6 +42,12 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *=
dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
> +{ return 0; }
> +static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> +{ return PCI_TPH_LOC_NONE; }

[Severity: Low]
Does this new stub make linux/pci-tph.h rely on implicit includes?

PCI_TPH_LOC_NONE is defined in uapi/linux/pci_regs.h, but it doesn't look
like linux/pci-tph.h includes it (or linux/pci.h). While current users
probably already include linux/pci.h, could this cause compilation errors if
a driver includes linux/pci-tph.h first or on its own?

> +static inline u8 pcie_tph_get_st_modes(struct pci_dev *pdev)
> +{ return 0; }
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526040830.5285=
4-1-fengchengwen@huawei.com?part=3D2
