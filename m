Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E5D3B27C9
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115982; cv=none; b=pevwGBs26PPWwNeuzGz1IPyP6Uq6TOE6o7ZGqv496LNuaJa3nyXPe5Hdt5FxPmxXwTa2pwGWdndHiKa2YM4orZBEe4TmL54jhWh39O5CZ4w2MeaXMj5tiDnKEp3FSK7xQG+DmhhPwuAwuLFQDoIeyidzNUtgQaKbOMoMRN9jqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115982; c=relaxed/simple;
	bh=3WhY3bnXpCfVAogGFubGgRHiRT/7GD4l05NryucQn3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DcegGRSYpptE7F7mZYtJ+2JFGlynE2+O2wW+iK88ZZL7JFDdr8OBWpXRqAbxKiG/yQEzi/a1z0o8ONL2xWbpjnuRFwbMPJtny67WyXd0WCD6uppQcdMy228ujdheR1GfJ1Dn9MFFTRt5Lma/ytQBV64YF/EsRqUsGtvYvv2lRMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDeVhAHS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDeVhAHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609721F000FF;
	Sun,  4 Oct 2026 12:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791115980;
	bh=3WhY3bnXpCfVAogGFubGgRHiRT/7GD4l05NryucQn3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDeVhAHSsrEt0JJmC10LijtCGcX8ces98H5tK1qJd3TJivW060d83GOsprjNwsJvT
	 Tq30aIU4zgvNvwGOtB6MiMp5lkS0GsvIAQB29fsItROv4ZCzZXxoIPo0PbsDCxa19/
	 m9UOWZG7mgYMpeoLgUVZO1E6h2iQ8JxwiCc39JgPr2MTaOCDpe9AI902OB8GCj9PEs
	 0mLUkos4VdO6V/TYZ4xJdadLcOAnjoTxPy/hLaBm/k2SIBMrMKKTkLDZlXqUeQ0k+j
	 WaWVY942ngvbzvzC9n4kBSKo1rENqTf/aEoGXzFgdbAj3HNnvluM68EXUBGwfj6Uny
	 DI1Tt2GdQJvPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] rust: pci: add vtable attribute to pci::Driver
 trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20261004120732.1045629-3-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
 <20261004120732.1045629-3-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:12:59 +0000
Message-Id: <20261004121300.609721F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Peter Colberg <peter@colberg.org>
>=20
> Add the #[vtable] attribute to pci::Driver and its implementations to
> support the optional sriov_enable() and sriov_disable() callbacks
> introduced later in this series.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004120732.1045=
629-1-zhiw@nvidia.com?part=3D2

