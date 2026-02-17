Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9602877DC;
	Tue, 17 Feb 2026 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364315; cv=none; b=p7a3RpKz5kxeB8zRtIbBypzkSo+NZIfySJYnyRF9p564HzoP/7uoE6ykVCDQdbhAxEWzw/1B2lZU3EdDKPSnajOfXkr7mjLADY8J2mqOPLEsU7Il+1081K8b5aaQVr/FLGNR9rTpBC1rXU2aQ7RWq/yVXzddDLFExbING3/eKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364315; c=relaxed/simple;
	bh=63kU7skAW2FXPyHSnSl/BgF4w/Fj3RPxttwsh3pdBTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/ucMdbEM0Nzn3ZVDYGRmkkrb0hMn/wRGNAKJ/i9t7MMFGts9FNQ/ER6v3n4umhd8RsnZHG7K3RfoyXxV9N7OcktXJ5IM4Y5lim1nRf0uJ0DXAcwCHjoh+7PTkeCwFt9enMYos5oTGrSRF1mmGfkkE2UAMt8Q2l6ed7Q8g31yPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5qHgFoM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5qHgFoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F798C4CEF7;
	Tue, 17 Feb 2026 21:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771364315;
	bh=63kU7skAW2FXPyHSnSl/BgF4w/Fj3RPxttwsh3pdBTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5qHgFoMTrN5wDKyuUSnwhoqHL3xDOLZilXEPCEy1ZhAxdsthPHUlLSspWWUg9DCi
	 JhKS50irmxbk1HJpoqZYjik+nAAm/cuWspxe1SwgIGcqTurxZQKqa39aWIWRAnKqJI
	 EIy0x10tYDXNIS22KN9Tlv8K2r9YuWGQ1e/abbwtOjN20Ah6xmKPvk+il26suRlGP9
	 5jAlUu8npvhslJ8eWAB9QbpnqS14anCOfPkcGCPxfGWGP5UjAFZz0C5aZ7HwRzRETs
	 ffzSWSi/1H66SJMFa/i2YY0M87GKyZ0EoFZaVQWvHVYbz96Y/srK3uCWYuM52JbOYD
	 YvOqheFqvY5Fg==
Date: Tue, 17 Feb 2026 22:38:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 0/4] PCI: endpoint: Add BAR_DISABLED support to PCI
 endpoint framework
Message-ID: <aZTf1K4p7QS8-R9k@ryzen>
References: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>

On Tue, Feb 17, 2026 at 11:24:40AM +0530, Manikanta Maddireddy wrote:
> When Tegra194 runs in PCIe endpoint mode, BAR1–BAR5 are marked BAR_RESERVED so the
> EPF does not allocate backing memory. The host-side pci_endpoint_test driver
> still ioremaps all enabled BARs and runs BAR read/write tests on them. Writing to
> BAR2 (MSI-X table) or BAR4 (DMA registers) corrupts controller state and breaks
> CONSECUTIVE_BAR_TEST. A prior fix reset all BARs in the EPC .init(), so only
> BAR0 was visible to the host—tests passed but 64-bit BAR 2 and BAR 4 were no
> longer available for real use (e.g. host DMA via BAR4).
> 
> This series addresses that by:
> 
> 1) Adding BAR_DISABLED and clarifying BAR_RESERVED in the PCI endpoint core.
>    BAR_RESERVED is used for (a) HW-backed BARs (MSI-X, DMA) that the EPC may
>    leave enabled, and (b) the second register of a 64-bit BAR. BAR_DISABLED is
>    for unused BARs that the EPC must disable in .init() and the EPF must not
>    use. pci_epc_get_next_free_bar() treats both as not free.
> 
> 2) Updating Tegra194 endpoint to use three 64-bit BARs at indices 0, 2, and 4:
>    BAR0+BAR1 for EPF test/data, BAR2+BAR3 for MSI-X table, BAR4+BAR5 for DMA.
>    Only BAR0 and BAR1 are reset in .init(); BAR2/BAR3 and BAR4/BAR5 stay
>    enabled so the host can use MSI-X and DMA.
> 
> 3) Adding a BAR skip mask to pci_endpoint_test so endpoints can skip the
>    destructive BAR test on HW-backed BARs. Tegra EP test data skips BAR1–BAR5
>    (test only BAR0). Adding NVIDIA Tegra194 EP (0x1AD4) and Tegra234 EP (0x229B)
>    to the pci_endpoint_test_tbl so the host driver can bind and run tests
>    without corrupting MSI-X or DMA registers.
> 
> 4) Converting unused BAR_RESERVED to BAR_DISABLED in the Uniphier Pro5 endpoint
>    (BAR4 and BAR5); BAR1 and BAR3 remain BAR_RESERVED as the high halves of
>    64-bit BAR0 and BAR2.
> 
> With this, CONSECUTIVE_BAR_TEST and DMA tests pass while Tegra194 keeps 64-bit
> BAR 2 (MSI-X) and BAR 4 (DMA) enabled for host use.
> 

Hello Manikanta,

There are quite a few things that I think we should implement differently,
please see:
https://lore.kernel.org/linux-pci/20260217212707.2450423-11-cassel@kernel.org/T/#u

I'm not trying to take credit from you, for all I care, feel free to take
over the series and add you Co-developed-by on all the patches.

I just though that it would be easier to explain with code rather than a
lot of back and forth.

Hopefully we can send a V2 that includes more detailed BAR_RESERVED
descriptions, that includes what are behind each BAR_RESERVED (including
sizes of each backing MSI-X table/ATU regs/eDMA regs/whatever) in
pcie-tegra194.c.

I also have a Nvidia Jetson Orin Nano board that I can run in EP mode,
so hopefully we can collaborate to get something merged for v7.1.


Kind regards,
Niklas
