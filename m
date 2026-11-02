Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619100;
	b=nzL8QKUHNH9dor8MYgwOLgRAUpvDx0FYC54boZliimIPayOG5BNLt10y/YK2f28EtZyR
	 nizOmbrSpdUmlaTEFt90L4V6Z6GLEvv0j6kv3FLxLIOS6v3EHk44UvOVyBQ2k0YG0G1NO
	 SIbdAzc326kW3yoOhSo1q75aZphi0V5fpyhoIoUP8+V5I27Lg6g7rHIe/9ZPAZEFP8Agm
	 GGaQVsr1iu04dstWrHuNLp3b3IETyk6uqARf7/gIrxJfzLmO66o3urAZOsl2yp27Hg0zM
	 7Qna6BzgQlGo1aR6mhVp5E1M+AvRRpUntwyNG2+DKjknRKeRx4QhklmwSJO1sBBvH+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619100;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jb+XexXG5WCTfFeV1wVBmRZuAjYlc/ur0Cln34YZ9TY=;
	b=Tf+aXTxvfYVLwGj7cF7EylH9aOIekwnJY3883Vagvyy6rdDSFGhdxrXVHdKB8evHAYN0
	 tdYdreURyttxrEDKpy5hXJW1bL6q04xf9OoCP63YBXOxNdrk4AChlE63ulqME7pjFQbS7
	 6egkuzAVUZ8dgpvDgW0FIP7UOkKIFR024lT2ptWLMUMSxXre8HBLQl3RGglMEQAX5f/Hr
	 7nilyUs+WgOl9GS3/eke+0ccTnbjgL0hqksJWNTVv1F+oq0SFpyHU5xv3PjB+5oH70YR7
	 sNTmqgbrAwHNdP+nRmUJLyGhdHdytMMRPMbX8IR/0vX3jl6OjJ6xEMHRtdkYtAO6JzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiEn6QMg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE61660A262A
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiEn6QMg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852371F00A1B;
	Mon,  2 Nov 2026 11:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619099;
	bh=jb+XexXG5WCTfFeV1wVBmRZuAjYlc/ur0Cln34YZ9TY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JiEn6QMgkm8jhpSDoj2BOMIpcQ6A0rJOTmF1TPaK2L6T3iaWJKT1ixK6WpDn2DxjF
	 COmYFx8CF8BJpuuiODuRKvgVe9MbQTDIw52551Hpr/eSgDA6mQWUh4+g+c/g/joBlK
	 3joHJP0cCoiSD4WFtyMhw1whlqkWpf1CyGiVf/A3drLU1KR1xcf7UvH/v0pkyT63jC
	 DCwnaURCkWmEYqxtWlo45k8w0zoch4SAhZQDcuHusewM60TNWr8CdO2qncTwJLXBPh
	 56WU9n9vXkC0WcsoPj2UuAV5KVU8+XkieSkPHvAJHBHWwAZMi4G68KUWrmMqOhxTiY
	 ov3pSQFI3rVbg==
Message-ID: <sashiko-outbox-193334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] PCI: tegra194: Add PCI_ENDPOINT dependency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261102111450.4010818-5-mmaddireddy@nvidia.com>
References: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
 <20261102111450.4010818-5-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:31:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: tegra194: host Kconfig depends on PCI_ENDPOINT instead of E=
PC stub
--

commit b82fa7e55a14cc1575d1ffe0c356f50c758354e7
Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>

PCI: tegra194: Add PCI_ENDPOINT dependency

This commit adds a PCI_ENDPOINT dependency to PCIE_TEGRA194_HOST in Kconfig=
 so
that pci_epc_linkdown(), called from the PERST# assertion handler, is decla=
red
when building the Tegra194 PCIe driver.

Closes: https://lore.kernel.org/oe-kbuild-all/202610230923.2lf3BsLs-lkp@int=
el.com/

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 0a0d56fcf0ac9..7041346849002 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -245,6 +245,7 @@ config PCIE_TEGRA194_HOST
>  	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
>  	depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST
>  	depends on PCI_MSI
> +	depends on PCI_ENDPOINT

[Severity: Medium]
Does adding a PCI_ENDPOINT dependency to PCIE_TEGRA194_HOST disable Root
Complex support on existing host-only configurations where CONFIG_PCI_ENDPO=
INT
is not enabled (such as during olddefconfig), or force host-only kernels to
build the unused PCI Endpoint framework?

In drivers/pci/controller/dwc/Kconfig, Tegra194 PCIe support is split into
PCIE_TEGRA194_HOST and PCIE_TEGRA194_EP, where PCIE_TEGRA194_EP already
depends on PCI_ENDPOINT, and none of the other dual-mode DesignWare host
Kconfig symbols depend on PCI_ENDPOINT.

In drivers/pci/controller/dwc/pcie-tegra194.c, pex_ep_event_pex_rst_deasser=
t()
already calls pci_epc_deinit_notify() and pci_epc_init_notify()
unconditionally, and those build when CONFIG_PCI_ENDPOINT=3Dn because commit
473b2cf9c4d1 ("PCI: endpoint: Introduce 'epc_deinit' event and notify the E=
PF
drivers") added static inline no-op stubs in include/linux/pci-epc.h:

#ifdef CONFIG_PCI_ENDPOINT
void pci_epc_init_notify(struct pci_epc *epc);
void pci_epc_deinit_notify(struct pci_epc *epc);
#else
static inline void pci_epc_init_notify(struct pci_epc *epc)
{
}

static inline void pci_epc_deinit_notify(struct pci_epc *epc)
{
}
#endif /* CONFIG_PCI_ENDPOINT */

Would it be better to provide a matching static inline no-op stub for
pci_epc_linkdown() under #ifdef CONFIG_PCI_ENDPOINT in
include/linux/pci-epc.h, ordered before or squashed into commit 9fcf1c9f540e
("PCI: tegra194: Notify Endpoint functions on PERST# assert") (referenced in
the commit message via the stale SHA bf644226574e) so that host-only configs
and git bisect are not broken?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102111450.4010=
818-1-mmaddireddy@nvidia.com?part=3D4
