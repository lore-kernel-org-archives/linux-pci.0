Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9C46D545
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337284; cv=none; b=oZNBxDfsoef2PsG8cq9ktFM1m1QqOGwHKPdsTsgua4UN4TPGrdO9grgVvsWSjOcuppc44ZzCZ1eoYn/fmW3Mcp6Y00fBWtA7HnnPEPK5iEykN5NGKfdx/ITLXjebbp5Gikzxjfe/j+JudzTnjj2OlgJAKPMjr7vMXr+3QGWgoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337284; c=relaxed/simple;
	bh=r0Vpu8MHdtG/jOJ4lfIo3BNo/VA/F1ic0itHuEq9YCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IXDqywQyqDQlIZi+PScqMh8h+a2p2ZbUCdZ1fADFFWOO8vvo0gwEOWxNxUM9lAkaLtf7EKQTTanCJRneM1G7SI/TN5WWXWw/B+OYZ/yigs+B7G1TpQgLlFntCQcDiVNrYYw5qoMB+xxBPDZTCWjg8Q0u8dks0iVCRssTfC8tHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MN6yf2F1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MN6yf2F1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D461F00898;
	Fri, 25 Sep 2026 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790337282;
	bh=GXtvE1gZqdp036d6DGSHPOKxWPM/GwgJ0D59jRHdfNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MN6yf2F1zaVarhp+iQz2txTZZTWf6OJ/9Vi81+fcI9MmV0TZ0PXIg5e+b+nDnnlCY
	 sNoyswM22I/X88Qn2UtGhjiWefEFEEpZhIsv9owToQ+dgcUWA5nyEMj9HmftEQX3/j
	 AjDWCi7rKC8DRvRuJrPTgDFoRDRqDbV3nzh8MB2Io17Fqgkoukb60HGmoQ7S7n3RlB
	 vc5KupQ0W8e716ZxAJRjUvn9VFZpsjSr2ftnii63UXYhDj91DFt0li97BlW/rqzGFq
	 jAqXqXKRdUTb75VuHoH9LuCze5Cen7OJ6ZcPS6U0pOFS1YFaSMC0sVMmuEwq0n6adg
	 ZCDzWqKwAtYsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Avoid dropping hotplug interrupts due
 to stale HPIE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Qiyu" <qiyuzhu2@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260925114635.192878-1-qiyuzhu2@amd.com>
References: <20260924101929.143806-1-qiyuzhu2@amd.com>
 <20260925114635.192878-1-qiyuzhu2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 11:54:41 +0000
Message-Id: <20260925115442.63D461F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pciehp_isr() uses the Hot-Plug Interrupt Enable (HPIE) bit in
> ctrl->slot_ctrl to reject interrupts when hotplug interrupts are
> disabled.  This check is needed because hotplug can share an interrupt
> with other sources, including native PME.
>=20
> However, ctrl->slot_ctrl is updated from hardware on every Slot Control
> Register read-modify-write.  A firmware change to HPIE can race with an
> unrelated driver operation, such as an LED indicator update:
>=20
>   1. The driver enables hotplug interrupts, setting both hardware HPIE
> 	  and the cached HPIE bit to 1.
>   2. Firmware temporarily clears hardware HPIE; the cached bit remains 1.
>   3. pcie_do_write_cmd() reads Slot Control for an indicator update and
> 	  observes HPIE=3D0.  Since the command's mask excludes HPIE, it
> 	  preserves the value read from hardware.
> [ ... ]
> This prevents stale-cache rejection of delivered interrupts, but does
> not restore hardware interrupt delivery.  If firmware restores HPIE
> before the driver's write, that write may clear it again.
>=20
> Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925114635.1928=
78-1-qiyuzhu2@amd.com?part=3D1

