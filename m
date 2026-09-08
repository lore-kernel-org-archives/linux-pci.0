Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9B33B6FC
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879578; cv=none; b=R8fJ8YLe8yEk0HacmO/BmbNnayx5ZIdvX8RmEdEdXhmmCYdUxNxBblfQ/ftxF7por4ixUWi/oFds038CK8OQ4/WILIiQtcvalyXkBwc1aZIXtTlCC+GqVzVYaZrz/QdJKDrU1RB2dfsWh5LxZK8GFhzI3EGNW3PpGPXqU8MZqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879578; c=relaxed/simple;
	bh=D4N817iLHF8M2P+YEarAxZ4lhrCI+ase6rLYooEgMco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BzS+2CoJZfJ16NgNCrLuWE4g744k0ZlHymtJt+FRNiM/EaLWNvsHVeoLkWhlX6nh6J6Z68/kQEbD6xCexsJgSG/WgyXQocYpgxiWhHzWXH9Y0eeib64xYEmzKbaYTFfnf88PCj2GusjZJbmoMydUxIjgIukAha6Z9l4hDCRan2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3591F00A3A;
	Tue,  8 Sep 2026 14:59:12 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/10] PCI: dw-rockchip: Fix LTSSM set functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-1-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-1-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:58:42 +0000
Message-Id: <20260908145912.BC3591F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Before the Rockchip PCIe driver has been switched over to the
> FIELD_PREP_WM16 macro, PCIE_CLIENT_ENABLE_LTSSM and
> PCIE_CLIENT_DISABLE_LTSSM were setting bits with a mask of 0xc =3D 0b1100,
> which means BIT 2 and BIT 3. After the conversion it only sets bit 2,
> with bit 3 being handled by a separate define named
> PCIE_CLIENT_LD_RQ_RST_GRT. Apparently the conversion missed to make use
> of this new macros resulting in the third bit not being set.
>=20
> Fixes: 30e919570581 ("PCI: dw-rockchip: Switch to FIELD_PREP_WM16 macro")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rockchip-p=
cie-system-suspend-v6-0-fbabcca9921b@collabora.com?part=3D1

