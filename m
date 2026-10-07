Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C661DFDA1
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352101; cv=none; b=qmQqf0COy4IWfrubQ4/ovRls9m+vl2opUV5xNGrkxL9pw3qYWGzVNkWLUuCCrm0dbht6vS44nnCcgl2Syaxz+4xrpUudKN7wNSp6imGwBo1IoO6QuT0/AftpnaInhI6dj6K+qDOjqm+WXeKHOCvy1AUkJUU4HApv4v0l0L5MwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352101; c=relaxed/simple;
	bh=9+UgO02NM2nt/cwXQcsu1wHPkaeMC9zzvsDP91/dhVk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pmHbZwO0IjZ+ctHR0ipmkyBDd1XQyowrr68BwYkDEXtIbqhzJ23BK5uNd8/XkhG3sm1o3JbPiXsr0L4KTxC6gcow9jllJN6R9+x+6+F2ESyhOMrqF9ydHkZsDjlAeA63hbN95e3KjEueQgNT9v2IvDiDMT3xjjXIyn9Y/A9oQg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6QvZon6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6QvZon6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608EA1F0089B;
	Wed,  7 Oct 2026 05:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791352100;
	bh=9+UgO02NM2nt/cwXQcsu1wHPkaeMC9zzvsDP91/dhVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T6QvZon6r7KR/822uifgGjPEK59zp7u/J5Fu3mKvJ2kZoKw7O2lGIZeWMjoFf34JR
	 RFXoZ+bz8Ah5zkIoIAOMxizcTtf1ibjQW0lbsYYe3ao3dHstgbuMBf6kcs+FvF6Wzz
	 PWa76mcaOVKv01z0r69rGnhR5Vev9fQyJOuZu8LR7shS3gsqyvfsI4waUpP4G9/4sS
	 zPPYy5noEtr+8MzgOl4R7o+0g6eD8l2sfnGSICCwdcxlLFl8KPuHxsnB88G+Hyeutl
	 DfL/ZtD69FDemH0I7XyYaDeAz3EloSz1aVLga2mC4XPfgQTR086AmrHE3dQ7SQ4CYH
	 C9aEGJgOCSAgw==
Message-ID: <sashiko-outbox-162650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/9] PCI: rzg3s-host: Follow hardware manual
 clock/reset initialization order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261007053645.1391545-2-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
 <20261007053645.1391545-2-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:48:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The RZ/G3S PCIe hardware manual specifies that the clocks must be enabled
> before the reset signals are deasserted during initialization.
>=20
> Follow this sequence in the probe(), suspend(), and resume() paths to
> match the hardware requirements and avoid potential issues.
>=20
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007053645.1391=
545-1-claudiu.beznea@kernel.org?part=3D1

