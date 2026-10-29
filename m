Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293448;
	b=V/yHOi86J10TtQnqs5Bp+wcEWfijdlvcOZUeNxqlsIuF+mll4elvoY0hlTpCF9rwYPpD
	 Sxlxv1skRwuvLavYCaG4394qUr2I25tPbA4IXHmEPjg6QXkOHF9d5aHtnt986wt1zqgPU
	 R6+p/8fGhUUY5ogv5EvWHXo0yFofTJ8gg/CmgQKq3Bb9m1DvclU1Y1Y9GK3S3o4jclz7O
	 hBqr4g67gjsoaUW0+hcR8WHyO/pZ3f7PnzajqHVebDFL/DZcci0zHEUCd3VK7jD8dD1th
	 CDwekNzyxkUq/vYoQYRK6vQnB2ooNGO69ngTreUP1lk7K3o+zmoX2Tnvd0hPCbNLMiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+3u4UkqyYa07lmupnGiZTIflcZuk+saOR2mmUmtxGN8=;
	b=jqK2f6sRhXgO9/K7wgIqdQWJ/XoI0dkmgMixGmEkJX2YVcrLQiC7R974tD4Lk+wcNr3P
	 DF9zwyJBEVpQR2+rBnmByKEYXvVSK5vr18jPB0+qv/ioXsCh0dfYZFZSfdiFZowX/gs8o
	 rEOCI8j49NeRYX3f5MONeQFrV3S+nWqO8Ve4JJlxB3Y7Nixp8kb4yFSJy7mtRtoP8RPgq
	 7EqlEbldTLyVrv4TmMOgEbb6iislvgYY46/h6PVsMQH4wGD3BI3ZyBia1c1jYWDw3F0la
	 z8VMFinkB6uKmOPY8NtCO3V62yhNknRFOzDJd4+OZ6VCrnhBUSKJAN8igRFRLvNs0fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcA7SOCH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC2606A31A;
	Thu, 29 Oct 2026 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcA7SOCH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF061F01816;
	Thu, 29 Oct 2026 17:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793293448;
	bh=+3u4UkqyYa07lmupnGiZTIflcZuk+saOR2mmUmtxGN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OcA7SOCHn6Su2MidSomTO8HGYCxnyEt84ruND8ZLG/clTI81wXb7PPOgt2AgJvED4
	 sUoVVZeLTjoPlIqJF2JGsqBDpAXClPRIksw20s6LZ3gfRXqt1vtoYA1N59RkpmKxbb
	 wI5CmmxO8IPV6c3E4eUt8riJs+Jk5wOnryP9QcPrinfX6zkDXYfRc6uzflpVL6LOLb
	 TiJjdp9aKecsKR/LnFdPMTh0z3XWxFuGwZN/l/F1cxKAADSGaJ6mhv3QrW+0hr4GfU
	 e940un/3FgmqkH6QfKMHOjfWOWF182nwFbtIdSIQLJt+XFTLNu17ReLa+JK1+lKFae
	 ppY/RoSdIAWFg==
Message-ID: <sashiko-outbox-189709@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] ath12k: use KVM MSI domain for VM passthrough
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261029163713.1366077-8-jtornosm@redhat.com>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-8-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:04:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] wifi: ath12k: stale msi_ep_base_data not updated in ath12k_pci_pow=
er_up()
- [High] wifi: ath12k: module load failure on baremetal when PCI_KVM_MSI_DO=
MAIN=3Dm
- [Medium] wifi: ath12k: vmlinux link failure when ATH12K=3Dy and PCI_KVM_M=
SI_DOMAIN=3Dm
--

commit ea9e51c37aa4f1f3d5125a423b52732232e12c47
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

ath12k: use KVM MSI domain for VM passthrough

This commit adds support for synchronizing and retrieving the host physical
message signaled interrupt address via the kvm pci msi domain in
ath12k_pci_power_up() and ath12k_pci_get_msi_address() when running in a
virtual machine.

> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless=
/ath/ath12k/pci.c
> index f7879fb48d32e..dbd960f88d386 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -8,6 +8,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
> +#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
> +#include <linux/pci-kvm-msi.h>
> +#endif
>  #include <linux/time.h>
>  #include <linux/vmalloc.h>
> =20
> @@ -1082,6 +1085,11 @@ void ath12k_pci_get_msi_address(struct ath12k_base=
 *ab, u32 *msi_addr_lo,
>  	struct ath12k_pci *ab_pci =3D ath12k_pci_priv(ab);
>  	struct pci_dev *pci_dev =3D to_pci_dev(ab->dev);
> =20
> +#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
> +	if (kvm_pci_msi_get_address(pci_dev, msi_addr_lo, msi_addr_hi, NULL))
> +		return;
> +#endif

[Severity: Medium]
Will this cause a vmlinux link failure when ath12k is built-in and the kvm
msi domain driver is built as a loadable module?

Both Kconfig options are defined as tristate without a dependency between
them:

drivers/net/wireless/ath/ath12k/Kconfig:
    config ATH12K
        tristate "Qualcomm Wi-Fi 7 support (ath12k)"
        depends on MAC80211 && HAS_DMA && PCI

drivers/pci/controller/Kconfig:
    config PCI_KVM_MSI_DOMAIN
        tristate "KVM PCI passthrough MSI domain"
        depends on X86_64 && KVM_GUEST && PCI_MSI

Because the calls to kvm_pci_msi_get_address() in
ath12k_pci_get_msi_address() and kvm_pci_msi_wait_ready() in
ath12k_pci_power_up() are guarded with:

    #if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)

building with ath12k=3Dy and pci_kvm_msi_domain=3Dm causes built-in
drivers/net/wireless/ath/ath12k/pci.o to emit direct calls to symbols in
pci-kvm-msi.ko, failing at the vmlinux link stage. Should this use
IS_REACHABLE() or enforce a Kconfig dependency?

[Severity: High]
What happens on baremetal when both ath12k and pci-kvm-msi are built as
modules?

The direct calls to kvm_pci_msi_get_address() and kvm_pci_msi_wait_ready()
create a hard symbol dependency from ath12k.ko onto pci-kvm-msi.ko. When
modprobe loads pci-kvm-msi.ko first, kvm_pci_msi_init() aborts module
loading on baremetal or when no device in kvm_msi_devids is present on the
bus:

drivers/pci/controller/pci-kvm-msi.c:kvm_pci_msi_init() {
    if (!kvm_para_available())
        return -ENODEV;

    for_each_pci_dev(pdev) {
        if (pci_match_id(kvm_msi_devids, pdev)) {
            first =3D pdev;
            break;
        }
    }

    if (!first) {
        pr_info("kvm-pci-msi: no matching devices found\n");
        return -ENODEV;
    }

Note that kvm_msi_devids only matches 0x1103 and 0x1107 here, and even
with later commit 1d17e12c16ad ("PCI: add QCN9274 to reset quirks and KVM
MSI domain") adding 0x1109, baremetal systems, guests with only other
ath12k devices such as 0x1112, or guests prior to hotplug still return
-ENODEV from kvm_pci_msi_init().

When pci-kvm-msi.ko fails to load with -ENODEV, its exported symbols are
never registered, preventing ath12k.ko from loading on baremetal. Could
that break ath12k module loading on distribution kernels where both options
are enabled as modules?

> =20
>  	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_LO,
>  			      msi_addr_lo);
> =20
> @@ -1485,6 +1493,10 @@ int ath12k_pci_power_up(struct ath12k_base *ab)
> =20
>  	ath12k_pci_msi_enable(ab_pci);
> =20
> +#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
> +	kvm_pci_msi_wait_ready(ab_pci->pdev, 500);
> +#endif

[Severity: High]
Does ab_pci->msi_ep_base_data remain stale with the guest virtual message
data after kvm_pci_msi_wait_ready() completes in ath12k_pci_power_up()?

During ath12k_pci_probe(), before ath12k_pci_power_up() runs,
ath12k_pci_config_msi_data() latches msi_desc->msg.data into
ab_pci->msi_ep_base_data:

drivers/net/wireless/ath/ath12k/pci.c:ath12k_pci_config_msi_data() {
    ...
    ab_pci->msi_ep_base_data =3D msi_desc->msg.data;

At that point kvm_pci_msi_wait_ready() has not yet been called, so
msi_desc->msg.data contains the guest virtual vector data rather than the
host physical base data.

Later, when ath12k_pci_power_up() calls kvm_pci_msi_wait_ready(), the host
address and data are fetched and cached in kvm_data->msg and desc->msg,
but ab_pci->msi_ep_base_data is never updated here, and
ath12k_pci_get_msi_address() passes NULL for the data argument of
kvm_pci_msi_get_address().

When copy engine and data path rings are subsequently configured via
ath12k_ce_srng_msi_ring_params_setup() and ath12k_dp_srng_msi_setup(),
ath12k_hif_get_user_msi_vector() calls ath12k_pci_get_user_msi_assignment():

drivers/net/wireless/ath/ath12k/pci.c:ath12k_pci_get_user_msi_assignment() {
    ...
    *num_vectors =3D msi_config->users[idx].num_vectors;
    *base_vector =3D  msi_config->users[idx].base_vector;
    *user_base_data =3D *base_vector + ab_pci->msi_ep_base_data;

Wouldn't this program the device registers and firmware ring setup messages
with the stale guest message data instead of the host base data retrieved
by kvm_pci_msi_wait_ready()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029163713.1366=
077-1-jtornosm@redhat.com?part=3D7
