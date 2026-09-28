Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654164D9550
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617607; cv=none; b=bRZa+Z1EhgVBS7na2+i86UnPlU3T6b6T2MXauDVFRd68oj9CN22uHAZsObDWMj3Dwp3s+UnAeSfkbAuAuScruaeeLWNen0iVswOfuaH0KqQtgMxHG/CjHVxAVtk3/ir04KrGMJaBaiqNR6iuIzqG9lyfdp8owtUQ8Vk8/BrQfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617607; c=relaxed/simple;
	bh=it/bcBDRMmU64VCevCO1KUqCf7cyg2WWgnWZwYs1DQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qIxV6KrhLNTGrZ92mGLhlMeF8ddtmehAN05vFpTu3NTJYXhOxJ0QXH1R9jKsk7L3ijXPJAs/ugIxkRG3M779SNBuZmHfJS+T/1Tv7rmnuasmhKkvvOfUNwa7N6P2e0Ie32u5M8XZwR0ZQK8c9D20LCcwAVJsPjtNK41KbO/ZZx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0Z3oofF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0Z3oofF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5A61F000FF;
	Mon, 28 Sep 2026 17:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617606;
	bh=it/bcBDRMmU64VCevCO1KUqCf7cyg2WWgnWZwYs1DQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G0Z3oofFA7HVrC5AFA4AGXU6b8FSkBc5vF4seEVS0LLnvwKHU8l1UCNDyQqsQlsRg
	 PTEojZR3yBZX4XjgTNGU0glsX8nrAYjVPcouamJ29+f8Rzv8PhRmZk+7frDVjuZSuG
	 dyaEesYDER0os7vm7wCEnQYYE3or8EdKUhFBNSrsmOasNpsHIAF67mt7mYdjdGaLf3
	 uCdWOybjcaYQpUW3T3B9YlzOPjLKnliwCsQL0hA6go1cldqpMlLU7W9F3p98VgJXoP
	 p83Hk2neExQA+RFMlvOPRqjI9Iv/gz/ocHqtrA1BhPwAoNObImVdvobmR/iCpM+zTL
	 Z7ENqfHxRWpuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] PCI/AER: Fix memory leak in
 aer_recover_work_func() when pci_dev is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-2-ba6b94c9c9a6@google.com>
References: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
 <20260928-b4-fix-aer-memleaks-v5-2-ba6b94c9c9a6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:46:45 +0000
Message-Id: <20260928174645.DA5A61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
> for aer_capability_regs (entry.regs) from ghes_estatus_pool and queues
> the entry into aer_recover_ring.
>=20
> In aer_recover_work_func(), items are popped from aer_recover_ring via
> kfifo_get(). If pci_get_domain_bus_and_slot() fails to find a matching
> pci_dev, the code previously executed 'continue', bypassing the call to
> ghes_estatus_pool_region_free(). As a result, the memory allocated for
> entry.regs from ghes_estatus_pool was leaked.
>=20
> This is reachable whenever the device reported by firmware is not (or is
> no longer) present in the PCI device tree, e.g. after hot-removal or when
> firmware reports an error for a device the kernel never enumerated.
>=20
> Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
> is called unconditionally for every dequeued entry, releasing the pool
> memory even when pci_dev is missing.
>=20
> Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error stat=
us data has multiple sections")
> Cc: stable@vger.kernel.org
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-b4-fix-aer=
-memleaks-v5-0-ba6b94c9c9a6@google.com?part=3D2

