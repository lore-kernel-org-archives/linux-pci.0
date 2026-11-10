Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351547;
	b=ysBvcxwIAtCxhUPXR0X4pcVqIXslwzKQt/ZbAWZ75nP/i5A/S6v5sIAtiRLnkNbV5xey
	 XByY9m6hKLCjnrM9nOkN8LcMhysv7Z3vwANfQ8VPq+/R40b6JBR0cHwI26xbluAlmOTQR
	 IYs5xuxrygWy+fpe2UmyVrVSLBroSy94m2mCUevvN1XfueYbH6cCUg+F6qVGkaYmkDYm7
	 AASFV2RYxqOq+RFccphCHdVS/FgI0Tujn+BMZn3WItNkaTEP77wfeWE04YlX5sQnM+v70
	 AxtY2Nbz512fUfsDHR3p+vXycDvpE1GEhRnfno27zLJxJlHDWYwXI0y+EWsfhjghsxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351547;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yDRj3RkNE2CJhvjbPsnLcWifP1ULBTojPvaz80cCYms=;
	b=e8FyNZEv3i4v3DM9ZAANl01rlWw/zbK0uLZntvWViBGMN+riUFscO4l5brVco+tO9Uxc
	 SY4bXNlcQexIdtEGQ7j1dHcfKW1BitXR5iSb/tmeelU1C3vuKRhnk/zbmzqUEl2xVVe/D
	 uWe4AIwxzCqVdoFykrAeYSIKDYe10RxrbibrXRDkTmjRd27cSikNH84n3aJbMrN+qGjKL
	 vHB/LuBC+K8Bx5ROxE3sTS7Haa4ZodKRsPC7OWOjQwJ2CP8GLBAHL/a4JpNX8ZOpEBykJ
	 BAieXPyVzC9UY1Q2B7atq9XKdKq1Yeqdg0nr9j004+VZ63RCZLmnZyTk6mgN+UZwMxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpiYkzl3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039D606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpiYkzl3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5431F0093C;
	Tue, 10 Nov 2026 22:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351547;
	bh=yDRj3RkNE2CJhvjbPsnLcWifP1ULBTojPvaz80cCYms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mpiYkzl36I5DbvR+8oSJfBkUlhdr9WOvE0gABnn6PLiB1TgmJZo7k50eVvfxcJOsC
	 qfQHSbpFHkZDwS9XMMJr3XJaCRT7mXyWycoYsA3GJtSqQDl/hlyJvofeDMrDHSTV5w
	 ByJ9B++ms7A1X+Efib/6XBb77ucMoYYyDSeexR4+tec34vRIZ3qeJYVbn6BM1vu3fi
	 6RhY9JQrJlfWb4NWDcbiiVdSdwFKZwL2zKQ7zBw7YSglIAOAvs3uqLgPXBKsjxvdiS
	 3XBZmh7tHJjRo/SeyPi7t5pvrLdDE0yFQ2bgbCvF76Se+Zlk/Tw4edMGngGBvmOY3W
	 weM2E+Qo4qMkw==
Message-ID: <sashiko-outbox-207855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] drm/amdgpu: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110-vfct-regression-v5-2-f49fae981bf3@amd.com>
References: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
 <20261110-vfct-regression-v5-2-f49fae981bf3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:59:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
>=20
> Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikza=
dch@gmail.com/
> Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft=
 filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-vfct-regre=
ssion-v5-0-f49fae981bf3@amd.com?part=3D2

