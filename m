Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257ED35EDBA;
	Tue, 17 Mar 2026 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739477; cv=none; b=fRustUHcSJFlZptmJ+6PPbJdI0koSIFBqZ2lE7AtxwGOPE07FeeVVBVtV+GzgsZvP6q4dClqvAZhyw1u64lAGqw7fyTX2X2azncG8FGE3PVbLHxcHxiUYYg5WXRDJhSlBOGZGcRUCeV10j3xlYWnrmwM9+Rwjt5dgybhXNBRpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739477; c=relaxed/simple;
	bh=43+AHaMyL30yZRlveKv3t3U0bn7S2AD4UBk/EnPXoVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9nDFx5U5T4AI8u3UeqqYBwMgvNPiHotEdNAsCe687WbXrFyEjzz8lUpdcquF9oD2fA66O4eDKpZrUGBMx5hdQ1DXm67YV6D6IzgTRXtZYdCPBc8iU1RT2oVow0fjt+hWuApxenE+Mkjp59/wUZmwhJ9Ra9F451poT12T+Boo9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sS+jblRR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sS+jblRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F9AC4CEF7;
	Tue, 17 Mar 2026 09:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773739476;
	bh=43+AHaMyL30yZRlveKv3t3U0bn7S2AD4UBk/EnPXoVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sS+jblRRyOT0/PJ0DAcNWLRpuD0VkrSVlPcRIIJbfhvfw0xIdKQhpdN4Ar/rNkADZ
	 GjNTmROciRRIWnQKUqcxKmhIdVGadnCroyUXhWwqNgWmMQtylWprp6/mBZ39LBzQrK
	 3tSLA+7OBLxqwzlB6k2pRL5IIZ8R+1/+IfK1RAYECUuKy3gbjPBB5XaunHt8CQUBG9
	 g0uBNdsQxSt48FGw4NYEdAbsd8y/9wmPdxH05hFICsrCc1kUfKwvu7PKDKqUT5SL5N
	 lcl4c8UrWThbgavLdyDmgny15y3kqVBQaGDfKpehh1FxO/K5h22R6S2aeK8xHViFhi
	 /CYFCaXwc1Ktg==
Date: Tue, 17 Mar 2026 10:24:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Koichiro Den <den@valinux.co.jp>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <abkdu_7n_lePaTIY@ryzen>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>

On Tue, Mar 17, 2026 at 10:13:52AM +0100, Christian Bruel wrote:
> 
> Tested-by: Christian Bruel <christian.bruel@foss.st.com>
> 
> with the DISABLE BAR dependency
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=33642e9e36dc084e4fc9245a266c9843bc8303b9
> 
> I will need to update the pci_epc_features after the merge.

I don't think you should update pci_epc_features just to be able to test
the inbound submapping feature.

As I said before, I think a better option would to ensure that the test is
skipped instead of returning failure, for SoCs with too few inbound iATUs.

A real EPF driver (not the test driver), that wants to run on STM32, and
wants to use inbound submapping feature, can simply ensure that it does not
enable all BARs (the test driver obviously enables all BARs, since it wants
to test all BARs). That way, that EPF driver will be able to use multiple
iATUs for a single BAR (as required by this new feature).

This works because all BARs are disabled by default. An EPF driver has to
enable the BARs it wants to use. (E.g. nvmet-pci-epf only enables BAR0.)


> 
> A more general question: I don't understand why only the STM32 is impacted.
> It seems that all targets, even those with 6 IB iATU entries, should ensure
> that one BAR is disabled to handle subranges.

I can't speak for every SoC, but looking at dmesg:
rockchip-dw-pcie a40000000.pcie-ep: iATU: unroll T, 16 ob, 16 ib, align 64K, limit 8G

rk3588 has 16 inbound windows.

Probably most SoCs have more than 6 ib windows?


Kind regards,
Niklas
