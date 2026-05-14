Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB331DDBB
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722607; cv=none; b=o5RX5Ux4kb7vWxhVcPeTtsBrf2Dgip+7P0cOBTgn8rCmpDzw3MHJiYbQYIHXwBrGaIJtjfIZ29BzcbSdLCNZVpZDd5ifHEB1exy6CTLUwwxFSahOgFNEnkxbAWjej8gQ8Gktq7OZE3pl6xzQhJoVmb5E7Ejjt17/Z+3kyu9nIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722607; c=relaxed/simple;
	bh=UQKj2lU0rKmrDAJoysJS/c2u/CMrmHsOncqSdhjOf08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BlZvwlORZfjpmdbZGDAizI5+pCzljNGm/i8JZq5Dldlp9p038YP03iUyuEdHEyfNDxLlMUNf0Xz2mMF+PiQEVGPVcYsVlTrT0j+kppx9QjeMUZ0ZKOG4Mtm5QutheseHWDfIvoGlTC3ZG3RqTL6PCU6R4L1l928Zmy/1uSLjDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCq3Xyk6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCq3Xyk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F8BC19425;
	Thu, 14 May 2026 01:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778722606;
	bh=UQKj2lU0rKmrDAJoysJS/c2u/CMrmHsOncqSdhjOf08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nCq3Xyk6ygJNIvjktfcgRBr2kT4ivv+l6hmUGnhpAqPsH90x+2t39zByFtHiQ1vEE
	 h6/o3fKl2krnhBBclstAX8AYLC170qfGMxQbQH8Koee4dKi6tSl7dMmTRAgpvxgquc
	 fjXFi0bZUtmdE+BLnoGh4Hc4Kez1qvV2zqAx78iJbiC9iuzgAAxk15rCNHTTOdpWZo
	 pM3W9bqvZwGz9gV7YS8od64q6YN2nlAJkXTcwJRZ1vCAVy4JYvLEyOm8FqaKLdlagu
	 NWb0zHcUYsJ5sX6h5XIjCfbxl05Zzzv/Me1Wlb2fzvIrx0DqLupCU1+ZmBePkxoLYg
	 2GJ6LNCpkXnHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/11] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512184846.119396-6-dmatlack@google.com>
References: <20260512184846.119396-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:36:46 +0000
Message-Id: <20260514013646.C4F8BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Bridge bus numbers are inadvertently cleared for 'broken' topologi=
es during Live Update, modifying the hardware fabric and disrupting active =
memory transactions.
--

commit 0f468978660735d49ff81fb445992a21db06f9ce
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Keep bus numbers constant during Live Update

During Live Update, preserved devices must be allowed to continue performing
memory transactions. This commit modifies the PCI core to always inherit
bridge bus numbers when any devices are preserved, avoiding topology
changes that could disrupt ongoing operations.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b5fdc5017f921..08ea9324647ba 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c

[ ... ]

> @@ -1497,8 +1505,7 @@ static int pci_scan_bridge_extend(struct pci_bus *b=
us, struct pci_dev *dev,
>  		 * do in the second pass.
>  		 */
>  		if (!pass) {
> -			if (pcibios_assign_all_busses() || broken)
> -
> +			if (assign_new_buses || broken)
>  				/*
>  				 * Temporarily disable forwarding of the
>  				 * configuration cycles on all bridges in
> @@ -1512,6 +1519,12 @@ static int pci_scan_bridge_extend(struct pci_bus *=
bus, struct pci_dev *dev,
>  			goto out;
>  		}

Does this code accidentally clear the secondary and subordinate bus numbers
for bridges with a "broken" configuration during a Live Update?

In the first pass (!pass), if the bridge topology is invalid (broken =3D=3D=
 1),
the code enters the if (assign_new_buses || broken) branch and executes a
pci_write_config_dword() that disables configuration cycles.

Since the pci_liveupdate_inherit_buses() safety check happens after this
block, the hardware fabric gets modified before the early return. Can this
disrupt ongoing memory transactions for preserved downstream devices?

> +		if (pci_liveupdate_inherit_buses()) {
> +			pci_err(dev, "Cannot reconfigure bridge during Live Update!\n");
> +			pci_err(dev, "Downstream devices will not be enumerated!\n");
> +			goto out;
> +		}
> +
>  		/* Clear errors */
>  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512184846.1193=
96-1-dmatlack@google.com?part=3D5
