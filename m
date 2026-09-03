Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581F4D8DAB;
	Thu,  3 Sep 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452008; cv=none; b=LcHVHYP6DsQVvksV1vc0otiYx9LhI91y0SblPLSmCvgSG4ySTwxnld4NcAkHxYzn0zpErIauzZGG4aJuOTpJVyFyw4CHbg+7/RRtEJKrstTisbX9U6Zk7zFtS8/cTcWKPGWIZJ3hJDoU7ILQOkMPPgND151NKfYUWf3MLlu0eO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452008; c=relaxed/simple;
	bh=GE0R8Z3pC+iCt9aRmWtxo6aXF/6WYnVerc2XHPYZAMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sU8bF7Z7tI/i91BctINP8xTh38MsbLWD+Q5/nuwdwQ4VwGPaVN75Ye0o7cGIFD/wh5yTxp/2SsZRnITFBzcpxIBNxzsCSBoU0LgL5LW1fVCCLoKvDw8Mgna51CUvxmjeWock80VFuLnssZZNPdnOduEgUYhtPge7ksKlt0hDm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd6SfnsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd6SfnsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3521F000E9;
	Thu,  3 Sep 2026 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788452007;
	bh=9X5aJMJdH11AGNV/aZh4P7AJzxCwlJt81Q8Oj9p0pTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fd6SfnsDLVBE/D/Ze162aaxJo94iGPI5oojlItSHKFrMgKOG5lEEQ+roWlITjTYc6
	 TzOIytNweIKCrxHEPl5nn1JcV/cMfvM+YczR5xG7c1RngCqg9a6ty0oiW5umkYhtlO
	 tR36yZYEMH6ZkTzlX5vOrqxWYCNpQMrY5hLIGBrNRuXznDbMdBWMQY602zpQGxFrIC
	 5t8XLHjUcGko550ixJl2EkSDV0Qup1DsA8WXp62n5ZQ0g1lh5Qhx1PhPMHQD8/MFEI
	 AMVmDhGItCbrAh7dHmoCFovC9jwazd0gwRzxGOzG1cDmWnfShQxa9s35dkCHgKFVY0
	 RyKg/Kwkg7RuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] PCI: imx6: fix resource leaks in probe error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhijian Han" <hanzhijian1991@gmail.com>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260903160342.3282199-1-hanzhijian1991@gmail.com>
References: <20260903160342.3282199-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 16:13:26 +0000
Message-Id: <20260903161326.DD3521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> imx_pcie_probe() leaks both pwrctrl devices and power domains on failure:
>=20
> - imx_pcie_attach_pd() attaches the "pcie" and "pcie_phy" power domains
>   and adds device links to them, but nothing detaches the domains or
>   removes the links on probe failure or deferral, so they leak.
>=20
> - A failure of devm_pm_runtime_set_active_enabled() returns directly
>   without destroying the pwrctrl devices.
>=20
> - A partial failure inside imx_pcie_attach_pd() leaks the power domains
>   that were already attached.
>=20
> Add imx_pcie_detach_pd() to remove the device links and detach the power
> domains in reverse order of acquisition and register it with
> devm_add_action_or_reset() so they are released automatically on probe
> failure.
>=20
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel=
.org/
> Fixes: 2c5768344f88 ("PCI: imx6: Move pci_pwrctrl_create_devices() to imx=
_pcie_probe()")
> Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903160342.3282=
199-1-hanzhijian1991@gmail.com?part=3D1

