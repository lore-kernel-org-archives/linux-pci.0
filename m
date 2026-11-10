Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303352;
	b=NZJzSdmv8TTgWhw1TC9kSFEnNJVO6x5XBU2/YSpOErjyJQsbDyuLmcBPU6AkdhW6Yj+b
	 qnC4QllUZDnQrsyCaYt8ZVZjw7yy+21eDrafYVvBlvWbm2DaQO1sGFT7Q2uoo/Sz4SXn3
	 8EEJ3OXD06phAUD4Y2/RHF2n5FHkcWXYrzLDhZdMxfZXUXddd45Ii9mZ/TjSz2W0oJsRh
	 jDEizgLFTv7uFgdFNPOwXedJfcS4/6bAFfRBn/Y61COAv4JVnEfh6pLBFldoQZ4J3I/qq
	 +S5omKvX207aExvYh7K6y3tT4i1aHFKXLjD7LZeRg7UJke3laGh8nAzif9KggTQUTKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303352;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AnqUAHJkRbkroZZIunwQb2/YJfJQURzSgPdYoRPgNHo=;
	b=BMK8e8Jmy0b4FU1vx7Ek10NfNoIWmkda6CQ4iqgw+JNZmfdfKA9G6cihMmJnCchDDBEG
	 zjtiwsVJhZML150ELw90FYSq4nMvoG0W9sIUnKwzGTY9IlQOOoi1gLbsSL7xlZ3VPjKxo
	 SzMb/bSQno3JVl6wMOvL6IlYuQ2cON8B/q570p0sEgvYouNs8FbYmDguwOsu1moNrHkuH
	 PUSE6P5EzevGG+UaEyqpQblSErkLFYGDG0rQP74FebXDJQI7H/e7FEINlqmNGww8m7KSD
	 kHxdIKmRTOYCV+V+MXrSB+KPUC6+G1WI7Q23Xgk7TJBHy0pfqvszUIC70jWORuVhvAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRa9mDSJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4C606B144
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRa9mDSJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C6B1F0089F;
	Tue, 10 Nov 2026 09:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303351;
	bh=AnqUAHJkRbkroZZIunwQb2/YJfJQURzSgPdYoRPgNHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LRa9mDSJJ0NdYtVkWQFkEKTzWbIletKVUvfSIoLBuuZmkqMwOv/nICKQNWYYQgItG
	 3ULVNRMeeKbF3qQTEIHE618BDfTqRNQItzVtpwCYIQu/zrvH4qqRb77hBq7vyB0tH4
	 jvuq7ohGa56YIq6w7McGa5116oqiqhvy1Oa2FfF8/T+qyYBfJ3li1Lb56w0ylJ/67P
	 ZqYEilW6k2md0mgUu2Fukb6vUfY9lm0vikemJhKmzpsBw8TDqSSGWsy6CviDHOXjsb
	 C/UiVzI1IFvT8RbTw0qZp3Lf/YWzLyRR3fapvf1doQtecPwhSTytGIzxlrC+Ln17nM
	 IoF5CxCVz3EYg==
Message-ID: <sashiko-outbox-206769@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] efi/libstub: Enable direct sysfb_primary_display
 access on LoongArch
Reply-To: sashiko-reviews@lists.linux.dev
To: wuqianhai@loongson.cn
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110092424.2647921-1-wuqianhai@loongson.cn>
References: <20261110090203.2631481-1-wuqianhai@loongson.cn>
 <20261110092424.2647921-1-wuqianhai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:35:50 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: wuqianhai <wuqianhai@loongson.cn>
>=20
> alloc_primary_display() returns NULL on LoongArch when neither
> CONFIG_EFI_EARLYCON nor CONFIG_SYSFB is enabled, so the EFI stub does not
> populate the core kernel's sysfb_primary_display.  Allow LoongArch to link
> directly to sysfb_primary_display, like x86, so the firmware framebuffer
> information is always available.
>=20
> Signed-off-by: wuqianhai <wuqianhai@loongson.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110090203.2631=
481-1-wuqianhai@loongson.cn?part=3D5

