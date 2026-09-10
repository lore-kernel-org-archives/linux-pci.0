Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C72D3A7C;
	Thu, 10 Sep 2026 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025165; cv=none; b=pymQDZhgdKxvc2TbZsd3aXSCOvfYjvY4YVXTItCIBJRsFpgH1+IRo7p5dsv6Cz7XaL3PBWK3rJ+47WPNHbbVmDygJ0C32CJX0cgcjepM2fmEgDJsF9SM4acRfuzicJq3QWNg0nNTIJR8KuxXHmySIX1xlsijig0cs35FAQ6eJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025165; c=relaxed/simple;
	bh=I9h+ZMFLdyw3o+nBehWg8qNA9wrV4mAd7TBHkzV2zbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=faLS37NiPmTvnlWv0Z5ygD1Ef7td7d4iQeVmxgEzfp+LJRfLRnc/v33TfSU1ZNODP86s0Db2Lg1jfllxrx87ZwhliMxtxXBg+aP4yVB/AXkGCpaAFLjIhaIbyfd8Lrk973sQOXiM8gK1h3IA6tczL0mVksPL8FJ2Db8e9+qyTOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diASGq9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diASGq9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FDC1F000FF;
	Thu, 10 Sep 2026 07:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789025153;
	bh=I9h+ZMFLdyw3o+nBehWg8qNA9wrV4mAd7TBHkzV2zbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=diASGq9Xj3PtRMTN7ntztDgkAqjVlgyUyBwB3357rIRRErTKZxsWPwEJ7lnVd56fN
	 LQHsH0WSBzORr6ZGmHLalN1LSwfCByfZCbcGmtzHpNIg4Wvc+cEPnDWvwy1gk8v5KS
	 bqBWvCA7dS5+lvNa2UC9TBAd6/TWOkLdtuzCdyBz0C2snkwsP9fJnl7OFGTJeEa/Ew
	 gSQ2hN6vvQKgwHyvrGNQI0ubpQbMln4uOaj1lyS+7efLsTs1Dml9po7N5R+XmiQth3
	 G6FzsDKVl7Qk70u3BI/X6Mdx0H+jEkCjTCxS4Fthqtmcnb3cYXqdQGxdiF1a7IBaHJ
	 2q4XKDz80rMhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/12] cxl: Cache endpoint decoder settings during
 PCI enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260910070808.1444264-6-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:25:52 +0000
Message-Id: <20260910072552.E0FDC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Populate pci_dev->hdm for CXL.mem functions from pci_bus_add_device(),
> after final PCI fixups and state save but before driver binding. This
> gives driver-free reset paths an early HDM snapshot while avoiding the
> pre-resource-assignment window in PCI capability initialization.
>=20
> Use the CXL Register Locator BAR Indicator to find the component register
> BAR, reject unassigned, disabled, or zero memory BAR resources before
> temporarily enabling Memory Space, and restore the original PCI_COMMAND
> value before returning. Cache the CXL Device DVSEC control register with
> the HDM state for reset recovery before a driver can alter it.
>=20
> CXL core refreshes the cache as decoders are committed or reset, and keeps
> the cached DVSEC control synchronized when CXL.mem is enabled or disabled.
> Move the register helpers into the built-in CONFIG_CXL_RESET set so the
> early cache path is available without cxl_core, and keep the cxl-test mock
> core from building a duplicate regs.o.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D5

