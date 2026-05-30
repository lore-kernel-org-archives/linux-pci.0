Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D137D2F12AB
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157068; cv=none; b=KbBh0WtojESxIVujbqtAFTEjIAQpDQTSMeWtvxfFM6SkGCWGG5v1kNvPDdnRtoAB/KVUaVJS+ObF85qF8mBoR4XgNNaRRASCCnjdOm/G4A7hGlGCN/W/qiapgWUeb2vTRP8gYDywdfMrs4EfDomY5fiLFYrv3p0jVcw+Hefkt4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157068; c=relaxed/simple;
	bh=IHtyyW5cFCHiV2+JxW5qeCP2l4JxRC6JjB4cLuEe3tU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cbCI836lnCB1o739eDYAA6x2FBMjKuexK5UEHkWbvD+sgJZVaPdSeol3VkparEMf1gfI4+o9diB45N8s9hnZOORt9GH7DIvKpw/5ks8L/2EhZDiMu3/TNkmsN4MnC1su1KKzGEk56xQPOu1ivT55VNghjc4egAu/anruuaEQpYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1jtFagX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1jtFagX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A3E1F00893;
	Sat, 30 May 2026 16:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157067;
	bh=Q2fjlxWHg7I6HtBHr4fSpGOPljZvB3EQjE5Qbs+EEBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D1jtFagXPdBt2s+J+70HaOAB+WzTGp4WJLBIi8lHnND3Ur6ekh5ENcTY/yo2o8+g9
	 6fCu2l8jY3irYuU1wVd1GvLhLlT/gjXfNc+/dVz035f/5PAmTC8IMpmHQ2VvwzXg4M
	 YrEOKmKiMQj7tZQk33dE3sfbBLBP8299L4IJttQ4ksxb6w9jWZJUdfnP4e3MYyc/f3
	 OdDgWGMeRQRKWNuC7rdjGX4PmBdBIxJ6w0wdwUsjlL9idebyWRnZHGsqs/ubGioXwh
	 dQm8QZbj22mBcAEIMsUOmptCZ56Flaz26wigxUNqSMcg6PEjsf8pWDfhxarWXPcOkT
	 3Xpjt0rPZ49hQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/16] PCI: dwc: intel-gw: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260530153101.695580-10-18255117159@163.com>
References: <20260530153101.695580-10-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:04:27 +0000
Message-Id: <20260530160427.99A3E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `intel_pcie_resume_noirq` function resets the DWC PCIe core bu=
t fails to restore the Root Complex configuration (ATU, BARs, MSI).
- [High] Reading and writing back 32-bit values to 16-bit configuration reg=
isters (`PCI_EXP_LNKCTL` and `PCI_COMMAND`) unintentionally clears Write-1-=
to-Clear (W1C) bits in their adjacent registers (`PCI_EXP_LNKSTA` and `PCI_=
STATUS`).
--

commit a2b3beed30ec9a660c2061cc97db74ca27bb57d7
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: intel-gw: Use cached PCIe capability offset

dw_pcie_host_init() calls .init before caching the offset, so inside
.init we must call dw_pcie_get_pcie_cap() to obtain the offset (hardware
is already enabled). The helper will cache the result for later use.

> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
> index 2674cd376f495..568b2634d08da 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -120,7 +120,7 @@ static void intel_pcie_ltssm_disable(struct intel_pci=
e *pcie)
>  static void intel_pcie_link_setup(struct intel_pcie *pcie)
>  {
>  	u32 val;
> -	u8 offset =3D dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP);
> +	u8 offset =3D dw_pcie_get_pcie_cap(&pcie->pci);
> =20
>  	val =3D pcie_rc_cfg_rd(pcie, offset + PCI_EXP_LNKCTL);

[Severity: High]
This is a pre-existing issue, but does this 32-bit read-modify-write clear
Write-1-to-Clear (W1C) bits in the adjacent PCI_EXP_LNKSTA register?

Modifying PCI_EXP_LNKCTL via a 32-bit read and write back will include
the upper 16 bits containing PCI_EXP_LNKSTA. Writing the read value back
to these W1C bits could clear any set error or status flags, such as the
Link Bandwidth Management Status or Detected Parity Error.

Would the same issue occur in pcie_update_bits() when it modifies
PCI_COMMAND, potentially clearing W1C bits in PCI_STATUS?

> =20
>  	val &=3D ~(PCI_EXP_LNKCTL_LD | PCI_EXP_LNKCTL_ASPMC);
>  	pcie_rc_cfg_wr(pcie, offset + PCI_EXP_LNKCTL, val);
>  }

There is also another pre-existing issue in this file regarding the resume
flow. When intel_pcie_resume_noirq() runs, it calls intel_pcie_host_setup():

drivers/pci/controller/dwc/pcie-intel-gw.c:intel_pcie_host_setup() {
    ...
    intel_pcie_core_rst_assert(pcie);
    intel_pcie_device_rst_assert(pcie);
    intel_pcie_core_rst_deassert(pcie);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does the core reset in
intel_pcie_host_setup() wipe the internal DWC controller state, including
ATU mappings?

By overriding the generic resume flow and bypassing dw_pcie_setup_rc(), the
driver appears to leave the ATU windows unprogrammed. Will outbound memory
accesses from the CPU to PCIe devices and inbound DMA/MSI transactions fail
upon resume without the ATU being restored?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530153101.6955=
80-1-18255117159@163.com?part=3D9
