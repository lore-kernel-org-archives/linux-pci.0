Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761489;
	b=n9LE+kB53yuQm4gM/+I25Div8ichELX1zsoFuvl/d3WTsUb8nlwBzlHk2GKNznVK0ZwA
	 N3du7ACtb9JWOMSlgPxehdt03tZ6C2XfqcMRVlV8Lp9rD0hkUyOY6cP9RXLQ35rUMemPs
	 58geq0iHDdiPQ8gs5+qnncb659BA93MnUlauo37Pz7Q1MnpcXFTnLHeU03aW6uSgOTeKx
	 Rh5Bw6yiIINjBx9skIU6QPYJ3J7xnZ3nvZhH9pwTuWeFf9qjizaI6X7z7oXthcOotqz9N
	 M8uPU3CmpsWl21EqbXq0x3fnFuT6T1DkxxmEHhmgWJQLtvWY7p33mpPT24jW80TQu3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761489;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iMS/Ln5KPPEeXaaeLuWcfxAnYjV9gGuPQZnibuKv10o=;
	b=GBmWH52tFHgOXjwcBO761c4GREglhxeP+6zgyHex+EnLq8klvPP0qPXHoeP6LCn3z3fB
	 GQxb/71fstlx7FEdEdUwe2NhUvM4WFUsvNVv1LRO/goOMQMkxzQY51Fs93Xh/C4yrDMX8
	 HuqZ0M3gK7MZ5UVE7wuNSSy0vgF56I1gmrLtyEQCMkCkZy1uiNPf1vMCpc1vJ1KOzGUTX
	 u29Prh7p4LOti+aBRfz3unVPTJPutZ8xZD20DejZLRcRUx0SmS8ibIZlhjPsznJ/qK5/d
	 jyKdqPEG6Ij99Vz8nhSp3C0N2a1XpyVBZee7+stWZr5QhvPPpusa6eqDrngVoNZ9A6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMvwKfGb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED7606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMvwKfGb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0091F000C1;
	Wed,  4 Nov 2026 03:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761489;
	bh=iMS/Ln5KPPEeXaaeLuWcfxAnYjV9gGuPQZnibuKv10o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMvwKfGbFeBk84miFGVk3WyO70Z+9VWMNdMr4+OTaTtKnAtdveAwqmvkZnwm3Pwcd
	 CrMFFx/vfxUAuI4Z024a9uYhaEIfb+uVc61eNTLZqNxZ0gVlbVDGYRKkhVPw/9u8Wk
	 QVd97G1s/BSxdIGs8xQkQTDYOXyFUg+80UvjUp5abEN29iHDPWR+0OXEs7+L8ck/6d
	 3MTNyKwPaZ5sAdeWa47pFFOwxd9yL9NRTOhZEx27LKbvg5ZPc+r5qW8ecGrI/5MxJH
	 /Xt/XAKu1wWLbs7ufYQT5OqUBZUJXs+vG0VUPuR8VpHSLyN7UUHXAtgoj5LV6k3jur
	 KN0HKTfqYwSCw==
Message-ID: <sashiko-outbox-196579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 21/25] dmaengine: sdxi: Provide context start and
 stop APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-21-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-21-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:04:48 +0000
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
> Implement client context start and stop by submitting administrative
> descriptors. Starting waits for the start descriptor to finish; stopping
> submits stop followed by synchronization and waits for the latter.
>=20
> Use the administrative reservation and polling helpers to claim status
> blocks before reserving descriptors, release consumed results, and retain
> timed-out blocks until context teardown. Expose these operations through
> struct sdxi_cxt for clients such as the DMAengine provider.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D21

