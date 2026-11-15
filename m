Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743778;
	b=sTab9AyT2F8JrN8WrXF+XSkwKuOMHxqHCdKSn0oFeweSvX3Y1oySzVo/uepVUmUKd5j3
	 sNTFaA4JnGTJ7DmtnFpfxUHVA+PEFgmlfxRzOfB3qci70xOZo25vYTP2Dq+WYqsy/+q0T
	 VFuJKRF7aFlJfFN/iiyppaj/PEvzb4PzrhBzUfIcBSs0iWm7yJVT9hzMVsQu7mxycb7Nv
	 wTaXhhyT/FiPyt3hoSVIBc1F3QW+QE7eDYI5Na/dqmkckDwnE37YlZmO4WPeIcrPHjWOB
	 g8YT4zLCWOGF+8rYGDSampsdz0u3y9axB966UtDPQvL7M6mEgdM8PDLOunOT0sWjfFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743778;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9E+G/EUAAeJdTP9W5Gxv8lBWvWx/K2k7gwKi4dNHbPA=;
	b=ydpFMU+NOrJxM+s1sE4hB1M6+Na5vyD8pvwR9pkEKB6r9pQFRw4UCL6akf1mix0qVnbb
	 28KD1PxfYVCBOUu0nQitcR/6zKYWgV/mPph+o3YG7UsEtvn0/yV179oeIqwhTG2vaYI32
	 ThUvJ6Dw//hOyYSSD+FeuuklBeqEyIONX/acgMcFHLDdTZ+dSjnfk3Cke8qOZpfuB2NEt
	 uJoykwa5lXGwTcHiY5Jy3l8k9iGbkI1eJ8fQorKpywyk+tDJcTYF45hqhTBDZCXOPE66T
	 iEu5HKBuNXZUCBfYpOe+Zr0KBwOi7T+C/1aqG1boIbB8vm7R2z77fFurfCIsFyuQVQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mz4If7Ja;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F2606A32D
	for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mz4If7Ja
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4929E1F000C4;
	Sun, 15 Nov 2026 11:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794743778;
	bh=9E+G/EUAAeJdTP9W5Gxv8lBWvWx/K2k7gwKi4dNHbPA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Mz4If7Ja58bkAGsPf9Z9SxmRgOkJ3xElsSwu4TX5bOTakOIrTyS6vghmRU0HjMa/J
	 wyb6VMxqCrToSmA9qAuEzhiTHeMBPdzy1AtgAfKyhHdihMj8bQ+2a7/rfCuPFHdhFB
	 rOQn7sGnzIzb1Xn8HdOVqbZKG+/M3LlV+KJOGLIJ3HD8dWRz3JNvHfbaNc594pthUC
	 DuuLw6g140YPETSJgvQrT282ZKOa0W8jnxCQg3cCyGG95JzZjK0mEd534j/as9sPs8
	 W1hR4T7/SZG/KzIMdz9BNEHrJWJ3DvdaDNJj+4ziVZGMkofFAhKV51p0HKsaAbTVAh
	 vYTZ7CZO93iDw==
Message-ID: <sashiko-outbox-215462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: apple: Prevent module unloading without IRQ
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongyan Xu" <getshell@seu.edu.cn>, linux-pci@vger.kernel.org
In-Reply-To: <179474326811.103840.15695658964160156282@seu.edu.cn>
References: <179474326811.103840.15695658964160156282@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 11:56:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The driver suppresses userspace bind attributes but still registers
> a module exit callback. Unloading it leaves the PCI hierarchy and
> unmanaged IRQ domains and handlers referring to released resources
> and unloaded driver code. Removing only the root bus does not make
> the remaining IRQ state safe.
>=20
> Register the driver without an exit callback so a normally loaded
> module cannot be unloaded. This follows the maintainer's suggested
> first step while complete controller removal remains unsupported.
> Keep the tristate option, so loading the driver as a module remains
> possible. This change addresses module unload, not dynamic removal
> of the platform device or existing probe-error cleanup.
>=20
> Found by the author's in-house static analysis tool.
>=20
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Cc: stable@vger.kernel.org
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/all/87mrrj8ku6.wl-maz@kernel.org/
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179474326811.103840=
.15695658964160156282@seu.edu.cn?part=3D1

