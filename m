Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06F403B16;
	Fri, 12 Jun 2026 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282796; cv=none; b=FCHYvbLwhUtBvWN02ZzH/l41c6X0frYtBhoCeZspRgxEt4KLZ3oWzzca0J2A1F9xojzUIhJ/wlhjB+xZlrHEL3pr/ijo8SKWmDsYkV4CAai2wMAzzK1CAOhvwPB794l76Y4V/r7FS6iB9ckcBlpDRLi6cZZlp0JxxzZAM9OUg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282796; c=relaxed/simple;
	bh=QVI55s8jIlMHAK31UnhsNkC4MMuPasaqN02VoRCNoFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rKHoz2CLL+ND9q0x2vEPLV2yid+GiuheBDyc5vHgpMXElgcgQRTdhpU9A61+7m3VwPdLbEYLS1FeMbi1R9inE1OG//okAA1pKoleCSiMSodbgTvm1TC8/BX7wzWsE2AkqSHw+iWpBEa0QIIFPM8JXs29jMNTgvrWFPA5vaWoqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHQ+BO7i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHQ+BO7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71451F000E9;
	Fri, 12 Jun 2026 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781282792;
	bh=hN7fUJ90SYke+luqkdN4SgBU4yhlgBIBIIzFh6Hr0xA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HHQ+BO7itPyO6J46r/OGj3OEcIrT1WKpZiCROgipamFRcbSmbHLDozTt5NcfuL5X8
	 w4ihonV/9PRidJ/lEG5RXiUynwAlQh6t3UjUD8y1b0dZsCPeKaOTUZ4okVabD5pjSE
	 ZSZ0qaEpMVm38rhntzqunN3/Ve4yXFV2TjPT/Y349RysyaS17j1IC4V5afLLERHUpR
	 ViMUpsKF1c41vWK3aDOeaCfBmRT/tylvKrZG35H61Y2qcQLyTnhS43ztiuNNyobzzb
	 LfxknPW21Z6MtPrmPqSz547TM4HfGje/JlaKmmSjWVTi4LiNJKe7yUt9zey/K2l6at
	 s2hMaeB+YmgGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260611161546.4075580-3-zhipingz@meta.com>
References: <20260611161546.4075580-3-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 16:46:30 +0000
Message-Id: <20260612164631.C71451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pcie_tph_completer_type() does not check for PCI_ERROR_RESPONSE =
(~0U), leading to a false positive Extended TPH capability if the device is=
 disconnected or in a low power state.
--

commit f9aeb32b2542c39fb3d9466efa934427ab4660a5
Author: Zhiping Zhang <zhipingz@meta.com>
PCI/TPH: Add requester/completer type helpers

This commit adds pcie_tph_enabled_req_type() and pcie_tph_completer_type()
helpers to allow drivers to query TPH enabled requester modes and completer
support without accessing pci_dev internals directly.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d951..4fe076bba953a 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> @@ -174,6 +174,49 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
[ ... ]
> +u8 pcie_tph_completer_type(struct pci_dev *pdev)
> +{
> +	u32 reg;
> +
> +	if (pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &reg))
> +		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> +
> +	switch (FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg)) {
> +	case PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY:
> +		return PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY;
> +	case PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH:
> +		return PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH;

[Severity: Medium]
Will this return a false positive if the device is disconnected or in a low
power state?

When reading the PCI config space of an unplugged or unresponsive device,
the host bridge typically returns all 1s (0xFFFFFFFF) and the config read
returns 0 (success).

If pcie_capability_read_dword() succeeds but sets reg to 0xFFFFFFFF,
FIELD_GET() will extract 0b11 (3) from bits 13:12. This matches
PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH, causing the switch statement to
incorrectly return that the device supports Extended TPH.

Could this trick drivers querying capabilities during teardown or error
recovery into believing a removed device supports Extended TPH? Using
PCI_POSSIBLE_ERROR() to check the register value before evaluating the bits
might prevent this.

> +	default:
> +		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611161546.4075=
580-1-zhipingz@meta.com?part=3D2
