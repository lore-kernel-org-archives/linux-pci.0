Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163735C6A3;
	Wed,  9 Sep 2026 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972341; cv=none; b=qm539BYr0gliQW5WLE9EkdGwy8glbW5T1MKOO2Zfi3ms1N7epUP6LLLZaMDTyHBNMXmvNPVtSBeHlQAoz4dUJ9th08H3byf9DrEZ/oGpvC29nM9+YbJUl6vM6fTGD8EYzzJk6PTocpUD9YfDg8HYRfSocv3iwd4rpZQB/+UClSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972341; c=relaxed/simple;
	bh=S+pvEOae1w9EY3/cY6pdjqNU25WCyd3zuhV+ssnJGs0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eLuWUn97+IDBMfUIEy0t+aIGxAV4zfifyPUIXL1NVOjvadICTpZ2+QsajbQuxv9UuUMjMe+wB8ImDK68k6XxHeZkytC9QIDtL5Ep2h2zxYYtbgpMevN1e57o+SDX7jegkr/7vuaB7xx0tc+bEC7IwMliYreufr5JRhfiJnH9i0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNEJU8kY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNEJU8kY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6F41F000FF;
	Wed,  9 Sep 2026 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972340;
	bh=A/jniKq40jPlDXnhdNOINrXDBhOnEzAaf3qgB1VQ8V8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MNEJU8kYYPJM5p1KzrlKYUIAWlIS/JfrDZoULQIVBTRB1eAU8qddnQk6M/sJalOe+
	 zZvHlAmUX+B/HNloNOb32DG79bafS8zz2mQlvAGl2SG6vzKDVR48SfMr6juzafTNQr
	 3jJjkcnxyIjjcRgTWBtEtgJVvdo/6TpbDpLwJotgEhFdl9Ga/1s34xS+WDxGlJav8t
	 8/fkMErq/irb/tDHZ0ucIuz7Fa85cBT06ed2s70xOry57YIxIUq0DcAHiJNuMDKBZz
	 7QZjqqt8qolULnwYXxtyMtnR3ML9r9S2OLNhIbg1mn2ItotzKc+gz6w/JJvZjWLq8f
	 OC/7gdvzlTqMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/AER: Map a raw AER Capability image field by
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260909163140.2723395-1-dave.jiang@intel.com>
References: <20260909163140.2723395-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:45:39 +0000
Message-Id: <20260909164539.CE6F41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] aer_cap_regs_unpack() causes data corruption and mis-parsing of AE=
R registers on big-endian architectures due to mixed endianness inputs and =
improper byte-offset access.

Pre-existing issues:
- [High] Memory allocated for `aer_info` from `ghes_estatus_pool` is perman=
ently leaked when `aer_recover_queue()` fails to enqueue the error due to r=
ing buffer overflow.
--

commit 5fdf5d4c5bbdafcab0279ec4f99b6ca67a1876af
Author: Dave Jiang <dave.jiang@intel.com>

PCI/AER: Map a raw AER Capability image field by field

This commit introduces aer_cap_regs_unpack() to map raw AER capability
registers field-by-field into the kernel's struct aer_capability_regs layou=
t.
It updates ACPI GHES, ACPI extlog, and CXL RCH error handling to use this
unpacking routine instead of flat memory copies.

Link: https://lore.kernel.org/linux-cxl/CAJZ5v0hDv11cPuztPZsaDd7uwD_49KznJy=
=3DtzuRO+dZc=3DCnAEQ@mail.gmail.com/
Link: https://sashiko.dev/#/patchset/20260904172337.1409775-1-dave.jiang@in=
tel.com?part=3D5

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 08c985e729d6c..ade1cc8c9f8d1 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
[ ... ]
> @@ -668,20 +668,7 @@ static void ghes_handle_aer(struct acpi_hest_generic=
_data *gdata)
>  		if (!aer_info)
>  			return;
> =20
[ ... ]
> +		aer_cap_regs_unpack(aer_info, pcie_err->aer_info, sizeof(pcie_err->aer=
_info));

[Severity: High]
Will this corrupt the AER registers on big-endian architectures?

The pcie_err->aer_info buffer contains a strictly little-endian CPER payloa=
d.
However, aer_cap_regs_unpack() receives this raw byte stream and populates
native u32 fields with it, which can lead to mis-parsing.

> =20
>  		aer_recover_queue(pcie_err->device_id.segment,
>  				  pcie_err->device_id.bus,

[Severity: High]
This is a pre-existing issue, but does aer_recover_queue() permanently leak
the aer_info allocation if the ring buffer overflows?

The aer_info is allocated from the fixed-size ghes_estatus_pool via
gen_pool_alloc() earlier in this function. When passed to
aer_recover_queue(), memory ownership is dropped without freeing it if
the queue operation fails:

drivers/pci/pcie/aer.c:aer_recover_queue() {
    if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
                            &aer_recover_ring_lock))
        schedule_work(&aer_recover_work);
    else
        pr_err("buffer overflow in recovery...");
        /* aer_regs pointer dropped here */
}

Since this pool is small and fixed-size, could an error storm that overflows
the queue permanently deplete the pool and disable further ACPI GHES error
reporting?

> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index e0e01aa5eba6c..4005344dda55f 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
[ ... ]
> @@ -58,31 +58,17 @@ void cxl_disable_rch_root_ints(struct cxl_dport *dpor=
t)
>  static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>  				 struct aer_capability_regs *aer_regs)
>  {
[ ... ]
> -	/* Use readl() to guarantee 32-bit accesses */
> -	for (n =3D 0; n < read_cnt; n++)
> -		aer_regs_buf[n] =3D readl(aer_base + n * sizeof(u32));
> +	for (int n =3D 0; n < ARRAY_SIZE(raw); n++)
> +		raw[n] =3D readl(aer_base + n * sizeof(u32));
> +
> +	aer_cap_regs_unpack(aer_regs, raw, sizeof(raw));

[Severity: High]
Could populating the raw array using readl() cause data corruption on
big-endian systems?

By using readl(), the raw array is filled with host-endian values. When
aer_cap_regs_unpack() later extracts byte-offsets via memcpy(), this will
read from the wrong half of the u32 on big-endian architectures, swapping
fields like the correctable and uncorrectable error sources.

> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> index 71f8fc9ea2edc..bba80c3803587 100644
> --- a/drivers/pci/pcie/tlp.c
> +++ b/drivers/pci/pcie/tlp.c
[ ... ]
> +void aer_cap_regs_unpack(struct aer_capability_regs *regs, const void *r=
aw,
> +			 size_t raw_len)
> +{
[ ... ]
> +	if (raw_len < PCI_ERR_HEADER_LOG)
> +		return;
> +	memcpy(regs, raw, PCI_ERR_HEADER_LOG);
> +
> +	flit =3D FIELD_GET(PCI_ERR_CAP_TLP_LOG_FLIT, regs->cap_control);

[Severity: High]
Will this extract the wrong bits on big-endian systems when processing
little-endian CPER streams?

If raw comes from ACPI GHES (where it is little-endian), the memcpy() just
above populates regs->cap_control with little-endian bytes. On a big-endian
system, this results in a byte-swapped integer, causing FIELD_GET() to read
incorrect bits for the FLIT status and TLP log size.

[ ... ]
> +	if (raw_len >=3D PCI_ERR_ROOT_ERR_SRC + sizeof(regs->cor_err_source) +
> +		       sizeof(regs->uncor_err_source)) {
> +		memcpy(&regs->cor_err_source, raw + PCI_ERR_ROOT_ERR_SRC,
> +		       sizeof(regs->cor_err_source));

[Severity: High]
Does this byte-level copy extract the wrong half of the register on
big-endian systems?

When raw is populated as a host-endian u32 array (as is done in
cxl_rch_get_aer_info), copying 2 bytes from the PCI_ERR_ROOT_ERR_SRC offset
will extract the upper 16 bits instead of the lower 16 bits on big-endian
machines. This swaps the correctable and uncorrectable error source fields.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909163140.2723=
395-1-dave.jiang@intel.com?part=3D1
