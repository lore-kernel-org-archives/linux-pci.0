Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1C5158B7
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088798; cv=none; b=kRMlMXMgECbhLAJtEHeoKVDLEtoAfxK7RvOBXvctuoH4WHkDwaCyvotyAuM8lCmx4X2p/N1vZhRNWRLqkxPqWT1uAeXOmpaDVj1ZCUEA1oJzq+8tQd49RHOhvetNS2N72FmhCOvxkO6m6/znsB5w/itOqpLDJ3+Ym+BGVK5r6ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088798; c=relaxed/simple;
	bh=bV2etBfLR2swCmF71+o+K1atSvXUo+WsOSqt4oSiUsE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hRfElSh8hCLTJYpT34pALCPKYSJKUzI9cbHgcaK/JW1yrucPhuzGHJTlCLzBi0OmLZ6uC5sYL59BXg1F6FpRECf5CEAnCyrzgf3828P0X2M4AtINpcjQ1lUozV9HgEmayx5Xmx52vCBwggpS5E5z40CaKnWxNpxMr88p6IMkYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOj27yoy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOj27yoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3725D1F000FF;
	Tue, 22 Sep 2026 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088797;
	bh=bV2etBfLR2swCmF71+o+K1atSvXUo+WsOSqt4oSiUsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jOj27yoyxdcvBy6MIdL51YIFX0XMAOE08/O29dNbZCwWsxBIXBBbCbJsp3l0D4yZP
	 gvLezKDWWVoh1sjtnxyZlYpvT7nwdfD1EMoy1NwaoyEveLioFf2ENBYNQDuJEclRAE
	 ZrbB47ZTjWWA1SXZUdCbVbMfp+lv/8+ToAnVj96sczQtfY64uazAn7IQRmU1eSRUl4
	 gVE6kT2sNdI5Q7UjDKPqUEVf2PvjgVingU65GOQ4fHsACYbh9/rJi2AmB4NFxbvbZF
	 RgCGBjt+kRzv69TbQyd3Yu6ezzP7XfIr13U9u9Rguug9h05WWC5/iNTFW/xNn01pO/
	 zPJXhC/1jsF0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/8] PCI: rzg3s-host: Move suspend/resume code into
 dedicated functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260922144629.586997-6-claudiu.beznea@kernel.org>
References: <20260922144629.586997-1-claudiu.beznea@kernel.org>
 <20260922144629.586997-6-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:53:16 +0000
Message-Id: <20260922145317.3725D1F000FF@smtp.kernel.org>
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
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922144629.5869=
97-1-claudiu.beznea@kernel.org?part=3D5

