Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292893;
	b=YTwxUzdJo4ZT1y/ZMMBMRWbgOPJyMOA1pugIXrEtE5LFopf5UYnxRpU/WXWwTv9b6cRu
	 QqhM6aUKlMs8bK2zbX/BNSnsizPocQ1UHY2yG3X7gk7UI8epR99HHvQpb5ic6+LvdAj6g
	 UXmTqMY/HlpWYe6uRAaXHpPKtRxUlKy5f9gSPv4Qj/tuY1WSLeJILUCPFdPj2J4N9Fz/e
	 ZHQAnID98KDUd99J7dXJg32ocbIxgzs8+jwCIK+6/sckvxfPHxtxh3fP+HBwe7+D7exEC
	 VCo4Ft7pe6V5lKuI+0a4lPJKls7tbj1bUjwa+sRrG4TfcYkh6+BRIbWJQPQPYsWYpyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C4748HbglnNYxcnNqXiiKvHo7SH7ZX2aG7oQF8WllVM=;
	b=gAbqp5zeYuIOIPpJwoubZNISM7DAGFpjplLfrzskSdU5khULZ3yd8lQPrucyhX1jpx+Y
	 m/q/wznigQEV/2M2q1UOL7rodEaLbbDZJgazsyiIetUh1bu+XBhXwt+EDG6/W8L7loSk/
	 krwI7TToiDzJUKvQX49lvIHgoUQGSAFhmyvteY7zhNkv0E+EuhDXerMiDviCWl8lT5o83
	 KUMEdt0j9EBmG2mzk4ZYKxeqIo/XupZu53hsKFcnnMd8qFoCrz4NYQNSphJQ76m7h3Nlr
	 Tbgdq0D0eeBqtWGifsqnMhb79TCOJPBOWjGzuS8BFiE27cifTFUbuTcEwG+E6vs7OKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAkRXJCO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5523F606A31C;
	Thu, 29 Oct 2026 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAkRXJCO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E331F01816;
	Thu, 29 Oct 2026 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292893;
	bh=C4748HbglnNYxcnNqXiiKvHo7SH7ZX2aG7oQF8WllVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GAkRXJCOOvuu/m8Qx+OLboNWdpMxsgRS2gXJp9mFhUGatcCYDIbAtzBQHNPfP+k67
	 07Q6giPscpnYYI9ZdcIgk0Hv3YHsYFl77HQU0uMQDYpHqJ9SG+m6SP3i7yKJFYdH3o
	 XmlzS5JI9tZ9gS2dC6FP+iEzVsRMXfToUwNjq+/0SwarMt5J89thUb5hgA/PKXn2OV
	 zeEwDdwWFGTbr0Ta9X1tSUJR3Fk4Xw4Vq9lsbUbd0rBXrz+3KX4s+mCV1CYWMFyzlK
	 KzfkSxhAhcsQFFFpzhdNrcTtQpnW5v8P9PP+hnjfMpy1T8u+aHe2Ex9ySl6wv7kQf7
	 HXwpScue1ktbw==
Message-ID: <sashiko-outbox-189689@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] ath11k: use KVM MSI domain for VM passthrough
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261029163713.1366077-6-jtornosm@redhat.com>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-6-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:54:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] wifi: ath11k: hard dependency on pci-kvm-msi breaks module load on=
 baremetal
- [Low] wifi: ath11k: vmlinux link failure when PCI_KVM_MSI_DOMAIN=3Dm and =
ATH11K_PCI=3Dy
--

commit fd35a9fb43489e50093e9e8bd845b666d46403f3
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

ath11k: use KVM MSI domain for VM passthrough

When CONFIG_PCI_KVM_MSI_DOMAIN is enabled, this patch uses
kvm_pci_msi_wait_ready() and kvm_pci_msi_get_address() in
ath11k_pci_power_up() to obtain the host physical MSI address for VM
passthrough, and adds a pre-softdep on pci-kvm-msi.

> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless=
/ath/ath11k/pci.c
> index 7e29ebaf97731..31889e5caa8d7 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -7,6 +7,9 @@
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
> +#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
> +#include <linux/pci-kvm-msi.h>
> +#endif
>  #include <linux/of.h>
>  #include <linux/time.h>
>  #include <linux/vmalloc.h>
> @@ -855,6 +858,13 @@ static int ath11k_pci_power_up(struct ath11k_base *a=
b)
> =20
>  	ath11k_pci_msi_enable(ab_pci);
> =20
> +#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
> +	if (kvm_pci_msi_wait_ready(ab_pci->pdev, 500) > 0)
> +		kvm_pci_msi_get_address(ab_pci->pdev, &ab->pci.msi.addr_lo,
> +					&ab->pci.msi.addr_hi,
> +					&ab->pci.msi.ep_base_data);
> +#endif

[Severity: Low]
Will vmlinux fail to link when CONFIG_ATH11K_PCI=3Dy and
CONFIG_PCI_KVM_MSI_DOMAIN=3Dm?

In drivers/pci/controller/Kconfig, PCI_KVM_MSI_DOMAIN is defined as a
tristate option:

config PCI_KVM_MSI_DOMAIN
	tristate "KVM PCI passthrough MSI domain"
	depends on X86_64 && KVM_GUEST && PCI_MSI
	select IRQ_MSI_LIB

And in drivers/net/wireless/ath/ath11k/Kconfig, ATH11K_PCI is also tristate
without a dependency on PCI_KVM_MSI_DOMAIN:

config ATH11K_PCI
	tristate "Atheros ath11k PCI support"
	depends on ATH11K && PCI

When CONFIG_ATH11K_PCI=3Dy and CONFIG_PCI_KVM_MSI_DOMAIN=3Dm,
IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN) evaluates to true in
drivers/net/wireless/ath/ath11k/pci.c, so ath11k_pci_power_up() emits direct
calls from built-in code to kvm_pci_msi_wait_ready() and
kvm_pci_msi_get_address(), which are only exported by the loadable module
pci-kvm-msi.ko.

Should ATH11K_PCI add a dependency such as:

	depends on PCI_KVM_MSI_DOMAIN || !PCI_KVM_MSI_DOMAIN

or should this be guarded with IS_REACHABLE(CONFIG_PCI_KVM_MSI_DOMAIN)?

> +
>  	ret =3D ath11k_mhi_start(ab_pci);
>  	if (ret) {
>  		ath11k_err(ab, "failed to start mhi: %d\n", ret);
> @@ -1350,6 +1360,9 @@ module_exit(ath11k_pci_exit);
> =20
>  MODULE_DESCRIPTION("Driver support for Qualcomm Technologies PCIe 802.11=
ax WLAN devices");
>  MODULE_LICENSE("Dual BSD/GPL");
> +#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
> +MODULE_SOFTDEP("pre: pci-kvm-msi");
> +#endif

[Severity: High]
Does this prevent ath11k_pci.ko from loading on baremetal or with devices
not listed in kvm_msi_devids when both CONFIG_ATH11K_PCI=3Dm and
CONFIG_PCI_KVM_MSI_DOMAIN=3Dm?

Because ath11k_pci_power_up() in drivers/net/wireless/ath/ath11k/pci.c
directly calls kvm_pci_msi_wait_ready() and kvm_pci_msi_get_address(),
ath11k_pci.ko has a hard ELF symbol dependency on pci-kvm-msi.ko.
MODULE_SOFTDEP("pre: pci-kvm-msi") only instructs modprobe to attempt
loading pci-kvm-msi before ath11k_pci, and does not make symbol resolution
optional.

In drivers/pci/controller/pci-kvm-msi.c, kvm_pci_msi_init() refuses to load
the module on baremetal or when no matching device in kvm_msi_devids is
found (which also omits ath11k devices such as QCA6390 0x1101 and QCN9074
0x1104):

static int __init kvm_pci_msi_init(void)
{
	struct pci_dev *pdev =3D NULL;
	struct pci_dev *first =3D NULL;
	int ret;

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

When kvm_pci_msi_init() returns -ENODEV, pci-kvm-msi.ko is not loaded, so
the kernel module loader cannot resolve kvm_pci_msi_wait_ready and
kvm_pci_msi_get_address when loading ath11k_pci.ko.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029163713.1366=
077-1-jtornosm@redhat.com?part=3D5
