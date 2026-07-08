Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C3478E45;
	Wed,  8 Jul 2026 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521359; cv=none; b=bK3X5z4A7zextQ2KbXbK0lTcTPC/ecHw7Ha2A2B63aZQD2LD8q5QwSZ8Q57t9dsoU9Y2ybinv5D/r6q+CLnqgnb/xCIETCDUeN705pm7aT0roh/Zb481f9D8CtiwaqTbCb4FP8R1PhK5OXOb4zpCNNC2EwRMhmGrM7j+SU9wC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521359; c=relaxed/simple;
	bh=w1fawoxoc6jpIjfKssHO3HbnDN9z+t5YL6JnefkNwmU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VNk756l0wxhCLkPBHzIzPe6RYIm7AqllMxUnrG+CrADzpZ+odmboZZl7GDW55a4OuqWatIV+cciJdn4XXAR7tNXBxWhmT319zXj/4Bh1hfp3fS4+vyClNOwcnZqKwfdATxwn8N+LQNswbWujjdG5Ht8XYkaRRj941WNpk09pcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEW0hVbt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEW0hVbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D601F000E9;
	Wed,  8 Jul 2026 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783521357;
	bh=kVhVg7sAgvofNtLPi0k0PzLWq+B0jf1LlR7OHMFngFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LEW0hVbtNAzYpk8XCw+MVGfUrUp6b/IaOyQ7cOoRXbdWRe3QlG8fGkCDuOc+b98Na
	 sdC1pdTOqUqpCX9NEsNiH9Ayazh3rFMa+MzrXsmiEFJ2YLLpZpvs2PFFfAMHbw0Uzl
	 dLE65gkZQu6JeTwnwbRpmaajEEuEi+P6ddXMjyv7Kh8dqIHLW3n91+wjDc8PxDc8XU
	 sFXFe4AbRFrqGtkilwithKemZcL2ArZGOUaoEh3ni4X9Jji/8bxw7iD9UNAYIYc+AO
	 bH9XH3iNfWo7qVv3M7PC4qva8CCLpcMaEJN3CkNCCkN8Xj3gKFMuKLhc1B1O6GjNlO
	 B9lvkKgIzWqIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] RAS: add firmware-first CPER provider
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: linux-cxl@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-10-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-10-8b3a85216cef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:35:57 +0000
Message-Id: <20260708143557.91D601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The ack register is mapped as cacheable memory (MEMREMAP_WB) witho=
ut any cache flushing, which may prevent non-cache-coherent firmware from e=
ver seeing the ack bit.
- [High] Fatal hardware errors (GHES_SEV_PANIC) are processed asynchronousl=
y in a threaded IRQ handler, allowing the system to continue running and po=
tentially consume corrupted data before panicking.
- [High] Missing acquire memory barrier before reading the CPER status bloc=
k allows reading a corrupted/torn error record payload.

Pre-existing issues:
- [High] A missing remaining length check in the CPER sections loop leads t=
o a heap out-of-bounds read when parsing.
- [High] An integer overflow in cper_estatus_len() bypasses length checks, =
returning a dangerously small size.
--

--- Patch [10]: [PATCH v7 10/10] RAS: add firmware-first CPER provider ---
commit 32e67d0a44c9a2a1207aa498bd207d1d6f803056
Author: Ahmed Tiba <ahmed.tiba@arm.com>

RAS: add firmware-first CPER provider

Add a firmware-first CPER provider that reuses the shared
GHES helpers, wire it into the RAS Kconfig/Makefile and
document it in the admin guide.

> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-i=
nternal.h
> index 77c10a7a7a9f4..15d11f10d0671 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -123,8 +123,7 @@ struct dentry *apei_get_debugfs_dir(void);
>  static inline u32 cper_estatus_len(struct acpi_hest_generic_status *esta=
tus)
>  {
>  	if (estatus->raw_data_length)
> -		return estatus->raw_data_offset + \
> -			estatus->raw_data_length;
> +		return estatus->raw_data_offset + estatus->raw_data_length;

[Severity: High]
This is a pre-existing issue, but can the addition of raw_data_offset and
raw_data_length overflow?

If a malformed CPER record has values that sum to a 32-bit wrap-around
(e.g., 0xFFFFFFF0 + 0x24 =3D 20), this could return a dangerously small siz=
e,
potentially leading to undersized cache allocations and downstream
out-of-bounds accesses.

>  	else
>  		return sizeof(*estatus) + estatus->data_length;
>  }

[ ... ]

> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 06b4fdb59917a..a78e7d17a1b9f 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -742,7 +742,8 @@ int cper_estatus_check_header(const struct acpi_hest_=
generic_status *estatus)
>  	    estatus->data_length < sizeof(struct acpi_hest_generic_data))
>  		return -EINVAL;
>  	if (estatus->raw_data_length &&
> -	    estatus->raw_data_offset < sizeof(*estatus) + estatus->data_length)
> +	    (estatus->raw_data_offset < sizeof(*estatus) ||
> +	     estatus->raw_data_offset - sizeof(*estatus) < estatus->data_length=
))
>  		return -EINVAL;
> =20
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does cper_estatus_check() (which calls
this header check) have a heap out-of-bounds read if a malformed CPER record
has a valid total data_length, but the final section leaves fewer than
sizeof(*gdata) bytes remaining?

If the loop in apei_estatus_for_each_section() executes when the remaining
length is very small, acpi_hest_get_size() will dereference gdata->revision
reading past the end of the valid data buffer.

[ ... ]

> diff --git a/drivers/ras/cper-esource.c b/drivers/ras/cper-esource.c
> new file mode 100644
> index 0000000000000..3f60c9849d9a6
> --- /dev/null
> +++ b/drivers/ras/cper-esource.c
> @@ -0,0 +1,332 @@

[ ... ]

> +static void *cper_esource_map_region(struct device *dev, unsigned int in=
dex,
> +				     size_t *size)
> +{
> +	struct resource res;
> +	void *addr;
> +
> +	if (of_reserved_mem_region_to_resource(dev->of_node, index, &res))
> +		return ERR_PTR(dev_err_probe(dev, -EINVAL,
> +					     "unable to resolve memory-region %u\n",
> +					     index));
> +
> +	*size =3D resource_size(&res);
> +	if (!*size)
> +		return ERR_PTR(dev_err_probe(dev, -EINVAL,
> +					     "memory-region %u has zero length\n",
> +					     index));
> +
> +	addr =3D devm_memremap(dev, res.start, *size, MEMREMAP_WB);

[Severity: High]
Will the firmware be able to observe the ack bit being set in the mapped
ack region?

The region is mapped as cacheable memory (MEMREMAP_WB). Later,
cper_esource_ack() uses wmb() to publish the update, but wmb() only enforces
memory ordering and does not flush the CPU data cache to main memory.=20

Unless the firmware is fully cache-coherent with the OS, the updated ack bit
might remain in the CPU cache, potentially causing the firmware to wait
indefinitely.

Could we map the ack register as uncached (e.g., MEMREMAP_WT, MEMREMAP_WC,
or devm_ioremap), or perform an explicit cache clean operation?

[ ... ]

> +static void cper_esource_ack(struct cper_esource *ctx)
> +{
> +	if (!ctx->ack.present)
> +		return;
> +
> +	if (ctx->ack.width =3D=3D 64) {
> +		u64 *addr =3D ctx->ack.addr;
> +		u64 val =3D READ_ONCE(*addr);
> +
> +		/* Publish status-buffer updates before raising the ack bit. */
> +		wmb();
> +		val &=3D ctx->ack.preserve;
> +		val |=3D ctx->ack.set;
> +		WRITE_ONCE(*addr, val);

[Severity: High]
As mentioned above, wmb() does not clean the cache line to main memory.
Could this leave the updated ack bit trapped in the CPU cache?

[ ... ]

> +static irqreturn_t cper_esource_process(struct cper_esource *ctx)
> +{
> +	int rc;
> +	int sev;
> +
> +	memcpy(ctx->estatus, ctx->status, ctx->status_len);

[Severity: High]
Does copying the entire status block before checking the block_status flag
allow reading a corrupted or torn error record payload?

Because the firmware buffer is mapped as cacheable memory, the CPU can reor=
der
the loads. If the CPU races with the firmware updating the record, it might
load stale payload bytes out of order before observing the new
block_status =3D=3D 1.

Should we read block_status using smp_load_acquire(), check if it is non-ze=
ro,
and only then read the rest of the payload?

> +
> +	rc =3D cper_esource_validate_status(ctx);
> +	if (rc =3D=3D -ENOENT)
> +		return IRQ_NONE;
> +	if (rc) {
> +		dev_warn_ratelimited(ctx->dev, FW_WARN GHES_PFX
> +				     "Invalid error status block\n");
> +		cper_esource_clear_status(ctx);
> +		cper_esource_ack(ctx);
> +		return IRQ_HANDLED;
> +	}
> +
> +	sev =3D ghes_severity(ctx->estatus->error_severity);
> +	if (sev >=3D GHES_SEV_PANIC)
> +		cper_esource_fatal(ctx);

[Severity: High]
Is it safe to process fatal hardware errors (GHES_SEV_PANIC) asynchronously=
 in
a threaded IRQ handler?

If the system continues running, could the CPU consume poisoned memory befo=
re
the threaded handler executes and panics?

[ ... ]

> +static int cper_esource_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct cper_esource *ctx;
> +	size_t size;
> +	int source_id;
> +	int rc;

[ ... ]

> +	rc =3D devm_request_threaded_irq(dev, ctx->irq, NULL, cper_esource_irq,
> +				       IRQF_ONESHOT,
> +				       dev_name(dev), ctx);

[Severity: High]
Because the IRQ is requested without a hardirq primary handler, the default
primary handler masks the interrupt and wakes the thread, allowing the
currently executing task to resume.

For fatal RAS errors, shouldn't the system panic immediately in a hardirq
(or NMI) handler to ensure containment guarantees?

> +	if (rc)
> +		return dev_err_probe(dev, rc, "failed to request interrupt\n");
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-topics-ahm=
tib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com?part=3D10
