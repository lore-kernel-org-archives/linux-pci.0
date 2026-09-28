Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02E1C861D;
	Mon, 28 Sep 2026 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559571; cv=none; b=c3QzsAUhVvgX1J6Oaxgp2ARVcHO58WjU1mtIi93c06p9c5bIzIV3hrJU5dTNvh4nX1zDRk9aovoOZt59w6m7195LoDorc8GL/tIRfQgA2wAWsJX0fDBd0WY751l9NrMOxZ/0uQW0gqEXVg0JZdv/FFftRvynFSxThF+nKz1Tzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559571; c=relaxed/simple;
	bh=aMkY9ARimuqPaML2iCJrSTHEuXkDTUHqNkoGbhkfAUw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Od/iHV7pwq34Mqsc5eYI6xFY4qiYjpkjQWC7zgybhmwMs3JkOl3mQkiJWP9DP81Dj2vYQd16PJui37Wnoe04zkLXjITVJjPXVyxxjN3OrAqMqKLRuwE/CX0yFdBQjyU4vlPbNq7nWPXOXSutXfKmzxxdotUr2CZMn9yDczKeRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAQcF1yT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAQcF1yT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A337A1F000FF;
	Mon, 28 Sep 2026 01:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559570;
	bh=aMkY9ARimuqPaML2iCJrSTHEuXkDTUHqNkoGbhkfAUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lAQcF1yTR4Bu90jUDNndmJ9eEqowLx5mKvhOBx7YUsJxfWOw+FsnbhmFxi7pYNV9E
	 qwZljQuDOZO2UubOLTxvMQbXrDMLX/DYB4Wgv9/uOdkYsQ+CEMCAUcRPceE588neDv
	 9hM/eN0YZSDDQ3D5dawP1dXIXqfHy/xzyeGimS6bCECUIuuHrhREYaEUbyKdbunKA5
	 POFjo6scUY2+C4srF61Zl5/3y1HyTkxjrlgBWt7mTbVI3LbtIKwOiC1eCbMEF8aM7i
	 cv2+XHSIBQnW2pHXyhtD4a1V6F2UZI9scagyEDwVXxpnxfHymPxRsrj2+tW+/Pf93M
	 bCjcYQEGbGMTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/22] X.509: Parse Subject Alternative Name in
 certificates
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20260928011123.450800-7-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:39:29 +0000
Message-Id: <20260928013929.A337A1F000FF@smtp.kernel.org>
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
> Store a pointer to the Subject Alternative Name upon parsing for
> consumption by CMA-SPDM.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D6

