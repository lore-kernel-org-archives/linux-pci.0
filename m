Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F931985D;
	Tue, 16 Jun 2026 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607647; cv=none; b=uPVxaS7+KOfiBRlX5S6P3kUPDqifS22rPmHPNYgL45Zp/y3guVK9dEHb9RLeFVP577fbEZeYoDa8YTnIczbHIhqskPukQX4S+hx0YbkVP9JM49pIonjE6SKQHi9X7NL1TBQ2OvFuJDcR2L5CRoe9HFx0o1g9hnP5zw8OM9jLcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607647; c=relaxed/simple;
	bh=mnlHqM/1ZVpvuwqLPVKTJPO7kIdK7gXuuPaNW0Bz+w0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ktM1ddAcNxd/NJ/Ddlc9RLTzz1FQczUmCW8sF3TrbjUtF+6ZZjxLMM8dKnIsnBjW1yvLvOzTGgPaabAaT3KBgP6jT34S4BQ862AaR2Bsnqep4cjVAsny8jjtBxPIY+LDvb/G65qTjeyzaOZxn13iA6hcRavS0pEzhyNhI8P20j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpDc9N4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpDc9N4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169C01F000E9;
	Tue, 16 Jun 2026 11:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607646;
	bh=D4BeaXIRSS9lNLuPvORgNWdICPvoeFKZ7c6ECdJOYps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VpDc9N4OWSbkcbI7ei6yVKajcd10HrhpmbS0VGmhggmpctu0COWzeR+BKEAY/Mfr/
	 EU6/17prJZaXe0vYAvnfFmqm05GGuCkyN3UsxxZW1wiT9hbUnF5Quo9HyW5ncj30w0
	 aF79udUwgCAOCfeaK6CF72j9lwYsd2Kplnxe9DECVwqqQyrGyHV8yj4jrdUUXiBmLR
	 Y73dMwB+YhlrvkzL8+w0vktzBXvUA0+1ymdX6ZAIEyJY+gh93xybnhWf/qlSlBowz9
	 UVS6gtqe59D8jQdShCekXXRZie6gkfuIe+lLcD8AcmBIa9HuCXcoY/Z/SzjmSr6/eG
	 /viwlmcsqJWGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU
 to steering-tag mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260616104621.41915-9-fengchengwen@huawei.com>
References: <20260616104621.41915-9-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 11:00:45 +0000
Message-Id: <20260616110046.169C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] sysfs binary read callback incorrectly returns 0 (EOF) for unali=
gned offsets, breaking partial reads.
- [Medium] Returning -ENODEV for impossible CPUs aborts sequential file rea=
ds on sparse CPU topologies.

Pre-existing issues:
- [High] Missing length validation when parsing ACPI _DSM output buffer lea=
ds to an out-of-bounds read.
- [High] ACPI _DSM buffer parsing uses an unaligned 64-bit cast and C bitfi=
elds, breaking on strict-alignment and big-endian architectures.
--

commit 3d85ff02b28aea880afdba0d09e73076f825fdb4
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add sysfs binary file to export CPU to steering-tag mapping
   =20
Add per-device sysfs binary attribute tph_cpu_st to expose ACPI DSM CPU
to steering-tag data to userspace, resolving the concern that VFIO should
not host CPU-to-ST translation interfaces.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 95280aab4fb51..aca5093e81525 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -130,6 +130,29 @@ static acpi_status tph_invoke_dsm(acpi_handle handle=
, u32 cpu_uid,
> =20
>  	return AE_OK;
>  }
> +
> +static int tph_get_cpu_st_info(struct pci_dev *pdev, unsigned int cpu,
> +			       union st_info *info)
> +{
> +	acpi_handle rp_acpi_handle;
> +	struct pci_dev *rp;
> +	u32 cpu_uid;
> +	int ret;
> +
> +	ret =3D acpi_get_cpu_uid(cpu, &cpu_uid);
> +	if (ret !=3D 0)
> +		return ret;
> +
> +	rp =3D pcie_find_root_port(pdev);
> +	if (!rp || !rp->bus || !rp->bus->bridge)
> +		return -ENODEV;
> +
> +	rp_acpi_handle =3D ACPI_HANDLE(rp->bus->bridge);
> +	if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, info) !=3D AE_OK)

[Severity: High]
This isn't a bug introduced by this patch, but tph_invoke_dsm() appears to
have an out-of-bounds read.  When parsing the ACPI _DSM output, it
unconditionally dereferences the buffer pointer without validating the
length:

tph_invoke_dsm() {
	...
	if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
		ACPI_FREE(out_obj);
		return AE_ERROR;
	}

	st_out->value =3D *((u64 *)(out_obj->buffer.pointer));
	...
}

If a buggy or malicious ACPI firmware returns a buffer smaller than 8 bytes,
could this lead to an out-of-bounds memory read?

This is also a pre-existing issue, but does casting the byte buffer to a u6=
4*
and dereferencing it break on strict-alignment architectures?

Additionally, union st_info uses architecture-dependent C bitfields to
extract data from this 64-bit value.  Could this extract incorrect bits on
big-endian architectures, resulting in corruption of the hardware steering
tags?

[ ... ]

> @@ -619,3 +647,58 @@ bool pcie_tph_supported(struct pci_dev *pdev, bool w=
ant_ext)
>  	return pdev->tph_ext_support;
>  }
>  EXPORT_SYMBOL(pcie_tph_supported);
> +
> +static ssize_t tph_cpu_st_read(struct file *filp, struct kobject *kobj,
> +			       const struct bin_attribute *bin_attr, char *buf,
> +			       loff_t off, size_t count)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> +	size_t entry_sz =3D PCI_TPH_CPU_ST_ENTRY_SZ;
> +	struct pci_tph_cpu_st st;
> +	unsigned int target_cpu;
> +	size_t copy_len;
> +
> +	if (off >=3D nr_cpu_ids * entry_sz || off % entry_sz !=3D 0)
> +		return 0;

[Severity: Medium]
Does returning 0 here prematurely signal an End-Of-File (EOF) for unaligned
reads?  If a userspace application attempts a short read or reads at an
unaligned offset, should this reject the request with -EINVAL or properly
serve the unaligned data instead of truncating the stream?

> +
> +	target_cpu =3D off / entry_sz;
> +	if (!cpu_possible(target_cpu))
> +		return -ENODEV;

[Severity: Medium]
Could returning -ENODEV here abort sequential file reads on systems with
sparse CPU topologies?  If sequential readers (e.g., using cat or hexdump)
hit this error at the first missing CPU, they might fail to retrieve valid
steering tags for any CPUs located after the topology gap.  Would it be
better to skip the missing CPU by returning a zeroed entry instead?

> +
> +	get_cpu_all_st(pdev, target_cpu, &st);
> +
> +	copy_len =3D min_t(size_t, entry_sz, count);
> +	memcpy(buf, &st, copy_len);
> +
> +	return copy_len;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D8
