Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16424441600;
	Tue, 22 Sep 2026 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067289; cv=none; b=jlogzv6OdcaSJdSxh4xFDd/IQX5l3ZGwb9V2XyYzWTOTL+vejFuS33GYVrwtH7b6CO1otKc/F0Y0C0IABTPIBCmaR9u2tX2CxrM1sV4Fgasg5dcJHXYOhaIY1NyC9eNBJXcHz51oQaAUKmnzGMxXQ0fKNGsozVmZ3wO86gwq+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067289; c=relaxed/simple;
	bh=Hf5xXc3OC0om7s+C/6GOHh3HvsjGM6oBC4Q+2Romi3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lReqGBDQ3IePq4MQQGMcX7hXNfi2KVrKqHYb4uttO2zzH4calpm85pa1R8d7XkyTQ7h7/fxVkVYqlsIe/aHDSgW1RC+0SRf6KLA0/vxPfAH5yRhp2z8/1Jl4AevYKx0RcVXTgKSgEaCY/dONKjTuCmhBAaaSMGCGXSWIykCHHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWMVZ1kx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWMVZ1kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3511F000FF;
	Tue, 22 Sep 2026 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067287;
	bh=Hf5xXc3OC0om7s+C/6GOHh3HvsjGM6oBC4Q+2Romi3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWMVZ1kxLRJfs17NbrAEiKAgKaetQh4bI/y3Nnw+81Jt4PZua7vHyJcRPrXL71QEf
	 6OEXZCR4GyyU4RMbpB2pX181HyGgUoZAj94q/KWHJoNZwgWneUsIPdYBewY5gsZT6k
	 7H0pf+dwfjTCXrChvoy8bolAFFJ3WT+/ASUIeqBWVP5nYfoydELzXRtcHAMtSfhrnV
	 8QuqGNLu88N97vxF4SAjqtXh0vPDaxuNpu0pLyyRR+GUsUA3W2QLcNq3l14uE/8to0
	 QTO5XyoZunTWW/7Uh0a0AT4Wx8saIHg50IJklla+ouDUk2V1eqSNMoEq1vXOTVBrbk
	 gqbxTO8f10NKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/15] cxl: Make HDM reset helpers available to
 built-in PCI code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260922083924.2451158-7-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:54:47 +0000
Message-Id: <20260922085447.8B3511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> PCI can be built in while CXL_BUS is modular, so PCI reset code cannot
> depend on helpers provided by the cxl_core module.
>=20
> Build the HDM resource helpers under CONFIG_CXL_RESET and restrict their
> exports to cxl_core.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D6

