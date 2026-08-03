Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C83515D1;
	Mon,  3 Aug 2026 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796830; cv=none; b=I1c9h4xcpD2HYcDbKTA+VhmCWptcisicw/tZ2xUxcJuda8ekOJuV86KAZoGmD1okRLYXN53YaHzEngrKQfjU2n5Io0cc5eU1RTqZ1eOj2zUISQgYffB1AWFScDNovWGjVlbOV2v1b7S0mV4z4GQTwxsSTtzIY1lkGW4gOdWBi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796830; c=relaxed/simple;
	bh=IacNtfUmvvX4Ds9HTqB01x9w7wmNeZGSXa8cO3vyzMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Le5KCbBuDtvUzl5TEI/LpiQcrpAhn6+RMAx3yCijKEKk/HFcFuGS0MEzhAiexKIvmg096lxHWGtrUIKmmq1u0AAlLwti95QzbzwV1YfeAwzsdXR5MJVkTFbG8E+EoX8uyub7sSL1PilXD+UUjrRbeGToqWrOVjwRxFqtpu1FHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dra/kgvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dra/kgvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE651F000E9;
	Mon,  3 Aug 2026 22:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796828;
	bh=r/hYZ4KrtQdGkOJFITe8e6EObaGaXQIN/wuwESbh6E0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dra/kgvSgBKS5GuEAHZZIU906NkCTK5sAvopiA/V/goEkwQH6Syc5pjHhrEM943Q2
	 jsBUjKL6W5CcjI6QhAB44iF0bPZ2Q9wK2Zn2vTqCC1q5FWQp+6eTosvDJytZXxptKP
	 Ow5RWsXBnoFlB7MVO9nC9+WWzfoRHvdO9N5W5OzWW98Nz4UIeu8q0K96tk7bIUlWt6
	 mN2AWOBE6rjLJIDGgQ+apA1kROscPo5RaKce2kJQZjCW4R5ljWy4kNOS2ngwv34DYg
	 GNjRDqywQSVlSUB8dznJdhCS4aC12LWkuOYLfU9iayKvEGWYSwI1ggLW/7xHQpy3nw
	 JPktI8qb4yhDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 10/14] cxl: Update CXL Endpoint AER handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260803221810.3685703-11-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-11-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:40:27 +0000
Message-Id: <20260803224028.4DE651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditional system panic on a frozen PCIe link for idle CXL devi=
ces due to an incorrect assumption about RAS register mapping.

Pre-existing issues:
- [Medium] Evaluating `BIT(63)` during CXL RAS handling on a dead link caus=
es undefined behavior on 32-bit platforms and truncation on 64-bit platform=
s.
--

--- Patch [10]: [PATCH v19 10/14] cxl: Update CXL Endpoint AER handler ---
commit 4439ebdc3bdbec21997bf9c57f9c8a4e5e9901ea
Author: Terry Bowman <terry.bowman@amd.com>

cxl: Update CXL Endpoint AER handler

This commit updates the CXL Endpoint AER handler by renaming functions
and documenting the unconditional RAS read policy. It establishes that
reading a dead link returns 0xFFFFFFFF, which is interpreted as UCE
bits being set to trigger a panic.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
[ ... ]
> @@ -343,9 +343,16 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *=
pdev,
>  		/*
>  		 * The CXL RAS read is unconditional regardless of channel
>  		 * state. Any uncorrectable error bit set in the CXL RAS
> -		 * status register triggers a panic below because CXL.mem
> -		 * cache coherency is already lost; continuing risks silent
> -		 * data corruption.
> +		 * status register triggers a panic because CXL.mem cache
> +		 * coherency is already lost; continuing risks silent data
> +		 * corruption.
> +		 *
> +		 * On a dead link readl() returns 0xFFFFFFFF which sets all
> +		 * UCE bits and also triggers the panic - this is intentional.
> +		 * If RAS registers are not mapped the read is skipped, the
> +		 * panic is not reached, and the frozen/perm_failure switch
> +		 * cases below handle AER recovery for devices without active
> +		 * CXL.mem traffic.
>  		 */
>  		ue =3D cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>  	}

[Severity: High]
The comment states that if RAS registers are not mapped, the read is skipped
and AER recovery handles devices without active CXL.mem traffic. Is this
assumption about unmapped RAS registers accurate?

It appears that cxl_endpoint_port_probe() maps RAS registers unconditionally
for all capable endpoints, regardless of CXL.mem activity. If a link freeze
occurs on an idle endpoint, won't this dead link read 0xFFFFFFFF and
trigger an unintended panic, effectively breaking standard PCIe AER recovery
for these devices?


[Severity: Medium]
This is a pre-existing issue, but since this patch intentionally relies on
dead links returning 0xFFFFFFFF during the RAS read, what happens inside
cxl_handle_ras() when we encounter one?

drivers/cxl/core/ras.c:cxl_handle_ras() {
    ...
    if (hweight32(status) > 1) {
        void __iomem *rcc_addr =3D ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
        fe =3D BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, readl(rcc_addr)));
    ...
}

When readl() returns 0xFFFFFFFF on the dead link, FIELD_GET() extracts 63.
Will evaluating BIT(63) cause an out-of-bounds shift on 32-bit platforms,
and won't the 64-bit result be silently truncated to 0 when assigned to the
u32 fe variable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D10
