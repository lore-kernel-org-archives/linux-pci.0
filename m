Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A8426EC5;
	Wed,  1 Jul 2026 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903694; cv=none; b=Eg76D/WqbszhNngCHDflJ/NJ9DJBl0W1hohn60k4qeLVLeu/NQj7iVIn7R1/mXdLwh3oVqSNIp3oL+ropLZRJWbiYFnIqulPE0ee1KwF3Sh1ZpQTE/U+rf+SrRRCHlrYOHL2/swgWjxiz/vg9oIyzVlZot9ZRHY8qChUYP07YXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903694; c=relaxed/simple;
	bh=ryOZZdoSIg8P2ev+PBokRZ+7Q01YlY/faEWNt/pvbx0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gkX0JUPiIdFeOCv6vGBXdmItnWfH0TSO8b2ne4kznQOPQn8flFrZJgHKxB3qJdI9RQBORb2jT9Ts5+2FWY/dy4cgGAionLi6xg3shgPRByDfVVU3v1HTaJH4ygkcuEw1YTbGwSi9ysvyo6pWY2A4KppYNbZB53ZevVPtCLv+QLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYSKGnw4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYSKGnw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88E01F000E9;
	Wed,  1 Jul 2026 11:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782903693;
	bh=ryOZZdoSIg8P2ev+PBokRZ+7Q01YlY/faEWNt/pvbx0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dYSKGnw4RSXW3fdf3vU0PcDjGmRWXruWcBlchRRUdP7a3lR6O1O4Jcdmg2YlhPUOR
	 dqY0YlmdxOoe8cPa3MMjn3Ngd8Rj8tTfau/VZtsKAm3DFaYwu7EgHaxk0okL5fB6WW
	 dQYwkuRTWzVv8FNUgIVdeFaQaFHD/9rlITvVYa96N0qudZoetqaOu3tGIojzk9GtfS
	 g88aeo3UDKjzTzd1eiahLVR0KwT2QXe4NnCjTJ/n32wNlms4mO6Vp/09O74Wi5CtkY
	 V/znjfxqsBnx2JHa5FMiV/W+azeYZaZnm2+bOxdKGxsULFOYyYc/gRMCyv9BLHkSo9
	 xTu4QGwxx8blw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 5/7] arm64: dts: imx8mq-evk: Add power supply
 properties to Root Port node
Reply-To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260701105234.198987-6-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
 <20260701105234.198987-6-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:01:32 +0000
Message-Id: <20260701110132.D88E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> Add the power supply properties to the Root Port child nodes to support
> the new PCI pwrctrl framework.
>=20
> Legacy power supply properties are retained for backward compatibility
> with existing kernels. New device trees should specify power supplies at
> the Root Port level to utilize the pwrctrl framework.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701105234.1989=
87-1-sherry.sun@oss.nxp.com?part=3D5

