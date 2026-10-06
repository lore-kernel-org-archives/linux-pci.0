Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7B270575;
	Tue,  6 Oct 2026 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791316112; cv=none; b=U3mKeE4eJqsaA4iIM+EDH5Q9E2zcu3M6QQt+VOxrgsy8+CKXkaGLcjg2I49YHwEHzYBq8bYeCikNmXqvFnE6lx/FMxOkAMov0xwGrD1Dnm6k73J45hhqCMRDTSjl6XC6yVdrLt456Mu9v6HsgodQbb8SNua7K8VoNpM/r29eP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791316112; c=relaxed/simple;
	bh=ozrljCclQ4TzClLcXUsZV1coylF98KbRNfSnChGkoz8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZHTctNkz0FhNKiWgtnNpsM6uobYaQKIL76Rs7F9F5qonJddVQB7pdreeYszeaq4zEACY5vU3dz1Pa9LPT+LGFpM7CnAl/DZl5nNjxcrY9L8q+2gBkw5W2Oe41IT9Mkq37oRBwnY1SiDfIVoHbsPIrSOII9TNCscUaG3+h0NStQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecoYev5e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecoYev5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DB81F0089B;
	Tue,  6 Oct 2026 19:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791316110;
	bh=Il4TIaCJkAOTW2lltBD1HBc/qYXW6IFEez4Ax8czULc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ecoYev5eI8jTm5EsGE+ZvpjlHTRSYKqBhdMVSggpbqzhLLY4Qy4/Ywa+eNOAl9Lfz
	 idlfqxWTQtNUNs8BjCo3Drra0Msg6Dtau1F5QknqfzACOCWs0fSqwoMTyGcI4H9ljI
	 L5ZfWaQiC5zAALl/UyupC98sNZkjQi0XyKPIulzRFB0DGBXrLjM3Sxysz9skj2QWbt
	 IaRx+LCmAM2jYb8Q1WbQVdeWqTEvEb6QGm3qnxQ2dx30j4jYWKmh0RrNVghQBj6hy6
	 npzQaCCRm4Vswx9j2KIK6mXm7n1vBXl8rKtufPOE/52JflzwqcgYLPE8CsWWJuNf2z
	 IdvXIlTvLNmCg==
Message-ID: <sashiko-outbox-162412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/9] vfio/pci: Remove DMABUF export dependency on
 vdev->memory_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261006193643.76330-2-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-2-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:48:30 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The VFIO_DEVICE_FEATURE_DMA_BUF export previously used
> vdev->memory_lock to protect VFIO's list of exported DMABUFs
> (vdev->dmabufs) and their revocation status.  When adding a new
> export, memory_lock was taken for write.
>=20
> A future commit will refactor DMABUF export into a function used from
> mmap(), which would create a new mmap_lock -> memory_lock dependency.
>=20
> In preparation, this commit introduces a vdev->dmabuf_lock that
> protects the dmabufs list, per-DMABUF revocation state, and a new
> bars_revoked flag.  The flag tracks the device-wide BAR revocation
> state set via vfio_pci_dma_buf_move() under dmabuf_lock, removing the
> test of __vfio_pci_memory_enabled() and dependency on
> vdev->memory_lock.
>=20
> This is a cleanup currently, but allows the future export path to
> avoid holding memory_lock under mmap_lock and a therefore avoid a
> deadlock scenario (a fault handler attempting to take mmap_lock in a
> vfio-pci variant driver thread that holds memory_lock, vs another
> thread doing an mmap/export holding them both in the other order).
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D1

