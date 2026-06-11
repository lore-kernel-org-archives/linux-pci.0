Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368B36A375
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208795; cv=none; b=c9SGH3oWPPgQgKIKKbGsUI/bdPJu0DjFcU6jmqi6JLHkyg7S/BkFCQyHeSxbyMP1csGQVrbcK2aADdyFCM25LsUw0tZzRm7nhSZ4kQ9yCwmVxB0fxssK440f5sztzhhDafBRewBHT/2Z9qCB/grpIv3xH5GBAqonZ4O/tK+cES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208795; c=relaxed/simple;
	bh=zHIffRj2jIJqYpl9gLeh1QaBNStYpt5XQozgoJrpnQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UOrKaTOQkoL5Y4dqsgO5zY/V++lmBExX8xXaEy7MewVo8XfeVA5cVblmqDy7UfpO3LlS53/cmWVataX20h+64nKyKDPKU5/3tKpfDnXNASBD7Ds1gezQgjnv4T48+HTx6RI9ps5w2B0hKk+jfLw875eXayKLmUAJqQDPOYI9BBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgKufIYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgKufIYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA801F00A3A;
	Thu, 11 Jun 2026 20:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208793;
	bh=zHIffRj2jIJqYpl9gLeh1QaBNStYpt5XQozgoJrpnQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WgKufIYa91pwLp3TEoekXp/gGGZyKb2djiY7q1rOzbPVadSFXD5NjH67PF6Vr34xo
	 z6dIN4eoW2bllQUEaIm9Hea6qsJakFk8V1FoVmSJoH+mn85/cxDkIIU/o1tI9ckQw1
	 vewDSRGiEwTdqLkjkXoErfUkL3PhEAlBJsBg1SR2ZS9vrCqrBLgkvjqeysl8TlI5RP
	 YwUGGnTxtch/837GJSjuDktxMHfmhoPdR5Aj0AWaDeaaoBJyilYQ2j6/rUCf8JdrYL
	 sjEIrndRMxdq0eJhgM4Iu1OV4UOQt/A4I1rte1Tq1f1s4VbDKEJEllU5sqG6sAU4KA
	 43reLfCcJZxXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] PCI: rockchip-host: do not attempt 5.0 GT/s
 retraining
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <fa9ed4fc6d4531a9216473151ddaebdb70398c20.1781207474.git.geraldogabriel@gmail.com>
References: <fa9ed4fc6d4531a9216473151ddaebdb70398c20.1781207474.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 20:13:13 +0000
Message-Id: <20260611201313.BFA801F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781207474.gi=
t.geraldogabriel@gmail.com?part=3D2

