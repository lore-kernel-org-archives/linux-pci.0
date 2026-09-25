Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0493806CA;
	Fri, 25 Sep 2026 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368453; cv=none; b=ZWTNRZ/KUmj6MFwsaTEtW9qBfWDpD6NLqoCzQ99Z1jKmg1cvlUC0EjlOO1n0Ee09r8rXJZtEAM0QfhqX1RK5Pzeup3Tf8HlBe/W8P7M9+KsgqiHadXFilDClG5FR5K1lcxnlIv+8Tt6NKEuDgvWt6EcUNifoTCD8tt2WLn0GMP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368453; c=relaxed/simple;
	bh=bnfaldVrCxoOcajNi/stgP3jq79zBFdofzyieDkwEMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rtt8HsCaaIDPeTWjxeyd9q+VnY41xBeQgqueqCm4gjpiZ1Ap9g4i0fwAG+NVy0/5VgqNrjjEx/K4feyizzTjzbccGXRONG5sSc4QnIjCqSG8Z3A6/EYXBE0cMu0nqTAM31bwMzq4rHzvc7QO3Vu0gyZ2BcDp/SEgx5k9BbFCLFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAdoT261; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAdoT261"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B291F000FF;
	Fri, 25 Sep 2026 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790368452;
	bh=cPj7hr49EAFMsHEqbkGgWGmd8TEdvpgifk7UcVy0xWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cAdoT261RlW1tETjUAav5od5E8LAar5pChYa/tcoeTS9I6RaoNm47Wyvj53F2syQ8
	 WsdZ+t3fLsVluTkBYxJnIV3fiKUc0x94og95D0mU6124tilcUJ1RVbWe5zWGCYvrj4
	 YR/qf9XEOcdSAy4kdSEYsQ3Ke2Aa1ovYywkiXkSkRCKPe7xKG25298nHsG0g4AjQiX
	 i6oy6eTrWsYqA6l7JksA1lLLJzI2Z1qTKLKoUazmMfKX9CVt7qEEtP2t//oTfoFv9Q
	 +oEdetaN0GP1RD0Z+wAhIY8FlbzMn70qfhCJ6E+P+1T0Pz7SJ3pBkpPIxwH824mzkE
	 peLtBh9muySnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: PCI: rcar-gen4-pci-ep: Fix reset-names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260925203039.110653-2-marek.vasut+renesas@mailbox.org>
References: <20260925203039.110653-1-marek.vasut+renesas@mailbox.org>
 <20260925203039.110653-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:34:11 +0000
Message-Id: <20260925203411.C0B291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Drop maxItems: from reset-names, since the entry already contains items: .
> Fixes the following warning detected by DT checker:
> "
> Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml: properties:r=
eset-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'pwr'}, {'co=
nst': 'core'}]} should not be valid under {'required': ['maxItems']}
>         hint: "maxItems" is not needed with an "items" list
>         from schema $id: http://devicetree.org/meta-schemas/items.yaml
> "
>=20
> Fixes: 173cc7417848 ("dt-bindings: PCI: rcar-gen4-pci-ep: Document Applic=
ation/Local register reset")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925203039.1106=
53-1-marek.vasut+renesas@mailbox.org?part=3D2

