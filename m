Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18011330301
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786662479; cv=none; b=coAvCXJ9WogqjkjnZa6Ka2ewYE/N6A3e0jhERPnllOHwacqafNeOY7963JbEO28EgIKX8IixWI0YbD624brKLzVDW0rsDbxXFPd3Rqc/04D+w2AbNoQZZwwWtSCGLaTw17LmsMtBgOJoilV0xgFHCyMyJwAcH7U8av7JgI4RG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786662479; c=relaxed/simple;
	bh=5ikdSnImwkeUcVaAbAi49+lLg7qw7n1WZ/S3WkgHDLQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iXryj0KTraJ/T5lx64xaNp4lsLqQS2GOBcm9eK72afkaMbhtTUJS6oROSUV0YA6HAgMTMpACB+qXm6DtcTf30boGM4v+bRUTrFWTFzp4YDTLDIjKisKk6QAJs2yMvspe/rmbDr/73WMQosCzUCnEpMd98GFBoukwGkSIsYFfeyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaA3D95X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaA3D95X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777AB1F000E9;
	Thu, 13 Aug 2026 23:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786662477;
	bh=fRFOTpo5cuJY3ke64gD2rV9raShwSkBwD+3N2M456kQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iaA3D95XbHCkBKbzKFWjEv75/gxklNKeD+bxVyaddPcI+rnM25Co8ADMcAUWbqsi1
	 AKuBduObftT538MBxOcy5b+xQ96KpEUdSs0yFixLLSXM3H/Y57ocsIB3LSp8IU7Wxt
	 jMsWDhvKCHeuDpM9zBGqvqx7t9UnFeFMuI4x09coGfbivy9oqqd4TIzFtWEc1uPhFs
	 b9xkdp+3QaUgkBw01/HUQNX0nXysYkzaThUgvfotCN8rDgARchyPeBP30S4LY18tFg
	 +ii+27qrRQttPtEv5BDhWbK0+jvpQIb284x2t7phCu8uxuuwvl2Y0oifcFGPfkBozG
	 TS1O7W2mhG6ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] ACPI: APEI: GHES: Add NVIDIA vendor CPER record
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kai-Heng Feng" <kaihengf@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260330094203.38022-4-kaihengf@nvidia.com>
References: <20260330094203.38022-4-kaihengf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:07:52 +0000
Message-Id: <20260813230757.777AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Dropping the `__packed` attribute from `struct cper_sec_nvidia` ca=
uses Undefined Behavior and potential alignment faults when accessing 64-bi=
t fields.
- [High] A signed-to-unsigned conversion vulnerability in the length check =
allows a maliciously crafted ACPI CPER record to bypass bounds validation.
--

--- Patch [3]: [PATCH v3 3/3] ACPI: APEI: GHES: Add NVIDIA vendor CPER reco=
rd handler ---
commit ca65b6ef5ec8eb0410ab8adcafb43315cd0cfefa
Author: Kai-Heng Feng <kaihengf@nvidia.com>

ACPI: APEI: GHES: Add NVIDIA vendor CPER record handler

This commit adds support for decoding NVIDIA-specific CPER sections via
the APEI GHES vendor record notifier chain. It registers a notifier_block
to parse and print error metadata and diagnostic register dumps.

> diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvi=
dia.c
> new file mode 100644
> index 0000000000000..597275d81de85
> --- /dev/null
> +++ b/drivers/acpi/apei/ghes-nvidia.c
> @@ -0,0 +1,149 @@
[ ... ]
> +struct cper_sec_nvidia {
> +	char	signature[16];
> +	__le16	error_type;
> +	__le16	error_instance;
> +	u8	severity;
> +	u8	socket;
> +	u8	number_regs;
> +	u8	reserved;
> +	__le64	instance_base;
> +	struct {
> +		__le64	addr;
> +		__le64	val;
> +	} regs[] __counted_by(number_regs);
> +};

[Severity: High]
Does dropping the __packed attribute from this structure introduce a risk of
unaligned memory accesses?

The ACPI GHES error payload is often located at a 4-byte aligned offset
(such as offset 84 or 92) from the estatus base block, meaning the pointer
returned by acpi_hest_get_payload() can be unaligned.

Casting this misaligned pointer to a struct with 8-byte alignment
requirements and accessing 64-bit members like instance_base or the regs
array can result in undefined behavior or alignment faults on architectures
with strict alignment requirements.

[ ... ]
> +static int nvidia_ghes_notify(struct notifier_block *nb,
> +			      unsigned long event, void *data)
> +{
> +	struct acpi_hest_generic_data *gdata =3D data;
> +	struct nvidia_ghes_private *priv;
> +	const struct cper_sec_nvidia *nvidia_err;
> +	guid_t sec_guid;
> +
> +	import_guid(&sec_guid, gdata->section_type);
> +	if (!guid_equal(&sec_guid, &nvidia_sec_guid))
> +		return NOTIFY_DONE;
> +
> +	priv =3D container_of(nb, struct nvidia_ghes_private, nb);
> +
> +	if (acpi_hest_get_error_length(gdata) < sizeof(*nvidia_err)) {

[Severity: High]
Could a maliciously crafted ACPI CPER record bypass this length validation?

Looking at acpi_hest_get_error_length(), it returns an int. If the CPER
record contains an error_data_length larger than INT_MAX, it will be
returned as a negative int.

When this negative value is compared against sizeof(*nvidia_err), which is
a size_t, it will be promoted to a very large unsigned integer. This causes
the less-than condition to evaluate to false, bypassing the early return.

The bypassed length would then be passed as a size_t to
nvidia_ghes_print_error(), where it again evaluates the
error_data_length < min_size check as false, allowing the loop to perform
an out-of-bounds memory read.

> +		dev_err(priv->dev, "Section too small (%d < %zu)\n",
> +			acpi_hest_get_error_length(gdata), sizeof(*nvidia_err));
> +		return NOTIFY_OK;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260330094203.3802=
2-1-kaihengf@nvidia.com?part=3D3
