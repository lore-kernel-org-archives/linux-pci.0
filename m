Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2FD38B14B;
	Fri, 18 Sep 2026 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701905; cv=none; b=AjD+l/hRdhQ5uGhbA73yR91xuLosVllKtr3G4wTwil1Rxo4/90AVnUndJF63AuwtaU08R1G9LYEBOSRBgP8CoypjUM4Sb3VyPVV1hNmQWHLMTSDdPNlyZ/1IkbvS3+B5cpFpwGaKMQK7ViFDCXCLgD9BJCUM5sG7DLfkjVT/ye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701905; c=relaxed/simple;
	bh=Z0iSEa3iLsSgbnOSZGhKWwYvekHxEizGJopNSZPXYqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=reGu9yRXvThoEsxQ0irlars3zYZiEK3Ub1u7q9NjkcE0oQuYd5dRAqRnMy6CTxmuw40SRJTe6Kazq6ygGa6aiRiVY1sbtyk9HQOpQq31ORmCRgZkY0+oAm/qh7eDzJ7Eg4LX0LEwLu+Tt1bvyS9jYqBQfiuZKX+UbGXo4u8dG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qqy9EBD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qqy9EBD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4782E1F00893;
	Fri, 18 Sep 2026 03:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789701903;
	bh=Z0iSEa3iLsSgbnOSZGhKWwYvekHxEizGJopNSZPXYqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qqy9EBD/TLusfa260tVFnPusUeKn0UyZ2N9BjpHBCpfc/MHiZroU3hUU5dKt5TEw2
	 6W0wp1pz+s+L8qAgT1ktncGhj7dOYVnv8UIR1+CVFN6iyYVyg5PWbUcs4ra6MhA5Ed
	 KQ2hreKgNjlsCXypWNocZhekSLFmzdp5wEEButK5iDhANFqEdbHV0WrWB6pKInZOO0
	 /KSdK7XF6+cba5GPeWILbbbWi/+KKrcC8q1eED7wUtr5w7MP9oLWEzTV9ewRymyoWV
	 45385GhKFnnQp+ycrc2MoWiFMjWzTkmwnW0UW8RAmLebETAjjolQVAOQ12pDGo4TC+
	 NX/YfnlhdhpRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] PCI: rcar-gen4: Drop the APP-based link_up check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org
In-Reply-To: <20260918032038.2216471-3-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:25:02 +0000
Message-Id: <20260918032503.4782E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> rcar_gen4_pcie_link_up() checks link state using SMLH_LINK_UP and
> RDLH_LINK_UP in PCIEINTSTS0. However, these bits do not reflect the live
> link state. On an R-Car S4, after taking down the endpoint, a link-down
> interrupt saw PCIEINTSTS0 =3D 0x20a000c5 with both bits still set. Even
> after resetting the controller with the LTSSM back in Polling, they read
> 0xa000c5, still set.
>=20
> As a result, dw_pcie_link_up() keeps reporting the link as up after it
> has gone down. That defeats the check in dw_pcie_other_conf_map_bus(),
> which is supposed to stop config accesses to downstream devices while
> the link is down, so such accesses go out on the dead link and stall the
> host. It also makes the callback useless for the link-down recovery
> added later, which has to wait for the link to actually come back after
> resetting the controller.
>=20
> Drop the callback and let the DesignWare core use its PORT_DEBUG1 check
> instead, which correctly detects the downed link.
>=20
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller supp=
ort for host mode")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032038.2216=
471-1-den@valinux.co.jp?part=3D2

