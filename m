Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127900;
	b=k7+182S/xuoZzjQBlIrFHI2x/yeRyutjSN8jBIpS/NA5tfYm0NgbHdd3dq6jvOkS4+P+
	 XpcicZzRJZK7/jz8E4sHfCw0yo4APGL/7rmfa3qpIXogKkUsKF/rlqnuTonxmpefFeW8k
	 KXX9W35rCBkDG4dBIwYwghIC0QBXVqOlrv7X1pKSIkuTkS/lt2ZMfQh1iAxAPpiBIET5D
	 ImfqGn8mCwFbteRHAoqCWloD7Xh0YuErUAE7Luo0IT+aEwGwnmTSnsYj21abqV2fKKTQI
	 pzYNnD6U6Z+HNZGyLgSiqj/gibvdzAieLb1T5p8cktucTJg0Zf7L4wyNFKbg/kGbBew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127900;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Rft8BhkDVgM3lrqAebPZw2F/X34gjZWU1HoE0P/PeGI=;
	b=SyLzoaykTEXSS6XSLif4DSNFriEq6oVR+OPpDmzkiCTWjeWHTSH4i/K17SxXT335Tocc
	 3pA1pSm620I3iPywT24xfkU/iYEy8WO3rq7deK9MFHT1BFX9AGAV5V5U4zb8wq0gOHP+7
	 3+mbUT82XBtPKuCfV738lNNR7mCc/qVy5yVjTLzzmGOkUwRMJtwgUdAJA6Wx+LZzCo8G/
	 OraFQXpXvejZLxrwzQPGRf4Y8j/Q8W8MLP2d6bg4tcI1tzwqHf+G+5p9G7tCRO0Uwuuzj
	 d4cgcb2EVwcaqq1QGjEPNYeQR2zGAEupzrz6EK2QMWpTE4ckyOCQ8Zhh6pXiCtrrx2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHfDuebs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD01606A32C
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHfDuebs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E381F000C4;
	Thu, 19 Nov 2026 22:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127899;
	bh=Rft8BhkDVgM3lrqAebPZw2F/X34gjZWU1HoE0P/PeGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHfDuebsp9CcyVmwxWUNXy+YCzZcEgiFPXgtRTSnZSmDVvReT+Y1Unlbgw5YwLN68
	 w5hDOJUJwfpjeOFPGxLU4u26V+preUnnSiyVqvwPie6NotkKMgDHwPwlN7L5KsAy+S
	 IEqOXxIWh8h65+cBkF1/tctlMmgfGG0Qi2sScY6jT66idOoGakVgkRY3QyLevQ9lQ3
	 +kPxMK3ee3RDYmhxoC8wL/3bAH5/ffLDZhvIC8JeJQASxgJWhopV+kXPMlYC+Qj45S
	 L0mCjBwYmWrGdOUSfKTfBwTN2Z5BrPH1s28LWv7Kx+UcPsStIXCOj2woBgb4c9dGAB
	 OTCJm1k7ZKEWQ==
Message-ID: <sashiko-outbox-224136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/13] PCI: liveupdate: Set up FLB handler for the
 PCI core
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson" <alex.williamson@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Down" <chris@chrisdown.name>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261118223704.3286085-2-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] PCI: liveupdate: pci_flb_finish() logs unpopulated args->data
- [Low] PCI: liveupdate: separate __free() declaration and init in
  pci_flb_preserve()
--

commit 525f211f02fbb47d85199fbccf703e0ddc3e892e
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Set up FLB handler for the PCI core

This commit introduces a File-Lifecycle-Bound (FLB) handler and KHO ABI
for the PCI core so that PCI core state (struct pci_ser) can be allocated,
preserved, retrieved, and freed across a Live Update kexec.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> new file mode 100644
> index 0000000000000..173433f64d002
> --- /dev/null
> +++ b/drivers/pci/liveupdate.c
[ ... ]
> +static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> +{
> +	struct pci_flb_outgoing *outgoing __free(kfree) =3D NULL;
> +	struct pci_ser *ser;
> +
> +	outgoing =3D kzalloc_obj(*outgoing);
> +	if (!outgoing)
> +		return -ENOMEM;

[Severity: Low]
This isn't a bug, but per the Cleanup API conventions, outgoing can be
defined and initialized in a single statement:

	struct pci_flb_outgoing *outgoing __free(kfree) =3D kzalloc_obj(*outgoing);

[ ... ]

> +static void pci_flb_finish(struct liveupdate_flb_op_args *args)
> +{
> +	pr_debug("Finished struct pci_ser (0x%llx)\n", args->data);
> +	kho_restore_free(args->obj);
> +}

[Severity: Low]
Will pci_flb_finish() always log 0x0 for the address of struct pci_ser?

liveupdate_flb_put_incoming() zero-initializes args and only populates
args.flb and args.obj before calling flb->ops->finish(&args) (matching
the struct liveupdate_flb_op_args contract where @data is only provided
to .unpreserve() and .retrieve()). Logging virt_to_phys(args->obj) would
print the actual physical address.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D1
