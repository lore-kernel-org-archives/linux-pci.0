Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744037702B;
	Thu, 16 Jul 2026 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221980; cv=none; b=GZOY7Bx7XDxT7JJemhAvKud+5Aet4T0RTcxct5pgVmmmwNMtPONsY0IleLthh6N+P8TgPiJyi39ZEAyn9inDb7DbLLzMBgPpkzdfusz5tNXYuvZYz/V9q+FGVAwIWTFh3KLlhL7HV0iIClAgFNY7WasGgctSQ8mf0vl0RhWB6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221980; c=relaxed/simple;
	bh=XAlxDx936I976N42X41klthEE2l7yBEU9890w2Bhxys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YfiyajP9RwUuN1kasFKQcEfQmf0l8065r6Q3DbJGRKDM6WLjAU7wrnYi52WI3S98Ch8tTupCJAgvtBJWrCPeeNi0JBUmH0i6p0HLahh67+cmcl1sljg51rfQqvPLKvsGCUc/oByBen+coST13xA+WvlkAWoOys5FFMATM2YXIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwrl+Cq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwrl+Cq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9F71F000E9;
	Thu, 16 Jul 2026 17:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784221979;
	bh=XAlxDx936I976N42X41klthEE2l7yBEU9890w2Bhxys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iwrl+Cq9OsqNZkqaRE4gRAWyxudbjtaV/SkOOyuXquNbGSnLCY8es4vXu4VnpjdgR
	 kmTmUKDK9HHrPoe2kfa/ncWfXrsHOsKXVgNA2btqSviEAX+0DhgQ+aiJbUlib2DqlD
	 VVAbxigjougmlUsS84Q+x6vF9FzbdtQADJc5UKvG+d7RFCLS/dqi4UXO7XNd/cK+By
	 tnpMvgu9o54Id2FyHK9OFZmOx2vNEium5IQmumBO9m5lqyam+0whhC1xj9Fso8U2yU
	 kFqogYMZDIfwGYr4jCBBLMivEnF6X3ZoouyvwsIsHVzLkW375Xi5dbZw3toZ/sQQEB
	 vESXCgVPWYjCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/6] dt-bindings: pci: tegra264: Switch to PCIe root
 port bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260716-tegra264-pcie-v8-2-23e51589229b@nvidia.com>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
 <20260716-tegra264-pcie-v8-2-23e51589229b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 17:12:58 +0000
Message-Id: <20260716171259.4A9F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> Switch to using the PCIe root port bindings in preparation for using the
> standard WAKE# handling.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-tegra264-p=
cie-v8-0-23e51589229b@nvidia.com?part=3D2

