Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159804A2A78
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402194; cv=none; b=eRGQUDxug1Q5p7ReRHv1VcNWUIDw9hLbhPKzglBIKK2MtOxqAhr8fKCrkL2SJHRKZOoM//3w+gmzxLWTk+j/rUAwHdm2qhlMSYHdoE3Nx97VDSUzvlTdZHZv0zm3UILjFgjI/r7zOwBpTyBPYtUvYPtbuhgmb+kfR/uFjOfpe3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402194; c=relaxed/simple;
	bh=14Sro0/v/PlXh7y89elV/FUWncCvflC6n4DcjRHuo84=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WpFMbHRbxb225X0SiQh4kRW5gseZ7QKx8nhh339bm8f5c9MTtlIzQRrMND5uM44jP/N1eu+wAT26Kkp1g9aic0lObTgqMLI4QeqMLPhwzICUtN4ay6F14IPM03MUEYnLgR2bldFjd3U66kJ/Uw1H3wGjUn3AcO2K1H2WPP5ZlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el2L8NWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el2L8NWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ADB1F000C4;
	Mon, 19 Oct 2026 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792402193;
	bh=14Sro0/v/PlXh7y89elV/FUWncCvflC6n4DcjRHuo84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=el2L8NWooWXmAjS7iYuT1y6Ffhy5hUISRklb/39kvfw+n+BZIIQhdNmxFrDWreMm1
	 cs1cSmrdF9MgMbGrDtw+yB5vtt8SX0CNo0+amrbGBuTtfM2aYiDO5bb3zoWGHtXCXS
	 9G4/B5QisRQZsPj1oMVB0GJzs2lVQireXxEredei8L0bqFjy5J79NS9Z4oiRxTikln
	 gMTyfGKbQqF3lNMPCHVQwCYtC/f9243pOU7ixq4ff9IsU+4hXHUhC7pzPpCSSRTLM0
	 OOYK5mkzDIEB06DtA3f4rcMGyllLCgdZCIBUihcaZqr2Rxfzk24pb60TbGHGgKj9R2
	 mtKwmD8q0GGTA==
Message-ID: <sashiko-outbox-176908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: PCI: qcom-ep: Add QCS8300
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019-monaco_ep-v2-2-852cb9f5d012@oss.qualcomm.com>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
 <20261019-monaco_ep-v2-2-852cb9f5d012@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:29:53 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The QCS8300 PCIe Endpoint controller is compatible with the SA8775P
> PCIe Endpoint controller and uses the same programming model. Document
> the QCS8300 compatible string and its fallback to the SA8775P
> compatible.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-monaco_ep-=
v2-0-852cb9f5d012@oss.qualcomm.com?part=3D2

