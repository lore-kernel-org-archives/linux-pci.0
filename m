Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920AC345EB7
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795603; cv=none; b=Y9DJ0UKF7lJsAbhMCfHn0VW8BZQey4BDVCbJpsi/SlztQMD3UnheJfc4EUrkxAgBebnRQSBEQr/dez9DZo+ymz70mUtBv42siCgwSvonsYLagTLczMDPrDrSbeAhILP9VI0BxsoyTwU+WodyyqbhDZzZEYW4FgUXVIuRTTAedtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795603; c=relaxed/simple;
	bh=JygL/ECAWtgiLBsGgU8gWK+BDTA/XyeFHlSxq+hrp4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MGAOXgh8yB2xmTk8SD9RbWTywPw4ODibE4n+/8s7ncmdFM/0xcbnBqZ/yGkkSgdCRjy2CjAnWcRc22oODhXdXPkSGuKtIw60vsoq8mSzXS3+jCL8yuvYRpfU1RHNoGFs3/1R6eTwtpkanhziuEo3T4CqQDXPvN5ouSgNTgzZ0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUFhi8GL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUFhi8GL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6D11F000E9;
	Mon,  3 Aug 2026 22:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785795602;
	bh=tL93Ikl+CBy2WqlZxgRfgqL0dpFX9ME8pY5BDVjXaEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kUFhi8GLo3LKN387gG634LEgrkKrS8hcZuBAqts3X9mBYszZ4LEpswXtZ5i4TLzzp
	 MhMx6VJmb8ZWB8KAm2Ef/7+LvD9ASWY1VO+f+iNfXJqvwXxD/t3hNB9OdeLUSJjMiK
	 8/AxRvVi61tDtgO/FnoEefJxDr4YGUfX46Vkv1epHOKqHX8cJctjuKXoxnkETNEAl7
	 vGWRF3QkYSus4arg2ge2C4wbr85CMlyzG/gsG15GF3us13RJZI9N6I7c+PxT9/dvGy
	 FvxWg7Ag1M7shH0sj7FEufleoIS5i2h2qxdMtkU6dD8rm3irF5otGPp107L+4ScFjc
	 dR6sQZxgHsj0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI/AER: Fix memory leak in aer_recover_queue()
 on kfifo buffer overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260803-b4-fix-aer-memleaks-v2-1-fd199b0171fd@google.com>
References: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
 <20260803-b4-fix-aer-memleaks-v2-1-fd199b0171fd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:20:01 +0000
Message-Id: <20260803222002.4F6D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting memory leak of `aer_regs` in `aer_recover_work_func()`=
 when the associated PCI device is not found.
- [High] Out-of-bounds memory read and ABI layout mismatch when copying and=
 parsing CPER AER payload.
--

--- Patch [1]: [PATCH v2 1/2] PCI/AER: Fix memory leak in aer_recover_queue=
() on kfifo buffer overflow ---
commit b967f56b707635c965827309db44195cb8cee5ff
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs from ghes_estatus_pool. If kfifo_in_spinlocked()
fails due to a buffer overflow, the allocated memory is not freed. This
commit fixes the leak by calling ghes_estatus_pool_region_free() on the
error path.

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c4fd9c0b2a548..967cde9dd5191 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1274,9 +1274,12 @@ void aer_recover_queue(int domain, unsigned int bu=
s, unsigned int devfn,
>  	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
>  				 &aer_recover_ring_lock))
>  		schedule_work(&aer_recover_work);
> -	else
> +	else {
>  		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
>  		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
> +		ghes_estatus_pool_region_free((unsigned long)aer_regs,
> +					    sizeof(struct aer_capability_regs));
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but while you are fixing memory
leaks of aer_regs from ghes_estatus_pool, there appears to be another
pre-existing leak in the worker function aer_recover_work_func().

If pci_get_domain_bus_and_slot() fails to find the PCI device, it executes
a continue statement:

drivers/pci/pcie/aer.c:aer_recover_work_func() {
        ...
		pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.bus,
						   entry.devfn);
		if (!pdev) {
			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
					   entry.domain, entry.bus,
					   PCI_SLOT(entry.devfn),
					   PCI_FUNC(entry.devfn));
			continue;
		}
        ...
        ghes_estatus_pool_region_free((unsigned long)entry.regs,
					    sizeof(struct aer_capability_regs));
}

Does this continue permanently leak entry.regs by skipping the
ghes_estatus_pool_region_free() call at the bottom of the loop?

[Severity: High]
This is a pre-existing issue, but since this patch interacts with
struct aer_capability_regs allocation, I noticed a potential struct layout
mismatch that could lead to an out-of-bounds read and corrupted hardware
error log parsing.

In drivers/acpi/apei/ghes.c:ghes_handle_aer(), the CPER payload is copied
using the size of the software structure:

        memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_r=
egs));

However, in include/linux/cper.h, pcie_err->aer_info is strictly a 96-byte
array. struct aer_capability_regs in include/linux/aer.h incorporates
struct pcie_tlp_log (60 bytes), expanding the struct size to 100 bytes and
shifting subsequent hardware fields (such as root_command).

Does this memcpy read 4 bytes past the end of the GHES payload? When
pci_print_aer() subsequently calls pcie_print_tlp_log(), could it read the
hardware Root Error Command register as if it were a TLP prefix, outputting
garbage data?

>  }
>  EXPORT_SYMBOL_GPL(aer_recover_queue);
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-b4-fix-aer=
-memleaks-v2-0-fd199b0171fd@google.com?part=3D1
