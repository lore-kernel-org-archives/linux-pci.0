Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540764ADD8F
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879647; cv=none; b=fRez/0f7nwZ+VTX0F9nPQebrTgpiQ/KieCSavQYkJto1e+RalgG4R38GuO5HXRSe58E1pz/ZxERI17lyOcdNOrTObITe07549vxjcWWkFCwXz7MnqHR90URwRSGvY9R6PtUgNmy4yYteHj4+kqLs5pq28abl1pTcictTZhHnDFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879647; c=relaxed/simple;
	bh=Z3PPuUHoaoB4c3uz8ASi1BPKwW9wCd5cG/XmRp+DH90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ptkcGc/VpgPa0RSV1nxmzLDmNDxyuziOiriC3huNPdnfep74HPio0ryTejpdwIvK+Cv0MsI1e3VMI9PeI9BVLUL+LYUyKSwmzpN/Lmg3ie4Mv6xdEDXm2pVSsb2/fisXuDDvdhBzMzAnOQ1nF5cuaMvHpfibUSrAlAoFf+oTvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6D21F00A3A;
	Tue,  8 Sep 2026 15:00:38 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/10] PCI: dw-rockchip: Add helper function for DDL
 indicator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-6-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-6-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:00:38 +0000
Message-Id: <20260908150038.5B6D21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Remove code duplication and improve readability by introducing a new
> function to setup the DLL indicator.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rockchip-p=
cie-system-suspend-v6-0-fbabcca9921b@collabora.com?part=3D6

