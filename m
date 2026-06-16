Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E15E43E48C
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624116; cv=none; b=uKwk7uJuUv+oLKKfjjdvEqWIDEZS1RmscrZXyeY8lwS9POScZI4qfUMxlNJxzuiOLMC65iy1sgkH8j2glO2YnW9KEB++Gmnv4In6fOonPlimZPFBOdGwcjs5Y8vJPT/5Z4tZ0dd+JP5b2/WRbkNCmf7JVX1TchwMPeHGr9m6boo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624116; c=relaxed/simple;
	bh=1zoBMgyXmMOmWHW+oUqSiLQDNlsbNqAteHMLVee8lxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UsGQbJFkzkC9ur9+mtlmHtoxPi2gdmqEGEEV0VP43Bz+tsJDF3btQdEZO1m8tJTGnOo2j6we/C7xJ9LERMDZdd0nUc3WptxaoUzziyy4YzX1ypXW5ip4h9GBdiNyQkIHOOjTtP0qmtXJzD8mMQpP09eAN33Cjo7MA1/FKO+Zxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5zXnRTp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5zXnRTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDEB1F000E9;
	Tue, 16 Jun 2026 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624115;
	bh=1zoBMgyXmMOmWHW+oUqSiLQDNlsbNqAteHMLVee8lxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n5zXnRTp9L2H+pVsR0xWNY/D6QR78u8napxJ6kwvfFMLazx04Cr58heBPABqAjKon
	 a86ziLnyYfP14wcxVMXN/f3EHFDmcc7EtlzNw/j1bJq8at+m+24yGAGO+LQjnZ0JTL
	 GSlhmw0IzDwZiFLTX3MUbDtVmAAQ1Cd+dqFcm/iYBva6TcPvrOqHCJ+KKMgbW+WYwK
	 UwYPncAf5pKHRhcD4aWuE4zlvA305wPFmjENYj04JMANUz84GpX9YpFjf6i7UqcPt3
	 GNUDQ8SqtoQyFLWCwS1OG8pl8VG0ItrKp93JGnkGWQdPnTFOYuEiEkB+gM0zIReb8B
	 Potk654uSRm9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] PCI: rockchip-ep: do not attempt 5.0 GT/s
 retraining
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <d994f8fb3481bbb8f3972f117334a6e8aea383fb.1781622998.git.geraldogabriel@gmail.com>
References: <d994f8fb3481bbb8f3972f117334a6e8aea383fb.1781622998.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:35:14 +0000
Message-Id: <20260616153514.DDDEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Drop the 5.0 GT/s Link Speed retraining code block from Rockchip PCIe
> EP driver. The reason is that Shawn Lin from Rockchip has reiterated
> that there may be danger of "catastrophic failure" in using their PCIe
> with 5.0 GT/s speeds.
>=20
> While Rockchip has done so informally without issuing a proper errata,
> and the particulars are thus unknown, this may cause data loss or
> worse.
>=20
> This change is corroborated by RK3399 official datasheet [1], which
> states maximum link speed for this platform is 2.5 GT/s.
>=20
> [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datashe=
et_V2.1-20200323.pdf
>=20
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@ro=
ck-chips.com/
> Cc: stable@vger.kernel.org
> Reported-by: Dragan Simic <dsimic@manjaro.org>
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781622998.gi=
t.geraldogabriel@gmail.com?part=3D1

