Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726042;
	b=sECJghrn8QGwVs9hMclCLrFd2Ixm7KA2B6xzMc2NPm4v+W5sL0lFH7XtoP7RSYFO5j7u
	 T3CjlN3VhxZEblLgVs1ugu1KAePhiiigPqFnUt++DCAq2TGaQlHTdDPnFltrM0tB1D16P
	 GEXeEnDa5iuuwhHmoCuWix0ibGmJ/nTLbpG/BbW6XxTl5VurpC8amg4Iax93wPAER8VPi
	 seXbPS9PmEol7KhaQH1dUnM/YLnnahbuO9XfRScxo02ZV11vsPt/DiyM1s/L957fBtrCR
	 w1yoJNxWB0evvPtBiiPPb+hBPiiPq+aWvFmeIdmpVtwmW/NSTGi+zYXa4YPEdjlY6Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726042;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GSZWQMNRRQKeKiORPlTniQ5xuB29M5LGd/dL1rFGXmE=;
	b=Dtd3UU6tSDkbOwxBjJOJVWaXRkYbURS3lTtXvMfpH6hlU/bt4uSWW4M1iB0j+IKxW8IS
	 FNVYGTwilvmPVR0Lal6FuDRTb9c87FnWkkt1NBt8QmORxBxW6p560gF0JTgR8y9unMf7v
	 HmBEJKaPuDMgxH8ct5A5jsx6hB1shjC6NGEAq7TQ4zt6d4XhRwagoyxm+MlZScirhaxGA
	 Vu1yOmnFEX42friI+YodnoZP8GF9v5NTHBg0pCv2CgKhDar6kFDmPcYBHYrgWn71M+FTk
	 D/vykrR3uByBRbIddhO8hYFT+HfkIWkPn5K3KdiUkkm8q8ueuB3EaqEc9R3/OS+sRaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n/BIpAUy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E640606D80A;
	Tue,  3 Nov 2026 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n/BIpAUy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581301F00A16;
	Tue,  3 Nov 2026 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793726041;
	bh=GSZWQMNRRQKeKiORPlTniQ5xuB29M5LGd/dL1rFGXmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n/BIpAUyeNiV5AToVuVj1rE4BJTXrCnup38fNbuF+u6/0gBLv1HRITS2YwzlJPQZc
	 9e8Z+IdjJOHbRq7w81HN7HQkLkA3ifxadA4dXuhqQcW9TtJTOY6xZQa2K0kbqIFsL1
	 ntdTB+N/12u2ypyRHBywQk0B4R7ReTzKBrYQfahzBPMImFNMNJFd74hk2qRrmmda8a
	 i7pwZNQYBoiNXGcEZBhx4l58uOadBlBMsXKLC8GP2YIRwRc2CHaK6vgkpaIBOuDzgE
	 a/Bq6vDqKM/ZMotb0IrTyf9Kk3ZPCVwWwQTsbTuwz9std3gVPhz3O+9TBufJ2XQOZR
	 z5pNRaJ/xwzZA==
Message-ID: <sashiko-outbox-195778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: switchtec: Add Gen6 secure switches to NTB DMA
 alias quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc: vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261103170033.471034-3-logang@deltatee.com>
References: <20261103170033.471034-1-logang@deltatee.com>
 <20261103170033.471034-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 17:14:00 +0000
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
- [Medium] PCI: switchtec: missing Gen6 device IDs in quirk_switchtec_ntb_d=
ma_alias()
--

commit 17094c1753a87a229df82238fb75b9bb1b5728fe
Author: Logan Gunthorpe <logang@deltatee.com>

PCI: switchtec: Add Gen6 secure switches to NTB DMA alias quirk

This commit adds four Gen6 PFXs and PSXs secure switch device IDs to the
quirk_switchtec_ntb_dma_alias() PCI fixup table so NTB DMA transactions
receive the proper requester ID alias under an IOMMU.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7f1f47ea2ee41..691eff466d9ce 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6250,6 +6250,10 @@ SWITCHTEC_QUIRK(0x5568);  /* PAXA 68XG5 */
>  SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
>  SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
>  SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
> +SWITCHTEC_QUIRK(0x6064);  /* PFXs 64XG6 */
> +SWITCHTEC_QUIRK(0x6048);  /* PFXs 48XG6 */
> +SWITCHTEC_QUIRK(0x6164);  /* PSXs 64XG6 */
> +SWITCHTEC_QUIRK(0x6148);  /* PSXs 48XG6 */

[Severity: Medium]
Should the remaining 12 Gen6 Switchtec device IDs from switchtec_pci_tbl in
drivers/pci/switch/switchtec.c also be added to SWITCHTEC_QUIRK() here?

Commit 5e6c21c56998 ("PCI: switchtec: Add Gen6 Device IDs") added all 16 Ge=
n6
Switchtec device IDs to switchtec_pci_tbl via SWITCHTEC_PCI_DEVICE(...,
SWITCHTEC_GEN6), which binds both PCI_CLASS_MEMORY_OTHER and the NTB endpoi=
nt
class PCI_CLASS_BRIDGE_OTHER:

drivers/pci/switch/switchtec.c:switchtec_pci_tbl[] =3D {
    ...
	SWITCHTEC_PCI_DEVICE(0x6048, SWITCHTEC_GEN6),  /* PFXs 48XG6 */
	SWITCHTEC_PCI_DEVICE(0x6064, SWITCHTEC_GEN6),  /* PFXs 64XG6 */
	SWITCHTEC_PCI_DEVICE(0x6044, SWITCHTEC_GEN6),  /* PFXs 144XG6 */
	SWITCHTEC_PCI_DEVICE(0x6060, SWITCHTEC_GEN6),  /* PFXs 160XG6 */
	SWITCHTEC_PCI_DEVICE(0x6148, SWITCHTEC_GEN6),  /* PSXs 48XG6 */
	SWITCHTEC_PCI_DEVICE(0x6164, SWITCHTEC_GEN6),  /* PSXs 64XG6 */
	SWITCHTEC_PCI_DEVICE(0x6144, SWITCHTEC_GEN6),  /* PSXs 144XG6 */
	SWITCHTEC_PCI_DEVICE(0x6160, SWITCHTEC_GEN6),  /* PSXs 160XG6 */
	SWITCHTEC_PCI_DEVICE(0x6248, SWITCHTEC_GEN6),  /* PFX 48XG6 */
	SWITCHTEC_PCI_DEVICE(0x6264, SWITCHTEC_GEN6),  /* PFX 64XG6 */
	SWITCHTEC_PCI_DEVICE(0x6244, SWITCHTEC_GEN6),  /* PFX 144XG6 */
	SWITCHTEC_PCI_DEVICE(0x6260, SWITCHTEC_GEN6),  /* PFX 160XG6 */
	SWITCHTEC_PCI_DEVICE(0x6348, SWITCHTEC_GEN6),  /* PSX 48XG6 */
	SWITCHTEC_PCI_DEVICE(0x6364, SWITCHTEC_GEN6),  /* PSX 64XG6 */
	SWITCHTEC_PCI_DEVICE(0x6344, SWITCHTEC_GEN6),  /* PSX 144XG6 */
	SWITCHTEC_PCI_DEVICE(0x6360, SWITCHTEC_GEN6),  /* PSX 160XG6 */
    ...
};

Every Gen3, Gen4, Gen5, and PCI100x device ID in switchtec_pci_tbl has a
matching SWITCHTEC_QUIRK() or SWITCHTEC_PCI100X_QUIRK() entry in
drivers/pci/quirks.c for PCI_CLASS_BRIDGE_OTHER.

Without entries for the other four Gen6 PFXs/PSXs secure switch IDs (0x6044,
0x6060, 0x6144, 0x6160) and the eight non-secure Gen6 PFX/PSX switch IDs
(0x6248, 0x6264, 0x6244, 0x6260, 0x6348, 0x6364, 0x6344, 0x6360), will
quirk_switchtec_ntb_dma_alias() fail to run during PCI enumeration for those
models, leaving their NTB proxy requester IDs unaliased under an IOMMU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103170033.4710=
34-1-logang@deltatee.com?part=3D2
