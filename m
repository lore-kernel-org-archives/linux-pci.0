Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38E4A0F11;
	Thu, 24 Sep 2026 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264109; cv=none; b=dFwf25uF5dAB4FuM2TpqlqGqs/FdIHlzzR2cYX2UsN61YJlZpIH2BG6THwhq4lc4oPn6woixVUYwtTwqrewMJIxT0fAcKzSKxeDLlIR4RHq1ZxvY/A+wro57AfC2YbFKjbAQIK97rgl+GAilaLbUSBE5zinFdNAJD4L/dO8btPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264109; c=relaxed/simple;
	bh=8dvQ0YkOHOVnvCqW6zuRUA8sOxa9Q6m6f3jc73jM9xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YXZf+Ygk4+z6msIWreglvAvn/PSMVdC0L9v1eSs3x54QpbZ00p/GuVhPdFCuEBk8prYKXM5hdEGHe3/szXGGAOkqmrHfUzOX3SimU3JzCZ+TrxvbRenhQliraxW1cAX1yj/ZaSQGsCUI3d5AgL6snl8a5cw5D6gHGmqx3NIRaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPI02YoR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPI02YoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA0D1F000FF;
	Thu, 24 Sep 2026 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264108;
	bh=8dvQ0YkOHOVnvCqW6zuRUA8sOxa9Q6m6f3jc73jM9xc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZPI02YoR6gqKIq9iseZqS+D0tb8btuGXszm2+MPzVSUuZYpsT+HNvlnRy0kBHZ9qc
	 XbNDRfl3cfGvLKOwYihDzloLYV9W21YKRFlCczjFU0/cjlbkMJbrS/MGr7fW3NLYht
	 eYd+HfjsnPPD0NkEYwjR9DMdD4RpVKZ3A/hu8GwNX+oIsPbxDLEWn4GLJlFudhWyny
	 m+U5TfCv+GlYGSNGFy3HnNAXYibnpFXe0PntMxyvIqJU4DcEaIKAUNjd6DklN1Wp0N
	 U0vtZ5+4qlLKeahf1pEk1L6BvlvWbFV7DhSEXGq7DwkTTrG0f8xjiigCuJTaQYyNyg
	 lSK2bcvNsWcGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] vfio/pci: Add a helper to look up PFNs for
 DMABUFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260924152159.49702-5-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-5-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:35:07 +0000
Message-Id: <20260924153507.EDA0D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
> find a PFN.
>=20
> This supports multi-range DMABUFs, which typically would be used to
> represent scattered spans but might even represent overlapping or
> aliasing spans of PFNs.
>=20
> Because this is intended to be used in vfio_pci_core.c, we also need
> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
>=20
> This move also adds a new member, vma_pgoff_adjust; this is consumed
> by vfio_pci_dma_buf_find_pfn(), but will be set in a future commit.
> Add it now to reduce the number of functions touched by later commits.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D4

