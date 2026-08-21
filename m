Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDDB40E8FC
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342072; cv=none; b=ioLdxSWsx2L2BCImIXABBSim4Zqg04RQ7+aKT888PPT8nWozw8I9h0SRmbuYBOJ+xNiuYop9AUYiCsGNo73QuyBH1FX3zpmNwjm0kTZ1pNd/QjQ/Fw99qaDMhzWpzKZMeP6AjmiBs47kzmXdgaaWLK4D8ZZTqJg2N3SXbLqX0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342072; c=relaxed/simple;
	bh=Qi9fy3sMz0vEchDlbaz4OkWNYyEnLUnfjwKGu4/DrbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ff6fC9/BA8EeCtHf5ZvbpIZSvwLi132un/11Zly8eVCUzw4Py3iw0qocfSmfmh7Wo0y7e+ep18CmpKl/bUAAzGOtrCcsommG+7TYra/riX8UHzmmi2g8b4ErSilldNUj5GF3yTEbQQskYZV1Zj0mztwcuZ1KobYMYzphb3myTRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFmXa5FM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFmXa5FM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1447E1F000E9;
	Fri, 21 Aug 2026 19:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342070;
	bh=hV96WrHP98ldHOTpAFby42SA3+3A3+uBMpTw6ZHmyH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFmXa5FMdo0tcaFBDrIBEPCA75Lr9N3pqFJTSVG0FvPfLNE+vU8+G1pOuXTvcR1Gp
	 OY46fAyQO7Q5ihnpdCWlRwU3py0eEqD5bSNvneVkK2v2MgwoI0IxqinTjvp7VotwpR
	 bjNJOdN1qXduTXT4rklgrIJwtf6d4tnsuyYfZ43o36Lt28NtMLbIiqcYZDYE8noR6b
	 +4YsBetcpidZ6ipUTRdNYVRooRuI3oefJEIEa1m3yX/vkPL8VmS2KOZuF5JbyObCyZ
	 KgVHQvHAH7sM7tTT/yYPuP1Yr9K2IieeG3byCGU0Na3NkIuvau6SVKKpz0vtn0veKC
	 AfzExy0YTGPiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/18] PCI: Account for Direct Translated P2P in ACS
 isolation checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-8-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-8-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:54:29 +0000
Message-Id: <20260821195430.1447E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete isolation check fix for Intel RCiEPs allowing Direct Tr=
anslated P2P.
--

--- Patch [8]: [PATCH v4 08/18] PCI: Account for Direct Translated P2P in A=
CS isolation checks ---
commit 9a6d73ba8f155a4921ede8386e7c653f5cc4bd35
Author: Leon Romanovsky <leon@kernel.org>

PCI: Account for Direct Translated P2P in ACS isolation checks

This commit fixes ACS isolation checks by accounting for Direct Translated
P2P bypassing Request Redirect. It introduces a scope parameter to allow
callers to specify whether peer-to-peer Requests must be isolated.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c

[ ... ]

> -static int pci_quirk_rciep_acs(struct pci_dev *dev, u16 acs_flags)
> +static int pci_quirk_rciep_acs(struct pci_dev *dev, u16 acs_flags,
> +			       enum pci_acs_scope scope)
>  {
>  	/*
>  	 * Intel RCiEP's are required to allow p2p only on translated
>  	 * addresses.  Refer to Intel VT-d specification, r3.1, sec 3.16,
>  	 * "Root-Complex Peer to Peer Considerations".
>  	 */
>  	if (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_RC_END)
>  		return -ENOTTY;
> =20
>  	return pci_acs_ctrl_enabled(acs_flags,
>  		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but should pci_quirk_rciep_acs()
account for the new scope parameter when evaluating PCI_ACS_RR?

The comment in pci_quirk_rciep_acs() notes that Intel RCiEPs allow P2P on
translated addresses, which means Request Redirect does not actually isolate
them from each other for translated requests.

If a caller passes PCI_ACS_SCOPE_ALL, does unconditionally returning success
here allow a malicious VM assigned a multifunction Intel RCiEP to forge
translated requests (AT=3DTranslated) to perform peer-to-peer DMA to another
function, bypassing the IOMMU?

Since this patch introduces pci_acs_rr_ineffective() to handle this exact
scenario for standard ACS capabilities and the Intel SPT PCH quirk, would
it make sense to apply similar scope checking here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D8
