Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76853D5C2A;
	Fri, 18 Sep 2026 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702032; cv=none; b=m4/k85nujjzmIddM1wT0xiSaVhaxNheY0m1lqZ15/HEry0P9mETrbqVuWaSB9yKUELuHBCU+aCQipP9hP67z6ZSeEakm+M1Oeu1ZD2fr9fqD/p5tEQzzJNNyM8uyIkU3nqsMcBLxTRw5ek6ZA1HiIJnFsqXIZ15y/DRyRw9f6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702032; c=relaxed/simple;
	bh=IZzVZkmpf6YGNSrZJp/GNzh4MWcArBSwK59OM2gA3cE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h7X38B91i4P7gA+PB62r8aqVnFjlXwBMpxXaRaU2fPlxz0CWoPudkkofVjvCR3b1KmfhlMKZalXuw4+MzbzlF6C4aq+B55Y/LHuj9cJMIX5YCiVsDw/i94NTIwE+lukWpxAb3kVDJuPt6IZrRblGc9zfQVdQiW107NlRwNpEj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFvkdYAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFvkdYAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23981F000FF;
	Fri, 18 Sep 2026 03:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789702030;
	bh=IZzVZkmpf6YGNSrZJp/GNzh4MWcArBSwK59OM2gA3cE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LFvkdYAzEwqe1WBdjbeXHUdWJB4zjnC1Q+7BF2gPqD/r5HIS8bbBBO5RN+h0oSxTs
	 aEKp+EPAGUEciaynlp239k8xp7U2vhy8+VWmWq2jT+kS4WB4m4yZfDcsLvkIVDykYl
	 sI41972G7GuXmhUpExnDZj9pNL9q+KPEOLvYfYCScDAPD2rCfFDDo6zBzradimECgh
	 RuZgkPP6e2qXGHP1odgYXXC7YpQu5Q1Qpaszb1kwVaaYuto7Z7t3duplAOYb4ldRYK
	 8+JlQD2UFQ4tHBrlTQx0wMwV0yTq83g7b3L9OxxC3nlOr6B+KmUIBCt/gC2OnP9pyg
	 VRQ/QVVdo7BLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] arm64: dts: renesas: r8a779f0: Describe the PCIe
 AER interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260918032038.2216471-12-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-12-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:27:09 +0000
Message-Id: <20260918032709.D23981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe controllers report Root Port AER notifications through
> intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
> respectively, separately from the integrated MSI receiver interrupts.
> Describe these interrupts with the "aer" name so the controller driver
> can use them for Root Port error reporting.
>=20
> Append the new interrupts to preserve the existing interrupt indices.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032038.2216=
471-1-den@valinux.co.jp?part=3D11

