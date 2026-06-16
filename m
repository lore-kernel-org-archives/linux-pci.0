Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1B44BCB0
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624128; cv=none; b=SM8zms1O3BctTH2TkXGEPnRktMaug8b2Oxi7spZrIKJGjepiEY9tPYPfFnRQJmdpsp9NskhjJQkM6mMW7hOYplxbxM5foHiWgXPWGrnwP6rkx9mCmlBHiYk8SZ3eTV4qlTazuYMaeHzl+jeIWL3piTwYbS60NkzMJ0bXNY26TSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624128; c=relaxed/simple;
	bh=RUl5rALdZQIkXxIEEh1ov4AwrUWUej+lzDRhoKWZ2/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tfvhuUa5Hmncn1Y8Iaagh3BKxRW41dAYtSalTP9sU8kf+8xbkM9A88S5CydRHS6zuq7yo2v3l1Gs/oX5bxL6I1D1Mss3cOZMvlN3+4K39/WJg6PXWNKLLV1a7Rw4cN6VM7P9Fe9luR3raaOsuc2OU49b2VTu7HRDD4qE+6hRrok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud3Lx7Dq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud3Lx7Dq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AA31F000E9;
	Tue, 16 Jun 2026 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624127;
	bh=RUl5rALdZQIkXxIEEh1ov4AwrUWUej+lzDRhoKWZ2/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ud3Lx7DqlU2F/RFHq6CL6Fv9xfpM55Hgf5jbCXfxx79tQAlLt+GvPY+nL80fec/+E
	 0YorxLRneabNyofNRF8cUkdbME57QYITu4xfA/7HAyVdg2APxpdNZDObqZ0Tk9FzE9
	 3ilMMhkxdRprsaispRsP0doWihtrLyZPmodI0Xwi5PSG6hQP+GAaK6xdoR/Fv1/FNF
	 wLFVLGkdHydjGa06pyiKYcNtwm2FvGzca8Gf1qPKFcb0FAEM0tze36ElTT8Aq16ZQp
	 OxMIq8d9dc13u+E9TLQfb9C1jPD6vWHogPwUJmpRxiP6AAc+sFLPvjJJ1wMNZV86pa
	 0zv0vsN5ltx3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] PCI: rockchip-host: do not attempt 5.0 GT/s
 retraining
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <68f6353e3a2ea4914de36c42b6906e41282adad3.1781622998.git.geraldogabriel@gmail.com>
References: <68f6353e3a2ea4914de36c42b6906e41282adad3.1781622998.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:35:26 +0000
Message-Id: <20260616153527.87AA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Drop the 5.0 GT/s Link Speed retraining from Rockchip PCIe Root
> Complex Mode Operation, so called host driver.
>=20
> The reason is that Shawn Lin from Rockchip has reiterated that there
> may be danger of "catastrophic failure" in using their PCIe with
> 5.0GT/s speeds.
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
t.geraldogabriel@gmail.com?part=3D2

