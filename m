Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BF2C08CF
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795254; cv=none; b=C//Oetw4nb9urPBt6NSVAB3RGySMNLgd9Wqk11QeQqv2xgv9jyjPAjCOccG0WbRqyFZ9/erfdx0z+VBstIYYl597vrw/1klOhX+xSEHu/zVS9/k8qMaPD9PuXLwT8MdDw+oyGHND3JwhECTJeoZCOjU3X3Vuh33QWMWLX+QCTVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795254; c=relaxed/simple;
	bh=6MPYbmYk2yb1B9EIe1WRPNR8YVoo9tQwOb7AOG3b3Lo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVbIoHCjETUN8aKn7yRFotHUjqgyGdln1ZK5llIubpqF46DT3hJVvDVpC//BT4buCxHaRy3PHjVv6wk4b3aTgk3SkiSSeU56mESdu3QbzteZ7H57Q+G+XuUpIduCFdhLYyMvAwQP93uJPGa6FgTI1jloo1LFVr2A2K7mQ7sqDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml23BrJY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml23BrJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D56C1F000E9;
	Mon,  3 Aug 2026 22:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785795252;
	bh=6MPYbmYk2yb1B9EIe1WRPNR8YVoo9tQwOb7AOG3b3Lo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ml23BrJY+EUBv7aqvzzecFoESB4NhKP9+DHaJ2g6JeCk8Pxc9xoNiSSOyqE/+fcqn
	 NVOS1we9nLSqj4Bqejjb/y8sbd4QcYRhaTHL95y9CXBtDyIrQMyZby2C6w6OrZu5PO
	 fWdsdBR4hiGjQ5ei9acdpODNV988/NquMba6r8FfkUA7Imemhev82ZG9grBL/6WEdl
	 bQMmpAQZ+UD1i08pO/zJzHA1RcDiEYVEcsLXwL0GAV3ljSwtav2+0aARdJaTlMbXuT
	 RaVWZcHcmRxZF/fAneYpp8dnWmV3frxc93GK7zVeNPQWHtOg7DSvaBdq/fZn14Q7OM
	 m10tEX8gg8FZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI/AER: Fix memory leak in
 aer_recover_work_func() when pci_dev is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260803-b4-fix-aer-memleaks-v2-2-fd199b0171fd@google.com>
References: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
 <20260803-b4-fix-aer-memleaks-v2-2-fd199b0171fd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:14:11 +0000
Message-Id: <20260803221412.3D56C1F000E9@smtp.kernel.org>
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
-memleaks-v2-0-fd199b0171fd@google.com?part=3D2

