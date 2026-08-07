Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1A33C1AD;
	Fri,  7 Aug 2026 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116428; cv=none; b=SUS32NSpsUMV4hWqt9yFC837UHLogiz9s8lHpnyR5ZPltJLwKdUcs1K4ijsqZH5DgoqbfHZy5XGgvZ3vUyXA/0DM8ZZ6BSGGBLwG08fRvtXcl878oTSx6vfTflqH5YIPYATxB1ZDgUR6KtGMGLFw5aalO3VJS+HTw765s5OzOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116428; c=relaxed/simple;
	bh=hF+na2MtvclSaqOXAtrOqON++Jg3yIgxvrmQkUCszi8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Sa8ajJJFqZjPqAjuUhZTkX/EK53b3oNrxr/Korq7zy6VNfNxDJ4KgeyNQrqIg5lAARKkHU0fvwzpKd32ilE7YiHAiHs1dk4Svtv+GgGNBb5B1f1hAp3JBg1v5ciOzxJ2eMahwTGd/fP65NS8qN59Y5gzHM21TT62ZSCkjgy0Wf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdJIsFI0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdJIsFI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4117B1F00A3A;
	Fri,  7 Aug 2026 15:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116427;
	bh=wgQmbdtHCvFqRoxry1i5eNtqIyEJ55658yXkZlfsF0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=jdJIsFI0Qs6Wn39qAN5JJDiHURWIakvyX4ZSUoNU9gQPOoVlMP0cx5y1oCrn66tZ/
	 zLNtCtCf5Verm0hPGdraL2Sq4Ox2tKNS3nu3Vk8h3J4PxoZkcNQIGN83HnfkDdpizK
	 UfdnnrIEhvtyh1k7mUjq9fJT6hOp/SfN6i9uzsq28/fmT7QOXlWJpUr6Un1CTaKdtT
	 HtDQg9oRmv3YL3Qhd76Xm9xnrC9XZbmVBykeLG6VivnemPoN3xak5yEc55VP8PsxhJ
	 qeUGkIzBQhS8IkKU5uw/a7lUrU/Se+JhIObBxJ0Sues/ttjDaUFzTDLLvOAmFCA3l9
	 ucpk0NIwKKouA==
Date: Fri, 7 Aug 2026 10:27:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Semih Baskan <strst.gs@gmail.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	rafal@milecki.pl, florian.fainelli@broadcom.com, arnd@arndb.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rosenp@gmail.com, rani.hod@gmail.com
Subject: Re: [PATCH v2] PCI: iproc: Use the EROM outbound window on BCMA
Message-ID: <20260807152705.GA59586@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807035726.387-1-strst.gs@gmail.com>

On Fri, Aug 07, 2026 at 06:57:26AM +0300, Semih Baskan wrote:
> The PCIe outbound window base on Northstar depends on the PCIe Gen2 core
> revision. Revision 0x01 uses 0x08000000, 0x40000000 and 0x48000000 for
> controllers 0 to 2, while revision 0x07 (NS-B0) uses 0x08000000,
> 0x20000000 and 0x28000000. Broadcom's own driver branches on the core
> revision for exactly this reason.
> 
> bcm-ns.dtsi is shared by every Northstar SoC, so it cannot carry a value
> that is correct on both. Commit 767012397976 ("ARM: dts: BCM5301X:
> Describe PCIe controllers fully") gave the controllers a ranges property.
> The commit shipped in v7.1.
> 
> With that property present, two things go wrong with this driver:

It looks like you're going to present two problems next.  They should
be bullets so it's obvious what the first is and what the second is,
e.g.,

  - devm_pci_alloc_host_bridge() parses ...

  - When the DT window ...

(or whatever the second item is, I'm not sure where it starts)

> devm_pci_alloc_host_bridge() parses those ranges and requests them, then
> this driver adds its own window and requests the whole list a second
> time, so every controller fails to probe with -EBUSY.
> 
> When the DT window is used, it is only correct on core revision 0x07. On
> revision 0x01 it points at an address the hardware does not decode, and
> the first MMIO access to a BAR takes an imprecise external abort.
> 
> The enumeration ROM reports the correct base for the revision actually
> present, and bcma already provides it as addr_s[0]. Drop any memory
> window that came from the device tree and use that instead, requesting
> only the window this driver owns. This makes the driver correct whether
> or not the DT describes a window.
> 
> When a dropped window does not match what the EROM reports, print a
> warning naming both. The mismatch means the devicetree describes a
> window the hardware does not decode, and that should be fixed in the
> dts rather than ignored silently.
> 
> The same commit also added compatible = "brcm,iproc-pcie", so these
> nodes now match pcie-iproc-platform. With CONFIG_PCIE_IPROC_PLATFORM
> enabled, which is the default on ARCH_BCM_IPROC, that driver binds them
> first and this driver's probe fails inside devm_pci_alloc_host_bridge().
> This patch fixes the configurations where the BCMA driver is the one in
> use; OpenWrt builds that way, with PCIE_IPROC_PLATFORM disabled. The
> platform path takes the DT window as-is and has the same wrong address
> on core revision 0x01, so that side needs a devicetree fix either way.
> 
> Tested on an ASUS RT-N18U (BCM47081) and a Linksys EA9200 (BCM4709),
> both core revision 0x01.
> 
> Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully")
> Tested-by: Rani Hod <rani.hod@gmail.com>
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Semih Baskan <strst.gs@gmail.com>
> ---
> v1 -> v2: print a warning for every devicetree memory window that does
> not match the EROM window. Requested by Arnd Bergmann:
> https://lore.kernel.org/all/d05ffeca-f289-42dd-b454-5a7c7741c6d5@app.fastmail.com/
> 
> v1: https://lore.kernel.org/all/20260727140939.389-1-strst.gs@gmail.com/
> Applies to v7.2-rc5 and unchanged through v7.2-rc6; the file has no
> commits in between.

FWIW, there's no need to rebase for new -rcs.  We always apply PCI
patches on -rc1 anyway.
