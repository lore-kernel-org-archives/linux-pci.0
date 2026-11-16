Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794860166;
	b=1dqKmbIEkjM0W4zsY8eseZjsQFMoG926V1KMwUkKnDWISioqv1tuj6qGo5XY2s0vHbY/
	 RWPgzbzfBzE1kDxUfPMG5oHSVpk3MNveAUuKFr4EMLnNAcgCw55hc2MNJNZV+CwmqNvlB
	 bECr5SMUAc9+1GbS26boDrKlKMCWeVlUVmD7ULWC5FEDbm+gyx+RLc6GOdFkLOU0HbAYZ
	 9Bh9K7+PTX8GG5WZYmxfb6LwHEgl+3SFm38gjY7MFQg6q2D/U5+FJeZYtWuzGe93lguDY
	 xK/kDcWE3MUcN8VY0A3KvGqCCsl+yygUxdmX08tkW+9+2PTrZ1dZYtaXdAe/NQWhxkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860166;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dovCebk8h79GmTj+SharCzi7BlQpWojk8Ot2cD35f0g=;
	b=UhcvzIpvHbYr0VQCXPhcXBliTgSuNkBwPd2tGANoqKr8dpYQED74444/x5yMhxNsd/aL
	 /cZSaLsvk8pwGqDV2MeEZGxJLWamgNyqsGQL5UzP/pfmi9tAlArs3nxB3+0hQEZBZtwac
	 yxxXi2EtgLjgDLVqTbUTiTONaUba0QkB1le+jA6YBhCAGOtj6EZS0AZE53R5KYzBvSeq8
	 i2XRjB0dynAvP7B5opzTgNlAHmgRC+rnEBsMVcwI0BJlXYJpgEXafpwNcnzci7Q0Eaw7B
	 lAMP4BomZXjDbldaBhDYKQK4sH+POmEglT3Iol8qS5jze9C71C/K6+IbEQfN87bmnhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAoFpqFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B989606A323
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAoFpqFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EDF1F000C5;
	Mon, 16 Nov 2026 20:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794860166;
	bh=dovCebk8h79GmTj+SharCzi7BlQpWojk8Ot2cD35f0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SAoFpqFdS8JvPDV10Q4FqHJTyalMlp/Cf2gSiSEqBwCSA46TpBo4CyHbDFQ5Itob+
	 uwytPpvQhUTYZ/fmtcJZ7Zf6eTPp3Ymks16lbhnW+4G5frIoeNMkABcU95TZdrYSpg
	 GvdDC96HOL9xnKg2azYBg4cGL38HiEgxG0sABmorikHSYA3hbiwxgaFCZvM+9BrgGu
	 nLn1cPw1ddPMNqkLjreIANjmM5tdIc6G4F/12xJZ3CALadWmNColG+2GM2vpPIBZrB
	 uyExPWQ6jUrB/HEaQ6QBb0uA0pAuuY39eShKLnKdEaHFqnyQxrhuXj2tWStRVB1P3J
	 DR+sFVLiokvjA==
Message-ID: <sashiko-outbox-217644@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: fu740: Disable pcie_aux clock if reset deassert
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayaraj Devaraj" <jayarajdmit@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116200912.156500-1-jayarajdmit@gmail.com>
References: <20261116200912.156500-1-jayarajdmit@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 20:16:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: fu740: missing Fixes trailer for fu740_pcie_host_init()
  clock leak fix
--

commit 5f0aad4ff6cb1ce1a8dd0a5f972ce2e2d06643f0
Author: Jayaraj Devaraj <jayarajdmit@gmail.com>

> PCI: fu740: Disable pcie_aux clock if reset deassert fails
>
> fu740_pcie_host_init() enables the pcie_aux clock and then returns
> without disabling it if reset_control_deassert() fails, leaving the
> clock enabled on the error path.
>
> Disable the clock before returning the error.
>
> Signed-off-by: Jayaraj Devaraj <jayarajdmit@gmail.com>

[Severity: Low]
This fixes a clock enable leak on the error path introduced with the
driver.  Should it include:

  Fixes: e7e21b3a339b ("PCI: fu740: Add SiFive FU740 PCIe host controller d=
river")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116200912.1565=
00-1-jayarajdmit@gmail.com?part=3D1
