Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8933AFB01
	for <linux-pci@vger.kernel.org>; Sat,  4 Jul 2026 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783168180; cv=none; b=UHSAw9pCs+X6ua9A+xejagre8lY+JeWkqRJM9qmAyz/kzxsmoqs8X/q8ZPkAlmpa7U0c4oDC4YQcEVjUOXfjZ6oD8R9oYOsiB4K/zKZ9ciUKL/pviH/mzBRehcAFQEpDbV3bhh5niGpOUAUrBYzTwnuWD7mtdfKgt+dL+EEVq2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783168180; c=relaxed/simple;
	bh=7GayJt8HnFXkQaj70x57BPcQiXRwCENGPCsvjAhUh2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vy7WIC+I2JFbfeD3gMHnOO0sFrqaLqb3K58KwqxIpT2Brwvn4XmnWCUYTX/gNMjSH9d+ntlvfKqRQMvq8oN2+UWELEXnWcGXougqorWEIGpnWzLl2uJoZfgv3NgliJOP09VvYXLvzKuouuBygfupoHqmbt33qx2M3neAixB1mvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2ngcMPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2ngcMPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EAD1F000E9;
	Sat,  4 Jul 2026 12:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783168176;
	bh=rhuM03UI8bQprrhy6WfU8hzsCw4drj/DhHXDhXih5wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l2ngcMPX4xr954KfS4o0R89SgWsawFh9E9ui28FE3H4JP9PCo/2MWo4Wq0izda+YX
	 /jrgW+Mcn8l+4s9dKaAKSgwhYSVYuicXYdo4srRc/MaymgH2HVXIKipTY1sGCjE/TJ
	 Q1cbRh5DmWB66nhRGajRfn5j15ZcOT37HX0KNF9UrQqQmWeD3RyAvU/H1nUqCCYrFL
	 C5/8ukXGjnzZkamPD4D76BZ1tiQX6RQ312OrDBegOZRv8dQvGhXiIieDyoIyl/vR9Y
	 ll9njOmIKmEFz4rNhFgnw/7AKuNv3vpfpQ1oYMIsDoCWYfWfByrh3e5rShlhmpVsN8
	 C4AfKtGF9XNLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: spacemit: add missing MODULE_DEVICE_TABLE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260704122538.92830-1-pengpeng@iscas.ac.cn>
References: <20260704122538.92830-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 12:29:36 +0000
Message-Id: <20260704122936.82EAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
>=20
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
>=20
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704122538.9283=
0-1-pengpeng@iscas.ac.cn?part=3D1

