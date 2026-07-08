Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433548034C;
	Wed,  8 Jul 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520461; cv=none; b=S/A6kRiulk793KhnnjK578cr3a/MkUOXWAue9WtCWqsB623EdhyMCuAzZ1ifWhRE9uttHsSgZV4PFr+vU9UtQxtdslaT2TyPcZD7UtP7f6KLxxGwQDNyEtWm3K3hxl6usb6+wGKiO4q9bta9l/sbnBzjihOCWDgV/WObPkKY4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520461; c=relaxed/simple;
	bh=ei29EELG4Ffd+NwGSq8v/69ckdiC/I8U3+BIjtcs2jo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oLOlRUUJwTFgVrPJXNnwMoQD9n6tw5f9psKlMza9I65BnQxmPUrZkPSvAvf57jGK/8sTWMUVaBFD4bZRX38JeJY93TQr/GY+iAF4a1/KvKkF+4WaDx9pT5CoPWUTa5jIiRuGU7/6MygbaoTVtL1j0UTnGoYOupp05Mi6jbAA85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftlG50/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftlG50/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2531D1F000E9;
	Wed,  8 Jul 2026 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520459;
	bh=h0TUJyrXzKtdLdL5k7vEC9WTZLW4bHSICqLOAzx8YLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ftlG50/MeO3Cv2QyFWn1g6hTNSIxWLjGOVy6W71NxOrrMCo00jxvqiXWXCzPeRz9M
	 RHG1IJrQgZkhR3a2kUkAV0Uc1MGML0SiyilRpdx91hUhwZnv90JE9nO5dZyltBxKXu
	 4mfflXQZbrSjp4u36l/n+2aCDDNKbQxwX78D7/Fr62DqxUL/tXfpLQkLTZ6IdVs2V+
	 kPgNdRH0+cCnj+6qwkNI6tT3J32LiaCYBNvZgXml5UmRK4xUy6ZJvi+S7B7F516LBd
	 FNDRKL6Usz65YLntN38YSS+9XZiVL7tDv7SfD1+Euj3RH6mw6TzQk77WDqjRo4mDob
	 cPSrBMMM0zxHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] ACPI: APEI: GHES: move CPER read helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: linux-cxl@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-2-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-2-8b3a85216cef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:20:58 +0000
Message-Id: <20260708142059.2531D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A 32-bit integer overflow in `cper_estatus_check_header()` allows =
malicious hardware/firmware to bypass bounds checks, leading to an out-of-b=
ounds read during CPER parsing.
--

--- Patch [2]: [PATCH v7 02/10] ACPI: APEI: GHES: move CPER read helpers ---
commit 04015aac8e37e710180920d3ccbdeddf2e3b4a43
Author: Ahmed Tiba <ahmed.tiba@arm.com>

ACPI: APEI: GHES: move CPER read helpers

Relocate the CPER buffer mapping, peek, and clear helpers from ghes.c into
ghes_cper.c so they can be shared with other firmware-first providers.
This commit only shuffles code; behavior stays the same.

> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
> new file mode 100644
> index 0000000000000..0c3f52b2d7f1c
> --- /dev/null
> +++ b/drivers/acpi/apei/ghes_cper.c

[ ... ]

> +int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
> +			u64 buf_paddr, enum fixed_addresses fixmap_idx,
> +			size_t buf_len)
> +{
> +	u32 len;
> +
> +	ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
> +
> +	len =3D cper_estatus_len(estatus);
> +	if (len < sizeof(*estatus)) {
> +		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n"=
);
> +		return -EIO;
> +	}
> +
> +	if (len > buf_len) {
> +		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block lengt=
h!\n");
> +		return -EIO;
> +	}
> +
> +	if (cper_estatus_check(estatus)) {

[Severity: High]
This is a pre-existing issue, but can this lead to an out-of-bounds read
when parsing the CPER block?

On 32-bit architectures, a maliciously crafted CPER block with an extremely
large data_length (e.g., 0xFFFFFFFF), a small raw_data_offset (e.g., 20),
and a non-zero raw_data_length (e.g., 1) could bypass the header validation
check.

In drivers/firmware/efi/cper.c:cper_estatus_check_header():

    if (estatus->raw_data_length &&
        estatus->raw_data_offset < sizeof(*estatus) + estatus->data_length)
            return -EINVAL;

The addition of sizeof(*estatus) and estatus->data_length can integer
overflow. For example, 20 + 0xFFFFFFFF =3D 19. The validation 20 < 19
evaluates to false, allowing it to pass.

Because cper_estatus_len() would just return the offset + raw_data_length
(21 in this case), the len > buf_len check above also passes.

Finally, when cper_estatus_check() is called,
apei_estatus_for_each_section() will iterate using the massive data_length
over unmapped memory, resulting in an out-of-bounds read and likely a
kernel panic.

Could we add safeguards against this overflow in the header validation?

> +		pr_warn_ratelimited(FW_WARN GHES_PFX
> +				    "Failed to read error status block!\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-topics-ahm=
tib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com?part=3D2
