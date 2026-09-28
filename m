Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D9336897;
	Mon, 28 Sep 2026 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559713; cv=none; b=iBib7S+Qfn8ESO1EWgMmYJ6M+Zd2t3ZoOhLmCXYLUhDOFluQMrK7pKSDIQZlxR99mlmR+wmcFr1xK+d5Kke1ASDjjcBzWxpwGNlsUpUePZo6bAT35uQfLQ2AojyFmlUvfSrw+2fxK8YaXHmC0GAn2xKtgPJmkUNmsA9i9F0Vmpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559713; c=relaxed/simple;
	bh=J/Y9/oHd/TKhRjBWKgaHynT5Cix9ywVo8hcGVD90oz4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g8l/8Rxh0vm+OxFNAK5y08TQZG9/m6frNH39nvFPBnE3ODq3MSHwSteS5Zz3CT8DRwbrmgL2nml57uU/E2AFbttRO2iNlw9nn1cKDmTRsAcuUjHFfc/LC9smhU6nx51mm011zUKJojQbJBy0d9f+zehjZRnM92GBGb5C0yTAzw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM+qbOfc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM+qbOfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E4A1F000FF;
	Mon, 28 Sep 2026 01:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559711;
	bh=J/Y9/oHd/TKhRjBWKgaHynT5Cix9ywVo8hcGVD90oz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GM+qbOfcnXy3xUAIPtuzWkyMs1dkuqYJP4NPmUl7ZGJyPoiMXvx9ipkYzoGZg8ihq
	 VLAqX0HTKWPT8ERAv0sf3AUiD8D/lsn3AkDTHj40P3Snro6AKfyfnCh/aj8Ky+S5it
	 PFw8XcZYDJCbyOk0L4m46IrfY+IsSxjtjASbDTJijL6qBzkGr/ty/QmeCuxcO5GheX
	 4Fv34ZLc5NdTYAoiJ7olEi0Gwua3nJXv7ViLqSh/QZgu23yM/3k54HPeGbwSdJfY0R
	 N6eeCU2ux4eSMt2Svdu+JNez5eLo6x3CC1BjKOT1BHKu/eLeaacaTBQWaXtLnygqY6
	 WGKD6eN/UfO3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/22] virt: coco: change tsm_register() to use a
 const struct
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net, linux-pci@vger.kernel.org
In-Reply-To: <20260928011123.450800-2-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:41:51 +0000
Message-Id: <20260928014151.63E4A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> The tsm_register() function takes a struct pci_tsm_ops *ops argument.
> This eventually is stored in struct tsm_dev as a const, so we should
> just change the tsm_register() register function argument to be a const.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D1

