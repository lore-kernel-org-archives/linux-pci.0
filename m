Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC831F9B5;
	Thu,  2 Jul 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016962; cv=none; b=trkqCB5dKgsKaIZC+hSQjq0TUiFuq69LblB+Md4IIDOVBBAXuQ9q4dk6/qCT1X5C4c/Sj1lxYocJk6E+ekcIrm8GgvxRp/0PUovxixjv44Z9A+5lhY5yImOe7dHQqI1yPonosalH48MiuRKTSVg/U5b2p1YFh/5NJNXEZ9Cu67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016962; c=relaxed/simple;
	bh=Ae+/zeh8gCqjCiwqvv8ueORiT2MorjMihfjfDtWkSaw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oAI6JozV8/TiSRBrNNgIEMWMKjacO4G1F7sXdNwLmNUDPzqcGUH+/cqug9yomQz59c8ZdZdhcT+BwUW44vSmTIzp3EjVaFBTV5ckpM+tOOsWcMRPtAn9UWmf68yk53fMXS1+p8C4UrvR5zbcSRLB/KPMhCNvUvV8O5qTm0gz8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzbK/Op+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzbK/Op+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872431F000E9;
	Thu,  2 Jul 2026 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783016960;
	bh=Ae+/zeh8gCqjCiwqvv8ueORiT2MorjMihfjfDtWkSaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JzbK/Op+SfICRExFrLAG+b/ClRChB4r2bCf+4ZlLhIWxnsEiEsS23S40ei8AhDTP8
	 zuAST4DEH2edhEo0aIYZSgjMVIMq3X0iwLAamlJ3zMRpv8kz/J7rrmrZvnJGWvQesh
	 ZipWPK0qUOMWGbPs1BRX7QDGzaXtVpBcWbuDDCdomwXCswyrd7LszucNO4/UI3aLIc
	 xkXgIHgqObigMRmeu0gDsKCOAIvCSSfPJWzQjXSkgX0njiBGRrmfe2oG0yLr5vtr1w
	 asMCGA6dmesukCrPxva+pmWkjVL77jcRLdTTZvrU3mYn2MgVeAb1OiznzokQzq0uDF
	 qY4FE5rStRJbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702181025.2694961-4-zhipingz@meta.com>
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260702181025.2694961-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:29:19 +0000
Message-Id: <20260702182920.872431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Implement dma-buf get_pci_tph for vfio-pci exported dma-bufs and add
> VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> for a VFIO-owned device.
>=20
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> uAPI carries both with explicit validity flags, and get_pci_tph()
> returns the value matching the importer's requested namespace or
> -EOPNOTSUPP.
>=20
> Publish and read the TPH descriptor under dmabuf->resv, matching the
> locking used for other importer-visible dma-buf state. The SET ioctl
> takes dma_resv_lock_interruptible(), while the callback runs under
> DMA-buf's asserted resv lock.
>=20
> The attach path reads @revoked without holding memory_lock. Annotate it
> with READ_ONCE() to document this intentional lockless access: the read
> is a benign early-out, and a racing revocation is re-checked under
> dmabuf->resv in vfio_pci_dma_buf_map() before any mapping is handed out.
> The annotation only needs to keep the access well-formed against the
> memory_lock-protected writers.
>=20
> Reject requests the device cannot consume as a completer:
> pcie_tph_completer_type() must report at least
> PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Make PROBE follow the same hardware
> gate so the feature only probes as supported when the device can really
> consume it.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702181025.2694=
961-1-zhipingz@meta.com?part=3D3

