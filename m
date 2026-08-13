Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B79495034
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640682; cv=none; b=aYCwZFWcxJESu85BhqAeVfQY/EevIEKS8IGrT9vagd8CjBVT79B5XXATdNIgat0Q0Yrn9tenDV6rRoQ4eOOZj279HxR69kmJmE46n2yRePLhBkmeEAllVSiqNSm3pXU9D1WpM7DfZkP/LHKIgXrAAtF+TgdT9nYsjtpZRS2l2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640682; c=relaxed/simple;
	bh=4fYsjSYi4Evooo7WodkPDFVp2K4fqQ9caMZ6B6nSX7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ng6tj+210tPoxy2jukeoXDNvDYRgsVI33HqhosA28f/lg5ADLipKlgzVrvOHs3/7ufG2yTCuXO7M3oSCmUTYD9ntt4cD1ztxgKgCk6dcErYyNUDeiGaPPGX9rx1GIyhL9VJuSG9S7RyRqHPGWDLo2DB9eP+LHE8nGSD4bZ/jyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8B/I5Yf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8B/I5Yf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49B21F000E9;
	Thu, 13 Aug 2026 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786640681;
	bh=tqZocjYOYzCII7+M6N2tFVw7vEvZGjklZxDtsA7CiZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O8B/I5YfUcYoYH8p9JlrUhSpLAAKMhzc49YALzVZI34Wk20MbaQuCE8wVAceI/vgJ
	 ddOyTawlNRoSLZn3aHFsDckdQJ5wPBk0yQAqJa3AhoeHtgMIHa/FS/M/8sCDHcNKSq
	 thKuUWa1HMEpFYkGK4rDZd2oQjynUsWlkYsPFkPuvXTxZB7dHIflwf+VzgMY8C04kv
	 KCRvndZ5FhfmdFboSjZsljnLYlGu93VAXGZ7LpLxkHhcT4ZtvztAr8swAwDHMjfnX5
	 dLs19e1AiCYL54y5vh+8p4jxON6JUNTUtpmHiTW7p5rwjg0g7Afj4xUiWOTfQfK+qS
	 049FiiYRoeUmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] PCI: Add pci_irq_type() to query the allocated
 interrupt type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260813165234.620555-5-dakr@kernel.org>
References: <20260813165234.620555-1-dakr@kernel.org>
 <20260813165234.620555-5-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:04:40 +0000
Message-Id: <20260813170440.C49B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing dummy implementation of pci_irq_type() for !CONFIG_PCI conf=
igurations
--

--- Patch [4]: [PATCH v3 4/5] PCI: Add pci_irq_type() to query the allocate=
d interrupt type ---
commit dc3ae5a104b31d99bffe0b8a2992cb68e0130731
Author: Danilo Krummrich <dakr@kernel.org>

PCI: Add pci_irq_type() to query the allocated interrupt type

This patch adds a helper function to return the interrupt type (MSI-X, MSI,
or INTX) that the PCI core selected after a successful call to
pci_alloc_irq_vectors(). It provides a common way for drivers to query this
information without directly accessing the pci_dev bitfields.

Link: https://elixir.bootlin.com/linux/v7.1/source/drivers/net/ethernet/aqu=
antia/atlantic/aq_pci_func.c#L196 [1]
Link: https://lore.kernel.org/all/DKKG2QM3YJYB.Z2H2B2UXJ75N@kernel.org/ [2]

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 64b308b6e61c1..80b8561b5be0b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
[ ... ]
> @@ -1845,6 +1865,11 @@ static inline const struct cpumask *pci_irq_get_af=
finity(struct pci_dev *pdev,
>  {
>  	return cpu_possible_mask;
>  }
> +
> +static inline unsigned int pci_irq_type(struct pci_dev *pdev)
> +{
> +	return PCI_IRQ_INTX;
> +}
>  #endif

[Severity: Low]
Does this also need a dummy implementation in the !CONFIG_PCI block?

This patch adds a fallback implementation for when CONFIG_PCI_MSI is disabl=
ed,
but misses adding a stub for when CONFIG_PCI is completely disabled. Other =
IRQ
vector API functions provide stubs in the !CONFIG_PCI block to ensure drive=
rs
compile cleanly on architectures without PCI support:

include/linux/pci.h:
static inline int
pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
		      unsigned int max_vecs, unsigned int flags)
{
	return -ENOSPC;
}

static inline void pci_free_irq_vectors(struct pci_dev *dev)
{
}
#endif /* CONFIG_PCI */

Could the lack of a pci_irq_type() stub in include/linux/pci.h introduce a
compile regression when building a kernel with CONFIG_PCI=3Dn where a gener=
ic
driver calls pci_irq_type()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813165234.6205=
55-1-dakr@kernel.org?part=3D4
