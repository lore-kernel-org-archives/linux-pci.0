Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507458F087;
	Tue,  8 Sep 2026 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887669; cv=none; b=upOgUTgk49zeTgepBOrPbsLzkXhzyU1piaVvxuGcYazfDVbctEFRLUZpxDzbnR7vR9HyLP6dcmb37TjYWAjXdB9PKgX2lqPwJ4uOtsyR8ObHIHqLhFovxLMCDDbtwnUEcg/MsyKw0JLbowIYqne6gLb0F6HJbt9or2ALR0gtlLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887669; c=relaxed/simple;
	bh=NvpRTIczKmSKO4R9q5uOVDPvYV28dO72C0NYIOxj1sk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AAe1Vt2HLfohZpVfO1kdgtlzlE8SWfQ/IJD9k9+qc+BFtTTsAT1iY9I41XcaWcshdHZNSbBh3a88OP8h0HeRfIZHHGWe1Gtmpg4eFrNSTGvKtrKPhipkNwEG6CrfKC6ZrClm0IXPyqWg7HGrjTlzX26gKohV1w5A24IQFnKidT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2cqXvJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2cqXvJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A111A1F00A3A;
	Tue,  8 Sep 2026 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887668;
	bh=0+3TinSTRCTA41NYSFwWJufDGwMcoOQQFrmfsndlfaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J2cqXvJNKMDtSGijWXTMozVaB8dgwEHGTSheBJZ5UMGpugO/DTNOMZIEMh0instkx
	 IFddROpJbEw4dYkpKdgUlcNyP4/Vg50QRCLqq4cEhpe5AdeC+M9CmX/xo76p+tu4aD
	 lg5tw+gqYwpogPITHHzaQfh5YvQfyrtKDLQy1SEXfIYslrX5ozJ7LWOaElDJrvW4KH
	 /KmfYdQd2gAg3XSGrpzgR2cxV+jx22A6oMhkEp8iO4OZVMkHCwx7rsL1z1CQ+MAbdR
	 WJPZ74etI0Slb60IAwTX/X1K7Fb6aojS8n2sQBtcdSUrK2sQbForKX3DP2yfBNepAz
	 0LDvLnwX1J6sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] x86/PCI: Disable enhanced atomics on some AMD PCIe
 ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260908170035.160166-2-mario.limonciello@amd.com>
References: <20260908170035.160166-1-mario.limonciello@amd.com>
 <20260908170035.160166-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 17:14:27 +0000
Message-Id: <20260908171427.A111A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Hardware state loss across suspend/resume causing data corrupt=
ion
--

commit 6c1c185449d3f44e1db8d42c0f5b1f2a64c2eeb8
Author: Mario Limonciello <mario.limonciello@amd.com>

x86/PCI: Disable enhanced atomics on some AMD PCIe ports

This commit disables enhanced atomic operations on PCIe ports for AMD
NBIO 7.7 and 7.11 based models to prevent data corruption with 64-bit DMA.
The issue occurs when the 32-bit IOVA space is exhausted on certain BIOSes.

Closes: https://lore.kernel.org/all/178789300872.392066.1596367663165036157=
3@gmail.com/
Closes: https://lore.kernel.org/linux-ide/20260406222335.379935-1-artmoty@g=
mail.com/
Closes: https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwyl=
im@gmail.com/

> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b301c6c8df753..0857fd9365ec2 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c

[ ... ]

> +/* Phoenix, Hawk Point (NBIO 7.7) */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14E8,
> +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
> +
> +/* Strix, Krackan, Strix Halo (NBIO 7.11) */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);

[Severity: Critical]
Is this fixup lost across suspend and resume cycles?

Because the quirk is only registered for the final boot phase using
DECLARE_PCI_FIXUP_FINAL, the PCI core will not re-apply it during system
wake (which relies on DECLARE_PCI_FIXUP_RESUME).

If the system suspends to S3 or s2idle, the NBIO power domain is gated and
SMN registers lose their state. When the system resumes, the firmware
re-initializes these SMN registers to their default state (which has
enhanced atomics enabled).=20

Because the kernel does not re-apply the quirk on resume, any subsequent
64-bit DMA traffic after waking from sleep could trigger the data
corruption this code is intended to prevent.=20

Should these quirks also be registered with DECLARE_PCI_FIXUP_RESUME?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908170035.1601=
66-1-mario.limonciello@amd.com?part=3D1
