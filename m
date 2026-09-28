Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E94EFFC4;
	Mon, 28 Sep 2026 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614668; cv=none; b=kW98BFlzH9KNOY9DGKv3ps2RYxfz4tdhJG8+lR/wsRHwxQfyYtxEGKCUSmnWc9hl/dWlhNbwcol4o+qpSZRnnw/LclmnkhlwkWr23gODb9bjk5Yltf12Dvyz63EfPPWgN42akNrbfkChRUHDs0zsvXppYPuI/N9/m8q4Zs1vZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614668; c=relaxed/simple;
	bh=jCxgf2I5bncXJod1oKWTXteZ5gnTt/BumFHkrATztLs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BEFa/UFt17s0EtLylM7fhiKhoKWGsi9y4xOu4EeCeraYBLtYTDMmBKXOgdCey+nWfHuKVLzQi+BGpyfazMS+Tj+0haMrMUkM3QwGp7qOriJ2Jxff1NEUsAGIAe/pmInxdwq4NHoqVS5bwhBSm2XbyxugYNWBjEZvEQqMrgSr/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZuWI3ZN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZuWI3ZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460621F00893;
	Mon, 28 Sep 2026 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614665;
	bh=jCxgf2I5bncXJod1oKWTXteZ5gnTt/BumFHkrATztLs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oZuWI3ZNQ7PHrdMRUMOgViF72Z3nsPFZdKOt+lXi3uRg+BMW7AjWWoVkL3zVuh0aO
	 nwgB5CCtTbCNrCRkfrUsdBkIjFD5pfn4/wkPXsYoA2P4tUag2Nh3Nm1i7hPd82Bhog
	 1jxRlBouMBu0+inD8obtCD+pswvB+/axiasd9nR0abEevisaa53J3Zw7kGndrfL0Af
	 4oxcGocmUia2qGIC3E/4IsToJ5fe8Oj353lIT5SFfa+vGslDlVB69igAzrXOcUkwNF
	 eT1ytSz/UZBQsp/QQSvDxCwDMczH01z80jgwQ9Nv94F6/mEmgZalpXhAZbRh3pWUMQ
	 gQkhjiJSA3QXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/15] PCI: rcar-gen4: Check live link status in
 link_up()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260928165230.3397664-3-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:57:44 +0000
Message-Id: <20260928165745.460621F00893@smtp.kernel.org>
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
> Keep the APP link-up event check from Figure 104.5 of the R-Car S4
> reference manual, but also require PORT_DEBUG1 to report the link up and
> not in training. The callback then rejects a downed link even if the APP
> link-up events remain latched.
>=20
> Clear the APP latches before enabling LTSSM to discard events from a
> previous start, and only read them in .link_up(). RC startup uses
> dw_pcie_wait_for_link() to poll the combined condition.
>=20
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller supp=
ort for host mode")
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D2

