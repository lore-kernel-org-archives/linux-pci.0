Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA84411A08;
	Wed, 14 Oct 2026 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963666; cv=none; b=k+jt0nstCfnSL3GWKStGiNuHTbgXaMWZ2bRg4FHlDFDjqICA1IIgpvAr9tZ/Wwgp2k9yhwALFBsvMZJBYL8vaHgVq4PL1gZbqBK3aujkjKUmME+Bo15AvTfaN1YZFzCH702sk4mfZOzvo6xiBdRVWNs2QmGlFQf4JSZkYQrvboo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963666; c=relaxed/simple;
	bh=7kgrn7vfHp/HBxFtKq6zzrmLScv3BCcSWbbxPL7Jk+k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=urRhGaEWZmA1NDDhnoS3dRJEyNB/kzw4lIGURQAU9koEUGoH9wE6U9ucojveyKD/BBvtrbKyS0U/102HlkMbjAqDap7XzCzaLnpkkzuwXB5L7E5ymNAIMCAZcu0it58+tVLs3f6JveVQxTfS5ydjdNQ7DVTWeQB1ZrR+jEI+iH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFCD1F000FF;
	Wed, 14 Oct 2026 07:41:00 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/13] PCI: brcmstb: Stop using chip numbers for
 conditions
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
In-Reply-To: <20260911233541.1650895-1-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
Date: Wed, 14 Oct 2026 13:10:52 +0530
Message-Id: <179196365204.38040.9410252322524941418.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=7kgrn7vfHp/HBxFtKq6zzrmLScv3BCcSWbbxPL7Jk+k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzzIHwOTKlLdlXCO0vyzNfsIbHoswX7ANZ93im
 FhbPPswv96JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas8yBwAKCRBVnxHm/pHO
 9VEoCACCjI0ALyCvEGCcqiXLR3pl3wf31kJVuI+1gEqK552ByK3YAP/JgjPB4YaSIozzPR71AB0
 5ABBNbCFqf/Yhm1CA7QL6gWJKmnPQbdI5yAKUoUB/WGfFZNZ/Ro3ZzfimeWChAigM/uhA0jdVfx
 xbc2U9N9hAfFsYTOJ0rX1Na+zksF0T42df8A9VZPK6D0u9+uFixz9fNGIazG1gjQW6YJkU/CJ3h
 89LCF2umlegZx0FWBCSYVzzLxVfLhhFDp2iVoSyjQaLXTEMBodT2/PPWp7vqkftDAn/XdKmklUz
 U1aOzHipDdx3JSIdoBLJwYaExJJdUOCzoRbmVbsPRfy6hL/L
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-11 19:35 -0400, Jim Quinlan wrote:
> Much of the brcmstb PCIe driver code does (essentially) this:
> 
>         if (pcie->chip == 0x1234 || pcie->chip == 0x5678) {
>                 /* ... */
>         }
> 
> when it should instead do this:
> 
>         if (behavior_xyz(pcie)) {
>                 /* ... */
>         }
> 
> This series does the above.  In addition, some other minor improvements are
> added in the hopes of making the code more readable.
> 

Thanks for doing this! Those checks were quite ugly.

> Jim Quinlan (13):
>   PCI: brcmstb: Remove redundant const specifier for struct fields
>   PCI: brcmstb: Use flags u32 instead of bools
>   PCI: brcmstb: Add Broadcom quirks macro
>   PCI: brcmstb: Declare and assign quirk OB_WIN_32BIT_ADDR
>   PCI: brcmstb: Declare and assign quirk OB_WIN_MAXSZ_128MB
>   PCI: brcmstb: Declare and assign flag IS_BMIPS
>   PCI: brcmstb: Declare and assign quirk 32BIT_PCI_OPS
>   PCI: brcmstb: Declare and assign quirk NO_RGR1_TIMER
>   PCI: brcmstb: Declare and assign quirk EARLY_PERST_ASSERT
>   PCI: brcmstb: Declare and assign quirk PERST_PCIE_REV_CUTOFF

I'll apply the first 10 patches as I see some comment from Florian on patch 10
and Sashiko's comment on patch 11. You can send a follow up series addressing
those comments.

- Mani

