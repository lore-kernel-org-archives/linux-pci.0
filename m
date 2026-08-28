Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06E448B95;
	Fri, 28 Aug 2026 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787923282; cv=none; b=s6oc7rGQqgzPyR9aylYjWgLtpt6NrOmimBUhv2eVUuJDAKFprDHIelL6f++etk31tqbkbbeTO6QdMZCw76mxBc/MfT1EW4ebwgWcPC8N2OX12ANXKDIUeatNICyJ233yK59yj+t5ahpaN6rDiDC8iiZuf8ghnJfqC882B2HOubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787923282; c=relaxed/simple;
	bh=LL8j/UhY4bJD9cR9M3EWLxaQPD7oDVkxVL67K6feq7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R9vzZIsiPRbTUORpshCsPJBlLfbMMpyP43O/RJxf/F81pY38J0zTNIux14NJeU4MpaY33yE7HzeLgYAq0qJi8bMcYiNAbfAv5vMLTosR0atWtGxH3QBw7ujM0iFnt3pE6j/DCo2yGo1vH/nlLGdxDGeUlQSvFdzEUW4gVZxwEek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn3o77X3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn3o77X3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54E01F000E9;
	Fri, 28 Aug 2026 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787923281;
	bh=LL8j/UhY4bJD9cR9M3EWLxaQPD7oDVkxVL67K6feq7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fn3o77X3Z5j1lIfycUzPWo3e13az41YbUlyvdXZ6I9XERVWXshoXRLhVLt9eSoPqe
	 HfuW923qJLgdeyQKHMp4jnfh5d3FhqlBdHFaSpOhbxnG8Qy9hKLCxAsFcQRkMZKmcn
	 mousmy/EdiTD6qHX2jqscua6a/byTT76DbKE8fFwOPfqFUnJQthoStAAczM9S1wvbO
	 U2CQ6pA68xlcPFeYh9qeBder2N7KGaz9TeUr5FCw53Q6U9X9KgujGzyWv3EsNkWScI
	 qBW67gLIZ3+cSElB2hg0ievDPVuS5rsbma3rUqR+qJi3EM07f9sZMYxw24TgCzOFCb
	 rI9XAHQmY+d0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is
 supported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Gorlas" <michal.gorlas@9elements.com>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260828-l1-conditional-imx-v3-1-6fbba62164d9@9elements.com>
References: <20260828-l1-conditional-imx-v3-1-6fbba62164d9@9elements.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 13:21:20 +0000
Message-Id: <20260828132120.B54E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> states for devicetree platforms"), ASPM states are force enabled
> on all devicetree platforms. This causes PCI devices on some i.MX SoCs
> (for e.g. i.MX 8M Plus Kontron SMARC eval carrier) to enter L1 even
> though CLKREQ# is not supported (and consequently supports-clkreq is
> not set in pcie controller node of their DT), which causes the device to
> never wake up from L1.
>=20
> Hence, disable L1 capability in the LNKCAP register if supports-clkreq
> is not set in the DT explicitly. For devices that set
> IMX_PCIE_FLAG_BROKEN_SUSPEND, disable L1 on resume as well, as these
> skip imx_pcie_host_init().
>=20
> Note, the logic here is very similar to 613f3255a35a, only difference
> is that leaving L0s enabled does not cause issues (at least
> I never encountered them myself when testing on the device) as its
> not dependent on CLKREQ# being physically there.
> Since there is already a way of specifying its presence in the DT,
> the driver should be aware and disable L1.
>=20
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for de=
vicetree platforms")
> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-l1-conditi=
onal-imx-v3-1-6fbba62164d9@9elements.com?part=3D1

