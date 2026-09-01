Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CF3909BF;
	Tue,  1 Sep 2026 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225654; cv=none; b=Zrd7vFEtc2R6VaD1hZ/2CaxQgkOpKuvkvyY86sWvqBlSMh8ZxQWuQfsY3eZqAnAMOmNWshEPqBcoTD6rOqBXpZ2bLjABLBm5IOPTMPQ+5Yrkg92ylti4J2QJ61E6BvuM9IvJDxRGBdWSN4gt9Nwysm8LSzo7T1mX5eK9Jgd7YMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225654; c=relaxed/simple;
	bh=6aqydAtSJYybWERIfmfkxWBzrYyUcD72Mm9caDpwlUA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jkl3+U1hLhl24C55UMDxEoyNuwStLh3sX9nQzeHgYSysdHpcH7mIU2KG38zxuqD/a/k+wXkghxWmwImUJV1kGJ+z1nBc4F/OrEyWQstepwi66ya5h9qiX+D5A3Ebnor0nJjaedeab+ZWhFkJ1M1ghl6+jDgqG2kAL9XuTiNHjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDYxpzk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDYxpzk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691FA1F000E9;
	Tue,  1 Sep 2026 01:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225652;
	bh=/3e4CIJ4iOkKr1VTV177SEW1Q8rLxBB7KOCiJo5KrTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IDYxpzk23QNJ1hVIiQfHr57dGg3VfBcfLmg6Y+Fg9xH06E2ihi57hudWDQESjmsbF
	 pbW5lBZ4k1JtDTi+cwMXqd35ZjR+U/2BcTKRLWwg4fkFaxxb2IcIXiKnwQUrqlQnqs
	 rmm5Wehc/TBOlbRSdWdGL8khp72tIYgK4xWefazjR3sXUzmMmpT2E8sYAXhNnT5Jni
	 3EgkYSIuGx/Spw1/uBFCu9EMc/AoDim/UCHSQfENPm66spV+eFtmNnYzWaxsAnlhv0
	 gOQJJmQSZaVhDAgJ7llr6YFNkd+YboKy7KyT3qDG2PFSzWCqn/DRAQ45koFHFtAq/k
	 cn3wI85bVelYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/21] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260901010347.2614656-13-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-13-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:20:51 +0000
Message-Id: <20260901012052.691FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The CMA driver's probe callback unconditionally treats every pro=
bed device as a TSM host, which triggers spurious kernel warnings for sub-f=
unctions like VFs.
--

commit e6e460ef636dca826aac1d314b1cb072ffd45217
Author: Alistair Francis <alistair.francis@wdc.com>

PCI/CMA: Add a PCI TSM CMA driver using SPDM

This commit adds a Component Measurement and Authentication (CMA) driver
using SPDM. It utilizes a PCI DOE mailbox as a transport to authenticate
devices during enumeration and integrates with the TSM subsystem.

Link: http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch

> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> new file mode 100644
> index 0000000000000..9f2cc0b2ec8a7
> --- /dev/null
> +++ b/drivers/pci/cma.c

[ ... ]

> +static struct pci_tsm *pci_cma_tsm_probe(struct tsm_dev *tsm_dev,
> +					 struct pci_dev *pdev)
> +{
> +	struct pci_cma_tsm *cma;
> +	int rc;
> +
> +	cma =3D kzalloc(sizeof(*cma), GFP_KERNEL);
> +	if (!cma)
> +		return NULL;
> +
> +	rc =3D pci_tsm_host_constructor(pdev, &cma->host, tsm_dev);

[Severity: Medium]
Will this unconditional call trigger spurious warnings for sub-functions
like VFs?

When VFs are instantiated on an already-connected TSM host, pci_tsm_init()
finds the host DSM and calls the probe function for the VF. Here in
pci_cma_tsm_probe() from drivers/pci/cma.c, we unconditionally call
pci_tsm_host_constructor() on every probed device.

Because VFs lack CMA mailboxes, this triggers spurious "TSM init failure, no
CMA mailbox" warnings in the kernel log for every VF probed.

Would it make sense to add an is_pci_tsm_host(pdev) check here before
calling pci_tsm_host_constructor(), to ensure we only attempt to initialize
it when appropriate?

> +	if (rc) {
> +		kfree(cma);
> +		return NULL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D12
