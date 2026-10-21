Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566025;
	b=Yp42EFriXMR2jW6LW0RYzLN3TRCiER+zu2W2P8iyoQwUbulyRUqMTMiIaa26jcI3BPP/
	 a7cidtnNu3ELUUPxERvyh4mRwt1pPyyuKjYDvqE+7ji3/bEJdK7HltcBIvzXb71auhnBK
	 0BCYaj9AnZYjvyOs9BQtX5eLdvEDbMoBobS5VDoJDkDszYY6yj4/hy2ZH+iRNFS35qcFa
	 erdhbayb6AhvTzLevy3zwbN99KOZ1yJ90uAX7o5Yq8Ztfdi5rHR+V9Fl1kY1CiikpWQ/F
	 nx/r4kPl2EotEfIYNK+wBph1LdQoF5+vUW24YCD1o+S5KLOSM9wRXGHsoq1GyoVG6rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566025;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D0U7LD+1OMXi9F3KB4i2r9piHjp3wjEVg+hH9Yd6jj4=;
	b=xM11TNtrByJh1Rdq6GTxRDDbzSWp94XAgcPy/hUr+rLIHwA4mBNnGzQqIoFScM2zCMXg
	 dY9Ai4REZy+7LfgoN8Gz5F8EaHuI9V+dnHdMZCZcSCEXfDDbo15gEEUi5QIzqcFnMLxvz
	 jdAI9BKFxq36JbawB11N/iYo37tc+VeAe70ugZIHkj6bhGrWfk/21aH3cvAQGi12rYRLW
	 laG5y+m9IqGBgY1K5Wj0T1WQETSZw40O9Jq2Y5OCZ9tYgAG9bu9E4NBgZPzEh5otF4XlZ
	 /umPrB7+gLw2yL5lyH2OxrZBO8bABDtmiMfzKa4PGkdrq0BbZpuB/6Qer288kcWQqXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liZX9ibL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0B606A319
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liZX9ibL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D661F000C9;
	Wed, 21 Oct 2026 07:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792566022;
	bh=D0U7LD+1OMXi9F3KB4i2r9piHjp3wjEVg+hH9Yd6jj4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=liZX9ibLUC9l7SuQz2950F/YySZAEPAsxWpsWN1H9nxixB8MkojZ/713aVDrwPQSk
	 MLMQClJvVBccBdbEnA9UX7ZrCVKxM4FtwxfMYdkcZpEpAuhQqL6eskyn4qa1DAd7wt
	 NlACMO0YNLhPJnuxQabn1vgzY9I+rKl+jKzUduBLUCwfHWsc8oerOoA/SUibUauA+W
	 0g9bIG7p712LxAwC53Id/bDxqwCZ1MN0L2+bFbQlymqK1Kp5DQb9psqshcD1Yyg5Ip
	 DOQ73zU20mRSsBEaTlKrXI6B6wvOuTIkHU5U7kc8xQOAd7hmbM2C2kc0ZiXf2asasp
	 47mnPdA292PnQ==
Message-ID: <sashiko-outbox-179851@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] PCI: tegra194: Notify Endpoint functions on
 PERST# assert
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261021061903.1269605-4-mmaddireddy@nvidia.com>
References: <20261021061903.1269605-1-mmaddireddy@nvidia.com>
 <20261021061903.1269605-4-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 07:00:21 +0000
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
- [Low] PCI: tegra194: missing stub for pci_epc_linkdown() when !CONFIG_PCI=
_ENDPOINT
--

commit 670ef998037ee122764995c2ef40bfe453687d53
Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>

PCI: tegra194: Notify Endpoint functions on PERST# assert

This commit notifies endpoint function drivers of link down when the host
asserts reset in pex_ep_event_pex_rst_assert() before disabling the
controller. It calls pci_epc_linkdown() directly instead of
dw_pcie_ep_linkdown() to avoid reinitializing registers when the reference
clock may be unavailable.

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index 8cb907dbf6356..8dede9531956d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1704,6 +1704,9 @@ static void pex_ep_event_pex_rst_assert(struct tegr=
a_pcie_dw *pcie)
>  	if (ret)
>  		dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", val, ret=
);
> =20
> +	/* Avoid the DBI register reinitialization in dw_pcie_ep_linkdown(). */
> +	pci_epc_linkdown(pcie->pci.ep.epc);

[Severity: Low]
Does calling pci_epc_linkdown() in pex_ep_event_pex_rst_assert() break the
build of drivers/pci/controller/dwc/pcie-tegra194.c when host mode is
enabled without endpoint support?

In drivers/pci/controller/dwc/Kconfig, host mode selects the common driver
without requiring endpoint support:

    config PCIE_TEGRA194_HOST
    	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
    	depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST
    	depends on PCI_MSI
    	select PCIE_DW_HOST
    	select PHY_TEGRA194_P2U
    	select PCIE_TEGRA194

In drivers/pci/controller/dwc/pcie-tegra194.c,
pex_ep_event_pex_rst_assert() is compiled unconditionally. However, in
include/linux/pci-epc.h, pci_epc_linkdown() is only declared inside the
endpoint guard and has no stub in the fallback block:

    #ifdef CONFIG_PCI_ENDPOINT
    ...
    void pci_epc_linkup(struct pci_epc *epc);
    void pci_epc_linkdown(struct pci_epc *epc);
    void pci_epc_init_notify(struct pci_epc *epc);
    void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *e=
pf);
    void pci_epc_deinit_notify(struct pci_epc *epc);
    ...
    #else
    static inline void pci_epc_init_notify(struct pci_epc *epc)
    {
    }

    static inline void pci_epc_deinit_notify(struct pci_epc *epc)
    {
    }
    #endif /* CONFIG_PCI_ENDPOINT */

Should a static inline stub for pci_epc_linkdown() be added to
include/linux/pci-epc.h so host-only configurations continue to build?

> +
>  	/*
>  	 * Deassert LTSSM state to stop the state toggling between
>  	 * Polling and Detect.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021061903.1269=
605-1-mmaddireddy@nvidia.com?part=3D3
