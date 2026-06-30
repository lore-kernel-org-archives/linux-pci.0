Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB323F39EF;
	Tue, 30 Jun 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816088; cv=none; b=qqJN/JncmAmC/TbJp/P2I0n9tOt26CDM5Bt/kBgeX8hxqB5q4L/CIfT+oD3QCBbCyKEYVhrzPuh4I66X4dqi/t2eC0tdVAzqG6PuNeIAoatWvtgmq9/uvm0s31+ZEFXqChZlvhXeMCnwyhPGbyxa4d+VsUg4Xt550E2hbHw4uG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816088; c=relaxed/simple;
	bh=2L1jOfu5YesDUETK0YRNmFyeIwX2aEFrVTujk8IWPnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vAtMDMoHGp8zoK44m8WQtbKIoposXxg/BhI87iYETdlsekdIV5bdeMZIevOVDbPDe36aR2S8stFhsZYj2gJ0Bw7AbM/iZFNXhp7o99oF6MN8AMObgqAzw7N6OcWJ1sSlZlLdAOtef+km+kGwzXQ/gmnlH3w6+2Ygjq8viaIYXOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIVGh0bt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIVGh0bt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A64F1F000E9;
	Tue, 30 Jun 2026 10:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816086;
	bh=2L1jOfu5YesDUETK0YRNmFyeIwX2aEFrVTujk8IWPnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DIVGh0bt9XtAMzDs6NVJdkuVLA32r0IQwbBzqJ7LqxByMKsojAzRGpVh2ch0I4sUp
	 lMxPQ00sA/Bp9jvK+UP/CIsarolU0pCsGXdSCGSVRepRQCuPgp9jTLOcsy5gegskwY
	 b9QfqW/ZRESZqWxZ/6wia9kJJLN3vJ9dZ8C5J1uztDh8i1NjBXHjqpwLL/cyOX0E10
	 i/Z/cGs52wl1u9NeColbhF1V+8UO85oWL5FDu3oNgGYS6d1hDEdWuEklYgK8pagk4V
	 RmRGWlbuuq39q5kFWKayNCqgqMgdrMPlAoZidO8SIx2G7HtqtAfAgHV0LQKnc1Bh4D
	 v8jgsq9nf22UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/8] driver core: fw_devlink: Introduce
 fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260630102804.413563-2-herve.codina@bootlin.com>
References: <20260630102804.413563-1-herve.codina@bootlin.com>
 <20260630102804.413563-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:41:25 +0000
Message-Id: <20260630104126.5A64F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Setting fwnode->dev is specific to fw_devlink.
>=20
> In order to avoid having a direct 'fwnode->dev =3D dev;' in several
> place in the kernel, introduce fw_devlink_set_device() helper to perform
> this operation.
>=20
> Having this helper allows to hide the fwnode devlink related stuff
> behind the helper.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630102804.4135=
63-1-herve.codina@bootlin.com?part=3D1

