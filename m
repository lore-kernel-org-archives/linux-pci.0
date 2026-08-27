Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB52486B85
	for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855140; cv=none; b=bJ8ITQS0cXVoZZ57hKc/lZytg6YIISOGY9G/tGHWXdI1HMpvBLqkTfJoLQzLawJoMkzrgmoxgjOCOOaWRi++upyBAMjUHnnQjsSzqLziXroukTb/INhPjMP08SaktkY6ewPeSnxMDTPWYfdkqKIP8TC8io16T4YK1rGlUBeLvS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855140; c=relaxed/simple;
	bh=iatu0C7NUCLk2z573m0t8XWYIZPDiVZwQlMbYeSNJ0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EcQ7f+Kz9Sn2vAe6w/UtZE476G3JeopBQkaX/wmg99Ko6mX8ZEA4r1ta4pvhDjjMBIVs1HIP5K5RZSe0HaHyfx/rVsVUmCyze3eCnpWBsFoQemt1istJS96PpPIb954Ik0g0F+djBXZgNpNTRZa3RNIswT6Rnp0HaJbfkxZOzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTWGrnZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTWGrnZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C31F1F000E9;
	Thu, 27 Aug 2026 18:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787855139;
	bh=iatu0C7NUCLk2z573m0t8XWYIZPDiVZwQlMbYeSNJ0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LTWGrnZnzNGtl6a12NHLziidNZa/UGuhNkKUR0JecoiuB4s1rpfr7EJo/YKX+j/T5
	 3UJIJ4/S1cRzJZG+GpPydsxeK8UCaFljKnYOYt0698VGgasr/Cb17pcNddT9vaUDEu
	 qnIbiKZ9kumQTwWJ5lhMn9CL+ZbwfoEm7ne5UvG2NEzpgiYVw2id1NRcKJW0d3JQrK
	 6lcScGiy6/h8ELfuxW35FbCmaEij9HO82pUl9/futfrZZjSgx6M0xhcOJaE+xTIDc5
	 RKafV1eJiRsLa5/X69JT6Lln616RIHfeKAFbgx2ATxzns/Cq8FoXf59yuM23xen9PV
	 uDBXR8zhpue/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix BAR backing DMA address alignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260827181757.1984374-1-den@valinux.co.jp>
References: <20260827181757.1984374-1-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:25:38 +0000
Message-Id: <20260827182539.5C31F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> DWC BAR Match Mode requires the target address to be aligned to the BAR
> size. pci_epf_alloc_space() relies on dma_alloc_coherent() to provide
> that alignment. For CMA-backed allocations, the guaranteed physical
> alignment is capped at PAGE_SIZE << CONFIG_CMA_ALIGNMENT. With a direct
> DMA mapping, 4 KiB pages, and CONFIG_CMA_ALIGNMENT=3D8, a 2 MiB BAR may
> therefore receive a DMA address aligned to only 1 MiB.
> dw_pcie_prog_ep_inbound_atu() rejects such a mapping with -EINVAL.
>=20
> If the initial allocation is misaligned, free it and retry with
> mem_size - 1 bytes of padding. Select an aligned subrange and record its
> offset so pci_epf_free_space() can pass the original CPU address, DMA
> handle, and size to dma_free_coherent().
>=20
> Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP contr=
oller and EP functions")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827181757.1984=
374-1-den@valinux.co.jp?part=3D1

