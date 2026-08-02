Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E51DEFE8;
	Sun,  2 Aug 2026 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785671386; cv=none; b=lD2Jgd1meP+9R3iG2bIARKCIULyK+Nl6M702TYmsv8Zh1O/HRXEmK9NiSP6+YEbx/0YkEFFcQzLPffw0dq3b+p7H8yUk9WRe8jSf5iUKF/JA1sXNM1bB0ccGeNaDZ6fiUQ2DqQhoWPnninxM8gIBkVjG27Y3zMntzMVWhhkH76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785671386; c=relaxed/simple;
	bh=MREafGtGNmwt5kJ1o4tdbKKSognSF47R5FqbwNKyvL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KWYtNwQSy1KjDuqFoGZKlueX7b2hQFXrHGqEgGvxlBdb3/MGCvNLSOkGiDZ1JN8nIIKFNkDCHL5obmwu+5HaV35PFLVLMlA282375+AnB5hY9kHDZMWFPd3yRHsHCDYr33qX8SYmWuGm/9EWJ+1dRUpn9E2ZtDDrsnSD8sF0P8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMO49Seh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMO49Seh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC111F000E9;
	Sun,  2 Aug 2026 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785671384;
	bh=qQ5s6kKmv82KP7OkD0P1K4uLltnzuM5GFfaEc6R7cFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mMO49SehEcpGF61R4nVCV2ILnlnHGV3oYebXhJkPrNcpe1PcgaY1LtEo7pHTvJyjP
	 Yjj17ZvppaZvW/rRIUmCN9k+cHQGmVZXBbJMa/plSJ6ev7BUQ/ZGTD3MuQxAxveXws
	 Jk+eqmvo75kt3saT4+MOqr2+Yefa72pTIr+uB8clOxquUvvlQ4zTaH6ChX2XbYpm8l
	 /MPFTNfTFg4MKUOhjPoVLGOj2nceLMSsSxXZsSlVCYtuDqzU3AlA4nwnLHjfsn1eIH
	 2ForVzTcRco2plFssIqkDfDxVBqhos9OpRXEUNRtocJ8/P7LEG5bXAqskCeVF3XItV
	 YTsj0a+CCAweg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: imx8mq: Declare the PCIe extref clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rudi Heitbaum" <rudi@heitbaum.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <3436ea65303090e435a24ba04416425f0380bd90.1785669457.git.rudi@heitbaum.com>
References: <cover.1785669457.git.rudi@heitbaum.com>
 <3436ea65303090e435a24ba04416425f0380bd90.1785669457.git.rudi@heitbaum.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 11:49:43 +0000
Message-Id: <20260802114944.3AC111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The requirement for a new 'extref' clock name breaks PCIe on o=
lder device trees for i.MX8MQ boards that rely on an external oscillator.
- [High] PCIe endpoint nodes on boards with external oscillators are intent=
ionally omitted from the 'extref' clock update, which will misconfigure the=
 PHY to use the internal PLL and break the link when endpoint mode is enabl=
ed.
--

--- Patch [3]: [PATCH 3/3] arm64: dts: imx8mq: Declare the PCIe extref cloc=
k ---
commit ad57d8a5f5ec29362d83c5dccc786006a9f4c2cb
Author: Rudi Heitbaum <rudi@heitbaum.com>

arm64: dts: imx8mq: Declare the PCIe extref clock

This commit updates i.MX8MQ board device trees to explicitly define the
"extref" clock for PCIe nodes, keeping "pcie_bus" entries intact. The
change aligns the device trees with a driver update that relies on the
"extref" clock name to configure the external oscillator.

> arm64: dts: imx8mq: Declare the PCIe extref clock
>    =20
> Boards feeding PCIe REF_CLK from an off-chip oscillator described it as
> the "pcie_bus" clock, which the driver never looks up by name and which
> therefore selects nothing. The oscillator was used only because the
> driver forced IMX8MQ_GPR_PCIE_REF_USE_PAD unconditionally.
>    =20
> Now that the selection follows the "extref" clock, name the oscillator
> explicitly on every board that depends on it so the behaviour is
> unchanged. The "pcie_bus" entries are left alone.

[Severity: Critical]
Does this break backward compatibility for older device trees?

If a user upgrades to a kernel with the new driver behavior but boots with =
an
older DTB that lacks the newly introduced "extref" clock name, will the dri=
ver
in drivers/pci/controller/dwc/pci-imx6.c:imx8mq_pcie_init_phy() clear the
IMX8MQ_GPR_PCIE_REF_USE_PAD bit because "extref" is absent?

Device trees represent a stable ABI, and older deployed DTBs might lose PCIe
functionality if they rely on the external oscillator and this bit is clear=
ed.

> Endpoint nodes are not touched: they are all disabled and use a separate
> binding.

[Severity: High]
Since endpoint mode initialization also goes through the same PHY setup
routine, will omitting the "extref" clock from endpoint nodes misconfigure
the PHY for endpoint operations?

If a user enables the pcie0_ep or pcie1_ep node on an affected board like t=
he
EVK, the driver will not find the "extref" clock and imx8mq_pcie_init_phy()
will incorrectly clear IMX8MQ_GPR_PCIE_REF_USE_PAD.

Does this mean the PHY will be misconfigured to use the internal PLL instead
of the required external oscillator, breaking the link when endpoint mode is
enabled?

> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785669457.gi=
t.rudi@heitbaum.com?part=3D3
