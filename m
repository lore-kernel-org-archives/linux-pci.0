Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3211DFFB
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794482; cv=none; b=FFBMi7kPquVu7QBVdWZ1msD/h1LpeplmzglvFQ+l1EZ4zEsCCzaSgxeLonSWDcHteF5HsKweKo+hZvZH1JsdaEVuzZ/iCzOwu184dLixCTcoJX2/C7b+XLDasBpQowe8ctn7/Cz6M64WgN02GXZnKGowMDpAUaYW3z+3Xu1bLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794482; c=relaxed/simple;
	bh=YnzYVljUukkPLYpMls4bZ9BUf4355KiX926ER9rwUFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hSnX1cFrJowH7AATgeaSJFxxkTArkW3mmxq2MVuieEfinThDu35Vaw2FHOsZzwQps8RtHfcK2siq0Sp9Uw9fHJLudOmVcznT2l2h+rN26BT+Ytk+4j+NnMRkyEXPstaKzFJERn8VHKLRZEqJX2CD+ImWSRPDc1urU8lhAOtwe+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8flR0VV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8flR0VV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD061F000E9;
	Mon,  3 Aug 2026 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785794480;
	bh=YnzYVljUukkPLYpMls4bZ9BUf4355KiX926ER9rwUFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R8flR0VVmj8M4rrgCcOsVdzauJt+26zxRfjDunNJKRIbkgBs4lRKPpqaVdE2I+Yca
	 amq6KGBzbwPO+GEuk89tnU58VAd7uWCyxWPrA9Sl/vsxuYSCA/Elp8SSuP9mLGtDDh
	 SuPPZjhY+wmHKcNBD1B3d79A661FqO3yY1/l5gqoKGRJeLUt3E3i+NxwH21LeKaF2k
	 6UMT8pFomff/kdeZtU245CSztPMcjhinA7nO+y8w8p+Et6x4rEDHUec7P0DyZJdeRf
	 Io1KWjBSEGs1MXYRr+GA6Dkffc3FO4RWCG2UrCs5nvPWk0TYIa+Io4BbgT6nUhzSBK
	 S5y8EJeUBKagw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI/AER: Fix memory leak in
 aer_recover_work_func() when pci_dev is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260803-b4-fix-aer-memleaks-v3-2-e87159611933@google.com>
References: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
 <20260803-b4-fix-aer-memleaks-v3-2-e87159611933@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:01:19 +0000
Message-Id: <20260803220120.5AD061F000E9@smtp.kernel.org>
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
> Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
> is called unconditionally for every dequeued entry, releasing the pool
> memory even when pci_dev is missing.
>=20
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-b4-fix-aer=
-memleaks-v3-0-e87159611933@google.com?part=3D2

