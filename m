Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286186;
	b=M5e8DG/zItP0kxDwF/Vmaf1oE/B3MpTCqK+cnpoRUG/tAeVAQ7hLgD2qLzmG+FqRocGo
	 XY4felGLT7x/ERkfjCV5NuTX0eb3RIYcADlQ7S7W85jgvkZ2Pw93kYUB1MRgOCb1yAg+I
	 dcBEBp6udiNftrkrtQeCQ3BMEZL1Pol4GEjoa16vC+Pr0D7VAg43hG/vvA6HyWsuxfvEG
	 apMHOyrlV2wnNv1MoVcTQBOhDllmJTq1kBnxuZhrAuqfkZPXegQNazVcBvBj349yaZ7k/
	 /0SdgFxHZ3IdmXorx7OL1sgxlW3khlfKrG61a9t5unXbmHdq73Hmu+bLUi4jyGxiUEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286186;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ESArhW/BXtswcRrj/Mei/A6bh0O2/0M2v5lFKlB/v8U=;
	b=AL2nllUN0nfjYchLph8gckgQLAWhG1LRArspVVIB5ohcgy1u3PWmLAU1hfJyRM/fAgbo
	 WnPK0PkPexORe8HYkiaei0iS4hvuTmtBHhbtpDH9pVXZe/64fSbNrlSBsynySszdJZi8S
	 oWWxkOu/jTCHOdUNErcbIYcXUm0QAYQ2IDVCr33zzs7Kh1roR29nwsk4akJ5OzDJneZ/r
	 ihFNQvKMoo7+HFzZibQeYpZ9SwTAoPoP8wfMQICOvUZLE3q9H6/jw8O4Hg0ZLnCOMCpTa
	 I0goWAo5tdum128aIS+HVNzqYohslU43spRjO2gqotOTDHm17tRogfrRCXsE/ZMrh0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PY6rQ4rc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93011606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PY6rQ4rc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460D21F01825;
	Thu, 29 Oct 2026 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286186;
	bh=ESArhW/BXtswcRrj/Mei/A6bh0O2/0M2v5lFKlB/v8U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PY6rQ4rcWxkG+xfLA2ssrwUBy0f9FVMa7ZA+B2Bmvq/W+5CY6oPANavP97HbZVdCq
	 T3wQXNWyI2O1EsDLdjScFFREcQ9NUyfmaQC3CicHs0k6g06EMEIQY5r8HAu6tON179
	 Wx2wtswBaLeWXceOWD1bU7rm5zAzEkY43STIQPXvWfqT5nLor51K0xOQqy7WlODdiy
	 jvNHWciGH0855laGgL25Rk0Vrzqts/RQ1kxpBZtfeYHHt7fXH99/C9HDkAhE6wZiSm
	 04gjserZDm8n8O82BVm0aOoUCslIAILtPkbznzR6pLqsUgBNFfIQNwBGbGDjKmYXPe
	 4uN1a0vR7TFyg==
Message-ID: <sashiko-outbox-189567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 06/18] cxl: Move HDM decoder helpers to built-in
 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-7-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:03:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The PCI core will restore HDM decoders after a reset, possibly while no
> CXL driver is loaded, so it cannot call into cxl_core.
>=20
> Move the HDM register programming helpers from hdm.c to hdm_regs.c and
> build that file into the kernel whenever CXL_BUS is enabled, including
> when CXL_BUS is modular. Export only the symbols that cxl_core uses.
>=20
> Keep the DPA lock assertion in the normal decoder programming caller so
> the register helpers do not depend on cxl_rwsem. Leave cxl_rwsem in
> cxl_core until built-in cache management needs it.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D6

