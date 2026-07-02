Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8B331EB6;
	Thu,  2 Jul 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007707; cv=none; b=AALMFSfqAepL5usYTuMlrmECrmeSKZbzimEH5eQ7/vnJT9CdqBOekNB+uB9nK9UTz/YlM19QCV0kySoruy3IDev9gKOd91JtPhNzmSEd3FoMbZnRRKsgtGOp/orZtE5oACQ6uasiFv6eQCKzntDXc410QRVO/I0Um7QXwezTrq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007707; c=relaxed/simple;
	bh=JeAFfreswiIRNdsHzJu8ZaO8Dqg3y5cjgk4NSRHdnHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TVebruN3MYHExdLwg4H8XQbUkopz38cHJOPYVH0Hxos+oaFdOin3/F0QNbC5BUh8P7DgAw2QktUMwI1ovPgc55tUL2/PwNjwRlNqCXR4mkkvweOp/0vTZCCl4nSK3eHVMFWQVATGcgl2Vb1c/ivtEUH/3Q8JSNLf/ALhraYbcDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERuoE0HO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERuoE0HO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EB61F000E9;
	Thu,  2 Jul 2026 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007706;
	bh=JeAFfreswiIRNdsHzJu8ZaO8Dqg3y5cjgk4NSRHdnHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ERuoE0HOa1K337emAcjfr6fEMFzBveFxYblQj9JtkXhRhIEibmhjnkf+8zrYlRbST
	 mdl1qGH2jRHd/3SbHPPUliy8InrbI1zDE73gHjEYQZo+PpSHKAURqbhTwHG4xr83AK
	 vTIzktfRyiCd4VAb4dspDWCMerBUY7LulFAs1J6YAgnWeYt0BsY+KM/V5T4bp2bXDN
	 CpRtJj6HEKarL7z5862Jzz9zna1TD5H641Wn+ZVxvASACQceuUqJXNrqSqhCKnNoh+
	 JiJaI4pl3tMZeF+T02C37JR7iLB7ynCQcgfv4ABRqrwyKRl2RPxpTBkygCA3H8udAl
	 z6baFg0JuVgSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/11] devfreq: Use sysfs_emit() for cpumask show
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, Frank.Li@kernel.org, neil.armstrong@linaro.org, linux-perf-users@vger.kernel.org, linux-amlogic@lists.infradead.org, imx@lists.linux.dev
In-Reply-To: <20260702154725.185376-6-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-6-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:55:05 +0000
Message-Id: <20260702155506.61EB61F000E9@smtp.kernel.org>
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
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702154725.1853=
76-1-ynorov@nvidia.com?part=3D5

