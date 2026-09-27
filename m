Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E82FD7D3
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506923; cv=none; b=agdrIMYQ/KSWlQ/u+lIm92iXk611Zeu4EixiH07IwLh+W0b7EWAo4wjsP6oqItaxgF2VGt/IuDJmSp8QlmLNjZpr7K0Qwl5nS15JSrrTy0pldka0qHPm48jzm0DQr8v/5/VPzhIm3zlyRNAVvoU0L3LBGtMmaI9ZXZvyPFtYY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506923; c=relaxed/simple;
	bh=invTFJEP2oJ6SZwFaNq8LWKkstG4/HU8hMvijSjMZT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=etg5TtandPRhYerlQdyEgvRHE3qtWpACOEzbJ70aTd/UIx1d20c2Da1j/8N3IHmSu6RxRAv61x5NgCSmTeRisPFRRPU9BxWEC0UKL64BLtu/22PUntWXknITyUc3LM5Qf3L2q8Xkd7vN/VUwQ7rvHus870MDhz1pgzWh3RKTMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgEQexZl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgEQexZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C391F000FF;
	Sun, 27 Sep 2026 11:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506921;
	bh=invTFJEP2oJ6SZwFaNq8LWKkstG4/HU8hMvijSjMZT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dgEQexZlxm21+zXy4sygZUag8ATyB1XPwWmE25KEzOtZVy+EyqkH2ZhUFbHLZAlJ6
	 7rHVlNSOFPZzbHIt0ntgkjGe6wfvc2WgXw0uqgSp7XR+l5RW88/lN72QuPnUz6YeB1
	 L5QSsBB8qwl6BVRwvTUtyYrlYXw5Fk3Jlj7tVlHh4Oeai51ByeaCQmy8rhtEZTUNoR
	 J0hnGwvz8zi/P7pmiVf9DZ7dNNKgilL5NedLv4KMRmuZ1v/Itqs07sumKtDWAguniM
	 g+V4TMUYWcuzWSRKZDG4Jz41+5jJ/+BCVQ8SQzwqKbjuAUipWCi6wJIKM2Wo4lWuBs
	 dUud5lgETJhug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Avoid D3 on PLX PEX 8532/8533/8548 downstream
 ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927105609.8813-1-kaloz@kernel.org>
References: <20260927105609.8813-1-kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 11:02:01 +0000
Message-Id: <20260927110201.A9C391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Runtime PM suspends an idle downstream port of a PLX/Broadcom PEX
> 8532/8533/8548 switch to D3hot, but that takes the whole switch down
> with it: any device behind another port of the same switch then
> faults with a fatal bus error on its next access, e.g. mptsas probe
> on a Sun Ultra 45.
>=20
> This surfaced on sparc64 once commit a5fb3ff63287 ("PCI: Allow PCI
> bridges to go to D3Hot on all non-x86") let bridges enter D3hot. Keep
> these downstream ports out of D3 by setting PCI_DEV_FLAGS_NO_D3.
>=20
> Fixes: a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x8=
6")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927105609.8813=
-1-kaloz@kernel.org?part=3D1

