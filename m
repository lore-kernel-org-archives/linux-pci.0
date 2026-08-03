Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23462DA756;
	Mon,  3 Aug 2026 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796297; cv=none; b=bsN16qSYtzsOXSz4MHPJi5NjPgQYAHPyQzVnq3LCPVa+l4z9sztHfJJRsrpm0Zohs4gdNKnYIoUx9kqViKC9X37wo/XqkuKEGrPf/A8qH9vIIwbQT2/r0gyLE70cRiHRZeQTFKK4DOusAx5og36RNJcfXr5y98syE+zju4S3sGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796297; c=relaxed/simple;
	bh=kndnwqdpNb1o362hOAhWvWBeQRczaxJAuEqfnwNJ1cE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hvivCw0WqEbt3INoxOkk+4BGshQ7Un3v1aB20RPgMalEU6ztSjWTOLHvPfmKFRBXdVVk5aHE6XHITPsj2F2m0dx/cJF9JYlwSuQFAoikvm0JBzmQL5Y8tzXkyMLiCsLafCN6EAHEiYPOrD5ubBKT6/g++vxSVjKlH8e/yEaD6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc9avISW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc9avISW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAE21F000E9;
	Mon,  3 Aug 2026 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796295;
	bh=kndnwqdpNb1o362hOAhWvWBeQRczaxJAuEqfnwNJ1cE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uc9avISWri76sQaoL17c7qSR9JhKqL2n3E+YENCmKCKvijBh5JiqQDXAkhYHlxwZx
	 a6JQ9MdyfKhqM4jb1zb+cOuRyeXQ2V69neJVLmVn2xut/rngGTBZ/ZXKcqSBMeTosU
	 3EC3TrPAa4BqFpaqNmKqq0nNbclSiIAynA4YN+6uH59dpMscdz668RW0L6L7fFnXBb
	 2EHxzUhJIjLXS07wiYfxwcycAAyF1jWAkv5Pzd+kSM3q1eIrHVbXzFkVyx3ZpwmykG
	 4PpbQ8TVepJ9JBOzcarMuvUO6WLuwDyKt1qx8cHDZZiTggMXB1iN0n+//E4RDs4F8h
	 YibZRCSWPyDfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 14/14] Documentation: cxl: Document CXL protocol
 error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260803221810.3685703-15-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-15-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:31:34 +0000
Message-Id: <20260803223135.5BAE21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> describing the end-to-end CXL protocol error path: AER ingress, the
> AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
> cases, severity policy, trace events, and a source code map.
>=20
> This documents the architecture introduced by the preceding patches in
> this series.
>=20
> Assisted-by: Claude:claude-opus-4.9
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D14

