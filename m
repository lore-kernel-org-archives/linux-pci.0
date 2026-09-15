Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD9341ABB;
	Tue, 15 Sep 2026 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496192; cv=none; b=qqla7qPKcUAZcJxAMYWT1FEmwqX3vqY0TD1GyGh/xU0w1pfOACQLAp3Vhqausny/DGgBP4Cf+UY9MEFZOiWfmLC/6JP2wqj4zr/tYNo7z0oKkqxDppcxcu0m0K+XdZ2pBi7d/AFQB3ZVrhiGBjPofMDEuFwo5B4g3epMOQnznXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496192; c=relaxed/simple;
	bh=Hf+oWHKG+uzcdkWUfzxe1vEYtOh+YYWW0d424E0u3qI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gDH973AyU3MecBUbLXKcPBDSaMKhXqbTSKgFlrcp5tB+qQQlgn0FJkAvcOha6qaWLEBSPfbOLsUg9JHbRrcr7ZYZP5CWDMrwVDwcX660eboPJP1zqflpuR9qOQV1b9tP42hdI3tbbnVCgcgyZNWE4PfvLfHEYyRDynrcINvD8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlYgbF5Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlYgbF5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4187B1F000FF;
	Tue, 15 Sep 2026 18:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789496190;
	bh=Hf+oWHKG+uzcdkWUfzxe1vEYtOh+YYWW0d424E0u3qI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DlYgbF5YmaWO5Cg5Tlp3de8bgcNkpmzCw/pMvMdtp+CAiIsF3oFAxOhRA1m20Rc7A
	 n+ZqX5S5Mf39L8bslj02uYkiPT0JF77VB6TW1sYX7bnKch3+40/CUP9zz9TQPXZ0fy
	 ZP49DFJfIWYTjW/y4IOCjbClQgE0dmYM9kCFZdXiSF5CKujWb/qAMGBLGe33PbDA8o
	 ROQJU+YEij53whpSTzYyBwU4yyXwcIymJ6+MFAr2q4jsbbcLiATrqocIFtJvn1YDlV
	 SsKJzJ7y4Ns11sNqY8uDYruce22BgLaXsIOC0aHQQcoeLa4tLdEu0Ro49mBMgJ1UbM
	 n4dfQk2X4ikZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: misc: introduce pci1179,0220.yaml
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260915181003.1633543-2-elder@riscstar.com>
References: <20260915181003.1633543-1-elder@riscstar.com>
 <20260915181003.1633543-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:16:29 +0000
Message-Id: <20260915181630.4187B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Define the binding for the Toshiba TC9564 PCI endpoint function device.
> The third downstream PCIe switch port within this chip has an embedded
> PCIe controller, and that implements two of these PCIe functions.
>=20
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915181003.1633=
543-1-elder@riscstar.com?part=3D1

