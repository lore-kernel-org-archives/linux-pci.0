Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025650;
	b=xcCi14T0RKzaMOdq2KUTDNQbtg35vEItefWVsBGomOMC3S/1lVwY52lZ6xo+PRsGwmrP
	 xxuKvIp+XW65SV/BQHPcHb5fZTZPeoScspefXVvUqN8klIlz7hXDC24nfIDaRskRYoNZY
	 NOLT9VjKAwKzrLh556CmBlKxBeIJb4BY42edoXbL1tHGvWErp/Qr6IMc3WXQfNxvJHV8a
	 u6gMEi1IzauPLrunRFBliHrTPmDDQM0ciuj7rxc48kn06BagiEKpBT/YvW0qTaLRA79LY
	 08Rj6quqIdJRq5HBFJWIEw5DnMP7CIpbPvPve6dBvViQNwa4VMHyKdDhvE5AT69Q/mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025650;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=1ruXTHkCetMraDuq0NO8uW2/frG1fK6TaoKDogox4c4=;
	b=hLMXcYI9UTdXnERsY0+nQasQAq82RIV2aiYTkO73bpi7TMldwAZP+laG0kMs7SnlNnmv
	 9sKD2k8WI3WxXWo9/OQb6LhcOan23MQWfWBZ6uOF6Xk9AhHKx7cIZ0U+JTZ1nHMLt7NSO
	 HaXLE60jv0KHGXUhfPRE7+MkJ3wwcCEy001ePmiKQgjxqinzA/R0w99LUYq5dsVZ4Fc4U
	 NYOHhZ+PcoFCpgWN8rUl5NL3X0zi7EVXAHOI0n6x18e9A4V28ht61XybNYQacxv/tFMH+
	 hbjOHdW6XaWlXK9wLaqedTyyTner5QNYui7GBYOkm9Q3V6jCQiP1MIAh1q+OPORQeww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoSjgBgV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E94606A32A;
	Wed, 18 Nov 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoSjgBgV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B621F000C5;
	Wed, 18 Nov 2026 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795025649;
	bh=1ruXTHkCetMraDuq0NO8uW2/frG1fK6TaoKDogox4c4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ZoSjgBgV5mGs5czaFsrET/69bbnJvqSGh1XOplpDVprZzXDbKna1p9ji0a+kIFZ8H
	 XidtqyIoNcQGDjXa5nlVSX6fwzGHjaEGC14ZVOhmzbWu64qRRHVTcN8hS80Ibs4Moz
	 TVgqVgtV/Ov2z/35uA1bkEiLBWEEhSskx3HTD2Jcpe1mcMcuJo/z78Ni99x3gKVfuB
	 iw0HR1s2eE78qFtDivE/26jAk0Kd9TTXzWytln2AXwJXzq7BcQENWu0i+xKBSy0Gb7
	 84fL8C4K3z+Ntxji7ZxFM8dx2xUqlhrIj5ZJBMCgpIDSS9apaS2Xgf9B6ayoM9t0Vl
	 5JL69t8WzYwow==
Date: Wed, 18 Nov 2026 12:14:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Habil Eren =?utf-8?Q?T=C3=BCrker?= <habilerenturker@hotmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/quirks: Cast PCI_D0 to u16 in apple_airport_reset()
Message-ID: <20261118181408.GA625801@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118161559.63617-1-habilerenturker@hotmail.com>

[+cc Andy since he's fixed similar issues and may have better ideas]

On Wed, Nov 18, 2026 at 04:16:03PM +0000, Habil Eren Türker wrote:
> PCI_D0 is defined as pci_power_t, whereas pmcsr & PCI_PM_CTRL_STATE_MASK
> evaluates to a u16 integer.
> 
> This causes Sparse (make C=1) to report:
>         warning: restricted pci_power_t degrades to integer
> 
> Add (__force u16) casts on PCI_D0 to explicitly eliminate warnings.

We have a bunch of similar sparse warnings in drivers/pci, but I'm
kind of hesitant to just throw in a cast at each one to avoid the
warning.

About a third of the sparse warnings related to pci_power_t are
similar to this, where we're extracting the power state using
PCI_PM_CTRL_STATE_MASK and assigning to a pci_power_t variable or
comparing for equality with PCI_D0.  I think we can fix these with an
accessor something like this (better name ideas welcome):

  static inline pci_power_t pci_power_t_get(u32 csr)
  {
    return (pci_power_t __force) FIELD_GET(PCI_PM_CTRL_STATE_MASK, csr);
  }

There are a few more we could fix with an analogous pci_power_t_set()
or similar.  Most of the rest are arithmetic comparisons (>, <, >=,
etc).

> Signed-off-by: Habil Eren Türker <habilerenturker@hotmail.com>
> ---
>  arch/x86/kernel/early-quirks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 6b6f32f40cbe..7459a073c74d 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -644,13 +644,13 @@ static void __init apple_airport_reset(int bus, int slot, int func)
>  	/* Card may have been put into PCI_D3hot by grub quirk */
>  	pmcsr = read_pci_config_16(bus, slot, func, BCM4331_PM_CAP + PCI_PM_CTRL);
>  
> -	if ((pmcsr & PCI_PM_CTRL_STATE_MASK) != PCI_D0) {
> +	if ((pmcsr & PCI_PM_CTRL_STATE_MASK) != (__force u16)PCI_D0) {
>  		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
>  		write_pci_config_16(bus, slot, func, BCM4331_PM_CAP + PCI_PM_CTRL, pmcsr);
>  		mdelay(10);
>  
>  		pmcsr = read_pci_config_16(bus, slot, func, BCM4331_PM_CAP + PCI_PM_CTRL);
> -		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) != PCI_D0) {
> +		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) != (__force u16)PCI_D0) {
>  			pr_err("pci 0000:%02x:%02x.%d: Cannot power up Apple AirPort card\n",
>  			       bus, slot, func);
>  			return;
> -- 
> 2.47.3
> 
