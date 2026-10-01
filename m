Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB7517BC6;
	Thu,  1 Oct 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865656; cv=none; b=f5FlF0UF8QSezuAvSj09c31GunUuwEeEKBWJArFLsGmTpn2SlT9kpV5maeOc8JW7ZwkrxWTVKl+7e9Lq5d4qTzEz4e9KbpMGolwS1ZbvCzr5y+l19ekjsiykGIuzIsjtnFzIps5XHuXkz4/DgCWpEEhsI4OqviGFQscZpxspxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865656; c=relaxed/simple;
	bh=gUmDWecobxNwhBB731Xg2/jn0xuP4dmGt5LcGYaZn2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BMwUVjrwbXC6WqoEM0RdUz3vP5LRQPsY8Z2Ie6dLJdq1vH4XZpO0WUAX0JX8hEPXIz5saZmMhPU64lejBAZ74kSZjYsQ83lnB14ZkA4luemIwXg+lU25xSCII8ugKFhf2oqZP15F4Ycy/O++l4WTJvG8V6ZVP5kBsqZGbQorxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5fInPaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5fInPaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2D21F000FF;
	Thu,  1 Oct 2026 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865650;
	bh=gUmDWecobxNwhBB731Xg2/jn0xuP4dmGt5LcGYaZn2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f5fInPaKSAVtT7n6r1Rj8gtniWnbE25cKSBAAIibNjkR4j5iM8wzHfp4/gla0sBaL
	 ibvQyXe0M7D4/3wUiEkDHhZmKSpKR22w1DW+wo+sLuMbxxRHKdbrijuGTfJLWiF0MO
	 LjiRKca/RQF5F8zYap3I+mTPBomB4g1pY0W70TP6aQ30GyexJP/8TP5pdQ6OLbKe8+
	 N60StUK9fKQFUJsEsZ8aUap9wZrYJj4Lvmyo+YEElb+rMGsV27z3zmcWFgOK3oJZSn
	 iLbgT209Yfw3mQIx7gaMWt7U0JeKjxlxCPyHjFx7n2GLs1Oxi0ohgqLCSJOJzRkFPC
	 P1WFuqKYYp7og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/10] PCI: of: Set fwnode device of newly created
 PCI device nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001142815.277550-9-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
 <20261001142815.277550-9-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:40:49 +0000
Message-Id: <20261001144049.EC2D21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Device-tree node can be created when CONFIG_PCI_DYNAMIC_OF_NODES. Those
> nodes are created and filled based on PCI core information but the
> fwnode device field is not set.
>=20
> When later an overlay is applied, this confuses fw_devlink. Indeed,
> without any device attached to the node, fw_devlink considers that this
> node will never become a device. When this node is pointed as a
> supplier, devlink looks at its ancestors in order to find a node with a
> device that could be used as the supplier.
>=20
> In the PCI use case, this leads to links that wrongly use the PCI root
> bridge device as the supplier instead of the expected PCI device.
>=20
> Setting the fwnode device to the device of the PCI device allows devlink
> to use this device as a supplier and so, correct links are created.
>=20
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001142815.2775=
50-1-herve.codina@bootlin.com?part=3D8

