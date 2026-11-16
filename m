Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823446;
	b=bSkJXspj/P5DcL0eyR+GM+70nSnzoU8FEnQi7bpT3ntDFP17FzTxfjZxYVorbsVBQyJy
	 qifHELMCgf+ChIFVyoaUIjXa7ajKS4fA5UDrAg4M3TjSAWIcOpg+HWl61nRxQkVgal5ps
	 K6xqDbjed8iex0mzPQeVGSdMNJFlGDHI8FIfWu3wHLiUNZCpqtMfK7P2gpjvSMGc/pSMr
	 Sh5Dv7Y3mI/8JWSa7fT9UENORX/RS84a76aJnSkMJKsJ1dIja9k2/xOlKEv1FAsW1L4wD
	 B3URHBc61UkIvoTeweNwRnyXsyO0luNG6FwlvsLu5i+ZpIggUSNjbYitfZiDs9PD3HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=655qopT5okZe/LZeSR1h9oXHDcKYrx6g7M5gPuWTM+g=;
	b=4p3fnTPIKVs3pKyQKKqZ6DbvfOXwmvfJXKkvMMRvTzTOyvsq+aaYXgcBqVlUHIxpHdS0
	 5VCCwMRFRBZvZlW8RZTEx7uaCGZaSrKXRWr8c3k8hFuOhufTo5yqImtmu6jzAuNlGWfci
	 zasaUT03k1e1wqIqh7r95kqWDaTYIdGfKf4vJuAc24R4csM25PGsKR15IyqtdV/wyDZWs
	 lD8BFo/9C1+LyT0AGyMe15p95uD+gImuUFGc1H8LPe3NLNUdXeyG9Hh7VcxqxKxdrO4W6
	 RCXwebiujZ4pmkHEvq7e3+3TYL8cFNR02NAPSj+E3N9xTYacCUr4guTzHINeuWXLo3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0nv657g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26482606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0nv657g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97421F000C5;
	Mon, 16 Nov 2026 10:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794823446;
	bh=655qopT5okZe/LZeSR1h9oXHDcKYrx6g7M5gPuWTM+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S0nv657gj4lOfWoeBQWPdmeXicRZ+lafMFTmkgraqm5YQs+9qNa2Gf8R7ZixBeDo6
	 1UfjO8+yHkI6OJd0pprweWJ+HYjudKr6EBTKBgqYVrSWwBJKmsLEc1NSSavtFxOYMV
	 04RlE6GTm308c/oqoytKB/jQWqg32udMKBAZCqS29bSnv18Cj9nCLkRQIzXS22RqCu
	 TtMMh9kanZbEnNzJKxvUKOmi6TjKt344pt6nbLNxkYy+c27f6qn7QmfWZP9B0pdDcs
	 uK0lF0afRdBSFU7SIeW6Pu1221cyJPInSjybDwGLUocaaRVX5qRSKK/Vde61+LnrXB
	 T2bfUVOXSAT8w==
Message-ID: <sashiko-outbox-216688@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 4/6] PCI: Resume downstream ports before sysfs
 Link Control writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116-rfc-b4-v3-4-0bf052b68f2a@boondocker.io>
References: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
 <20261116-rfc-b4-v3-4-0bf052b68f2a@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:04:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] PCI: sysfs: race between lockless pm_runtime_suspended() and
  RPM_RESUMING in pci_write_config()
- [Medium] PCI: incomplete runtime resume scope for config writes in
  pci_write_config()
--

commit 98319c505535590b91bff76fabaefdd4333fe854
Author: Matt Thompson <matt@boondocker.io>

PCI: Resume downstream ports before sysfs Link Control writes

This commit resumes runtime-suspended PCIe downstream ports in
pci_write_config() before writing bytes that overlap PCI_EXP_LNKCTL so a
subsequent runtime resume does not overwrite the new Link Control value
with saved state.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6669e9ad5bd3b..ff47ea1f90433 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -786,6 +786,7 @@ static ssize_t pci_write_config(struct file *filp, st=
ruct kobject *kobj,
>  	struct pci_dev *dev =3D to_pci_dev(kobj_to_dev(kobj));
>  	unsigned int size =3D count;
>  	loff_t init_off =3D off;
> +	loff_t lnkctl =3D pci_pcie_cap(dev) + PCI_EXP_LNKCTL;
>  	u8 *data =3D (u8 *) buf;
>  	int ret;
> =20
> @@ -809,6 +810,21 @@ static ssize_t pci_write_config(struct file *filp, s=
truct kobject *kobj,
> =20
>  	pci_config_pm_runtime_get(dev);
> =20
> +	/*
> +	 * Link Control can be written while config space remains accessible in
> +	 * runtime suspend. Restore saved state first so a later resume cannot
> +	 * replace the new link setting with the saved value.
> +	 */
> +	if (count && pci_is_pcie(dev) && pcie_downstream_port(dev) &&
> +	    pm_runtime_suspended(&dev->dev) &&

[Severity: Medium]
Can a concurrent runtime resume cause pm_runtime_suspended() to return
false before saved PCIe state has been restored?

When the port is runtime-suspended outside D3cold,
pci_config_pm_runtime_get() increments usage_count via
pm_runtime_get_noresume() and returns with dev->power.runtime_status still
at RPM_SUSPENDED.  If another thread begins resuming the port at the same
time, rpm_resume() sets runtime_status to RPM_RESUMING and drops
dev->power.lock while running pci_pm_runtime_resume():

CPU0                                  CPU1
pci_scan_bridge_extend()              pci_write_config()
  pm_runtime_get_sync()                 pci_config_pm_runtime_get()
    rpm_resume()
      runtime_status =3D RPM_RESUMING
      rpm_callback()
                                        pm_runtime_suspended() -> false
                                        pci_user_write_config_word(LNKCTL)
        pci_pm_runtime_resume()
          ...
            pci_restore_pcie_state()
              pcie_capability_write_word(LNKCTL)  <-- overwrites new value

Because pm_runtime_suspended() only matches RPM_SUSPENDED, CPU1 skips
pm_runtime_resume() instead of waiting in rpm_resume() for the in-flight
transition to finish, and pci_restore_pcie_state() overwrites the new
PCI_EXP_LNKCTL value with the stale pre-suspend value.  Checking
!pm_runtime_active(&dev->dev) (or calling pm_runtime_resume()
unconditionally) would wait for an in-flight resume to complete.

> +	    off < lnkctl + sizeof(u16) && off + count > lnkctl) {
> +		ret =3D pm_runtime_resume(&dev->dev);
> +		if (ret < 0) {
> +			pci_config_pm_runtime_put(dev);
> +			return ret;
> +		}
> +	}

[Severity: Medium]
Does restricting the runtime resume to PCI_EXP_LNKCTL on downstream ports
leave other saved registers vulnerable to being overwritten on resume?

When a PCI device runtime-suspends, pci_save_state() saves the standard
config header and PCIe capability registers including PCI_EXP_DEVCTL,
PCI_EXP_SLTCTL, PCI_EXP_RTCTL, PCI_EXP_DEVCTL2, PCI_EXP_LNKCTL2, and
PCI_EXP_SLTCTL2, all of which pci_restore_pcie_state() writes back on
resume.  If userspace writes PCI_EXP_LNKCTL2 (for example, to set Target
Link Speed) while the port is runtime-suspended and then writes
PCI_EXP_LNKCTL to retrain or enable the link, the second write triggers
pm_runtime_resume() -> pci_restore_pcie_state() and clobbers the
PCI_EXP_LNKCTL2 change with the pre-suspend value.  Writes to other saved
registers followed by a rescan, or config writes through
proc_bus_pci_write(), have the same issue because pci_config_pm_runtime_get=
()
only resumes devices in PCI_D3cold.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rfc-b4-v3-=
0-0bf052b68f2a@boondocker.io?part=3D4
