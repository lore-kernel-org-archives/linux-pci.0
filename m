Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761328;
	b=Ue5CHCHnwnnnUSuuG7rw5V5cpCkzMpbH2EMi+AKljJHRM2CtFGJMdJgXHIxj6ptRNAhP
	 lIndMl/2jasVjxK90iz1HKCW4rBdmXVpuvbA86ZSyOhsWdvk+nJSHNYbiUkEo38kWHI/y
	 fDvKsenS/2lq8STE1a6cpGO08599rqR8iqF/rtOg3cFTCB/PSVjg4a5Luf7aamqfrBFQA
	 KXPgPK46/IFv+Atxs7JhvnTlr/3aUeXiBEtc8IYorsULd3umiRAgOYmeksrhu4+8go7rO
	 r8lDJVGlFGykm0UMRnIUpNfP8jv8/yLndUq1pvQT+gvSiHNAVaUwLE/Nyfhx+JkGmoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761328;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BhYYtTApPLShiNF/2aY6UfeBtAw6n/znOCJ9z8DPHkg=;
	b=b10Lnvu5e+CUYCoDprXIY+1nl2sXYEB+kVpIWd/TkWJ1tVkaw33boLJRItfHJZHsyeZG
	 DTS0D5Ux78RD3VK6w9pBFirfPAw2lF7o2W+QVD7VSBU0WWv+XTYZ41n3kfClGq3ooRJE5
	 ZY01J3JAzQTuWYV5iLLbhYFnkzUEJIJRPtbpgNAXtCftArawDsVgmMGqMGyewL1cEhLXa
	 RDWumzpN5wRJfLqrff6xm1Ea/TMfiIVmhmt6vWyztcVwBH7a8OZ1AGx7F36vJQcP7Hp7L
	 pjqLIH6kmvTP3qi9Zc44tJ129nEJnCuvn5jh49/fsX9awBkaDOo4lFNhlm1HOkUmjNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LggNtK40;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C6606A338
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LggNtK40
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8B61F000C1;
	Wed,  4 Nov 2026 03:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761327;
	bh=BhYYtTApPLShiNF/2aY6UfeBtAw6n/znOCJ9z8DPHkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LggNtK40MwmZsgKt83KPgY9aRlwL21WDgtXONX+Vfj+UCCOgkVm7OYkgutQidSL4i
	 EPxISv2HaTf5jgwlPa1m+m/yeSLKvLwW7TG4PCRXPT1RE1sheUv88bXNLVPNu4LARI
	 +IH8SRGYsHvElrQVivFupMNYnpA8yQg/0eI17wuLl+hW6PIzd4xypv1l/LcaQsM7s+
	 c4mjquzZkxIKVvsrDbA68VsSy5kbsAh+ri2zsFNORSj7xoWFAzErMJaHYawWQo69zR
	 Rg35qrXpsoCabrmjgVky6Wlw2Q8lM6Jlh/Ktdk+S5BJocDrvLIovmEl/jwRyDooxX1
	 5pcfcHuq7bUig==
Message-ID: <sashiko-outbox-196562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/25] dmaengine: sdxi: Add client context allocation
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-12-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-12-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:02:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Allocate and publish client contexts, track their IDs in a per-device
> xarray, and release them during device teardown.
>=20
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D12

