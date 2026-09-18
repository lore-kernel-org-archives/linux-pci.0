Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB43A0EB8
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752826; cv=none; b=KdFPt/vIN7bvEqnMuBpNbugNYWC8ffyDe0HS6nKHKQ30dnudj6SC/wxMPY+hb+0B+16iJ+061W9+nHoVSJ/X3mDOmj+Uk1N7GTXu1c9pvxgu70nmd7rDU213AuWgoWt7aX+BtoqsE6MlxNr9N11NksYXuI30A2Cbm+AWENF1Tno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752826; c=relaxed/simple;
	bh=g93bebs9E+ozhRj17ACqE6SMmXyfWlefQY8YYmI5kuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EQELhNj0IVH9biRmuLj0zhlbjYtIwzJnXlxywxwCOTJV0dF9nR/iJe5nBx6HqFPFZl/ZHemtDiFk8s/ahas7OM9j1QUrDTWLQGw5lFJeJaMS5zIL8rwokpOFIj+4t4LsUyt7so9XI1alLwpywrduXmB3scGfhdGeKr6xFGFpidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/c/4PiP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/c/4PiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7AA1F00898;
	Fri, 18 Sep 2026 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752821;
	bh=g93bebs9E+ozhRj17ACqE6SMmXyfWlefQY8YYmI5kuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b/c/4PiPw9qKFg4sb7F/Deag91wZzno4dwxNy2ne8hvnzNffCYgNRL94CN++6UWwe
	 pvKgshWYLrQJjuLjUo7n6PwI56sJjUHOpShd1dUgmVsxe/IElhif2x0A5jrV/WxSwa
	 zlaD/0w4ddHsxtLO61oalDetmqNLw/aIjjZ/NxavlUfXLwc+wVl/5opPOIcPVvetE4
	 NcSxa1PMQ4cZisaRgVOaPraNpsbojimMxrVvzh032+ejubHsmgNZyaeEq4deGdrHL4
	 +HgP/Mz0hShxDL84F3fp8VRnZzT9AwjDEiT4KTbTuQ9tq53ShKf91H4DyXaq0O0dVW
	 uhKaICpUIylVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] PCI/AER: Fix memory leak in
 aer_recover_work_func() when pci_dev is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918-b4-fix-aer-memleaks-v4-2-f0a2c21ed1d1@google.com>
References: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
 <20260918-b4-fix-aer-memleaks-v4-2-f0a2c21ed1d1@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:33:40 +0000
Message-Id: <20260918173340.DA7AA1F00898@smtp.kernel.org>
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
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-b4-fix-aer=
-memleaks-v4-0-f0a2c21ed1d1@google.com?part=3D2

