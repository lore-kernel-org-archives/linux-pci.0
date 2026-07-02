Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA63368AB;
	Thu,  2 Jul 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007663; cv=none; b=Ix2nbOj/kz1IR11fW+onGglBp5m1H9yJbTESdGcDewcOW/FLY/3VUx0Pi3RvD3m82G3lvocmbm63jemEZS8+E05pQtW6mKuxV13z4jyZ1edt3lzcp4z7eBn3JZ/UDNvokeWR6Vm+rxTQittE6fYSn6MbAuIMPvBPVxFOyDWmBTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007663; c=relaxed/simple;
	bh=UQN/ulBGEMPe0Pumu5fkewtDCPeEZj7oOJ2MNLZMVTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aFzM07ACdykYTgyR7OZfyIuyFuUUfE+WxrHpS88v1G7oheiipQFg4fseqAcaM+FbiCmP0W0sSFrAdTKjD6M+diVpKKPKRHqTQpdA8kLawZHHSvZzZh8qNkv5KeApPE6dwPEWaVq5zrvzjl5fDo8SuxRpuXNvlDrqzS5y8CMoMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXjEJE51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXjEJE51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055F21F000E9;
	Thu,  2 Jul 2026 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007662;
	bh=UQN/ulBGEMPe0Pumu5fkewtDCPeEZj7oOJ2MNLZMVTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXjEJE51vOsOoaWIzpRk3pY9F2SzwkGi+m5FVl5rDTRVpctNcpMfPv7PNxj09TjRU
	 IV9ASpEvpXu4yM8cZQ8oEoC5c/RZ9z676tV+LeVqQ9SweLe1LJd3OQ1M5KY3QKOsym
	 K8Rl1rRip9eBv7d4xnvW6t0c+YruIOakefjgxx8gUPARdvNKHIhK00KIfca/m7sm1E
	 g2cyvTBz8BnRtWKMfCWB5Y9SZ/BBNVJSsYtZqbw+G5/8KUZMr/16Ju2rRtzWGHfGjt
	 /jcQV/2xqq2bahsC/zjZyuS0hPNoot2Nf3h7BsHJA2JVlZDyME4i2LgVQIOUmpEI1D
	 uqVVAYDYWMVFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/11] arm: Use sysfs_emit() for cpumask show
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: neil.armstrong@linaro.org, linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-cxl@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260702154725.185376-2-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-2-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:54:21 +0000
Message-Id: <20260702155422.055F21F000E9@smtp.kernel.org>
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
76-1-ynorov@nvidia.com?part=3D1

