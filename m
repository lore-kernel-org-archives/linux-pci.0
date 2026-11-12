Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510880;
	b=b5+1oAkcRqS8JiQrHr/HE0eWhlJT16xdceo2dWqAJ720uigIya+vZzx/Rkd8O/6bwgou
	 Q0yXQE01jP1Iz2R9DQKr9AJIfd4d3K0x769uywFUpfI7/u5CYRKHdatu5O75/eKkuR442
	 O6LM1mpWRccEjbjUcMpegTR6/BzVOGUj7Ouz9oHE6hlhOL4EaN1hkYYARvo9qKV7UXoMr
	 HXEHuPec0yxz1CCXA/H6AZ2DIskEiZzjE6+9WILg+HgpEOlOirb9szLG+MfoXIuxOnt3Z
	 Q8rT4S9DDVPHzL7e9GeIIQ3EmCL2AQXssNKm9pP9J61q44Ljtjxx15HC+FOfc7Pl5YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510880;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wyr2kTPK2cYT1fUC4U3XZTAZExg+zcIv0fCSp5IKbyU=;
	b=DYCZYLRnUxbr1rmCE08d6TSwuvQCw9tHnMetov2cNQUjkkcUvIb6AaGnMLBU8huBgAgH
	 7LiMCVQpWZBz7Qf6Z7Mr+4lgDNkYu4dCTKo3CjZcl13DPn7y0q5XAAgXr7CtpzOachC9S
	 7hmcrH+YlRH2FbwNSzerb779Io/XYdEPLk98q8RC/jEzseH7Ako6y07G4o2z0l82lQwOI
	 TUq5XVaUajoYq8i35lxB2OIVLs/4uyGK+QA5+ECTvZmFhLFPcAc2CPch6QPMLxlKpuRx+
	 2kKK2xwnBMomszEW9TARF6k+c8p1nQ/djFL2afX/fA4pXYnY+ca3mUqBnnkbPRvpdHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MiOIsbPG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C41F606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MiOIsbPG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA481F000C4;
	Thu, 12 Nov 2026 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510880;
	bh=wyr2kTPK2cYT1fUC4U3XZTAZExg+zcIv0fCSp5IKbyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MiOIsbPGW8jS1fH9P57KXUahwvRwzSUjrGnOmrmzGe6/GcamXcSfoHX2wjFpSd/05
	 tUc2C1m4yPnJ21/pRk41jIHBP8w9jGo1giUCwmKSbfJ0HzcZti+uX7ko+wJxKE7pqF
	 G1pOTHIVdF319jHOfbv1+/CA6s8PeEHUppozvVIuSrV9BRhgzmEKFH9C6E/A4CSi8X
	 pSgtaOR0+gV2Fs+jZgKP7IcY9v0hB52Q3kVxQWY415aFeUrB+6TRadW3r5h0QAdQTd
	 jtY1ql+F7SvxO5qzlkNZjOcBpdagMRRopufmqwQyLxUrS4vzaw5syIxq2DNZhJ3xEQ
	 884WTPTr1IJYg==
Message-ID: <sashiko-outbox-211750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] PCI/PM: Disable bridge D3 on Lenovo ThinkCentre
 M90n-1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112-superm1-kbz-222179-v3-1-f20b5ac06b6d@kernel.org>
References: <20261112-superm1-kbz-222179-v3-0-f20b5ac06b6d@kernel.org>
 <20261112-superm1-kbz-222179-v3-1-f20b5ac06b6d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 19:14:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On the Lenovo ThinkCentre M90n-1 (board 314D), suspending the empty
> Root Port 9 turns off a clock needed by the onboard RTL8168 behind
> Root Port 12.  The NIC becomes inaccessible and r8169 fails to probe
> with "Unable to change power state from D3cold to D0".
>=20
> The RP09.PXP_._OFF method gates PCH SRC clock 1, which also supplies
> the NIC behind Root Port 12.  Keeping Root Port 9 in D0 preserves
> that clock and allows the NIC to probe.  Commit 4d4c10f763d7 ("PCI:
> Explicitly put devices into D0 when initializing") exposed the firmware
> bug on every boot by ensuring that the first runtime suspend executes
> the power resource's _OFF method.
>=20
> Add the board to bridge_d3_blacklist to prevent bridge D3 transitions.
> Check the blacklist before platform_pci_bridge_d3(), since ACPI allows
> D3 on the affected hotplug port and would otherwise bypass the quirk.
>=20
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializi=
ng")
> Reported-by: Joshua Perry <josh@6bit.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222179
> Cc: stable@vger.kernel.org
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Signed-off-by: Mario Limonciello <superm1@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-superm1-kb=
z-222179-v3-0-f20b5ac06b6d@kernel.org?part=3D1

