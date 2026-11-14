Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673069;
	b=yb5jcy5rM9impjLllSVMgSVmKCV4Kzqyw8tOsPcqqo7/BmmaJAubNLFHoPR9VqY28mLi
	 j3Ckku0HoQdqUAO+FHK9K1Uy9Hwl0hPwnPd4yQwrZfNZdb9rSlW6IyE7YuvRyY5r7qcpW
	 +W3x2BYaHW6T4SINWiigV2si1Sz1On5UqwLkcAmju9SYgAffK2GusEV6gN+uhZ5MD7y3C
	 NtEpc5py9/A/nMTM6Ho/GKhujRi77VsgIYiWDIj7wT7DCFv02dJHYwf5o7m+VFagi6Hai
	 beI4TdHt0CQyNkd8WXEdn9tdD0ioxf9UERlishviTYNmGiuWZ6bCBul/T1lgh67Y7NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673069;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wr0YDk2NIO72Qi+lObtIXD2n/bb8N256RnBpGouW3is=;
	b=DYW/z6FQcf3grW30Y+/NhF+voCRxqbM5AzP+LzJLEnob0I+fN1UQT1tPuXil58JswyWE
	 kL1yTSHW1LeoPQWU0QjYb7rCtmDsMIL0KJSrTRcRgp0e9N44ZJjy4IEKsi46SRhvj8k5G
	 hKKIVlBz77V69cVgh8SWtL+9pmKIJV5vicwS6e0zYdyaaA8vMkISG1zKYODWOLEf5cTaC
	 /vLEEt3fKQH0oKtt44O2I8n93MxujI2G1BVU8ldRESRXw7RvDxS6ne5iUhy3emOr2Ekss
	 zZewoGVwaSZulazJcvz27HD+1YXBDwQO+fqVpHXCf15G+vX9j94wvERWk29eFdDSzYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWs4TEsS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC46606A329
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWs4TEsS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CC91F000C6;
	Sat, 14 Nov 2026 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673069;
	bh=Wr0YDk2NIO72Qi+lObtIXD2n/bb8N256RnBpGouW3is=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JWs4TEsSGe0kyFleCxiyTr9cmPMMMoJW+emYWQfEtMThHeFR2D1CbpqZH0DFgR9wC
	 PKqxusV3O51mlC71Q4IdtNtqnTgaVINHEvzpSWGtLk7JGnJlv+Ze5EFuPAAz15yjlj
	 l6VT+f9Zqc1DLd5orZo/9qfCka/dnew1L77IUgxebAW96KM+wc2wJb8s5yDLpJfYJj
	 iP4T2z0B72YAdNRgPYt0vlZgFRNf0Ja1aDeE6vECDUD/1ZnBxmipo4Xz0brgdTOI3a
	 zbXIk6N94oCYiREbEm3zibUn3qXlsdBl0g9bqx9eTP7oGGLhcIp0ZMCwcXudkoD0Rp
	 ymevyRYgnYQhA==
Message-ID: <sashiko-outbox-214740@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] platform/apple-gmux: Fix MMIO interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?= <amd-gfx@lists.freedesktop.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-4-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-4-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:17:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] platform/x86: apple-gmux: missing Fixes trailer for commit
  0c18184de990
--

commit b19f0c98a4551005b56d57291e3256d29b977707
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

> platform/apple-gmux: Fix MMIO interface
>
> This patch brings a lot of fixes to MMIO interface such as:
> 1. Using 1ms waits instead of 100us.
> 2. Checking if Timed out before reading and writing
> 3. Adding missing wait before gmux_mmio_write32
>
> Tested-by: Sebastian Zygadlo <szgit@icloud.com>
> Tested-by: Yossef Osman <yossef.osman@proton.me>
> Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

[Severity: Low]
This fixes the Apple T2 MMIO gmux wait logic, timeout checks, and the
missing pre-write wait in gmux_mmio_write32().  Should this include:

  Fixes: 0c18184de990 ("platform/x86: apple-gmux: support MMIO gmux on T2 M=
acs")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D3
