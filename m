Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86134D93B;
	Thu,  2 Jul 2026 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017218; cv=none; b=CHdXvZdKHkWK4VTTGAbr/Jh3kjpziqNtIJjnueDFXy9YHeoF3w/LGaFPfKfl+rrUz3t4+2n7vGMEpXZagndXiplXu4P8v1aw2wM01fewOmm8fAeTOBjMvyWr/ScP/0Q5ECiSfmJYig+n4iis8uMtzmfPnd+Pm9fzAqFBuDRHuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017218; c=relaxed/simple;
	bh=uOroB1HpaYO3OVE30hsF+NSvifM1bvDE4IPJen0iY6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CDOhPndc74ShsKgnStxyxnR9Vd49E7nfV/Rnjdsaa58GVHy9N3QXfkov+ciGK4BS/KjjVMTcfI35vqyAe/oOXBW6l4WgGTOZq0LZP3eWm/6r2slBzubix55sXTifZWzrG40w79OIw+jGrmsI2bbVjbBrvPrYMnEalN/5X4zO83E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGP2hANp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGP2hANp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3851F000E9;
	Thu,  2 Jul 2026 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783017216;
	bh=q1l5gsRWtbKLXK/O8MLTQEF8W3gIBNxoSoLVBDKohz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MGP2hANpKbsyd8+AYl0TW8f6TlpL1ZWv3x76vk2uOurgbmxDbeXl/JiuTNQE2uf5R
	 xJ7rswngzlTYoIkwJO+i9v8F9SmqPo4nbwF4ha5flvFwINlZSpVVg8qmv/hZtf/CZ3
	 8DzzeoL0bVasY5qLAuvtun83Le8spjnbE5MNEyQ1Pb+PV+gt6+LEcENbVqSGhzEAJW
	 DmlRIcnQfoSLnnPeZu887opg9MI3lf4XxPfJu3PhZujNMkDZo5gGsFiCEPd7ChJdTh
	 zrO1JT4yHGFJkKO6vwAkaeN7LuM/UI2FeT2MA0Qm+844QgpXTlTp/HMVFvm6MJsXQa
	 oAelZcWWSfinQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/4] dma-buf: add optional get_pci_tph() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20260702181025.2694961-3-zhipingz@meta.com>
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260702181025.2694961-3-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:33:36 +0000
Message-Id: <20260702183336.5C3851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The kernel-doc comment references a non-existent callback `move_not=
ify` in `struct dma_buf_attach_ops`.
--

commit 335ebd67b3a2610991185474a464ea3b3511fff0
Author: Zhiping Zhang <zhipingz@meta.com>
Subject: dma-buf: add optional get_pci_tph() callback

This commit adds an optional get_pci_tph callback to dma_buf_ops and a=20
wrapper function dma_buf_get_pci_tph(). This allows importers to retrieve=20
PCIe TLP Processing Hints (TPH) from the exporter to emit matching hints on=
=20
outbound TLPs.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c

[ ... ]

> + * The returned steering tag and processing hint are only valid until the
> + * exporter invalidates the current mapping (signalled to the importer v=
ia
> + * &dma_buf_attach_ops.move_notify). Importers must re-query after a new

[Severity: Low]
This isn't a bug, but should this kernel-doc reference invalidate_mappings=
=20
instead of move_notify? There does not appear to be a move_notify callback=
=20
defined in struct dma_buf_attach_ops.

> + * mapping is established following invalidation.
> + */
> +int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> +			u16 *steering_tag, u8 *ph)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702181025.2694=
961-1-zhipingz@meta.com?part=3D2
