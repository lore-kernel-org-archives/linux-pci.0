Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569D3FA5FE;
	Tue, 30 Jun 2026 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816930; cv=none; b=m6piotd5cQvMe9BHMvVBRzL0KERjqWutrnkaQpBUMYyRfWyVgi57x7xNsqlGiBjUJm1Iom3SiOmtzsxbUgDGqbxgAObi0u5Ax4GuG0uJB604s8BMldvHR/imUOesgVqa3cH+S9Nq6h6XKRsM9ipNz/LVdL+akTjl0RgLaNEfZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816930; c=relaxed/simple;
	bh=CkrHhrc7lLV8+xYO9JCwnG5qf4+zRm/XYvhIw4Nw2CU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BUDSpX4QpzyIb8wdiz7Mfuq1ihpPxk2sdJ4JvpIilNII4erg2fz5UChWHO22adXMfH3NEbwFvhWwpGsaZ0pf+8vXNxd2zjHaNj5lex1ekcZlJgemKCCpqZLxwxMnTMS1UKar6z13/yUg4/IJOYWdBrfKPM/M56KIUnye7RdvdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps+gejKz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps+gejKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07F21F00A3D;
	Tue, 30 Jun 2026 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816926;
	bh=CkrHhrc7lLV8+xYO9JCwnG5qf4+zRm/XYvhIw4Nw2CU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ps+gejKz0I8W08xk6Ge/4XDeEV0hwSSDJvsMtN2kRC+Mzo16lzfEVxbg/0IWwYJ3M
	 9Owrvr7sPs2SvIbpBr/B6A6Ha4+GKYDVHgvx9t7c8Y+s1EPzsXjMar/1NIX78GFeYY
	 BNqm/WMxhRCXrEpkIRwYJKey1D9WZeXvOD8AgwLI0rWwATyPH8UhoA55CguGF2t3nD
	 8mYmVCrb7AISo+0woS8+MpwraupEXAnSYg9ydnRR4OOyKwahP28EWKeGBaj6kP1mGY
	 51OwwIritbJ6ddGMrBLAwvYjOzC+TKhRPLPV3CFZFgwBwURCyzezu5POPFlNI8Gl4Q
	 r9+XmW4iyBswA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/8] cxl/test: Use device_set_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260630102804.413563-5-herve.codina@bootlin.com>
References: <20260630102804.413563-1-herve.codina@bootlin.com>
 <20260630102804.413563-5-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:55:25 +0000
Message-Id: <20260630105525.D07F21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly dev->fwnode.
>=20
> Use the dedicated helper to perform this operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630102804.4135=
63-1-herve.codina@bootlin.com?part=3D4

