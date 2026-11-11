Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425918;
	b=m3gh1P7Jr33RN9mZckhb2dWlC39rn2uNyLTDBSatSpEjr86RnOF3c0ufTIWgeJcv9aSE
	 2DhpKfttqUi3My3ZbchzSTeKExSg2VEvZ5tmd6++sRDpGQkRZLZ3Rm/xYINLEXsS3e5n2
	 UaJ/BEVnGtF+qZBoQ2lb7LYeNkWQyF/jb4NoxlhKSPyHdST9ov3ezEkX+2ubM+i9TsXNM
	 yOY4Ao737ynSHlRtrUw3dB3SgCKHROuPssQRA+TUBry0dzG5wQ19o1OjlI3uAjGfYvJhP
	 TeM3tYfVlm34/nct4wKvGB+2mcANBvdVjVQnCRqlNWXVPTjZWxM08S5eLq5X6gDpoXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425918;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vyDD6mXSVm/Bk08o6laBKYw4xi+uy72/jp11IiD0Y34=;
	b=MtuFabdCA6Lv7Ll1Ex+IhyfTOqqyW9RFu/1alc6WGIjTRyGOubag4WzrTurfDHZL+tSh
	 nC5pOVbQ8DpNI95I7BlxkxWqi2pijgDmNq+3tNZG/e/KQxEzUbWtkNywLhPpqM5WT9hdK
	 gg+5ndMzYyo3wwDqIIGeJlDrwz9mKJfqng3KWxLXirgbwyOJnINZoIPOXy0wykoon/Tv+
	 Wd3jO4wyuq7lxl4tratsj7Ce1t77PQxc1nyvL2XI+Fmm7JpzW3VG8Oo/GJ5T4pvIskNnB
	 M8cAXqEb0O3cVBoxKvEFHXta72CXifqMFwWVXCkJpQu9C9c3BhEEmcR41+D/+u/Dltw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hk0XV/PJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F2B606A31C
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hk0XV/PJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428D31F00A05;
	Wed, 11 Nov 2026 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425918;
	bh=vyDD6mXSVm/Bk08o6laBKYw4xi+uy72/jp11IiD0Y34=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Hk0XV/PJeUWcWdBB5EjB/jIVTB/2+Vfraiv4q12lh3IjNjgzq6HOP5EfY0X58TxG/
	 UDqezFhRr3oLrdcssFtvGA+4WkwBNGlWkJRw1gnx0/4XdADCNMl8wzgiQ6XrLIkYbf
	 XrRO38idqY+4x8qTAUPlKUinDm6ZEutZvdnlO4w60Mr/6OGLYlYjUJXYc8XEzbg+4U
	 NJ3uRZ9zSx5kPiHqGXYCsYG1wWUOlVnveep4QoqFVTC+xz3e2koAccHRdfFd0cCvBX
	 M2eq35bv2Sev1WPcLcXvxoLzQd8FLFYCsm3mW/70v8Fm40cmgH5dEN5yq71oZhFODn
	 v3ErT4G3dvp1g==
Message-ID: <sashiko-outbox-209578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/7] vfio: selftests: Add vfio_pci_dmabuf_create()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111192411.4133780-5-dmatlack@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <20261111192411.4133780-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:38:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add vfio_pci_dmabuf_create() and __vfio_pci_dmabuf_create() to export a
> VFIO PCI region range as a dma-buf fd via VFIO_DEVICE_FEATURE_DMA_BUF,
> and preserve -errno on failure in vfio_device_feature_ioctl().
>=20
> Native iommufd maps device MMIO BARs for peer-to-peer DMA via dma-buf
> file descriptors rather than VM_PFNMAP virtual addresses.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192411.4133=
780-1-dmatlack@google.com?part=3D4

