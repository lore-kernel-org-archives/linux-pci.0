Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DFE1F8723;
	Mon, 28 Sep 2026 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603706; cv=none; b=KgooLTCOecP5ulA4+eB92UCwKDk+qCihxCfOlrBNH5wC3Q/8Y+iib2KuCn0WrL9Ja6275ozV3BeqzNYXsU8NRITs6+39aNItN2DUWb8kTEXMH68HKYWp9OsyWmBtwfFHTIRwJwKK4bOMht+hhCBObcLhm5Wvl2LRrHbqAF4EoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603706; c=relaxed/simple;
	bh=YwByXUiGMAklKOA7Zjz8b+cHHloc/mFDlEje6fe+QZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MzXZygGnb3lFcS6xf67+hBdIjBbKY/0PgtdiDuGKoRObP+n3YbRNRot0s9zVvUK/72WE8EZF+anEIipDKBgz4xyKDnZShRFPSMzQqckX2fgw1eig8s+nso6Lo4NtsdO7s1IDoqLrs3/gQ7zZuANBij9W+ESoYbQ60VNnFCNYZuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOw4exZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOw4exZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18DA1F000FF;
	Mon, 28 Sep 2026 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790603705;
	bh=//FSE1BSumy4RN7mFbu3/W3sCieDFRRAwnq0FJ08uDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UOw4exZxPIy7QDvopnruO77NAj4N7kVq4LbhLQD8MLUKNMaQSxup6s6dsoa+iWSGB
	 iO44e/q8OWtvsbwNqsMA98WrYeorlE+uEKAMQBmm80Jz4wEsdqevjdOCXvDUpM03j7
	 C7XeJL4D67vnMAxDRBq300uTQRXhOKp2wiups+qHIkvFKqq+gvl/r27DPb/e/36VBC
	 befUQR8j2MAHH2o32L834qbXgzLoZgDh1D6NOYtT58Jg4/e3VuUmPibEHQnXLrxPAT
	 yUfAz+zf/ghBav5jTdZH0z0pxus7Lzu4OjTosQEaLCSbMyGDgXwHCd4I9yLW6l39pA
	 cWE8GuKBfvmYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: layerscape: async probe by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Jardin" <vjardin@free.fr>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
References: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:55:04 +0000
Message-Id: <20260928135504.E18DA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Vincent Jardin <vjardin@free.fr>
>=20
> dw_pcie_wait_for_link() polls for up to
>   PCIE_LINK_WAIT_MAX_RETRIES x PCIE_LINK_WAIT_SLEEP_MS (10 x 90 ms)
> per controller.
>=20
> The controllers are probed one after the other, so, it leads to slow
> boot time.
>=20
> On an LX2160A board with 4 enabled controllers and no link on any
> of them, ls_pcie_driver_init took almost 4s.
>=20
> Probing the 4 in parallel allows to have it down to 1s.
>=20
> The controllers are independent, other DWC based drivers are already
> using async probing such as qcom, imx6, s32g, rcar-gen4 or stm32.
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-for-upstre=
am-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr?part=3D1

