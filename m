Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF730EF86;
	Thu,  2 Jul 2026 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007732; cv=none; b=DGj/hUj0r0k/CQcuE+VuUMyKWBHzfl3LMXRyRKtUAebNWn2nvZewmySqDqFMCE198RcqTpPFoHuApuFATLhtI5BUPTSFTdxCEZaSdhogUXXcSVA8kOUJ5MEnFXQXVhCwqvZZbM7UbjYSOVmdi1ceaG7TmL4TcTtg5ZqJjEbRAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007732; c=relaxed/simple;
	bh=M95W2kiexRbhvzko8M/qdaPrG9dB/Xndyu6bi7MzSdM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cM900f4bCOKYwkO+/J07dd7H2v/OEpcQ4EPgmQHc3j/1wzIUQ+t1AyKZC/K2BRz52lTDdHYTInRdYu+JYwB2zxJk6QT2D1TI4bnaHmH/8J34fBRZLAwajVTeXeAEBzKw/tMZdRRE3Wewy9CJCPFGAWg+xQgp+ivjHKRPMP4PzDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8qI9BXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8qI9BXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9257D1F000E9;
	Thu,  2 Jul 2026 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007731;
	bh=M95W2kiexRbhvzko8M/qdaPrG9dB/Xndyu6bi7MzSdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A8qI9BXW5w24j8N6RwLFMN7Y3bD6QdwueuWdBgmqfS/KxaAW82u6BsNngAAFDX57m
	 +DHXvJ43tbjneb7p2R+C5Hnhi+7Bnv9yjty8Rtj1LTAZnLzsXjUOoM9Qv3XLjITDkr
	 Y/xDsdkTAFJiWPjQcU2xA9kAfySoCZu7/2XXyhp7XP5hdCC0QyJUZwmpPirSkXJZbQ
	 xm59s5/RN52ID6hoYoDiB13tmHCHrM5k3ELdq4nNfYb1SpyRObxm3GTNz3msNy5eKF
	 pX77MN4E+EVA3qm09LyfWEwYMiucT3m2hDPJ9JL5+8s3vEL4bSZhhKSUW13uEFVQF9
	 JViP9HrFJU3ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/11] PCI/sysfs: Use sysfs_emit() for cpumask show
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: imx@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260702154725.185376-10-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-10-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:55:30 +0000
Message-Id: <20260702155530.9257D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> These callbacks are sysfs show paths.
>=20
> Use sysfs_emit() and cpumask_pr_args() to emit the masks.
>=20
> This prepares for removing cpumap_print_to_pagebuf().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702154725.1853=
76-1-ynorov@nvidia.com?part=3D9

