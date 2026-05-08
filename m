Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9CD28725B
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778212686; cv=none; b=andJB7jOJbQQ9fzMXhgeUYZAwVEKBe/UPX+vuviRu+Kv+T4GsSfdB6gaAkUOtKAMJ1npY7Q53trVouQmshqxI3FFJDFXsi6S2zYdSqePGdiXx1pn/REH8iqrZI5cmjShMHEdHsdmbLzYKvBuRjkTQOQgdzqjYHvFzbjyqhqlCgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778212686; c=relaxed/simple;
	bh=Rb6o2pAgryP/W1ucJ1j0Y1K+zUjA9Nncf0PWkb75PPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bk9jrdyLSzzlh2qNrsxy+Ma2eToLUYCp8/fYpIRAYFgM6qyVmFBaZ7BdUgKpoLQ95iDGmnSIIbwH82Km1/oUcTFTbz8RjIfb1+SPiGPaEYgADt4aTMJRUtUgqQIPO1JqOvwEkoP8N2Q0H0BkkZwjOo6zAhddXeYw/JVwPzlb5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeFmUgv/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeFmUgv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE8DC2BCB0;
	Fri,  8 May 2026 03:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778212686;
	bh=Rb6o2pAgryP/W1ucJ1j0Y1K+zUjA9Nncf0PWkb75PPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FeFmUgv/5s7QSzA9d3jTuphN3bQgxmbTzAc0XrCeXcH2emQzccvCGQWYELHD8KvlE
	 Bq2lpfkxEG1mWM+1vtyJUliBUEnLU9T/LuGuMysbHVl+UhcGiCmSqVaY9UoDV7s9u8
	 bSNKkmK9vWmQxcKftbjuJmP2qdk5U0ylnCdcInMpissQB2CsbDoYve/LmRkHJklLzd
	 YOAuK3bVXQg7eOXLd64wR/SF0YLBu/ejXlMburXYOJWzP3qLfzoAjy+I0Sub4jmVB9
	 YLpf1Hv6ZbdJ/blK151x0pSDWwCteouh5RM9h014P0r9Cr14/mWOqnnOKgbkNdKv0W
	 Sw2BXyTzqgDvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/18] PCI/CMA: Validate Subject Alternative Name in
 certificates
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260508031710.514574-11-alistair.francis@wdc.com>
References: <20260508031710.514574-11-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 03:58:05 +0000
Message-Id: <20260508035806.0EE8DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Valid devices with a DSN of 0 are incorrectly rejected
- [High] SSVID and SSID fields are incorrectly omitted for PCIe bridges
- [High] Torn read of device identity prevents reauthentication after runti=
me mutations
- [High] Kbuild linkage failure when compiled as a loadable module
- [Medium] Chaining `snprintf` without length checks risks logic errors and=
 out-of-bounds stack reads
- [Medium] Strict case-sensitive comparison of the Subject Alternative Name=
 risks rejecting valid certificates
--

commit 72435325efe665bb825f47731ca5c0081b7acc14
Author: Lukas Wunner <lukas@wunner.de>
Subject: PCI/CMA: Validate Subject Alternative Name in certificates

This commit introduces functionality to validate the Subject Alternative Na=
me
(SAN) in PCIe Leaf Certificates. It parses the SAN using an ASN.1 decoder
and verifies that the identity encoded in the certificate matches the
device's identity in Config Space.

> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 16abfd0e17e19..15512512fce7d 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
[ ... ]
> -obj-$(CONFIG_PCI_CMA)		+=3D cma.o
> +obj-$(CONFIG_PCI_CMA)		+=3D cma.o cma.asn1.o
> +$(obj)/cma.o:			$(obj)/cma.asn1.h
> +$(obj)/cma.asn1.o:		$(obj)/cma.asn1.c $(obj)/cma.asn1.h

If CONFIG_PCI_CMA is configured as a loadable module, will Kbuild compile
two separate modules (cma.ko and cma.asn1.ko)?

Because the ASN.1 compiler does not export the cma_decoder symbol, would
the cma.ko module fail to link during modpost with an undefined symbol
error?

Should these objects be bundled into a composite object instead? For
example:

cma_module-y :=3D cma.o cma.asn1.o
obj-$(CONFIG_PCI_CMA) +=3D cma_module.o

> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> index 998fde6366fb8..ee186f3619409 100644
> --- a/drivers/pci/cma.c
> +++ b/drivers/pci/cma.c
[ ... ]
> +int pci_cma_note_san(void *context, size_t hdrlen, unsigned char tag,
> +		     const void *value, size_t vlen)
> +{
> +	struct pci_cma_x509_context *ctx =3D context;
> +
> +	/* These aren't the drOIDs we're looking for. */
> +	if (ctx->last_oid !=3D OID_CMA)
> +		return 0;
> +
> +	if (tag !=3D ASN1_UTF8STR ||
> +	    vlen !=3D ctx->expected_len ||
> +	    memcmp(value, ctx->expected_name, vlen) !=3D 0) {

Does this perform a strict case-sensitive comparison of the Subject
Alternative Name?

If a device vendor provisions the certificate using uppercase hexadecimal
letters (a common standard for hardware IDs), could this strict memcmp()
erroneously reject a valid device?

> +		pci_err(ctx->pdev, "Leaf certificate of slot %u "
> +			"has invalid Subject Alternative Name\n", ctx->slot);
> +		return -EINVAL;
> +	}
> +
> +	ctx->found =3D true;
> +
> +	return 0;
> +}
> +
> +static unsigned int pci_cma_construct_san(struct pci_dev *pdev, char *na=
me)
> +{
> +	unsigned int len;
> +	u64 serial;
> +
> +	len =3D snprintf(name, CMA_NAME_MAX,
> +		       "Vendor=3D%04hx:Device=3D%04hx:CC=3D%06x:REV=3D%02hhx",
> +		       pdev->vendor, pdev->device, pdev->class, pdev->revision);

The commit message mentions handling devices that mutate their identity
at runtime, but this string is constructed using cached software state
from probe time (like pdev->vendor).

Since pci_get_dsn() reads the live hardware state, could a mutated device
result in an inconsistent string containing a stale vendor/device ID but
a new DSN? Will reauthentication fail without a full PCI rescan?

Additionally, snprintf() returns the number of characters that would have
been written, not the actual bytes written.

If the inputs ever exceed the 79-byte CMA_NAME_MAX buffer (for instance,
if a quirk mutates pdev->class to exceed 6 hex characters), the string
will be truncated but len will reflect the untruncated size.

Could this cause the later memcmp() check in pci_cma_note_san() to read
out of bounds of the ctx->expected_name stack buffer? Should scnprintf()
be used here instead to track the actual length written?

> +
> +	if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL)
> +		len +=3D snprintf(name + len, CMA_NAME_MAX - len,
> +				":SSVID=3D%04hx:SSID=3D%04hx",
> +				pdev->subsystem_vendor, pdev->subsystem_device);

PCIe Type 1 devices (bridges) can also implement the Subsystem Vendor ID
capability.

If a Type 1 bridge implements this capability and includes these fields in
its certificate as required by the specification, will this condition
unconditionally omit them and cause validation to fail?

> +
> +	serial =3D pci_get_dsn(pdev);
> +	if (serial)
> +		len +=3D snprintf(name + len, CMA_NAME_MAX - len,
> +				":%016llx", serial);
> +
> +	return len;
> +}

Looking at pci_get_dsn(), it returns 0 both when the DSN capability is
missing and when the device's legitimate serial number is 0.

If a device implements the capability with a valid DSN of 0, will this
check evaluate to false, omit the field, and reject a valid device?

Would it be safer to explicitly check for the capability's presence via
pci_find_ext_capability() instead?

Also, pci_get_dsn() performs two separate 32-bit reads without a lock:

pci_read_config_dword(dev, pos, &dword);
dsn =3D (u64)dword;
pci_read_config_dword(dev, pos + 4, &dword);
dsn |=3D ((u64)dword) << 32;

Could a concurrent mutation of the device identity result in a torn
64-bit read during this check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D10
