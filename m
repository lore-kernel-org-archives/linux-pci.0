Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973652;
	b=OvEAubh4m6yo9LAl2sMp1RVkXIls/yXTnBHX6vsASbtRzVBPmmAcEo6rDZC6ncOfvPSy
	 Wmj8PSVzpSG35EWOvCtDiCSXqJ6q5iFTvtkaH69aPRtUKfuJ3EoSthE+92IUe4jxHctGm
	 HujkKHUV/V/a1UF1u+ELeokxX6HSQ2nwreTMkbxXMqeNInftvQL8JZMYt7S1anTapzRM3
	 MDcr+6c0JxHMJ/VbdicL0suB6igUxByntNXBXjbcaa+Ttah96NPLEZ/dZM0WoYe25VKJz
	 jZPcYr/UxOtJ4Z51E8eyOhzQRRQ6a7h6PHIW8McwOyG1Pmet/GV1dP9pmfc6hSpmBtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973652;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kj/p1SysJ4suUaYxNSg33K2Ik7OXWYi6cZYFOinaY1Q=;
	b=cgYRwYNO9OprtyYNpdaqDWxSkVff8k3WGwL0cbS3Wgds07tkkL43PZnvi5LmvqmnoizR
	 /mN65kNRz0BFHZoh1HEBj91Mt0SK7kyP8Cc4EN2Jhjd0duymogiIdUp0QDHb4UQm95lGz
	 chLPy4KbQ5vTWF4vu/L/XzGARLP5+y7zidOqod2kW3yfuZxi9q3pUjgH8iEIXnGmKbl9j
	 kciVSX693bJtnntq7LPU8+Dc6kionYlQvb/Fpnx78wcYSfFTa5Yo2PQM5oHQIjGdr5E86
	 NMJ0GykXf6/dNT5PsOISUyjUhhiW/cq4VBzyRN8lWioLsiDS7NJC5bvu94wEPUSRp1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jdUlnD9/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F946082BF7
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdUlnD9/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276231F0089F;
	Fri,  6 Nov 2026 14:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793973652;
	bh=Kj/p1SysJ4suUaYxNSg33K2Ik7OXWYi6cZYFOinaY1Q=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jdUlnD9/WOQthqdcSE++kZKMXPKMaWEikPFtj4r/DSAUNdz+5RachVwnWxUX7feZI
	 KSSFa3OOm5fZtNXHg77R33OQKunmSknnNM2mfna+7sv5ULsZd1GDRD5jDaTuRJWH9v
	 tihPnTXbFRxxtSdJKePEAonAQyDo97Z5bnqM6sQgIbKsY4oF+Urc0CTzQUTTp6WY3D
	 HiTiYdA9PQFdatMnldetnxQVQCKsFyYBk52lT31jp1gSdiHumI5WyX+Wcjwl+yApYr
	 iW8sXoR+tRSERtBfNbZDl8/fm9OU9zmiVOfUkrz3i3r0revpO8X/HaEyduy2eHUHLw
	 TAs3oy8tH0J4Q==
Message-ID: <sashiko-outbox-201528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/14] PCI: Don't size or assign disabled BARs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-4-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:00:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> When a 64-bit BAR is larger than 4GB but pci_bus_addr_t or
> resource_size_t is 32-bit, __pci_read_base() marks the BAR with
> IORESOURCE_UNSET | IORESOURCE_DISABLED and sets its size to zero while
> retaining the type flags. pdev_resource_assignable() only excludes
> disabled bridge windows so such a BAR is still included in resource
> sizing.
>=20
> pbus_size_mem() then calls __ffs() on its zero alignment, which is
> undefined behavior. pdev_sort_resources() catches the zero alignment but
> logs a bogus "alignment must not be zero" warning.
>=20
> Exclude all IORESOURCE_DISABLED resources in pdev_resource_assignable().
>=20
> A disabled expansion ROM is still assigned because ROM disabling is
> tracked with IORESOURCE_ROM_ENABLE, not with IORESOURCE_DISABLED.
>=20
> Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger tha=
n 4GB")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D3

