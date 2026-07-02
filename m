Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F130D400;
	Thu,  2 Jul 2026 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007772; cv=none; b=kWb7WXVRxGohjC0RSHOKdG/RX45ZZr3776iN13LOwhjRmVqPbwu1T8OCVc5T2BLM69/aOHxh9/d+FFFyhBUfZIv9xNHG6sDTxbGH+FfAdLCsPRpuADbc6t8Z4P/n5kznJwYS/CMdBg8+49bfLyfBStWq38yVV/OCBvkcXmDrIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007772; c=relaxed/simple;
	bh=cIFnEIkKpjgp2EyaqZwVX9TRZDm6r8qWcsBcKP2yb+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nOzQV+AU0AAjG+AW5zMI66k6lhHaszuGHdDS2mPMJF3ZkD92YwuacT4fu8GSCZfcllR9o21APcXdPCAhy3nvRztI1w6bYSiiHvbwqdg4UJbffVuhEpZD4sIHN1HkeFIKaVe6l8DBsg9xjEzBsXQgS4RCnzW4iI1mptNZC8+wiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEmMPFq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEmMPFq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658611F000E9;
	Thu,  2 Jul 2026 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007770;
	bh=cIFnEIkKpjgp2EyaqZwVX9TRZDm6r8qWcsBcKP2yb+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gEmMPFq2a7WvV/MOiUxFbnvBz6+8LmfxVtuPC0+FB/ImZW72Ntt+5IiHJDjEOdr19
	 Ysl0xfx3/AL3poqWG+VSlVfYavvsarPh1223cv0E6SVcO10yoSYI0dcNrP1z/2FMUM
	 1tMVUGOSXtjy4F1hkfqz10TSFF2jOFwKY/YKej0dEoEIz3H1LoHCj71xe8iONivSRK
	 1/cwAGWfJRnRosfObfudTf+a+6KaodLnVYvybGYaEBaBsec/NNK/uUePfmIb5jKBDu
	 fqMPTkYhY55/mVqYW8VrHk+Ktvc3YiFqyOYFqn0j/2H7/L0m7h8gOFfJ6nt3mZBeOB
	 CNnSgsLBBYkQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/11] perf: Use sysfs_emit() for cpumask show
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, imx@lists.linux.dev, linux-perf-users@vger.kernel.org
In-Reply-To: <20260702154725.185376-11-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-11-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:56:09 +0000
Message-Id: <20260702155610.658611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> These callbacks are sysfs show paths. Use sysfs_emit() and
> cpumask_pr_args() to emit the masks.
>=20
> This prepares for removing cpumap_print_to_pagebuf().
>=20
> Link: https://lore.kernel.org/all/akANJ-AT7nHpRMq-@yury/
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702154725.1853=
76-1-ynorov@nvidia.com?part=3D10

