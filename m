Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B74A440A
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442918; cv=none; b=gojiAXRz4P2koI0JDKWxpRvDsdMYZeSYnENz27nbTuFJIs2WUkLklZ+vOz9v4Ofu54ZAoY9v7BUGBlpE657W2FU3RjUn/zNWfqjHeHNhPmA2O2AUHxL9TD18KFybHbAerwYzf3ZoBXxN4nGVvalDjwIpMvpNKNj9vDbihs4STAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442918; c=relaxed/simple;
	bh=S+JqRGvdqleqxEOguJ44gl3Q6djQSIx7vr9PEYMQCnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dGLSWqM4SXicvaKkW/99yLkrGerQGNlZR9wwQnfuyGWaY/JC81z6rBDKMDul7Z9VsWSRMwY0RdQ6OBeS/Lg61YGonMu++8jm7uWbBGfGEA0K1tv/sVE4jy3FgUDZ/C8/ouZ6CPkT1t53mT8nPFdubDMS+eKqsrhlvHRWBI/Od/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcop7bZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcop7bZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240D01F00A3D;
	Thu,  3 Sep 2026 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442913;
	bh=S+JqRGvdqleqxEOguJ44gl3Q6djQSIx7vr9PEYMQCnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcop7bZwftqFeahDbR1cDyuS4F7JnbVSPZaSMJCBmPCZFua+TWCVlvnUZh4QOBvwB
	 j0Co2y+axXl5WlGrLmEODX105q1NTizVxSVm2glDwprKJFlY/t3vX7LWQT08eXoXS7
	 zQHVOGzD1EOu4I8K0anlzLJvVLiyqgYI7p1o2dApeeiQUHYrQqNHNPGW4G1v2zuNmV
	 iFSqUD4/YHatvJy2gGtGzG90aN4PvNr5yyi+8aUQBW/cTqg1prYNWQXKP99cmPNUi5
	 3e2k5meAWjZpi5/oXPPH4prHYiPo5WbhBE0FD97UGWuxhLtisZ9Csh4qwYlT/M4fD9
	 ag71pCyXYusLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: rzg3s-host: Add support for RZ/G3L SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Biju Das" <biju.das.jz@bp.renesas.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260903133320.144245-3-biju.das.jz@bp.renesas.com>
References: <20260903133320.144245-1-biju.das.jz@bp.renesas.com>
 <20260903133320.144245-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:41:52 +0000
Message-Id: <20260903134153.240D01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add SoC-specific data for the RZ/G3L (R9A08G046) PCIe controller and
> register its "renesas,r9a08g046-pcie" compatible string. RZ/G3L reuses
> the RZ/G3E config init/deinit callbacks and power resets, with its own
> L1-allow syscon offset and mask.
>=20
> Also increase the timeout in rzg3s_pcie_set_max_link_speed() to fix
> the "Failed to set max link speed" message seen on RZ/G3L.
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903133320.1442=
45-1-biju.das.jz@bp.renesas.com?part=3D2

