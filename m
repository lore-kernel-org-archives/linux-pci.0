Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696EC3C1F4F
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910478; cv=none; b=jqgjjQP4VKLdTbJf1/4xiJC5/Yp/tJsz5dbzC3AEjyKv7AJIu4azkCM3fgqwToNeXj5Aa7ZJ9BYbm09P2rIDQQ6Xk7AB2o7zca9sk1V8eOpNqIGcRouTVEbCX9WDpml4V878NV0Nj/fgjj4SOirk95cLAyg1gvs0xOIz0MPwkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910478; c=relaxed/simple;
	bh=KWr2qvq7fKHtpBvrm4B+NjExyDqwL63eX+jR2kD79D8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FRxmjWPh3/qB81Ri3t2WF8RehNsYgOylud1J/1QwPOnCWhwv1EdOjAiuVLwWCppzbjr1JlVCPk4EbSvZYWD899O1iZWzNH9/OwrRxM+KlPdzTnlVcBDJM3j2nf+rg01Hm/4no6wqTsgipmtzzuEjCMAnicCCfEVCl8emiRdlnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp53w94b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp53w94b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA801F000E9;
	Fri, 24 Jul 2026 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784910476;
	bh=aURWlvklHJj6W2z3k9vIOi+c7Cjz2IxhxkXA60pc7cc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cp53w94b8LVOQUYMa/FvnLhjCkuYSaZZde/36rczjVKJnLFM27ShnYWe+WuOBYOJx
	 uiKd+iOpf4CkSBv76wl6rnCcUJ5lboQZWIEH9e/qG0KBN7NrGsptwQ5HVxcB0ZTfTm
	 thyVuHJ0Hd7NmMFUXWdv3KvIpsh+dzl/1W8PBL4/PnxNWb1iF/+0WwkcHoIo0TJAw6
	 uc+YHvKhAVRZ8FNsIhfeQjoXgKwMtrPiL2y3NyHYxb/Q660yPmtP8ETuWpRcoKyQ8m
	 XOpZKfOTPZmWz4l9dsAsq0F2mYjgl+wA0QU39O7OZm7vs5AAasUSwsOgr1ll8OGtAi
	 zRy4+Lzb/Shqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] PCI/AER: Support Advisory Non-Fatal Errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1b62915ffe06ee5b08e846531c42392e5f244337.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
 <1b62915ffe06ee5b08e846531c42392e5f244337.1784905909.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 16:27:55 +0000
Message-Id: <20260724162755.DDA801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The OS unconditionally modifies the AER Correctable Error Mask reg=
ister, violating the Firmware First architecture.
- [Medium] Native AER incorrectly suppresses logging and uses the wrong log=
 level for Advisory Non-Fatal Errors.

Pre-existing issues:
- [High] PCI device reference leak if hardware error status changes between=
 loops in `aer_process_err_devices()`.
- [High] Hardware errors are silently dropped and permanently lost due to a=
 TOCTOU race condition in `aer_process_err_devices()`.
- [High] Data corruption when decoding concurrent Machine Check Exceptions =
due to an unprotected global buffer in `acpi_extlog`.
- [Medium] Memory leak of dynamically allocated `aer_capability_regs` when =
the recovery queue overflows.
--

--- Patch [6]: [PATCH 6/6] PCI/AER: Support Advisory Non-Fatal Errors ---
commit edbae3f971fbe817c3d83a5348c5dd09f2b62fde
Author: Lukas Wunner <lukas@wunner.de>

PCI/AER: Support Advisory Non-Fatal Errors

This commit introduces support for Advisory Non-Fatal Errors (ANFE) by
unmasking them during device enumeration. It updates the native and Firmware
First error handling paths to compute ANFE status, increment counters, and
trace events recursively for both Correctable and (Advisory) Uncorrectable
Errors.

Link: https://lore.kernel.org/r/20240620025857.206647-1-zhenzhong.duan@inte=
l.com/
Link: https://lore.kernel.org/r/1614689994-10925-1-git-send-email-yangyicon=
g@hisilicon.com/
Link: https://lore.kernel.org/r/BJXPR01MB0614C01A9523786117B1F1CBCEC8A@BJXP=
R01MB0614.CHNPR01.prod.partner.outlook.cn/

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c196c94f43d7b..ff6ff7abc2866 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
[ ... ]
> @@ -410,6 +424,15 @@ void pci_aer_init(struct pci_dev *dev)
>  	n =3D pcie_cap_has_rtctl(dev) ? 5 : 4;
>  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
> =20
> +	/*
> +	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
> +	 * 7.8.4.6).
> +	 */
> +	if (dev->devcap & PCI_EXP_DEVCAP_RBER)
> +		pci_clear_and_set_config_dword(dev,
> +					       dev->aer_cap + PCI_ERR_COR_MASK,
> +					       PCI_ERR_COR_ADV_NFAT, 0);

[Severity: High]
Does this code modify the AER Correctable Error Mask register unconditional=
ly
without checking pcie_aer_is_native(dev)?

In systems using Firmware First, the firmware owns the AER hardware and the=
 OS
must not modify AER configuration registers. While preexisting functions li=
ke
pci_aer_clear_status() correctly check pcie_aer_is_native() to respect this
boundary, writing to the hardware register unconditionally here could trigg=
er
unexpected hardware interrupts to the firmware, potentially causing firmware
crashes or system instability.

[ ... ]
> @@ -916,8 +997,20 @@ void aer_print_error(struct aer_err_info *info, int =
i)
> =20
>  	__aer_print_error(dev, info);
> =20
> -	if (info->tlp_header_valid)
> +	if (info->tlp_header_valid && info->severity !=3D AER_CORRECTABLE)
>  		pcie_print_tlp_log(dev, &info->tlp, level, dev_fmt("  "));
> +
> +anfe:
> +	/* Recursive invocation for Advisory Non-Fatal Errors */
> +	if (info->anfe_status && info->severity =3D=3D AER_CORRECTABLE) {
> +		info->severity =3D AER_NONFATAL;
> +		info->status =3D info->anfe_status;
> +		info->mask =3D 0;
> +
> +		aer_print_error(info, i);

[Severity: Medium]
Will this recursive call operate with the stale info->level and
info->ratelimit_print[i] state?

Native AER incorrectly suppresses logging and uses the wrong log level for
Advisory Non-Fatal Errors. It reuses the pre-computed info->ratelimit_print=
[i]
(evaluated for the parent correctable error) instead of dynamically checking
aer_ratelimit() for non-fatal severity. Consequently, if correctable errors
are ratelimited, the non-fatal errors are silently dropped without being
printed.

Furthermore, it inherits info->level =3D KERN_WARNING, meaning non-fatal er=
rors
are logged at the wrong severity level. Firmware First correctly avoids this
bug by dynamically re-evaluating both in pci_print_aer().

[Severity: High]
This is a pre-existing issue, but can this cause a PCI device reference leak
if the hardware error status changes between loops?

drivers/pci/pcie/aer.c:add_error_device() {
    ...
	e_info->dev[i] =3D pci_dev_get(dev);
    ...
}

Device references are originally acquired here. Then, a loop calls
handle_error_source(), which contains the only corresponding pci_dev_put(de=
v):

drivers/pci/pcie/aer.c:aer_process_err_devices() {
    ...
	for (i =3D 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
		if (aer_get_device_error_info(e_info, i))
			handle_error_source(e_info->dev[i], e_info);
	}
    ...
}

If the hardware or firmware clears the error status after the first loop but
before the second loop reads it, aer_get_device_error_info() returns 0. The
second loop will skip the handler, and the pci_dev reference is permanently
leaked.

[Severity: High]
This is a pre-existing issue, but does this create a TOCTOU race window for
newly arriving hardware errors?

drivers/pci/pcie/aer.c:aer_process_err_devices() {
    ...
	for (i =3D 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
		if (aer_get_device_error_info(e_info, i))
			aer_print_error(e_info, i);
	}
	for (i =3D 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
		if (aer_get_device_error_info(e_info, i))
			handle_error_source(e_info->dev[i], e_info);
	}
    ...
}

This function has two sequential loops: the first prints errors, the second
handles and clears them. Both loops call aer_get_device_error_info(), which
reads the current hardware error status directly from the device registers.

If the hardware asserts a new error bit between the two loops, the second l=
oop
will read it, and pci_aer_handle_error() will write it back to the
Write-1-to-Clear (W1C) register. This clears the newly arrived error from
hardware before it was ever logged by the first loop. The patch expands this
issue by extending it to Advisory Non-Fatal Errors.

[Severity: Medium]
This is a pre-existing issue, but does this code cause a memory leak of the
dynamically allocated aer_capability_regs when the recovery queue overflows?

drivers/pci/pcie/aer.c:aer_recover_queue() {
    ...
	else
		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
    ...
}

In the GHES subsystem, memory for struct aer_capability_regs is allocated f=
rom
ghes_estatus_pool and passed as a pointer to aer_recover_queue(). If the
bounded aer_recover_ring kfifo is full, it prints an overflow error and ret=
urns
without freeing the memory.

The aer_regs pointer is abandoned and the memory is permanently leaked, as =
it
is only freed on the success path inside aer_recover_work_func().

[Severity: High]
This is a pre-existing issue, but can this lead to data corruption when
decoding concurrent Machine Check Exceptions due to an unprotected global
buffer?

drivers/acpi/acpi_extlog.c:extlog_print() {
    ...
	memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
	/* clear record status to enable BIOS to update it again */
	estatus->block_status =3D 0;

	tmp =3D (struct acpi_hest_generic_status *)elog_buf;
    ...
}

The ACPI extended log driver allocates a single global buffer elog_buf. The=
 MCE
decoder callback unconditionally copies the new MCE event payload into this
global buffer without any locks.=20

Since Machine Check Exceptions can trigger concurrently across different CP=
Us,
concurrent executions of the MCE handlers will simultaneously overwrite
elog_buf, corrupting the data structures being parsed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784905909.gi=
t.lukas@wunner.de?part=3D6
