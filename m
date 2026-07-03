Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5131A55E
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052997; cv=none; b=bIhx6BuzY1nMN24bxYlYnDnLq/c7AV78cr0BOWtjLgPVcH2eCajGFCOch13xiPI5DmYpyofYUiUTwVnDVyy3NYGUfppaWcmA4AHBT7Gbo7fZsOV3GIE4umrw/JuDyTJ8ZWalaD0ccHquuDwkU53FQBeBC8X3kmZhiw5palHJIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052997; c=relaxed/simple;
	bh=wxg6g2m1/QKqSb1SkZaPVcE2pvCfEmjPbIWsSETZCNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DWNbWD46INGNjyldqoTwhiTEPqt3fx47DXI/yjtit8LolsrlsBieyz908sOWiQ5a6CrKU9O4CNWL7xuFLDyDbJQJLph6jd8a4Dht+GUAghTE5u6hfReoGup2gWj4Jdpx/ipw7TXAogAOTMyyhV4Q8nbMOO4xbEKyQWg0YAuyk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnOikOoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnOikOoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FE61F00A3A;
	Fri,  3 Jul 2026 04:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052986;
	bh=ETX3GvMRJgRp+X3OB01rpHvsUQOXMdSfEcHyjAiwnYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MnOikOoaBBwWZnq3Gosn4ouPTJJeDvc9AKnalHxbBRLwuX+nt9FNvMNPVx3cFhKqS
	 aUstAm+1+Tj+0hn+SVTWaReZuGzQbhL0U+27B7NbrfXiv1wICzoQkaRXglEMo4ZNGi
	 AU8erIFtgEBYnCcgR6VWfaMRuP2C756LPA63va3xmRAnyuCUFePJlU/wDCEOK0y8ro
	 2GSJWEYlrMPxDfoxeU9SfykgiA8vlDx7O9ecFW8znhf1AvHOFCXhZ/HdprKvAYUuLy
	 Aafm5PN6718RPuTBG1WLjg0PHrIzsz8vI5kbAH9oOVourvC1rKFyIWV948TuJkTm2v
	 ATdg/JVsZoX3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/18] iommu/arm-smmu-v3: Factor out CMDQ batch
 force-sync conditions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <3499c9990bfdfa3580abb5972c816f32d037d6f5.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <3499c9990bfdfa3580abb5972c816f32d037d6f5.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:29:46 +0000
Message-Id: <20260703042946.A0FE61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> arm_smmu_cmdq_batch_add_cmd_p() carries two distinct reasons for flushing
> the current batch with a CMD_SYNC before appending the new command:
>=20
>   - The batch's pre-assigned cmdq does not support the new command.
>   - The Arm erratum 2812531 workaround (ARM_SMMU_OPT_CMDQ_FORCE_SYNC)
>     forces a SYNC at one entry before the batch is full.
>=20
> Factor those checks into a new arm_smmu_cmdq_batch_force_sync() helper so
> that adding another force-sync condition becomes a one-line addition.
>=20
> No functional change.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D16

