Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDD6360EC0
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290277; cv=none; b=EgHHZ4HLHmZ7UpdMAlEiNjU9BizUuXMDrBb88Cva2cxKXSpfMm8rzBMOFWRT7q+dJvVhYBIN2FI1rxYfzrbPfeiA+ukxFllCPNq5E2vh7lnQi0U5NagJ9+rTqlGiEdF6Tg1nLqHLEM9O3uhZkaOURfDeVpqjlNZzSVKUh0lTS3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290277; c=relaxed/simple;
	bh=c4LsYHPZPHB51YX33o5qJjR191yMDtV8O+Q8UtxT7Vc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hpLTrHRlKvKzSimEhx4bw6JMAUqRsvczwZPBJXNgW5rNkXC/PXikkqnASw0/rHJZrAZZTvn63qlg8/l2JtwAs3OqwxdqGL2rQlrCHhphIMhCb1xrnqscdmcATxS/EpI/U7tPAwbnK+0oVlLLuCX7o+GX3QLNZv9z9JsEljv9nek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQSRzdf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQSRzdf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62B91F000E9;
	Sun,  5 Jul 2026 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783290276;
	bh=zgKz+1+oQvcCws4Kf2OViU80STyuJ0MlE2z/on5itro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQSRzdf4Db50B8WUGCFyatOyHG8lmHdiIZpMIRFZf1cweIJfAgQghN6Rc/BJduys1
	 tOM8ee4lXJl7YvtyQk1fkBUXQfdjri3C2eSmbMq4LNW/f66bnUqlCCZzkomwOnVgI9
	 BXdvSleBzwa3m56VSOSBXuPdm1EDFyn90MqZTpq3FaqFGlkO+RW88r+G1TXIeSMj3n
	 0htRKwOc8kEOnG9YKxMQ0sKpxiLgU9AQgSv7Zb5q1et5yqJMYLveKuJ+LMWCJIJwi1
	 gmsDZnp3qjcjq+iMQVSBoBf4ltlnehWsG7SGXV8p2PmvaY/630Asb156RP8ANMrlC+
	 Ykos1WCdNbhdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] PCI/TSM: Create MMIO descriptors via TDISP Report
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-15-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-15-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:24:35 +0000
Message-Id: <20260705222435.E62B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] 32-bit unsigned multiplication overflow in MMIO region size calcul=
ation silently truncates the size for regions >=3D 4GB.
- [Medium] Bitwise NOT of a 32-bit `unsigned long` mask zeroes out the uppe=
r 32 bits of a 64-bit physical address on 32-bit architectures.
--

commit cfcbb8abea88df9f3a56b20ab3e4fac1bdbf37ea
Author: Dan Williams <djbw@kernel.org>

PCI/TSM: Create MMIO descriptors via TDISP Report

This commit introduces a helper function to create encrypted MMIO descripto=
rs
from a TDISP Report. The descriptors allow the low-level TSM driver to info=
rm
ioremap() how to map the device's MMIO correctly based on the device's
expectations. It also computes the obfuscated base addresses for each
encrypted MMIO range.

Link: https://lore.kernel.org/linux-coco/20251117140007.122062-8-aneesh.kum=
ar@kernel.org/ [1]

> diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
> --- a/drivers/pci/tsm/core.c
> +++ b/drivers/pci/tsm/core.c

[ ... ]

> +struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev)
> +{

[ ... ]

> +	for (i =3D 0; i < mmio_range_count; i++) {
> +		u64 range_off;
> +		struct range range;
> +		const struct pci_tsm_devif_mmio *mmio_data =3D &report->mmio[i];
> +		struct pci_tsm_mmio_entry *entry =3D
> +			pci_tsm_mmio_entry(mmio, mmio->nr);
> +		u64 tsm_offset =3D __le64_to_cpu(mmio_data->phys);
> +		u64 size =3D __le32_to_cpu(mmio_data->nr_pfns) * SZ_4K;

[Severity: High]
Does this calculation suffer from a 32-bit multiplication overflow?

Since __le32_to_cpu() returns a 32-bit unsigned integer and SZ_4K is also
32-bit, if nr_pfns is large enough (representing 4GB or more), the
multiplication will overflow before it is zero-extended and assigned to the
64-bit size variable.

Could this lead to the size being truncated (e.g., yielding 0 for exactly
4GB) and exposing intended secure MMIO space to the VM as unencrypted
memory?

> +		u32 attr =3D __le32_to_cpu(mmio_data->attributes);
> +		int bar =3D FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
> +				    attr);

[ ... ]

> +		if (last_bar < bar) {
> +			unsigned long mask =3D pci_resource_len(pdev, bar) - 1;
> +
> +			/* Transition to a new bar */
> +			last_bar =3D bar;
> +
> +			/*
> +			 * Determine the obfuscated base of the BAR. BAR
> +			 * offsets are never obfuscated.
> +			 */
> +			reporting_bar_base =3D tsm_offset & ~mask;

[Severity: Medium]
Will this bitwise operation truncate the upper 32 bits of the physical
address on 32-bit architectures?

On 32-bit platforms with 64-bit physical addresses (like PAE), unsigned
long is 32 bits. The mask truncates the BAR size, and ~mask flips those
32 bits. When it is promoted to u64 for the bitwise AND with tsm_offset,
the upper 32 bits of the zero-extended ~mask will be 0.

Could this completely erase the upper 32 bits of reporting_bar_base when
compiled for 32-bit platforms?

> +		} else if (tsm_offset < last_reporting_end) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D14
