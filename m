Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907F35DA55
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921923; cv=none; b=srRjR/Y9K3T/zA7grWTtHDsnCfXy5nj10XEUuBYs/NioVHDrv4QRnFrCvKyiS0eS7K6czBQSXkE1RMuFqC+DYy5Bv2jP9Ia9GkfH5bLdmNKfh58WRj+2tiX6fq5txlKIFORtk4BHLCWyfXIK8mpYCT3SnQUtW+Tvt4PgApGXaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921923; c=relaxed/simple;
	bh=Iu38UU2Uip70RVovb3bbezDM1lfJAZutyB9X+pwdSL4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MaAB/u0nxPsEfEXuujG0p+3lq1KKIWf2IZ1AcYeJ6lV+UVOCXIeDhZUJ+kP3MI6bizx364e5LJR4amGq6JBFnuYpiuQZZP4voB2vnRegCHinipF9BGYynUyzaRYsVImYjj4TtGoOv0l+qOpO4wDLPE1lS3jhVWPgxc5mC7f5Pl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjGtfEW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjGtfEW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C9F1F000FF;
	Tue, 13 Oct 2026 20:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791921921;
	bh=zRxItz915lAefs27QIaYzfw5/qyds9E5uw6hSC3dswY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HjGtfEW25XVT+odGCZwfGNQwr3HCE+FJqiGiRJU9ym2K+J4EM27Dn7yt/bA2IJfk8
	 T7tEVExmwXlMzNy0CkjVTzwlMnBVoSyY4we/54iWM8ODAhrOQlm83wp0b9XdxX6y6N
	 Vwzq4Lov8DOxtEWmTzp7p5lEyIdQ16ls6gVLAocp6GkmPrz54SeX8ild0o11hOakww
	 r9UvmbRKh7q4BVHkNQJDb+oLldZrg3761hZKfv28vagxL4h2oRXFa64JuYMvWkm7t5
	 qy8urwnFKhy6Vj/hkGqr0Nhm6rq4HixBQz5DKil/kxcOTMdW6EXYviEem+fgGVid2A
	 2+gel2qO/fwrA==
Message-ID: <sashiko-outbox-170438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Update saved Max Read Request Size in
 pcie_set_readrq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261013195307.181647-2-cassel@kernel.org>
References: <20261013195307.181647-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:05:19 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: Data race in pcie_set_readrq() corrupts hardware and saved =
state
--

commit 5cff2e9dcd50378ba11b9189a892c4623d8503cd
Author: Niklas Cassel <cassel@kernel.org>

PCI: Update saved Max Read Request Size in pcie_set_readrq()

This commit updates pcie_set_readrq() to also modify the kernel's saved copy
of the Device Control register when changing the Max Read Request Size. This
ensures that pci_restore_state() restores the intended MRRS value after a
device reset or error recovery.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5944,8 +5944,12 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> =20
>  	ret =3D pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>  						  PCI_EXP_DEVCTL_READRQ, v);
> +	if (ret)
> +		return pcibios_err_to_errno(ret);
> =20
> -	return pcibios_err_to_errno(ret);
> +	pcie_update_saved_devctl(dev, PCI_EXP_DEVCTL_READRQ, v);

[Severity: Medium]
Can this introduce a data race when called concurrently?

Looking at the newly added pcie_update_saved_devctl(), it performs an
unlocked read-modify-write on the saved state memory:

drivers/pci/pci.c:pcie_update_saved_devctl() {
        ...
        devctl =3D (u16 *)&save_state->cap.data[0];
        *devctl =3D (*devctl & ~clear) | set;
}

Both the hardware register write via pcie_capability_clear_and_set_word()
(which drops to the unlocked variant for PCI_EXP_DEVCTL) and this new state
update appear to happen without synchronization.

Concurrent access seems possible via VFIO, which allows parallel lockless
pwrite() calls to the PCI Express capability region. This routes through:

vfio_device_fops_write()
  vfio_pci_core_write()
    vfio_exp_config_write()
      pcie_set_readrq()

Could concurrent user-space writes corrupt both the hardware register and t=
he
cached state memory, causing pci_restore_state() to mistakenly restore
invalid state later?

> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(pcie_set_readrq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013195307.1816=
47-2-cassel@kernel.org?part=3D1
