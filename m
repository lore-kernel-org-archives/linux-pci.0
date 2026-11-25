Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595159;
	b=P8gGpwPMLh5JEtPoPuwcBH+JcwhVK92vvAUmzly8xRLKAjhObqmJHvX5sHYBCbkdRPpO
	 4hpZQ/nm8M4fGEuh9rGftPisgs9BwAgJR8pX2uQA2oili5MvT+YY4BgSdxYeBwLIqPyI1
	 qj6OCwQ+hUwukTr/Jejet5rCi5rJfGN/Bvxo+LwRJdvbdZcJDcM1ePeD6lRbe8aNXcSA7
	 LUauTB/kLeE9FE3qs2VcJZBfeIzQ5JHwIFJa1wyqTb9gRD1b9if56+l3hsnTGfMpmSS3e
	 w5VtfT9+7clZNkDoTZ4tFVnNdIBE7C9SKt+L+rIc9sJ1iWP8SlAdomvhe8xn89l6p6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595159;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r7FfGS/ERByTxcAOOBdD6WEY3J4OyIgQjeV+QoA1oPY=;
	b=Md3hxcNIn6+HaMTpJBrTYRfEFPOiuDhZM44P0BepD7Yh9q/SBqrr1v5vekhOS1duMlmn
	 yU5Ttao3Q5sc2F8Oxrq1zKF17EKs502qdWDy47D24Iu0VTRVs/6z2rYHjfVcjjLzdXtqK
	 WZw1FFUxK3CS7WDHF/rxsuisUbDvqRKdn9P/IYilDZmz5JaPVJ6JqHWhRFiykLvTLoCl9
	 JiGloRL+qGNttdLHC4gcRav92iXzXFMiRmXJ0WeNxbdzHZSW0mbMZWTGTAx/DHFbhHL7R
	 wY5R81qcVwtqLtMWAKy3inggcedeMi7WEhMuCwDczGN7hW2tZewsU8Iq6yJ65YZVIJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeZiPhO4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9B606A323;
	Wed, 25 Nov 2026 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeZiPhO4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F9C1F000D1;
	Wed, 25 Nov 2026 08:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795595159;
	bh=r7FfGS/ERByTxcAOOBdD6WEY3J4OyIgQjeV+QoA1oPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jeZiPhO41OpuaVJ4bbpzn6wDMPoJTGDoKGFlobt07pGv/itaixfgVj4rCjNV2Q/go
	 QbG9TyuwY1zY4ka7U/GWNxbGyFiZERLNSTESWS441Ly4SVRaa7mYyW78WdeDtEi99g
	 OYzq1zEn5XpM2meEIkzdy1TbfObieQTq1aXW2u4rzX440Iy7Sicm/u2H83M4s4HFsJ
	 FMGEqGOqc2y9xcfsmUJlKuUzCudz+QBGm0yLDith4R7AfIW6LADfrU8A39CJW7yRSF
	 JpYfPAeLtyKjfsO912CQfnQqE3zJNRGcXfgKcscPHgsEDhVODgWetQxR8EuTAKyilB
	 dY4P7GpQXWxuA==
Message-ID: <sashiko-outbox-232890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/18] virt: coco: tsm: Register the TSM class
 before device drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261125081121.379481-6-aneesh.kumar@kernel.org>
References: <20261125081121.379481-1-aneesh.kumar@kernel.org>
 <20261125081121.379481-6-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:25:58 +0000
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
- [Low] virt: coco: tsm: missing Fixes trailer for tsm_init() ordering
  fix
--

commit f86dd161856178a3168b08b14d984f9f73c2f1a6
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

> virt: coco: tsm: Register the TSM class before device drivers
>
> Register the built-in TSM class with subsys_initcall() so it exists
> before a platform TSM driver probes, independently of object link order.
> CONFIG_TSM is boolean; remove the unused module exit path.
>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

[Severity: Low]
This fixes a built-in initcall ordering bug where a platform TSM driver in
drivers/crypto/ (linked before drivers/virt/) calls tsm_register() ->
device_add() before tsm_init() registers tsm_class, leaving the device
unlinked under /sys/class/tsm/ and absent from sp->klist_devices for
find_tsm_dev().  Should this include:

  Fixes: 603c646f0010 ("coco/tsm: Introduce a core device for TEE Security =
Managers")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125081121.3794=
81-1-aneesh.kumar@kernel.org?part=3D5
