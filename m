Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9613F4DC7;
	Tue,  4 Aug 2026 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872327; cv=none; b=N9HuYIah5uYJS9Eh47VQVFbxFZNzyfoQmhz1igUkiI74UCEp/wFLloI84gJBSFUBMoPr9FNjfW3jdLpxZAQmkeq33QNFJBlbLUm5c7omitzla6CqmGbXHf/8dG8bHB8kIxm1FQevpH1vjYnwfbpY4yDUsSydxaIca48Dak+uUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872327; c=relaxed/simple;
	bh=wOJtDaKKweLTvF0w6+XZ7M/iwhw8vHtbQdUN5nZxA+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D8rf04QkMhOC/BG2jBmdelXcQh50zha28fHPA2Kjb1ksh9WWicU2J2+N2Iz1fvvZp3dLM5HPCcOC+XKq6B1guF6c+OqqD9hmzmPeeOcb56VchLHu+egoPBIYyEpIC2e2Kfbvm34TRDQbbXNrv6IYLrA59XKA1Rm2nxBwEXrBPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML5a/Ka4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML5a/Ka4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAAB1F000E9;
	Tue,  4 Aug 2026 19:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872326;
	bh=wOJtDaKKweLTvF0w6+XZ7M/iwhw8vHtbQdUN5nZxA+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ML5a/Ka43v5cS6wSaRwWLGDIXP7x0LDlwyT5UstGY5enHrIgLjfmBIxiyR0P85Ueg
	 yRr9GCTQnRLk9u2y2/vzRXazAkeFu1MqbOI/oi8IqajuhfIBdK/WW5nm4Q+BPBM8aG
	 vy4yNEE7VQ23dOCgKH8tEbfCMrgem/ueY5vLPzYCWNQKNiOBKaA76QQ1y5ki1VUovy
	 h49LgoH0k9R02Rxj9AejfBQSnAlvT0qLKopDpKUIvbviSQ+LRtCk2BnH0qviR/mIpd
	 IloeNjRqKWisIe9zxIbsgRYe1uxnnAxNvaOVulviisrpKSL2GpLcPmMwnCla2eCR/3
	 66xyjnJuMlplw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/12] cxl: Validate HDM ranges before CXL reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260804192958.1823952-8-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:38:45 +0000
Message-Id: <20260804193846.3BAAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Before reset, require cached HDM decoder state, collect enabled decoder
> ranges, and reserve them with request_mem_region(). This rejects reset
> while affected CXL memory is busy and keeps the validation stable
> through reset.
>=20
> If CPU cache invalidation support is available, invalidate the affected
> ranges before reset. If the runtime backend is unavailable, continue
> after the range reservation succeeds.
>=20
> Reject CXL Reset when no cached HDM decoder state is available. The reset
> path needs the cached address map to validate affected ranges and perform
> CPU cache invalidation. Also reject normalized-addressing decoders for
> now because the cached decoder range is not a system physical address.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D7

