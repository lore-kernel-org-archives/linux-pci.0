Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85749F10E
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549892; cv=none; b=FUOcxBRtP2RLoQ9nJ2Tq+WtjwuBcJ0qJOvGiBscuzhvGyeTML+oXqTU0c7Q1NJWxFsvLwT9ibYV7B43EKO7nO/SwmUDEcol/j2eV6B6TCI3xfdBfRMzQmf7E9gBCkpwVDrE42YEKQNlRXvjqa3o8HPLzOmF2OjGXSGLVQ4UxGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549892; c=relaxed/simple;
	bh=AsEdeL+5g42P8u9lgaB+5iejCEwr/ZqbjxIDrr89P+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pt2wJUvtHpnX0w6vvwbaY3z/rXg5iYWQpiIZ822Kz6+hlqb1H5oBlLs47xl1OvbTX3mqeNlGG2Wg+FgtLQCPtMqDrPID0/v7B1bDnJgRvkXQ0MIAKSzR6Cvt+FZql/jtpiUh6LcrdXyv081I+dhuk++XpIf+4fy3QUUNtN/O1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq+QBpL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq+QBpL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A511F000FF;
	Wed, 16 Sep 2026 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789549870;
	bh=AsEdeL+5g42P8u9lgaB+5iejCEwr/ZqbjxIDrr89P+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lq+QBpL9raN9T1A9NDQzskc/km1vkZvIunyUBh34k1hODB1vx+HyOeqYs/0DWArPV
	 Zl145CgmyS9iX7ByglvY0nJnJ5lnoMEuVTd7Yw7U2eZ1f/O4NWkosbPsSZ2DZ4b2DN
	 yb0tX4U9kBDi1rJIOR15sXWUcSFqinfpMV9xgZlaJAMbyPenXt4cVEE3oNI96RjKCA
	 Dlhlv4TZaEOspbBcaLJke10Ahk+39xVw2lhNPP0989b4Ebha1+V1fBtEGGVC243wzu
	 ARakuhu+7X+qw8C1apml2FTZjtfOfZ7aZ9BancfNdtrFfhmsxN2cAmrRuRQkRW63zP
	 +J8IIVFzKUSKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: deinitialize endpoint on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260916090126.2963064-1-lgs201920130244@gmail.com>
References: <20260916090126.2963064-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 09:11:10 +0000
Message-Id: <20260916091110.A6A511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> qcom_pcie_ep_probe() initializes the DesignWare PCIe endpoint with
> dw_pcie_ep_init(). The probe failure paths call dw_pcie_ep_deinit() to
> release the corresponding endpoint resources, but the remove path does
> not perform the matching teardown after a successful probe.
>=20
> As a result, resources initialized by the DesignWare endpoint core can
> remain allocated when the endpoint controller is removed.
>=20
> Notify endpoint functions about EPC deinitialization and call
> dw_pcie_ep_deinit() before disabling the controller resources. Keep the
> existing early return when the link is already disabled since Qualcomm
> endpoint controllers depend on the host refclk for hardware cleanup.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller=
 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916090126.2963=
064-1-lgs201920130244@gmail.com?part=3D1

