Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74042495041;
	Thu,  3 Sep 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442745; cv=none; b=kMacRWtIpQQooEmkdccamxC0tA+/4Mrxt/+2FJHuNhrgT8Dn0SER10Y0LzUv4jo9IB42p9tUJiIMkflvgw+3R49cjsrjXpTMvGT+okAOUJ/Bf4fh4DxlCAEH3stn5mntiSIfvhoDntQNyAFXFd69zmqRy52bxT1v7QpaOuUWy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442745; c=relaxed/simple;
	bh=t1+ppZMHHFq0RKj+u9/9Je6aZCtCRhx2zUY7tZ7tZ2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N6MNYJ/AUT/HfDFHiLQj4k7O31v0sE0gqXroCNYjTN5tp+lhp+s6z7aJAol1v/ZCGR4TCLv/xMXIBusiscDZUJVH/ShrFC6h5iCl3icEaTJwYf+zcWD4qYWrsPHYmFW16RY3uAne9HnwHlQ2UliPikRQ51dcgiaZSWRxaHMOtS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6QqurAx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6QqurAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0F81F000E9;
	Thu,  3 Sep 2026 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442717;
	bh=x8YMNxhSiovj2JrzXyTsCtTPqqn25O9GASHtEDSwIAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k6QqurAxV0NGHTQhIMZUrZimnceraf6iADv3dSa0Zk/8wFcjxQEVBsL8BfUD1afu0
	 bX/+aefbR/8bal3ZMRNLAtzys5jWX5TsT9F4z1o3K72/nHvCrIUIDE8X9yAF8TFD1R
	 gykdaW9tGrMMdyX3Ks3v1vrpaTlHKQ9KIrFUMW/bz30C349SPzdmCfYSby5LIFU7zb
	 wsD30yh+iMEibMPPdNP6rrrtzIwPiiZLUTL37VExIxxUjhUE6A8Yo+DfIwsVRvPx9O
	 1uqNNC+fY+s8Ik+LrR8IKyWE5icna2EMCw0oHc1S1Lj9lhkUGi6UHzw/mcE0/rPSfY
	 Pe3YxnknzI2RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: renesas,r9a08g045s33-pcie:
 Document RZ/G3L SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Biju Das" <biju.das.jz@bp.renesas.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260903133320.144245-2-biju.das.jz@bp.renesas.com>
References: <20260903133320.144245-1-biju.das.jz@bp.renesas.com>
 <20260903133320.144245-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:38:37 +0000
Message-Id: <20260903133837.8E0F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Extend the existing device tree bindings for Renesas RZ/G3S PCIe
> controller to include support for the RZ/G3L (renesas,r9a08g046-pcie)
> PCIe controller. The RZ/G3L PCIe controller is similar to RZ/G3S but has
> some key differences:
>      - Has 3 clocks compared to 2 on other SoCs.
>      - Has a different set of reset signals
>=20
> Add device tree bindings for renesas,r9a08g046-pcie compatible IPs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903133320.1442=
45-1-biju.das.jz@bp.renesas.com?part=3D1

