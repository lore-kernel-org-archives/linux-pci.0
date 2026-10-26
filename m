Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005081;
	b=YJ5XNmPa//Gu5xAYVWPUQ/p+mhB7uAyyViy3iM5YOZvV+6ggscL4afBrAbVgVUrp37oo
	 gdjt+7AChKLQeDWBEOILdFvagY4Ow++syXB3ogQjEwlJGlXx9ET4hNMEHuEwkEGlE58QV
	 ywCQcHMwR7tpCiQ7uu7BVauYK3ZJj7O+pqi0+RfScc55XvbpxvJoK1RoCN/ItR0IUzYGf
	 fkoYCzRFH16h8XBXGQbdfveFj5njih5jcuZQjpKIPqe3gML1gpQ2NgBLL/hjDc5iOELg5
	 jrJKmWeA0Im0s7ctHjcAQkGgyqUOEchaFthKzo7YcPSUqrBBjzQpZpEXemt5r6EH8Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005081;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nq/Vbm6PJsrKA+1GIde8eBXWm/K55ivzRskLL85lQA8=;
	b=EBAcCDRZxXXM0LLp0r2F20URGnJyJ4mDR1kPE5WqnJkS0hmiiND9OpypBYoH0kDYNpjt
	 Jfi0xMQvcwEsGwCmhT4hB3EXoPlnjMzVUghmcTRIvWvVG6P7m580/vY3Jg8iuVV9wwgg8
	 EIjP6dxbmlFKyS5Wa1llu/QqI0iwU8zZjsBMwYHocSHwAR3EUudg7N716YWzGKPc3doUU
	 uXrKUqIw7jq6ITHwF2ARBd7qCpqeTmQMHuPbDOQWnYJxX8/TozpB6H/cMONNVNflw2MWR
	 L19qoEK5fDTgJhGe78imDdrbA6wotZ4vwLM9bzqGvSwIXcCI4b+ZrA1+sOnJECzkVuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVw+HIr0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44694606A31D
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVw+HIr0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070E71F031E1;
	Mon, 26 Oct 2026 08:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793005081;
	bh=nq/Vbm6PJsrKA+1GIde8eBXWm/K55ivzRskLL85lQA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oVw+HIr0QNIxZHZSz58EimVvqUri1j1MZevHV9qkHRhue4R0l1xF2lm/inBJLmEkm
	 /zN0iGdUJQbdewYnrZmeK/gsmTpEgqlt1fyKLxA1q3JAcVvGzMfWiW/5OtwLr9b6+W
	 skQa17X8+7yhHvCCGJ7s+g5zsANckAHj3PxiKmAtuAYVL++hL+R3MoUDy+N4We74bE
	 /3L91wDj396TtT1evBAzHiltv8hWuNNdOdMneVyLiTqSQjlVfBa9oaNhT7oaUxq97B
	 s5ixIXmUV9fbUiBnH9KUn8wqmDx9NXEk9ayYZrdjXQNHu/soZ+CkSQLfC34KkcshU1
	 4HayTwCZE1ckg==
Message-ID: <sashiko-outbox-184713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261026045930.129874-1-mhklinux@outlook.com>
References: <20261026045930.129874-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:58:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> In a system with multiple devices with the same configuration (such as
> NVMe controllers), the affinity masks are the same for all such devices.
> Linux typicaly must select a single CPU from each mask to be the effective
> affinity. If a fixed algorithm is used, such as picking the first CPU
> in the mask, interrupts from multiple devices are assigned to the same
> CPUs, while other CPUs are not assigned any interrupts, producing an
> interrupt load imbalance.
>=20
> On x86, the "APIC" IRQ chip avoids this problem by spreading the
> interrupts across the CPUs in an affinity mask. It tracks the number
> of IRQs assigned to each CPU, and chooses the CPU in the mask that
> has the fewest assignments. Because Hyper-V vPCI device IRQs eventually
> parent to APIC, the spreading done by APIC accrues to Hyper-V vPCI
> devices, so all is good in x86 systems.
>=20
> [ ... ]
> IRQ chip (GICv3) to actually set that single CPU as the effective
> affinity in the virtual GICv3 hardware. As a result, IRQs are spread
> across CPUs like on x86 and interrupt load imbalances are avoided.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026045930.1298=
74-1-mhklinux@outlook.com?part=3D1

