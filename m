Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019149;
	b=pqgGnnmi1imVPls5NWPchu1JAD39slGpOq4f2J0tHtqcd5+HWQxZiMip0X8srHvwAxO3
	 KvbmYAkuLGhZ/Bx2tAbaXy5N3rzRSS9/zsfv+ZKFTPoB1nRXpRboi7hY3HwG67E2GpeB0
	 lzqLBBksPGePkXWKPtFo2k75R/+s19BoGzCRnAIJ1AheUijjP++jr0y6U1qhzWgu6cNcE
	 7MpHaaZV6JzeFM3sKpTRUmdGfMIudxc/HyBcxwZrZGxn5I3o8LcRWH8UaiYpapPFN2hPY
	 PYxnYmfwMgu8vfZ2W+++MqUvwmAoTnMFIZ6ajvv5YmRRkmGcpbhwg28hDC5qR9aldeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019149;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5H8PSkVDex+QRhjYafGVEPRpclEzemLgL58kmtAzVlI=;
	b=JvcjaW685qM7byhOdHKj0kGYf0uEPnYFbiOMC38Jl2xeAfUWky4h1iIvM24dfGNyg5kf
	 PjsfwFnhddSgFdA9EJcQ/9W8D2Yyg0XAN8LWXW0I3XgnBPqaGufly7ObD1Wxw1YVNvUaQ
	 Q9bB/3q669cTXmLNJUVk3t+fcztIxnb06/TcvmVYhZ0TnL9Ct6BgsnCM1lpa7J4LjOJ8w
	 pZhlI14eA15IOlh9zGfWyCwzqvJRAEocI7ZScgtx7JjHY2BFJ+JOgjivGdBKiRauGYZs4
	 8PcdOdCLGeDaQyGJWwZNqckwcLHn4u1TBWoW8hMHpXURFYEZyi+IkSM2AZCiwESTg2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owMnxlIC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704A606A325;
	Wed, 18 Nov 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owMnxlIC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4031F000C4;
	Wed, 18 Nov 2026 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019148;
	bh=5H8PSkVDex+QRhjYafGVEPRpclEzemLgL58kmtAzVlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=owMnxlICEwJk+ETmJz7BBDWR3vkgUmTi8OzDsVPUVyU5015AJBg+eD5d6z3xq1gHC
	 um8avSd4PdfuLtJzHF2YiramSqDta9xxBiA9hhnwSef2Dq/U3oq15agn6mWhofauhR
	 sLC+TjcYnz3FrNnE0hxShhL6T7euNS5QzPvwszOLoeGmHCb6o5dBiGkNEfnn344yU3
	 xloX0zQ9crglIWtdSd2cA/nHrr4zBM7sRYHD0G0C53mBTFo5zv9i5qBsFw8nFxwTB6
	 UUmjyVQG+figJYUs5d+1dlfErxWJ24xNgBceHlrBP58BDLX9nDYC9jRloSnk/mxpz9
	 rsUFrssCzCiVg==
Date: Wed, 18 Nov 2026 10:25:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gokulkrishna Sekar <gokulkrishnasr@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org,
	Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
Subject: Re: [PATCH] PCI: Encode corrected PCIe port type with FIELD_PREP()
Message-ID: <20261118162547.GA597321@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118153505.95686-1-Gokulkrishna.Sekar@harman.com>

On Wed, Nov 18, 2026 at 03:35:05PM +0000, Gokulkrishna Sekar wrote:
> set_pcie_port_type() validates PCIe port topology and corrects
> invalid upstream/downstream port type information in the cached
> pcie_flags_reg value.
> 
> When performing these corrections, the code clears the
> PCI_EXP_FLAGS_TYPE field but writes PCI_EXP_TYPE_UPSTREAM or
> PCI_EXP_TYPE_DOWNSTREAM directly into pcie_flags_reg. The
> PCI_EXP_TYPE_* values are decoded port type numbers, not values
> encoded for the PCI_EXP_FLAGS_TYPE bitfield, so the corrected type
> is stored in the wrong bit position.
> 
> As a result, the cached port type may not match the corrected
> topology and subsequent users of pcie_flags_reg can observe an
> incorrect PCIe device type.

Looks like subsequent users would think the device was a PCIe Endpoint
(PCI_EXP_TYPE_ENDPOINT==0x0) instead of an Upstream or Downstream
Port, but only for devices that claim to be the wrong type in the
first place, so it probably doesn't actually affect many systems.

But it seems like a candidate for stable anyway.

> Use FIELD_PREP(PCI_EXP_FLAGS_TYPE, ...) when updating the cached
> field so the corrected port type is encoded consistently with the
> format used in the PCI Express Capabilities Register.
> 
> Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
> Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
> ---
>  drivers/pci/probe.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f..7b09a4463097 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1674,7 +1674,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		if (pcie_downstream_port(parent)) {
>  			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
>  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
> +			pdev->pcie_flags_reg |= FIELD_PREP(PCI_EXP_FLAGS_TYPE,
> +							   PCI_EXP_TYPE_UPSTREAM);
>  		}
>  	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
>  		/*
> @@ -1685,7 +1686,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
>  			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
>  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
> +			pdev->pcie_flags_reg |= FIELD_PREP(PCI_EXP_FLAGS_TYPE,
> +							   PCI_EXP_TYPE_DOWNSTREAM);
>  		}
>  	}
>  }
> -- 
> 2.56.1
> 
