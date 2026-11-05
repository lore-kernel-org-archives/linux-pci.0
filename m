Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885901;
	b=IlQYr9WQwEMdOD3UVMg8oqLVbcD8bK+lnlCkGtKz0d2W5nBCMHjBktI+2KhgtXXdhRdV
	 IlDdjdkyiIB9s42kWSN4LoDgn17AAvroMo3OHxp41y1Ukj4TGyiVNxlk/t3rolp0S6hc+
	 0EEoGCVfJL+SxE880jURbzoXW852CONdZ+IKCi68QrY3JMLMTnuhk6od0LdYmCai+NyBQ
	 bAKpXi3iQ/wM6rWgmofxvUcg6vh7jo2Ec+0ADWOqynujIwttWtvMripsDdiobUlvs2Nkv
	 6IsffiTEYqEyHZpRK9QXshUCelldbGs1ebf69yMMO5gZ+Wdzzkg7WFu6qBzazSqh0KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885901;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ewpNNzU8Ah3tpMIHp6kFnvUbqopq6WMDd5UjLg/FWjk=;
	b=w+mwqhM36ShSB7UUGxUGHCi9yMUumNflDlXZAbE9eigSsCsvpa0PY2VlHW/aqIqWJol+
	 SfbAaIYO8no+nW0eWEqd6N3reSUoJZc9wAPAfpqhxS/u7TgAwUnbmX/97hbC1aLEZVQva
	 pWsp+jVssYRakZf4EvnTfQUnfvbgr/f2L5APlsrzf/rny+3tiPF/XeYquK2w3++SWWmmV
	 Dx6ruLnYKJ8bOtvfQoTjNutxMt6L+oTB4CJdlC3iJh48l/6FFfxmcpUbHn68Z/ahrOKBj
	 vSNUq83Fb4t9m7OnmYJjYJ+Ed7aUDOU3Jc7GHevic1SC6dteVMEtwnVRazpRxNIa/nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL4yOFN+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5195606A326
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL4yOFN+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0981F000C1;
	Thu,  5 Nov 2026 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885900;
	bh=ewpNNzU8Ah3tpMIHp6kFnvUbqopq6WMDd5UjLg/FWjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EL4yOFN+kp2vb9qOKHZf0hW5Ajf2rMzyniHoBSi24yFtl6ZQ2zvpyFXv/aem5bEvz
	 cWTRC5eEGM4nNVc75cBf05TzFFf4V6PLhg8vQMyURu74pX+NWHZOQsxK053icjbJv2
	 iPA9QrSeDX6udpyxc5JguS/nog82/M0lCJekTIC6SkodiUkIl6mZxvasoMzxNyZrK/
	 GEBWY9rgitaxaKyE1tU9ZJ2imwyRVtoKqqZYd1LDxk85nT/fpaA2SIUT+8js6v3Bl8
	 B3SE5ZN4mU20UUrwONLZwunSpMgRUEqaMJ4QvI80tbYR8MWRTyO5yczuG41uGq8gf6
	 qoVDwetMom03Q==
Message-ID: <sashiko-outbox-199168@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/9] PCI: dw-rockchip: Move devm_phy_get out of
 phy_init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-3-a2e55846649e@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v9-3-a2e55846649e@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:38:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> By moving devm_phy_get() to the probe routine, rockchip_pcie_phy_init()
> can be used to re-initialize the PCIe PHY, which is for example needed
> after a system suspend/resume cycle.
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-rockchip-p=
cie-system-suspend-v9-0-a2e55846649e@collabora.com?part=3D3

