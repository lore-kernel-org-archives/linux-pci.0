Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657826;
	b=w/akFvHqGjglfMBbO3x50D0cDd5aomK8awzP+sZ/5M7SFZayynRDG4Nob1EN6t2A6Lul
	 j2AKtnwr9SfWL9ECNB0BWF8TSbwJSBGkkfz/jYRQo4O2jSFG7P8/T2p40+4QXc6teJb2N
	 pgDchxsEhpI6cyKb/0o/TogWyXYsd6IhN8CACWyP8EmHcRBKQ4cxcBqT1KUHl6aoUMqK1
	 xIYpsPUbKaapqXWwgSugIoxILN7A5zOGQyJRYr5xcr9vRLU9NuWGpcjTZVgoAKvDKyvKy
	 /oORYqtcGRkr3aPiIYZCCSubcdOEfDPAfRJod5Wx25z0Wx7Bat2aT75lZYbKIFaU8Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657826;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=th/5Zr8T2GorAPMBbutFHoN+vDr5aeGPA57V4q4qZtA=;
	b=gQVK4XFSDqlqeJXCOImf81ExWHA7XLWmxGbQvOlIe8Xtu+P/x6fjevFF+U9c59vC8jpE
	 3S3wyMvTtjnBZOrl4oGhgZWhCbpdBBXTdUs5BRqFd/uWZh9HOUCUak5tuF3+3bovph2kr
	 p9o8TVGLOP0yetsazoFQUCPDX1z/Z5KwbzNMmzV8QKoQvF0gIduXe5KFk/3CWTRXaJ2B6
	 0BCukPCoeP6hg5SadRShbuqVUp8xmk9olUfuRzEwpHlxcvB0sSHYBXzqDuospvwbzX+vC
	 4fSAnyVbq132t521yyIcCIpnS8q7uQUauM0n7iqsIWW58NHqy1Hl7jXoDjbfl6pQl7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyBiFupp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902C606A319
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyBiFupp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6261F000C2;
	Thu, 22 Oct 2026 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792657825;
	bh=th/5Zr8T2GorAPMBbutFHoN+vDr5aeGPA57V4q4qZtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eyBiFuppusPnvuBrVYdp3UrWndg44GSL7FKFw7dA06OMTW8UbouebrKWPa7r4VHk5
	 UdS+0mUnnju28rh1RYEuyyE28B0M9MyvEbOu6abvh49v6kEkWnfqpWBjn7VKHVJQI+
	 X5pk6QjyZkHawtCStLWKaNTdNxtmnjW7Dw3b44ZPD/4Og7qmKD57CQpY0l+oc4nnx6
	 qbT9ygVhJK1mGWPPQthQsuMmZr5mUoBM5x8xDrjjQeLlcrt17VQuBQ0cyNgdlu6zce
	 LCGxb50uKNiPrRxMm2mJLdIh2+KAOr+IKU/R2s1nXIbqM7eEisYFXfYPR9CfeOMLDd
	 qWfCgwi0Wf4TA==
Message-ID: <sashiko-outbox-181171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/10] NTB: ntb_hw_epf: Use the shared NTB control
 layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261022082230.3164834-9-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:30:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Currently, ntb_hw_epf.c duplicates the endpoint control layout with
> hard-coded register offsets.
>=20
> Use the shared struct and macros in pci-epf-ntb.h and derive offsets
> with offsetof().
>=20
> No functional changes.
>=20
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022082230.3164=
834-1-den@valinux.co.jp?part=3D8

