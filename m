Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795330853;
	b=mH5JzMDXrmWc+CweapjCpo6vBndHGimJcMv/TZb/tBH647/DLBXnTi5UB//G0KJGB6Dt
	 RBcaA1RKLh2rI8N4keorvH6Q7KZDbg+xecxEYbQVajTzlTWa2rksDfTBn4Atd1s7pqXZH
	 /MCd1jKwSMqMmJeVcm6seLuG/RQbwfuuvw2K2Bi+0bNejjHR5mslvtciX1T3HyTMhKq7Y
	 X3LDTuNppCYo1bnNyg4kg2q0L09Gr7fcgBMRq/foDhfcCs4yzbJSbImPpH6RIWqxIlMrd
	 KU0FMYfnAfFhynGT89Z6n6KNimGWnuH0tVkAitP/yaABM/sPj8Ag5yTij1xZVLIhNIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330853;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b1PBoaQr/vtqwRB42Bne8Gt7x3seH3DTrmTdPCjIrlI=;
	b=upNlkNm+qfWmVQ+vtvnG13wtkhv4MzALkSEUjllpwbDhAQoSv2285PqQwO5Zyyxr6tGG
	 kLnm2cFva+Jmk5h3zIP5gkDYRJpn9z+1RXIyfWA1vuKO9BWKuHsryC5hjDei23q4DBy6N
	 BsUeWnSYCdQ0GefPQXlnyxUPwyFQsW7epgsJAxzGLwWHTd1gm8s7AtZRUzB5fgx4K83Fo
	 RD5PNSWoR/9yP3dXDZAUImzEUPEKhu84jV6wC8Tbh+Su4zQZW4XB1SMw8lgdya+Em7hlx
	 KlsBzw6V/dnkKm0hTKHid88SMCO1jWsUw/aABkoSYhZBgnA+YUKEHth2/2EtO7vhbzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oq30XFcY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF1606A333
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oq30XFcY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1A31F000CF;
	Sun, 22 Nov 2026 07:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795330852;
	bh=b1PBoaQr/vtqwRB42Bne8Gt7x3seH3DTrmTdPCjIrlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oq30XFcY7N9JVQqmHZxhZkkZ8eL7B83vYfW0+hgHYXDwmBjsgl462BMECGgSnQXqa
	 b1DK9CmjcDH0SSAd6DDfuvISPHyeoAQ8faDyqctTJjwH6wvdFpz9/t4sLoegIKzQFa
	 FWIYe9xsFGc/COrdPb8+3zz/UNprSDE/8i7RwVzmCFJ1vPXR0+qAvqAySV6geACTO8
	 wQx1Tp2cFZSvBSGV9YsVqItMQ9Rpaa2T5ph3VUJOhNT7GYDm60iUnGVdNTvBY7i7Se
	 fLf2K2IOuwBuRMiB384ubnghufjPgGcHhkkFwfKVJDynMNaoHljU3ikBeq5cZfFWu0
	 6rhtSbffbhTjQ==
Message-ID: <sashiko-outbox-227776@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/4] power: sequencing: pcie-m2: Add PCIe M.2 Key B
 connector support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 07:00:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 4-patch series:

- Patches 1, 3, and 4: no issues found.
- Patch 2 ("power: sequencing: pcie-m2: Add support for PCIe M.2..."): 2
  potential issues (1 Medium, 1 Low)

A detailed review has been sent as a separate reply to patch 2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-pcie6_fix-=
v2-0-2e0fe615d90b@oss.qualcomm.com
