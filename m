Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4FB48BD20
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939836; cv=none; b=RdQ0naAfH5r8w2irTjmVf9llRKkdCHHPslJwuMzbE86/VKnh630mrjeVCu66WytfalNs6so5ee9LsbqWaUOui4oiiFxQ3+EI3npIxO2EnU0laBdFOQnLA4Lz9vrTBOBGDD3aV6MY5vK1l4dtMLT1HjbOBliefzwZ+AbSkC/hY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939836; c=relaxed/simple;
	bh=WikFiXRckIKm0IzX7L+qxh0PLgkQnMDy5ESmGignTXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TOaeGI+/5Jpl6XWxBECgalPwQ4JY8v+0GJSyBA0XEawb/ftO/YM36gB3zsyNOkj5KomoGUeFALIH8gIfccG+5lsUcGuTxmenKVMqSRlJu7CGtRHRlojoI8DEPwZLn2s7KVMlJw4bCqY9eHiakN2h7GyjFo5DDbTTHCwIX51dec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W71YaAHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W71YaAHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1972E1F000FF;
	Fri,  2 Oct 2026 11:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939834;
	bh=WikFiXRckIKm0IzX7L+qxh0PLgkQnMDy5ESmGignTXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W71YaAHWn/Q9k5SSdhQnkVRyVm7UZ8SXixmrkx1EP2wGt4TKvqCprR4UAE2DDgx0s
	 0CHHmN+pJuKph9oN2i27+N9wPz/Gmb7tvW7dRFwUa1yAdzwEH79IOsNGQu/DskFrnz
	 YzfFA8TLJDWKjO6GdTk5d42/LKz79uZR0KiOwFtHnMJJW3PCabcKFw22MLnIBQWX6h
	 BBZihzmJg8WtP7IeHYEq98OANTwkDgYb0EZmX7Ym68E+Mfy6XWaNr9AWVtDkZ+LuCJ
	 pngPXw5+b5mgM2Y52tEkVN9rdVvvsKz7C0vyBSwg5wWLEsLqlIaN+D5+YbCF7NI/je
	 M9jQxTiQUZO8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] PCI: rzg3s-host: Move suspend/resume code into
 dedicated functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261002110935.2004349-7-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-7-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:17:13 +0000
Message-Id: <20261002111714.1972E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> In preparation for implementing hotplug using
> pci_host_bridge::reset_root_port(), move the suspend/resume code into
> rzg3s_pcie_host_stop() and rzg3s_pcie_host_start(). These functions
> will later be reused by the hotplug implementation through
> pci_host_bridge::reset_root_port().
>=20
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002110935.2004=
349-1-claudiu.beznea@kernel.org?part=3D6

