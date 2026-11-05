Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903813;
	b=edCn0NhNqS/MMJxQqSE3H69kwOwrxJu3aEA0wbyZxLUwRzkKzUMF0P+tt5CJaY6HvMzZ
	 IbsNRpD9kOPtnJfjtBzdLKuiAIkWq5CKabDwIl25opdii0jKX+xndQlI01oFSwpfOu4bL
	 iNj8NgGnZOYeSEyJ16oHD8D1XEvMDHIc86YjS2Gj4tjsqchk1BuZrajgOuI5G0AsZCvLx
	 S/fx5/seN7AJZtDKvkiQa/j9OP/R8VcBW0gavBqscrL35ZihxOH5vtzrlJcICXi6gQUiM
	 4hkqOyLBq7JTmfoPX6aaBoKLMNgX407a99SCyPX2ZodsDkAPeaSKvb5ONquVUcBIjew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RBeUlU2wu0DRVykgRa5Pzlfj6dY/EBIODYPVUfaFIUc=;
	b=naPXolAoO9LET33HVaNn89QblT46HpoUPEX5X1YQPtIHRupY6s5t/jr+4lloboBGJlDi
	 uoCnmn56ZtipV+iYR2yABfg3auDeQGgB+Ym3GTimoAQZkfRsyZ2ba7p+mE/q6hP1PWssf
	 V1TG7dQPYvPAQPZYmShGfgjK2H9y320D38YkzzAtzE4ntkd2xVyFQWNccJCWfSZt9jdV7
	 dA6DS8EbR/9036NTNmDOv3ka6GSyQxOfB0GvAKN3uzU2DW/8Y3guetMwnAA7W+mAV+s/K
	 kwb26owdcVl8CGMxdtMBRAPWsxQzO+ka12f8ZLP0op37jfkFQVFVOeEUBWmf+oLGVWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O/aenWhw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A32606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O/aenWhw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931411F000C1;
	Thu,  5 Nov 2026 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903812;
	bh=RBeUlU2wu0DRVykgRa5Pzlfj6dY/EBIODYPVUfaFIUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/aenWhwcsoPtn/O2wKfjtgRqFRIwJKkFtOvLn4zFhQ5L42JZ+HfO62KW3edpz3nr
	 4JHHFgTEZE596LMExnBO2hf538P3xNBhWzd/23SGngpvGWTvtCjSU8axnkttypNEpN
	 QXT98tbgYCq3w5Y07up5NlpkoS7Zg7jq4CWaj+AWeNtHsOmWNRj0ZmqoZZi4TzLpoI
	 jZJjkCtSJGajqwdFsWKbMDAwN+BJnsIovF/obgs4fYSf+o/F0gpPXPe1apLLq+KhMI
	 FQqLX0WYRYgg4Lva/SkopANkLMQa53626ETaN3k+0QjCqhkVL7yZ85wMcinUaYxpWq
	 qM/vXQLN6mc3A==
Message-ID: <sashiko-outbox-199778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keith Busch" <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20261105182706.3700908-3-kbusch@meta.com>
References: <20261105182706.3700908-1-kbusch@meta.com>
 <20261105182706.3700908-3-kbusch@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:36:52 +0000
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
- [High] PCI/MSI: pci_msix_mask() reads MMIO when pci_channel_offline() is =
true
--

commit b206f920f881524539101689cd7270ceba32c679
Author: Keith Busch <kbusch@kernel.org>

PCI/MSI: Implement irq_mask_noflush() for MSI-x

This commit implements the irq_mask_noflush() callback for PCI MSI-X by
splitting pci_msix_mask_noflush() out of pci_msix_mask() to skip the MMIO
read-back that flushes the mask write. Parent domains that mask on behalf of
PCI/MSI clear irq_mask_noflush so they continue using their own irq_mask().

> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index f987cf897264e..db4dc37888f73 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -44,7 +44,8 @@ static inline void pci_msix_write_vector_ctrl(struct ms=
i_desc *desc, u32 ctrl)
>  		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }
> =20
> -static inline void pci_msix_mask(struct msi_desc *desc)
> +/* Posted write only: the device may still send an interrupt after retur=
n */
> +static inline void pci_msix_mask_noflush(struct msi_desc *desc)
>  {
>  	desc->pci.msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
> =20
> @@ -52,6 +53,11 @@ static inline void pci_msix_mask(struct msi_desc *desc)
>  		return;
> =20
>  	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> +}
> +
> +static inline void pci_msix_mask(struct msi_desc *desc)
> +{
> +	pci_msix_mask_noflush(desc);
>  	/* Flush write to device */
>  	readl(desc->pci.mask_base);
>  }

[Severity: High]
When pci_channel_offline(msi_desc_to_pci_dev(desc)) is true, doesn't
pci_msix_mask() now unconditionally execute readl(desc->pci.mask_base) after
pci_msix_mask_noflush() returns early?

Prior to this change, commit 2e2f69fc8ae2 ("PCI/MSI: Skip MSI/MSI-X
programming while the channel is offline") added the pci_channel_offline()
check to both pci_msix_write_vector_ctrl() and pci_msix_mask() so that
pci_msix_mask() would return before the flushing readl(desc->pci.mask_base):

drivers/pci/msi/msi.h:pci_msix_write_vector_ctrl() {
	/* The Table is unreachable while the Link is down */
	if (pci_channel_offline(msi_desc_to_pci_dev(desc)))
		return;
	...
}

With the early return moved into pci_msix_mask_noflush(), masking or tearing
down MSI-X vectors during PCIe error recovery, Downstream Port Containment,
or surprise removal (for example via pci_free_irq_vectors() ->
pci_msi_teardown_msi_irqs() -> pci_irq_shutdown_msix() -> pci_msix_mask() or
mask_irq() -> pci_irq_mask_msix() -> pci_msix_mask()) will still issue the
MMIO flush read to the unreachable MSI-X table BAR, which can trigger a
secondary Root Port containment event.

Should the pci_channel_offline() check remain in pci_msix_mask() before
readl(desc->pci.mask_base) instead of in pci_msix_mask_noflush() (since
pci_msix_write_vector_ctrl() already checks pci_channel_offline())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105182706.3700=
908-1-kbusch@meta.com?part=3D2
