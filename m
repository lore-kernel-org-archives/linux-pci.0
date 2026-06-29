Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C93E835F;
	Mon, 29 Jun 2026 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720442; cv=none; b=tTpMlSEbGLfktNsvLQVubGM1uE94XViANpGoaWUXMawLONfxBJWzMLI9S21aR3mDyUMW0+tBbHFyBcpQf8nmccKrsoWFQCz/u+JDUf5xUucalO7H2A1i2irGuvqWynTrTUPPlOduzea+ZMcafQ2u7Ho8bQ76jzSbHCr11WvqkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720442; c=relaxed/simple;
	bh=DPSjSixCvXazn9e4N96cwlAyC3ntFKdsaKypwHJoiZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nXIO0suGk1vSvDgojl0aqrAKTByPvUn503X8okvpX4uWMmYK6C2Zyb3N2Fca/DRr6583j7FvyiobPB9VDtbFbO4/rxyjnqUvvNRVmFE3hMlJwk9uuNalroDrGOmnAa5gvY/TheUBjm2tEPIAiIjuohJacCJpZanxwXkD++VT/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlFV+3tn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlFV+3tn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0B11F000E9;
	Mon, 29 Jun 2026 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782720437;
	bh=DPSjSixCvXazn9e4N96cwlAyC3ntFKdsaKypwHJoiZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YlFV+3tnEk6VoHcFLUbqyh93MsXsJ5Rju5LqSYzN+5T29sPQs56WhkNWnPjcFdH0Q
	 6OuMujCe0JAmDm7GxPHHuYDUxqd3ui/I2WPFj1WVfhii8HXdYmPrxeQOeMt2I6eMa/
	 bt94tLsFLn/Il6UtR8YVi3Ea8TvFuR7p+9aQQT9cMC3igEsaHslDFWI3d0taX8Breh
	 wD0mut8k7dgq29h8b/Q1gokUefeh8F5wY7IcOI03t8G1tkFrMW+ahnUoTxI7hIm2WM
	 neAE7T0Fv2rkWV/j8iQskXsHGHbQBWezNIcGAklqCD19wwrXmCyirxu6QxOYSDBFgY
	 KLFzZGo0uFuyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pci: ultrarisc: add required DP1000
 PCIe clocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Wang via B4 Relay" <devnull+wangjia.ultrarisc.com@kernel.org>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260629-ultrarisc-pci-clk-v1-1-5ea3308fdab3@ultrarisc.com>
References: <20260629-ultrarisc-pci-clk-v1-0-5ea3308fdab3@ultrarisc.com>
 <20260629-ultrarisc-pci-clk-v1-1-5ea3308fdab3@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 08:07:16 +0000
Message-Id: <20260629080717.0A0B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jia Wang <wangjia@ultrarisc.com>
>=20
> Require the DP1000 PCIe controller nodes to provide clocks and
> clock-names, using the standard DesignWare clock names "core",
> "dbi", and "aux".
>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-ultrarisc-=
pci-clk-v1-0-5ea3308fdab3@ultrarisc.com?part=3D1

