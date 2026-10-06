Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276C3BAD9F;
	Tue,  6 Oct 2026 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276813; cv=none; b=KELtDOkUSiIHEtPzr1Hc0fe4GwOHpF4lKqi4D+02SqeRrx70gUQ7DutwiuqLU9nGRGqr3ZJcwZoW69cVDNz9AG42MSXub/e2E4Q9Npi5nUx+F0L+STEUFfUD8WCwA7uVhR456OFgmmMAi924JozQoKvZPcTmaxjbQ3meF75PNRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276813; c=relaxed/simple;
	bh=FiTimomtEV8v2mTIovSRmMZsDedQGIjXhqHx2WrJpKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q6cY/n1V3LC46E15JghTDGqBHcHV58xTe2PGYctGmatVSpTDPZoXrt71L7GXOiapt27ZExID+7xplkJucxZpI3o5bVw3vcTOzbwfA7YkYdRyLHvcFmJoleExepFtKwppUjPddVnh0b3VvSb6MucnGYASkZ6Lknxvg4DArEBNSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiBdoX8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiBdoX8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E971F000FF;
	Tue,  6 Oct 2026 08:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276811;
	bh=FiTimomtEV8v2mTIovSRmMZsDedQGIjXhqHx2WrJpKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XiBdoX8M9/qvulbhgDqn6ezGMuBnCzpTgMbThHR9B5Y276cvFc93nE0JJOcMsXgZF
	 3FiKvtTtgVTLVQ/zZ/jFR6H7FahStwSQMQYnf+zRKT9fuceVuz/GKA6x1QlfWPYlIL
	 1fI0dTVON8+4/oU3S8QWqiOpM2jqHY1MfImHaLhcsCcQgqeTTuqgPtD6H5ctGc50IS
	 X31XDclUU7ZSolWMnla6xrsfA1sMFYjUF0ffcsLsZah/ehfuWxoqCQf6rWb5azZ+pw
	 eJAtGy8G8YD/hRKvJ+Z4d5tBtiBTnTvwTzVymVtf2W1lnnpNEJPD7EHtuZxYcCtHVR
	 SqYEnSOnT18/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/18] PCI: rcar-gen4: Check live link status in
 link_up()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261006084638.3821710-4-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:53:30 +0000
Message-Id: <20261006085331.42E971F000FF@smtp.kernel.org>
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
> reference manual, but also require PORT_LINK_DEBUG1 to report the link
> up and not in training, through dw_pcie_link_up_debug_check(). The
> callback then rejects a downed link even if the APP link-up events
> remain latched.
>=20
> Clear the APP latches before enabling LTSSM to discard events from a
> previous start, and only read them in .link_up(). RC startup uses
> dw_pcie_wait_for_link() to poll the combined condition.
>=20
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller supp=
ort for host mode")
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car V4H
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D3

