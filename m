Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F276207DF7;
	Tue, 14 Jul 2026 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991918; cv=none; b=HbLyOVQ0ahM4K2m2nstuIUupdQV02XvCjHRNv6/mMDNtxbpoFtf7/zx/7KY9UBOAR5MncAC265FvcuMQOY0Q2nnsd4VzchnCuADzXoqqhiHo9zypEEAbzl+KpJyFdKBrRrgNkspWIH1Gu4B38fvwqg5FhKtk42ezcp7FvmXwwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991918; c=relaxed/simple;
	bh=S0OIYxZ2Oe9uuuqQT1uHRVtc88us2WImxwPL6a53bw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QF+MIK7iVYuEFlhcQ3lkftG3siYQLQRmq/j9ACSi/XoAWhy7zjDCDHy6VJWCI9S00H+3axbsymTn03NfGBTjQY7JctzO41vIjdxAgz8fSES40DQd/sbd2TvaqXwJZRD3yueoezMAQq25GenMCZzEjsOJjZsQuxe5YB7nckUFz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNgT+O/Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNgT+O/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6311F000E9;
	Tue, 14 Jul 2026 01:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991917;
	bh=S0OIYxZ2Oe9uuuqQT1uHRVtc88us2WImxwPL6a53bw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RNgT+O/QnEUrksvevhcGGbCWLPVexg9EFkIS3cdkSaHz8hWezFWfg4PitiQsLFi4k
	 1ApgV+zgDEdOQxwJNF1TRI2bp3SMx4hh8YWnBfqJtA+5+G0A8SN1fVxnwUD0AkTWD8
	 gPMZLrMV3AwzKddzcqlM5U31Zc/jFbFKsb9jCbo9pTgUODRofsAToXY81Kdkz8J95p
	 FoM09GQ2b1On5jmB86XQqCXVRP7LR4I8Sd/yD1bjfcZIZxcISK37C9oLln2LCZmyMG
	 B5F3YTlia1jS/cGgY5cyamlWi8gp1xOLKMDIds/oIlKUrru0XNGw3wndEs35CmjS3v
	 fvqLqSi08O6CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] PCI: ultrarisc: get and enable DP1000 PCIe
 clocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Wang" <wangjia@ultrarisc.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260714-ultrarisc-pci-clk-v3-2-e72723fc0ef1@ultrarisc.com>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
 <20260714-ultrarisc-pci-clk-v3-2-e72723fc0ef1@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 01:18:36 +0000
Message-Id: <20260714011836.9B6311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jia Wang <wangjia@ultrarisc.com>
>=20
> Add the required core, dbi, and aux clocks for the DP1000 PCIe
> controller and enable them before initializing the DesignWare host.
>=20
> Also manage the clocks across system suspend and resume.
>=20
> Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Comp=
lex driver")
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-ultrarisc-=
pci-clk-v3-0-e72723fc0ef1@ultrarisc.com?part=3D2

