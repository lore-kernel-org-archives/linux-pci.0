Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE78342902C
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342046; cv=none; b=S5Bf4NLqM+Dec4uZK/H8PhZZFMvNqm9hssPF35uKP0vu/QcFwV0w+xaUCBV9gmkpq3/S8wxPafTLonEhXAY52QICJi8+ZHWM62xxCFM9gmbULhlAWD2MDAYGSpK+35Rs6w/YmZ0gbwXt/9vLt13C/ByyI+1tPvaPoHaqErxT4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342046; c=relaxed/simple;
	bh=u3RPSlHtQZ+GQxYtfrMCty/BrXvI45pa+VeKPa7wljg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SnVGl3sZ4kwfZmWdaneF/eY78WwK5bH0ZGIJ9R4AfJyKBTyhuOhLkTLsFDNk13KU7rlIph4V/luiECJ++gTjz9lrxMbZizpApwHia9Qz6Z1y1KSFC4YRXa0CKqZANkDS6mZ004Y6xZaJolIRscAtBi75h8O5DJUPMkUi5ZpousI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPB3aKIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPB3aKIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4901F000E9;
	Fri, 21 Aug 2026 19:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342044;
	bh=JbzbeeTRjOjyUJCyuhtFmqBqEF1OYmzxceBp6gjSniw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GPB3aKItqJMUahCxsmjZ+8qB12K4tdG4/Zil0OUsKpq3+12WuqC6iJGG8w85rl8FT
	 C3Ot6IGy1DvkRP/2AXPwUBTRQn4QoDAN4qhXvVlzeAbfTUcnlOYxZB4cQNAoYV9vB7
	 4hL5cbQInz9k1sMaO1Na3cSJOf6Ro0b/TWbOj6VQUQPELU1aPh77v/bNKuO6h1yrDU
	 lG/64IZ9SjATpv6adWLzdbnxrFMB20lpfF9n/UYDg9ItH7sudyux32+69DhHHUUY3q
	 VLuaPCCFgxyRWNOrs6uHKELE/58ANb2kwQzHGzDx94Ak/5ClvwyJBpzuFh0Beaz3xg
	 TmfnlGmuFUsCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/18] PCI/P2PDMA: Derive peer-to-peer routing from
 ACS control bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-11-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-11-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:54:03 +0000
Message-Id: <20260821195404.5A4901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ACS Egress Control (EC) is incorrectly bypassed for Completion TLP=
s, violating the PCIe specification and allowing unworkable P2P DMA paths t=
o be mapped as direct.
--

--- Patch [11]: [PATCH v4 11/18] PCI/P2PDMA: Derive peer-to-peer routing fr=
om ACS control bits ---
commit e4c8e3c20c328ff7022188129cc2873b1613420b
Author: Leon Romanovsky <leon@kernel.org>

PCI/P2PDMA: Derive peer-to-peer routing from ACS control bits

This commit modifies the P2PDMA ACS redirection check to separate the logic
for Request and Completion TLPs. It evaluates Request Redirect for client
requests and Completion Redirect for provider read completions.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index a364008bbf504..1eda7b2135d70 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c

[ ... ]

> @@ -536,26 +538,35 @@ static struct pci_dev *find_parent_pci_dev(struct d=
evice *dev)
>  	return NULL;
>  }
> =20
> -/*
> - * Check if a PCI bridge has its ACS redirection bits set to redirect P2P
> - * TLPs upstream via ACS. Returns 1 if the packets will be redirected
> - * upstream, 0 otherwise.
> - */
> -static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
> +enum pci_acs_p2pdma_state {
> +	PCI_ACS_P2PDMA_DIRECT,
> +	PCI_ACS_P2PDMA_REDIRECT,
> +};
> +
> +enum pci_acs_p2pdma_tlp {
> +	PCI_ACS_P2PDMA_TLP_REQUEST,
> +	PCI_ACS_P2PDMA_TLP_COMPLETION,
> +};
> +
> +static enum pci_acs_p2pdma_state
> +pci_acs_p2pdma_state(struct pci_dev *pdev, enum pci_acs_p2pdma_tlp tlp)
>  {
>  	int pos;
>  	u16 ctrl;
> =20
>  	pos =3D pdev->acs_cap;
>  	if (!pos)
> -		return 0;
> +		return PCI_ACS_P2PDMA_DIRECT;
> =20
> -	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
> +	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl))
> +		return PCI_ACS_P2PDMA_REDIRECT;
> =20
> -	if (ctrl & (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC))
> -		return 1;
> +	if (tlp =3D=3D PCI_ACS_P2PDMA_TLP_COMPLETION)
> +		return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
> +					   PCI_ACS_P2PDMA_DIRECT;

[Severity: High]
According to PCIe Base Specification 6.12.4, ACS Egress Control applies to
all TLPs, including both Requests and Completions.

Does this logic incorrectly bypass Egress Control (PCI_ACS_EC) for Completi=
on
TLPs by only evaluating Completion Redirect (PCI_ACS_CR)?

If a PCIe switch has ACS Egress Control configured to isolate P2P traffic,
will the hardware drop P2P Read Completions as ACS violations while the
kernel incorrectly maps the path as direct? This could lead to Completion
Timeouts and potential runtime failures when drivers attempt P2P DMA reads.

> -	return 0;
> +	return ctrl & (PCI_ACS_RR | PCI_ACS_EC) ?
> +		PCI_ACS_P2PDMA_REDIRECT : PCI_ACS_P2PDMA_DIRECT;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D11
