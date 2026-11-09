Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255072;
	b=KauU64CGszrcu3wykk3DS+7acgpKoScc42auIE1OMeArFGzEiIspcy5JMJpBmKL495pa
	 AGHfNFaaeree9x6oTx5V0big/K4/UMywB2zxDp5ZZoM0iu+AUunXfUXFbkiJSQfBkQ+oB
	 OTlbkaV1DeIisOVXyq0u/9sRG8Y8y3C+2gVRZEVZgT3RsKFKPgRDOw29M2vr2swOk7pur
	 TizhDfSlbHTQI0Rx2vAm/a+14LfJuliJxGJdZAGh2LUlhUJ+8cS05TdmygqHprSlUZ9Gl
	 zX4iU+qtxvnb/Xt6dn7CmEuZSiLJQkPzmrg8oy3y2c0Ofusoi+R9AxRXExfMxV/aSSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255072;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3unplZ2AMkHbCG3ouJJFyNnk5yojzgIrCp45k1VLkkk=;
	b=TnMuYkXAsEiJ0MOWFmtD1/EDfaOT03me01oSR2q5s1/Sq5q1veNSixVrl5og6tsV6Buc
	 ymH1HhtrNj/zsFZRakywg8iHNRpt/gmrWYHBEvGuvAXOkSRvPZaQ8tYmijLKj1kicDOj6
	 QmxafS/RGSlSMdr6Klz/K6qkBUpxecKZnMGk6v60cUxEzWxxuqkKNktHv/LBGKQcM6BHv
	 J8jNV38Pz1gEc+roWIIZ6hh/9BajetORTvWvtFgYfYWah12BRn9jvlBv+2I/yzkQDVtOX
	 QwKKHNU8B8AYqmEU67I8H7xUKi27Yenayq21zYZr5LRw7titRtwmQXq+EvAsSvoJ7SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RU4IUFJc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923F606A336
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RU4IUFJc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DED01F008A1;
	Mon,  9 Nov 2026 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794255071;
	bh=3unplZ2AMkHbCG3ouJJFyNnk5yojzgIrCp45k1VLkkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RU4IUFJcomCLGcLePveUxEGJk3/A0FargjLx5nXJY17WsaI+/Lc9Qh1jhr/UlYK+v
	 9VuHwOUDh1HqXoWzhVD4nEjWkUuPKvawop15eZXY6JuN2siyZIMdNqb49cFaJqq/CT
	 mk9Fm1QkBVAADGwtPIxodlxD24Kf+30pFF23jrY5MpvzeP3n8yOo347KCmGCJrEB/y
	 fGtMgYji2d7Z2gw3gJBLu7HWXrvWbhFAYn5UJMRey+LwQH8RG5kBbM/ep4WMsSW1nb
	 Mq4psZg99aPRvSFhUshuWTLnvxwUWYuDJk6Z1hnNH/1l28DBIiJqSrgLQqd7ol0n77
	 VGDyorIqaztfA==
Message-ID: <sashiko-outbox-205548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/MSI: Skip address mask check for MSI-X entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Yang" <yuyang@kylinos.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261109-pci-fix-msix-alloc-failure-v1-1-6370c0b84354@kylinos.cn>
References: <20261109-pci-fix-msix-alloc-failure-v1-1-6370c0b84354@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:11:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] PCI/MSI: skipping MSI-X in msi_verify_entries() breaks mask
  verification
- [Low] PCI/MSI: wrong commit cited in Fixes trailer for
  msi_verify_entries()
--

commit ad679f69e8ee163ac9de4d91832ae0f1a10a2a14
Author: Yu Yang <yuyang@kylinos.cn>

> PCI/MSI: Skip address mask check for MSI-X entries
>
> The AHCI controller on Zhaoxin ZX-200 platforms supports only 32-bit
> MSI addresses, but its MSI-X capability uses 64-bit message addresses.
> pci_msi_init() therefore sets dev->msi_addr_mask to DMA_BIT_MASK(32)
> based on the MSI capability.
>
> msi_verify_entries() is shared between the MSI and MSI-X setup paths.
> When the irq domain assigns an MSI-X message address above 4GB, the
> 32-bit mask inherited from the MSI capability causes MSI-X setup to
> fail with -EIO:
>
>   ahci 0000:09:0f.0: arch assigned 64-bit MSI address 0x8002a030040
>   above device MSI address mask 0xffffffff.
>   ...
>   ahci: probe of 0000:09:0f.0 failed with error -22.
>
> MSI-X table entries have a 64-bit message address field, so the 32-bit
> limit derived from the MSI capability does not apply to them.
> Platforms that use msi_addr_mask to constrain MSI-X allocation, e.g.
> powerpc pseries/powernv and ionic on PPC64, already allocate addresses
> that satisfy the mask, so the verification is redundant for MSI-X.
>
> Skip the address mask check for MSI-X descriptors.
>
> Fixes: f144d1496b47 ("PCI/MSI: Add device flag indicating that 64-bit MSI=
s don't work")
>
> Signed-off-by: Yu Yang <yuyang@kylinos.cn>

[Severity: Low]
Should the Fixes tag reference 2053230af11d ("PCI/MSI: Set device flag
indicating only 32-bit MSI support") instead?  Commit f144d1496b47
("PCI/MSI: Add device flag indicating that 64-bit MSIs don't work") only
added the opt-in flag for quirks and drivers; 2053230af11d ("PCI/MSI: Set
device flag indicating only 32-bit MSI support") is what made
pci_msi_init() restrict the device based on PCI_MSI_FLAGS_64BIT in the MSI
capability.

> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 8a0133a6a2863..7f34bccc8248b 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -338,6 +338,13 @@ static int msi_verify_entries(struct pci_dev *dev)
>  		return 0;
> =20
>  	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
> +		/*
> +		 * MSI-X entries always use a 64-bit address, so the address
> +		 * limit for MSI capability does not apply for MSI-X.
> +		 */
> +		if (entry->pci.msi_attrib.is_msix)
> +			continue;
> +
>  		address =3D (u64)entry->msg.address_hi << 32 | entry->msg.address_lo;
>  		if (address & ~dev->msi_addr_mask) {
>  			pci_err(dev, "arch assigned 64-bit MSI address %#llx above device MSI=
 address mask %#llx\n",

[Severity: Medium]
Does skipping MSI-X descriptors in msi_verify_entries() bypass
dev->msi_addr_mask verification when a driver or quirk explicitly restricts
the device's addressable bits?

Although MSI-X table entries have 64-bit address fields, MSI-X is delivered
as a PCIe Memory Write TLP and is still constrained by the device's DMA
address width.  Drivers such as ionic (which only uses MSI-X) and radeon
set dev->msi_addr_mask to their hardware address limit, and on
architectures that do not consult dev->msi_addr_mask during MSI-X doorbell
allocation (such as x86 and arm64), msi_verify_entries() is the only check
preventing an unreachable doorbell address from being programmed.

Because msi_verify_entries() is only called from __msi_capability_init()
(all entries have is_msix =3D=3D 0) and __msix_setup_interrupts() (all entr=
ies
have is_msix =3D=3D 1), this check also turns the call in
__msix_setup_interrupts() into a no-op loop.  Meanwhile, pci_msi_init()
still lowers dev->msi_addr_mask to DMA_BIT_MASK(32) based on the MSI
capability, so powerpc's rtas_prepare_msi_irqs() and
__pnv_pci_ioda_msi_setup() will still force 32-bit MSI-X allocation on
devices with 32-bit MSI and 64-bit MSI-X capabilities.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-pci-fix-ms=
ix-alloc-failure-v1-1-6370c0b84354@kylinos.cn?part=3D1
