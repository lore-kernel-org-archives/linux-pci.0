Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033544DA9C3
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839322; cv=none; b=sZzzT0ZGQdvWVbUEM5mtK6XEe5Xt9nZp7kjuQxVFgfL71JO6TCW9w2qRCJBrptQ6W+SVgVXOhT8FH0junnD/khhQZwaS6lANV4uN+MGYQKXuXV72V0iYVeTcLHwul5oUleETK9buTIYdqMBwkFzNOuqMraSZaF19gA8ppjacOO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839322; c=relaxed/simple;
	bh=B2ENGoJu1g1MSxhR/tK9qyGkxuSNdboM8O8w/rUUNac=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EL+ygZtYNWjbn+s9jZWoNlmkLrHkSV7clrlmMmEJIur0fFNKv9vgriyFX435V1Qb1zVV8G0TFjj9BDtihhvjORQaKDbpXzI22dSHqAYT22Stg5Gf363Bk62y8TeV9PLf7zs7J1tq/Pe1BYvYxG1IbxlE8YnIkIUZmFSve5gLQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b41l2/xl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b41l2/xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A231F008A1;
	Mon, 12 Oct 2026 21:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791839321;
	bh=28fzzSRJBsrSXyU/LSX8b/Q13VIxBfsZi6U4FLNOf4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b41l2/xlPFOJJoup8186P6XQodYzMWrEE3/P6OjmtOASk6XMJnCs+YM6ya9ZKst9s
	 HxnB2Lua63b+gG27dXK/XwFIdOVbaeE0Xxa9kaSucwanuEwaqaci9SZz9XXsBnQtal
	 5jpAh7sK/gbhFw+UiwwEuzflYi+ALrQiKaFjxi8jNUxaPAkUpmbA4zjgkFXW2elNsA
	 Aw3At94K+mTrRS0kXD7Spt9hXgVQcB+b1b/2inggFoH6LhywAqlQQ2oXcad/tXUpHU
	 rMS4JpEwXl+sVGoS1/19u+vee3TNHscmv0hqh2hfxB+7OqQ+kIjoqvvElN7Mk33ZGt
	 vxf/+cxqc5a+w==
Message-ID: <sashiko-outbox-168608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI/AER: Make aer_mask_override effective for
 injected errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261012-fix-aer-mask-override-v1-1-49a0d7aeaea0@google.com>
References: <20261012-fix-aer-mask-override-v1-0-49a0d7aeaea0@google.com>
 <20261012-fix-aer-mask-override-v1-1-49a0d7aeaea0@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 21:08:41 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The aer_mask_override module parameter of aer_inject is meant to allow
> injecting errors that the device masks in PCI_ERR_COR_MASK or
> PCI_ERR_UNCOR_MASK.  It does not work for Correctable or Non-Fatal
> errors, nor for Fatal errors on Root Ports and Downstream Ports,
> because the modified masks are restored before the AER driver reads
> them.
>=20
> aer_inject() writes the modified masks to hardware and restores them
> from cor_mask_orig/uncor_mask_orig right after inject_lock is released,
> before irq_inject_interrupt() is even called.  The injected error is
> consumed asynchronously by the threaded handler aer_isr(), whose
> helpers is_error_source(), aer_get_device_error_info() and
> aer_get_anfe_status() read the Mask registers.  Those reads go through
> the emulated config space, but find_pci_config_dword() does not
> intercept PCI_ERR_COR_MASK/PCI_ERR_UNCOR_MASK, so they return the
> [ ... ]
> masked in PCI_ERR_UNCOR_MASK after aer_inject has been unloaded; with
> the read-side emulation alone it ended up unmasked.
>=20
> Fixes: 457d9d088b02 ("PCI: aer-inject: Override PCIe AER Mask Registers")
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-aer-ma=
sk-override-v1-0-49a0d7aeaea0@google.com?part=3D1

