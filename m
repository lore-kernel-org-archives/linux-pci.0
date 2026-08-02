Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329D489874
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686841; cv=none; b=mrAconKb3VQC4/fy9/PKxPTPCwTKvYjnSAXcPdtkFY5t/5olUrcfxdNEvjiLo3hb65WA9epy1MgkKCBxE5XssBdDSs3ZTn56h9vwwkXPYCr/A3kDV6fG4v5UNWBvJ4l0tk9hmtCk1nAfwhR+SwDzbGax9tZcKvRTp8wp/1EeNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686841; c=relaxed/simple;
	bh=Hlwi16AyiWh8NFFZVE15uGmVgU93ox0A0kTI5ojklWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MTVzfbSUsdlXFHbZntXndLkoX+g5/l2vsieUq1T/kuz5+S/s2NLBMFAimCNNwl1lw4svpCMbnABMh+zX0XIswrkvvzSktdmZaeObZaLOjAw5aXCJr0ydbGrbZhCW3P38M0gde3/Jho01G/ZRp5J+yHZBLjA06B1ZUgPMHyDPNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPDmZMcz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPDmZMcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23091F000E9;
	Sun,  2 Aug 2026 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785686840;
	bh=Xdt1aOQXBbWxMnEV/1q97hvphKSBQBml9xFWhARAbmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DPDmZMczVVRe6+ErufrWubiVrsITAmncLls/65ccnPa5S/3xWTCU3c7Ofnx1ecs8B
	 D/DbiU9LxyRhtIpIvWKly6lIyHlA/3bhyCrRglPZJ+67unkJQAjxEVVhmDhcddaEtY
	 qQZxej9v6l23YP2DixlNp0Li0hwOniBHHL7VVEZ47d8ue4/PNZMRRf4Fn6YZofeynL
	 5iX4WjnqHmCEPr1Mb+BZux8JlCUwi410h6afKD6bFjyOBIYGW8BludXo62cTKhpIBo
	 kwFzV16GOerVpw41RGWvHYb3xX4hcPe7+RQDL/Bo78V3eSbqJJC1Q7C+JzFPcgXZx2
	 /8MPLw3WbCGKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] PCI/P2PDMA: Add KUnit coverage for the ACS P2P
 routing walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-12-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-12-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 16:07:19 +0000
Message-Id: <20260802160719.F23091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Extend the ACS KUnit suite with end-to-end coverage of
> calc_map_type_and_dist(), the provider-to-client hierarchy walk.
>=20
> A fabricated PCIe fabric (host bridge, Root Port, Switch Upstream Port,
> two Switch Downstream Ports and the provider/client endpoints) with a
> fake pci_ops backing the ACS Control, Egress Control Vector and LNKCAP
> reads lets the walk run without real hardware.  The tests assert:
>=20
>   - BUS_ADDR when no port on the path enables ACS;
>   - THRU_HOST_BRIDGE when a Downstream Port's Egress Control Vector
>     routes the peer with Request Redirect clear (an ACS Violation) at the
>     path divergence, leaving only the host-bridge route;
>   - BUS_ADDR when Egress Control is enabled but the peer's vector bit is
>     clear;
>   - THRU_HOST_BRIDGE when Request Redirect redirects the request and the
>     host bridge is whitelisted.
>=20
> calc_map_type_and_dist() is exposed under CONFIG_KUNIT via
> VISIBLE_IF_KUNIT.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D12

