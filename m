Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291350;
	b=qf5+yQBiePUSwvbm1qN2eImE2Yfg4tm2kQVF3iALk7/6uXLQGW7fQDApe8nSHtUcn2Cb
	 KjMHNDlbdPvxCAD916KN9wHGGE6/lgCGQ9hg09VjAiaSMUh0L6wTzCPUcHrCUl3FAls45
	 QDk5NsA1RM7pcGXjYqVF+Y8PtJADJ46Yh4WT2xyIuWXhfVzgNEXoK6rME2X1EmmRmsypR
	 K1gJobM16UwrTytzBiWHPcwL5G/DEYEjnLE4O86RrPNBUJyeLt98liZzkz0BjXf/K3uKA
	 etx9ly3TBOJoX9ubPbi/hnzJ/7HugUpMkriLGsUShvpmqO/0KfKM0Q3TA2rEcd54aJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291350;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oPEL7GADlr6ILt7weN+ikXZ7mLgkeBefVcnGIkrGxHU=;
	b=YvKIktkBex/8Q8EMcgLdwSzGPNJcJM3NPLdrNOzTkIMK3Tzyp2Fut7RTwXoPh2VLBWlg
	 v4ohB4J/SYdLPbnf+B8t7aD50Gw2g2/+twHD3qaaykUEmplfVk00bZI+b/j9kGmAWLK18
	 lKEkpZQWeSU62uCY405poMJt79VdsXT/+tXzCYRf4nxQIf4aJjk2RKbfJd8wHHVENXEW2
	 dWsXd0IuVsFcUd4ATtLPvthbnDMnZjfZkw4YpeeTIe4AYsz8nnOMfk7nthH8Ny1jBdK2y
	 q5cQY1XCSIPwQgzavGUa8dQd/9hxm0Pkr12yXItzj1Ycp/qoCQtERG1DRyFUvrJLNGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SXsOMCbO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A860606A31C
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SXsOMCbO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4BD1F01816;
	Thu, 29 Oct 2026 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793291350;
	bh=oPEL7GADlr6ILt7weN+ikXZ7mLgkeBefVcnGIkrGxHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SXsOMCbO/Pe7T+2alWjR+Y377SWJWSDtUPNPyTxh+ZYsHepjRMOsY7neDP5FQBz+4
	 a50wql1fWrvvMKCRtl1ra+cZeo9KGblXVCBF6YnZzctAsYPLcC6lMz5/MdVQFqCgup
	 InTAaXfH2n+pWWS4+oyMBlZsRIT8s41vp5vhHTGAlSJfHjVeSNTILcQJ8jZoFVnmPr
	 tErhRsUIMn9hceZRh4OxrTV2JABa+T+SdigW/hMCmkJ4y8K1j8sYSIM6381sECyeHE
	 j5hj+UbjIBfdcyboWt2CK07U1NkigSRgjzO7FB8OHUnfgcwM9kXDdRmJggrSKPZMYc
	 8srnGpa0zalgQ==
Message-ID: <sashiko-outbox-189661@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/video: Preserve the default VGA fallback for legacy
 modes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hengyu Liang" <hengyul@cs.unc.edu>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029162311.3389523-1-hengyul@cs.unc.edu>
References: <20261029162311.3389523-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:29:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Commit 596b3678326d ("x86/video: Only fall back to vga_default_device()
> without screen info") made video_is_primary_device() rely exclusively
> on screen_info resources whenever any are available.
>=20
> However, screen_info_resources() also returns legacy I/O and memory
> ranges for VGA text modes. These ranges are not PCI BARs, so the resource
> lookup fails and the default VGA fallback is skipped.
>=20
> On a SeaBIOS QEMU guest with bochs and VKMS, the boot VGA loses its DRM
> boot_display attribute and fbcon leaves the console on VKMS. This can
> be checked with:
>=20
>     cat /sys/class/drm/card1/boot_display
>     stty -F /dev/tty1 size
>=20
> Without the fix, boot_display is missing and tty1 is 48 rows by 128
> columns. With it, boot_display contains 1 and tty1 is 50 rows by 160
> columns.
>=20
> Use resource-based selection only for linear framebuffers. Fall back to
> vga_default_device() for legacy display modes, while keeping EFI and
> VESA framebuffer ownership authoritative.
>=20
> Fixes: 596b3678326d ("x86/video: Only fall back to vga_default_device() w=
ithout screen info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029162311.3389=
523-1-hengyul@cs.unc.edu?part=3D1

