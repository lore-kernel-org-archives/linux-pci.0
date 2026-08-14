Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4F3CF976;
	Fri, 14 Aug 2026 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722288; cv=none; b=otrKvvdWerBE2LCJulM02dKB/LGCXW45FuGkdrEPss06jh4Ua4IUXWkbnN2+KVIPGbQG+MPaSywcUGQt4eFo+K7sJaDY1imlT6oheWSlUiBWZmJ58NF3R6tCDdKxm+CpIZ1Vy6YSytqdWsk9nulCLqbd3Tj6/eQ8ZRnnPcbpjwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722288; c=relaxed/simple;
	bh=Kka3amGyNuGFimuZzDfVcMXhcgkz2Qdyo0LQnvQDC8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ejf8JX3NrW6fMaoLRTFEujlriU5zz5VCIJ05OjG9l+Jktvu67xEL4bTgthRevtFs+PjVaunVwKm14xE0aEMbRmchmYQ9w9pHj6aWcBHIz/jQrtuhSx0YP6IiQ9h5fcamQCnd1sizAOvXzCfa0QCjs8BwNfu8BX2ULK3e8zQf+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHlyJV2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHlyJV2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C64A1F000E9;
	Fri, 14 Aug 2026 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786722286;
	bh=Kka3amGyNuGFimuZzDfVcMXhcgkz2Qdyo0LQnvQDC8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bHlyJV2NXkTaVKIGpHbBvOU1y+E4nGz5fjYB7Xmu+OSfScNdK4U9Dt2IHX4UowLHp
	 TrlTIKvt9j51yoA74yhaPG1fymMoOrtWtzssrEsOGT3ID/VygdLiiNXiU3GL4kn2fL
	 dkeHDbeEhbRAejN3vE8a/uZW3nlg/JmohG5A8uLWG8BYzm52bC8eGnIq8dNo8F+g80
	 kUvM4kD8JpBu0XnRblMrXBi8uZ1WDi3+bj8leQA9r5jWDeLYadIi6w6MYzsYPREgec
	 Ux9wKaJ0QcNRC4z8iNM8bpkgRqRVlinnpnmiaYIGrB9J7/NdL0LqpxA8rC9HUGkfZQ
	 LKEBVVSbsOxQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/5] dt-bindings: pci: tegra264: Switch to PCIe root
 port bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260814-tegra264-pcie-v10-2-05d08c592b05@nvidia.com>
References: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
 <20260814-tegra264-pcie-v10-2-05d08c592b05@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:44:46 +0000
Message-Id: <20260814154446.7C64A1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra264-p=
cie-v10-0-05d08c592b05@nvidia.com?part=3D2

