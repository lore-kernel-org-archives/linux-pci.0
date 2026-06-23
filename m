Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009601C5F13;
	Tue, 23 Jun 2026 05:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191001; cv=none; b=kJrebrqzjOh7z2CX/6EjT8741KH55M8tt+ANc12iC0LqWMnTKJSH4bfCPkux24jnVYdlPE7nMKT3Xa+1hp3+tlbONGmB+qrjhSMghIrqVvmerXaBMD8XqssQ6kZubxU25V1G7mDuGWM7qrQM2iHWY4Al/WZ4cc2z0Cu0yn8KH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191001; c=relaxed/simple;
	bh=Ervv08aQudxWdtfaZNKUK6UwB3Ou+4+0FTiMVEVmUZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UqOAf5/anmhWkFLT39SO+kqBRDD+V1jA/Mdj8JhDD9CDiDlQmKZrodyk9G0B+TMjFrrCAJT5/6eBImXKQLi1PzlokrEqdADdwPnH1SBjpuPZvSOhPrXcYJkFoGiOETe1Ls9MlyKUochUD5HVnPXJBcG3RQUsIwp6EfLvx2H8fXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc3CsTCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc3CsTCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FBF1F000E9;
	Tue, 23 Jun 2026 05:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191000;
	bh=Ervv08aQudxWdtfaZNKUK6UwB3Ou+4+0FTiMVEVmUZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fc3CsTCeoShr5QmfU0/BHsEM6XeKXdiezHmC3WEaL141x4+JTySV7oFxOyBbJQwox
	 SfRzETpXHeMN4YRfkaSeFnco84m544BXeuzKOhx6yzi4S5YDg+xI79fZ5I2d9UnVH7
	 APbLd2pFGxl0rrG5Fae1xl2/cG6hKd6FeQXLqQ3AQq+854hbfbG7IkiWelM2GXAbPr
	 9pV7m98oBOrMBEOU11D1iAwDaFh8eKAga/GL9KGgnrc1kZnCvfCCCpM/Ur18+6w5RX
	 721VX3F2Z8RxIrbqmsr5BL7M/lRWnnVWhtqOLTJbBU96rsxg482xPJiQ15dmlHVWs1
	 2o1YENVZ29cNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/21] X.509: Make certificate parser public
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260623045406.2589547-5-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:03:20 +0000
Message-Id: <20260623050320.62FBF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lukas Wunner <lukas@wunner.de>
>=20
> The upcoming support for PCI device authentication with CMA-SPDM
> (PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
> in X.509 certificates.
>=20
> High-level functions for X.509 parsing such as key_create_or_update()
> throw away the internal, low-level struct x509_certificate after
> extracting the struct public_key and public_key_signature from it.
> The Subject Alternative Name is thus inaccessible when using those
> functions.
>=20
> Afford CMA-SPDM access to the Subject Alternative Name by making struct
> x509_certificate public, together with the functions for parsing an
> X.509 certificate into such a struct and freeing such a struct.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D4

