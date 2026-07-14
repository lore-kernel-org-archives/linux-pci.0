Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75C28F5;
	Tue, 14 Jul 2026 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991722; cv=none; b=J/BoOo7M2x3Fyt0UC+l250wVrbi2UsNpHHwae+7WuL47pkiI6tcy/ZJmc8xUKCSsCCFJfKR1LF3EHlneLwvqRxS45MJd4xa3cek7LN53+2cDsBe9jj9Bh/PJIAWSb/GfiGCEb4G5j/bcsCXUOWe1nCyGT0H4bwtax5O3rNG0YLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991722; c=relaxed/simple;
	bh=X0HeZtFkkn1SU2dLRhNwE7Xjcdh740jB8r24lUrnMOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tFTwGxTQNxMJISFEQeFRCTKHon+Z43fQU27lgmBNc2q3dR5MU+HVrVwxr0Rc2mH2YS6t54BAMzvVTzXQLHKuN2bP2VEp3LBcEmKNnZs9PgHxFlQ5Ex3SxTt8uDfavm8ifTmPino8OPLwqFElM9rTBbIeo3+JQTzIYPfu9iXFp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd5BeOM5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd5BeOM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61621F000E9;
	Tue, 14 Jul 2026 01:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991721;
	bh=9DKJQm3acDAtqJ/hSlGSCXRR3a67t/hDKvsd7Txn+I4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sd5BeOM5TqJVn9/+hf6w5jCfWukcc1y6mDUtuI6xYkF/h7b/pXKIvkCsHvaSzr2ob
	 9xWVfoeKdrfd0i9ad/DKsziJ+AeZ+FV13HurEE1OZhMeaTAWE0VySqeIQN8KVv1Yu7
	 CZk8e6fUuONKnhhONkkrlEkjMvLTQZCxDGd0n7FPGlCAR+nkbIZHU5HqfqGqfSI+U5
	 ITOUNG01/+sLKXMIGHretLuyPtKrsAzFKlPPNRf5zlyK2RV1AV3lRBu30N6SwubFAQ
	 pT/4lEPJGimlDWJutcZgSgIoS/zX+lzi5Od4H+P8y6AULwb/p58dJ/5E9AF2R9TRmX
	 kdKdoAquNCsrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] PCI: ultrarisc: allow DP1000 driver to build as
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Wang" <wangjia@ultrarisc.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260714-ultrarisc-pci-clk-v3-3-e72723fc0ef1@ultrarisc.com>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
 <20260714-ultrarisc-pci-clk-v3-3-e72723fc0ef1@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 01:15:20 +0000
Message-Id: <20260714011520.E61621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jia Wang <wangjia@ultrarisc.com>
>=20
> CONFIG_PCIE_ULTRARISC is a tristate option, so the driver can be selected
> as a module when COMPILE_TEST or platform configuration allows it.  Using
> builtin_platform_driver() leaves the module build without the module
> init/exit plumbing and causes modpost failures for the generated .ko.
>=20
> Use module_platform_driver() so the driver works for both module and
> built-in builds while keeping the existing tristate Kconfig entry.
>=20
> Add a remove callback and call dw_pcie_host_deinit() during removal so the
> root bus is torn down before devres releases the controller data.
>=20
> Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Comp=
lex driver")
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-ultrarisc-=
pci-clk-v3-0-e72723fc0ef1@ultrarisc.com?part=3D3

