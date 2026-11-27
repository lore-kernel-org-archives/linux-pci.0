Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795750074;
	b=FbxhvHlV+FQvL1sS17t1nNQoKutj3IWjZBb0xYVLYjKWvtKG+9Dmf4BAWNot/qgDYOXS
	 INjRmb6ZyqN51vFAsqHT0zq282zFdto4qMBWwcUUjnkBbVl756Uaz/CBqTdX37db3AD5V
	 UZ6YTHOLoYEuLRKKYuBOsJoNneISdpSEfl/tDN4pR2Ax6D7QB63YkQLG2/LrkEEhrMKsS
	 TX+WlZjklCs7u8xUjy8v3AInD4MTDBpbPYqHYFfY8hNg9fwSqkftqdoocyLsooF1kx/Ke
	 syJK22lfBeyNbwsl9LRGXTaaiLIxVE9Fe/radq+bLyXnIR+7q+zN5y9GXkieGC7kXLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795750074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FlPVl+4IFVvF+qvokFMFHOCb+EYaGzgb5zTf9722DGk=;
	b=v1lQQZg3iwVMGPO8GbJ+TW5KgtbQ6eBz2bmRN0yaK9q8BBoVXwfUOjDvKHg4gc8IgPHI
	 AFIR+tZb2NRMSMgRkon0P9sBkYWwIEB4cNhAT8f+ogmQRYG3du+JYa91be5aJ381dH3VO
	 oXmtdTGZzMfq8mTyO/c+NxxYkDnH/ud0MxCyhiWMBXBdwYmM1W4AHzy4TVgrvSkCy/oIm
	 dMjdMmKpipq7BR89/EMMZGqYHP6cLK3QPuOC+j/NoegmFlq7OLj2acJuGT1O/8QcMIrz6
	 sEoqmf03JFc6ddtq69CjH/+0qh+5ATOZTRfilLS7VgTl1ABiDVfLy4DvdSW52vi746Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRHy++4M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B03606A324
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRHy++4M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA231F00893;
	Fri, 27 Nov 2026 03:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795750074;
	bh=FlPVl+4IFVvF+qvokFMFHOCb+EYaGzgb5zTf9722DGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRHy++4MvujiY5v/t7C41WKkG6+9t0BbLe/a3gLsYTumr0tpDT5bdse+pHXuwBUAT
	 5RHJsYvP6NstJHs0o3BU56Fd+LgR16A0vkD+N/6r64rnwXgumhHZ9ajbJ7+W7IfI1m
	 Osi1PgYR6Ezf+jW6qbrwsFslxWYaa3efZ/0PicnaJtFEJeeFdHDBXOziMqSes+TtuK
	 wrvJ23T+jQeIQLMXKyeFbQP94EhgDfwOfYzVZ2F9jf5wYMPHPgQvTjb3wyNrCn/jut
	 R5XRVDRQxpuGAhjFeS4iIAvDr1om/md7c3EXz+QnOYFnVDBzB2ZPx9ePsjKSBGRXc4
	 mgaUENGaLBz4A==
Message-ID: <sashiko-outbox-236533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 00/17] PCI: rcar-gen4: Recover from link down and
 route Root Port interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 03:27:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 17-patch series:

- Patches 1-8 and 10-17: no issues found.
- Patch 9 ("PCI: rcar-gen4: Add Root Port reset support"): 1 potential
  issue (1 Medium)

A detailed review has been sent as a separate reply to patch 9.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127031145.2521=
228-1-den@valinux.co.jp
