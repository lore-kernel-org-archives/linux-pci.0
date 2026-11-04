Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760939;
	b=UOGPXaeypeJzsc1l56uGXVRpkfvM/UbCuJUM5QW6I/XcAxXcvzD5iInTsIMLC9OgKhNC
	 7QcqN/93+ZWTTzzy0548wEf7/SvpbdF2qwuowkw0TmLQfGk3ATBX4FuRzNS6IFOOppNFU
	 68zI0aHpf2nvbKfz2glhgUY6WCVx+XwgIUS/xcK6RP2r9zGmn858L2Kz9xQ9al21/ubLj
	 WLzUx2RyrliLNnhiy7pWWHbQ2ex5aBmK6o/a4fYEwlHhDnPU21mrRCIOYBmkcPtJk72HH
	 kswvsNZavAHVxV2OSANvdhbTOSm1DAaBz7tmW/w5rr5E4cPRTcpNbEiy1Tfs5JTcwYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760939;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pef3bUE5hPWKofXWTSoSRyxs2cdCnXAmAUTuvomi+H0=;
	b=5lp/fPIKZIErr/iPi8wh+QxB5Qv7K22o6mu9+L8IXSxZkeM+T9zHWfiyVjosZVETxh/P
	 i6imS6Ph/bHC7hUyttLL9aD9t43qoF2VYZ7ADPcCowHaujiduddTwISXNKvT+c3/VC7eJ
	 A/2wHtLWqg4/KLxk02xcKYd/bYH3N4pQPIK+J3Xy4oD3uvgZ94y6IIiI4PFLyq08pXwMs
	 3hiGM7qhSFCXHi21Qz6XVyIZkLCdF81CkDOuYBzFWdBgGnIysucSboThZpTaesRdr5IKg
	 U9lsFeIOBYOv9CoWJGnSsi9WQvKYtRoTDLyoe8f6QSvzgQI289IILORDCxHoeToSJJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ao6D3H65;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61D606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ao6D3H65
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A081F000C1;
	Wed,  4 Nov 2026 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760939;
	bh=Pef3bUE5hPWKofXWTSoSRyxs2cdCnXAmAUTuvomi+H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ao6D3H65nuNxjz6UjyvdpYc3zs9xjNruVJaAj9YOVJkFPiSMIcwION+1yoO1VKkJ8
	 Qi/JZl+cg2up/6OcN3SoisV/qOEJqwsnTmKY1hJiH/pny4mlI05u59moBTCyXzolxW
	 8lr2wc99geyQotgdjzb73khBXO0XwOhSgfAO3sG9C4ZgRVgULSKWKUJ1/rhxOA/8re
	 8sKSsjQdulqOt+XyQp5nl2ovo/hk1mCqkc6+M2zeYFpAJtdjCTTDOAw09b658QwgdG
	 8IH6Kb5AvD9wDrEbDvi5hJUy9KfQinZaBMx2rJlZLt9xOccO7ZnY4coRh4jHg6ylTd
	 YP7MCHZt8knRQ==
Message-ID: <sashiko-outbox-196545@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/25] dmaengine: sdxi: Configure context tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-6-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-6-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:55:38 +0000
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
> SDXI uses a two-level table hierarchy to track contexts. There is a
> single level 2 table per function which enumerates up to 512 level 1
> tables. Each level 1 table enumerates up to 128 contexts.
>=20
> Allocate and install the L2 table and a single L1 table, enough for
> context IDs 0-127 (i.e. the admin context with reserved id 0, plus 127
> client contexts). For now, to avoid dynamic management of additional
> L1 tables, cap ctl2.max_cxt to 127.
>=20
> Since the table allocations are devres-managed, there is no
> corresponding cleanup code required.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D6

