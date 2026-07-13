Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C139021F
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929064; cv=none; b=mN+mrBk0VRFo3SlNdpXkRiXyJhwhtHLTzwQRcID1S5x3CG81xHSCdRgtVuJ3dt+9ijRLn9xrYbxTkPjOyoAR+NGXlfQ0Vf05SP0UeqCSanCpWV7G6DUz4lPrO20XctARltOUQCo8+U1ef8rArOFRsldxzHAJV+LVgXaaF3whLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929064; c=relaxed/simple;
	bh=9w+DcjQA4fIrB4vsrZQyqT8ZkCk1PSG8KZ2LcO9Mh1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rGXKFMthkCfIACjZdjT3q92K4FIcO1+GYd9kOYG70O6s1RCJotvUScsLBy4PsKgIjJBQmpIaJIgZDUpUZTa6zfRMBU/s7uJTt7Kf5H2cK01CWxS1sL0EYA7590kNWKWm3DD6oK658zILTtYENrlA42QtajhkLeaeir/rxJab8eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc+I1BJg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc+I1BJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C5D1F000E9;
	Mon, 13 Jul 2026 07:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783929063;
	bh=+q7UHaxwODOV/6HmzLyDJnBcF2NCWmfVG9jFYaBqV3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yc+I1BJgcl+NbtHNpcsD5B5Wwzmsi5gQ3bQlhGLtweFWdpxThbt6d8sEE27NgjbgT
	 teK5N0fjwStS1MVtL5lXT1VPhouWOnU4p55i8i7k7OpR4U0V4T2RJdYoFpjli/2GMd
	 tdtLsCJ9z6IHgRkNoHbNpLdE0bjD2r4fMeyfxbxcNpDA6BU3p1U24qzxKk++UqRZJn
	 yPZUyoV/XPYhAdaUzwYC1SMZhegCxsKYK8BZNKf+YU3qfSTqsJgDUtojaVKG7VxzjM
	 q8eiQzB48DdUkXiGXKAPEku6ymu2JDFM7mrm9fikYPhQRZem+hOliADqYmc4tA/wpv
	 PBt38lIb7/A9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Clear Attention Button Present in
 Slot Capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260713-b4-clear_abp_0713-v2-2-4f0333a98d4e@oss.qualcomm.com>
References: <20260713-b4-clear_abp_0713-v2-0-4f0333a98d4e@oss.qualcomm.com>
 <20260713-b4-clear_abp_0713-v2-2-4f0333a98d4e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 07:51:02 +0000
Message-Id: <20260713075103.35C5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for broken hot-plug detection on certain Qcom PCIe =
IP revisions.
--

--- Patch [2]: [PATCH v2 2/2] PCI: qcom: Clear Attention Button Present in =
Slot Capabilities ---
commit 2d72cd4fa9f71ba9a26ad4415df596d93e7bf902
Author: Qiang Yu <qiang.yu@oss.qualcomm.com>

PCI: qcom: Clear Attention Button Present in Slot Capabilities

This patch clears the Attention Button Present (ABP) bit in the Slot
Capabilities register for Qcom PCIe Root Ports, as the slots do not actually
have an attention button. This allows surprise hot-plug detection to
function properly by ensuring the Presence Detect Changed interrupt is not
disabled by pciehp.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 465c940109a7d..0a826ba632772 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -372,6 +372,12 @@ static void qcom_pcie_set_slot_cap(struct dw_pcie *p=
ci)
>  	 */
>  	val =3D readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
>  	val |=3D PCI_EXP_SLTCAP_NCCS;
> +
> +	/*
> +	 * Qcom PCIe Root Ports do not support Attention Button, so clear
> +	 * Attention Button Present in Slot Capabilities.
> +	 */
> +	val &=3D ~PCI_EXP_SLTCAP_ABP;

[Severity: High]
This is a pre-existing issue, but does this change fully resolve the problem
for all Qcom PCIe IP revisions?

Looking at PCIE_CAP_SLOT_VAL in drivers/pci/controller/dwc/pcie-qcom.c, it
explicitly includes the PCI_EXP_SLTCAP_ABP bit:

#define PCIE_CAP_SLOT_VAL   (PCI_EXP_SLTCAP_ABP | \
                             ...)

Functions like qcom_pcie_post_init_2_3_3() and qcom_pcie_post_init_2_9_0()
do not appear to call qcom_pcie_set_slot_cap(). Instead, they directly write
PCIE_CAP_SLOT_VAL to the capability register:

qcom_pcie_post_init_2_3_3() {
    ...
    writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
    ...
}

Since PCIE_CAP_SLOT_VAL explicitly includes PCI_EXP_SLTCAP_ABP, won't the
Attention Button Present bit remain set for platforms using revisions 2.3.3
and 2.9.0, leaving surprise hot-plug detection broken on those platforms?

>  	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> =20
>  	dw_pcie_dbi_ro_wr_dis(pci);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-b4-clear_a=
bp_0713-v2-0-4f0333a98d4e@oss.qualcomm.com?part=3D2
