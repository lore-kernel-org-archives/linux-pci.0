Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293256;
	b=5rYlNhIaaIlAPfpbCIM9YkVZVwegK3sz7bcMImfUP8XA1maERnP9Ed1fRUu/8lHzNcge
	 si4ZteO9r1oJ6Kl8b4wIQQg9YojOXMlUYz1y0Z61fROSAZHhq6PmZ+KP9dWyRekvtl5Fu
	 m1/Uc83b5UcO/IvXZmUzQp9EOfB/YF1fUJKoFLGSemecUjnIMITpCI993ZIqKGnYwZ96U
	 V9x3i7lLE4TppiosSlbOBE1Pb69LAWjWddyZlzSZKF9UvCBnR9eNLIKjRnxhVUP7a/j7y
	 8uaiQOGEzIblySGj05DkpvUgk+Dbam65fih2Jkc3GpiuZk2VtRXwJGvUnAq6QJSJFaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293256;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/SkVqrmXCCu+YhXaYDbM0WKeXA7PXhoZA95x+bSgAts=;
	b=3XT2U5G3gU+6c8pwYgH0DFxShYP/k/kactGf050RdKYrjA0KXKshqj8m54lcJbL4EHJZ
	 GculuYdO/Ak6Wx8MXaqmz9Tuxs2FaLDVs66RCQzSAR6RbIyCCER7UxERSGIOEn68Jsm6A
	 oHhSuwCuJG2A6PN04vRDJ4c77bq+wI90UrM2ffdBBSAOdZ4f8TNZ4hopONrzN7IGXQ0CJ
	 h7dRQV9zdr9JeSfXzzfaowVTfx09Gkkg+fixvHl2lGrbmmC//k0xnldb1ZpkOBZ6MPVbE
	 VCBeRwN392vzPr3ZwBXu/KWJJCyPnwbM/iUdto8WjxyWKnvt65O/fgiu0gr263GsLqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEo9h859;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200A606A33C
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEo9h859
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358791F01825;
	Thu, 29 Oct 2026 17:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793293255;
	bh=/SkVqrmXCCu+YhXaYDbM0WKeXA7PXhoZA95x+bSgAts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NEo9h859tvPB99KXhNL2VZFQxxYlJIyc1uQOMtLwnZsVicPCQKWHmCzGz4cmXKrBV
	 nFVsEFU7V+dd6uESIUdSpnRDyqQZaJERq3Y6XmYZz0/cAP3mMCNkfetSx8ZNKCAQtn
	 aJ2YLbr+5KVPsfJP6+zdTksrsQ7tHgG+j+Mg/aQbn/c7mHCp6giD7tEnMdS45+4Uqx
	 9QqjuPPWfHeRz1+Ys3m4ENC41zn4inXLgK8HKraRwXyDj62DzHzDti3IcEhmd8SDvX
	 I/sIKfr3dLDs/qLoaSeQM8lHukcDECI+pTqz8oMm/pncrK7L25tRSQ2F5MyZP6I3x/
	 Fg1Iz1Vkwd9WQ==
Message-ID: <sashiko-outbox-189702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] ath12k: add PCIe link recovery retry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029163713.1366077-7-jtornosm@redhat.com>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-7-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:00:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> When ath12k devices are passed through to VMs via PCIe passthrough,
> the PCIe link may not stabilize immediately after global reset due to
> virtualization layer timing variations. This causes MHI initialization
> to fail with "BHI offset: 0xffffffff is out of range" errors because
> the device is read before it's ready.
>=20
> Currently, ath12k_pci_soc_global_reset() just warns if the link is
> down but continues anyway, leading to inevitable MHI failures.
>=20
> This patch adds:
> 1. A retry loop (up to 5000ms) to wait for the PCIe link to recover
>    after global reset (similar to the existing LTSSM retry logic)
> 2. Proper error propagation to prevent continuing with a dead link
>=20
> This is especially important for VM environments where timing can vary
> significantly from bare metal.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029163713.1366=
077-1-jtornosm@redhat.com?part=3D6

