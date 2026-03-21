Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB911B4138;
	Sat, 21 Mar 2026 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774096344; cv=none; b=LlPVE5LgFqTWOT7kr2JDKSLxGPosTBunzbbHIQsNu09q+FovSKnW6ea2h5ZHv8jLFELnhNWkxFGn/tTH0CzrSF0Yc1RSLaUTraH8Kr0IBD4LOdMjGiGMLTfpVxWaKBxLrrq6X9Ak2mJE4USPWTnLXf1ZQMbkMBtJYpggzUU+fxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774096344; c=relaxed/simple;
	bh=NfA8TR9mP5UJuh19960UA0gKn5/P8FEn4E0bQW2dUm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHXOCF2UPSzhhiO9dl6eYuiq6gj8fMC+1aut/fSUETtf44cZe/0xPvK2J6yP9Ja6lYgcNcLiA6XXQxVAWZ8jR7Rv0QDgKkiUsTItpt0o5V+axcFrnG2icZAcg5Q/r0i5bF8lsl4WyMKcI7OTr0vXRk9wk1WGTaaMTpVkL+Fy8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc0crXi3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc0crXi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD31C19421;
	Sat, 21 Mar 2026 12:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774096344;
	bh=NfA8TR9mP5UJuh19960UA0gKn5/P8FEn4E0bQW2dUm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dc0crXi3oB5+Oe5bWO4jNkBJgNgOHa5/pPOTLqSmwsMNr9AiBbM/OYRCf7Og2PqeJ
	 cYA88OqdaEFwttk6i+QFbc6SL+qXqtRwNbya5MOlEvaEzAwQgfMQDtoYZXPHnLaQ8Q
	 Ne/wWnvB39zIoLDknk70qq/1CHK5TGEsT/Vdff8WTTTKf8gZjWJmSCTokNDqI/BkNe
	 x9qEwVIjPafIFdb7zZ6DbsssEg+VeVv54f0N1x3f5QF1Ihl9uJQQEppKtE8A+VtMta
	 5NqYz4utBCUnC3o8FkbmFVPsIpNnK1wUzr1esQqoX1E5S3UkU7sAX3+oXvMAvVZCPK
	 VTc3YTg+65bpw==
Date: Sat, 21 Mar 2026 18:02:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PCI: endpoint: Add Tegra194/234 BAR layout and
 pci_endpoint_test support
Message-ID: <szjsh6git6axis5lmdmkrlhmasy5myswojhm5o446tutdgaujy@b62twswsxpmw>
References: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303072004.2384079-1-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:49:59PM +0530, Manikanta Maddireddy wrote:
> This series is on top of https://lore.kernel.org/linux-pci/20260217212707.2450423-11-cassel@kernel.org/T/#u
> 
> This series wires up Tegra194 and Tegra234 PCI endpoint controllers to the
> shared PCI endpoint and test infrastructure:
> 
> 1. Add a new reserved-region type for MSI-X (Table and PBA) so EPC drivers
>    can describe hardware-owned MSI-X regions behind a BAR_RESERVED BAR.
> 
> 2. Make Tegra194 BAR0 programmable and drop the 1MB fixed size so EPF
>    drivers can use it with arbitrary sizes via the existing DBI2 BAR
>    programmable path.
> 
> 3. Expose Tegra194 BAR2 (MSI-X) and BAR4 (DMA) as 64-bit BAR_RESERVED with
>    the appropriate reserved subregions (MSI-X 128KB, DMA 4KB), keeping
>    CONSECUTIVE_BAR_TEST working while allowing the host to use these BARs.
> 
> 4. Add Tegra194 and Tegra234 to the pci_endpoint_test device table so the
>    endpoint test driver can bind and run on these controllers.
> 
> Tested with pci_endpoint_test on Tegra194/Tegra234 endpoint.
> 

This series need to be respinned on top of pci/endpoint as we merged patches
that conflict with this.

- Mani

> ./pci_endpoint_test -f pci_ep_bar -f pci_ep_basic -v memcpy -T COPY_TEST -V dma
> TAP version 13
> 1..13
> # Starting 13 tests from 8 test cases.
> #  RUN           pci_ep_bar.BAR0.BAR_TEST ...
> #            OK  pci_ep_bar.BAR0.BAR_TEST
> ok 1 pci_ep_bar.BAR0.BAR_TEST
> #  RUN           pci_ep_bar.BAR1.BAR_TEST ...
> #      SKIP      BAR is disabled
> #            OK  pci_ep_bar.BAR1.BAR_TEST
> ok 2 pci_ep_bar.BAR1.BAR_TEST # SKIP BAR is disabled
> #  RUN           pci_ep_bar.BAR2.BAR_TEST ...
> #      SKIP      BAR is reserved
> #            OK  pci_ep_bar.BAR2.BAR_TEST
> ok 3 pci_ep_bar.BAR2.BAR_TEST # SKIP BAR is reserved
> #  RUN           pci_ep_bar.BAR3.BAR_TEST ...
> #      SKIP      BAR is disabled
> #            OK  pci_ep_bar.BAR3.BAR_TEST
> ok 4 pci_ep_bar.BAR3.BAR_TEST # SKIP BAR is disabled
> #  RUN           pci_ep_bar.BAR4.BAR_TEST ...
> #      SKIP      BAR is reserved
> #            OK  pci_ep_bar.BAR4.BAR_TEST
> ok 5 pci_ep_bar.BAR4.BAR_TEST # SKIP BAR is reserved
> #  RUN           pci_ep_bar.BAR5.BAR_TEST ...
> #      SKIP      BAR is disabled
> #            OK  pci_ep_bar.BAR5.BAR_TEST
> ok 6 pci_ep_bar.BAR5.BAR_TEST # SKIP BAR is disabled
> #  RUN           pci_ep_basic.CONSECUTIVE_BAR_TEST ...
> #            OK  pci_ep_basic.CONSECUTIVE_BAR_TEST
> ok 7 pci_ep_basic.CONSECUTIVE_BAR_TEST
> #  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
> #            OK  pci_ep_basic.LEGACY_IRQ_TEST
> ok 8 pci_ep_basic.LEGACY_IRQ_TEST
> #  RUN           pci_ep_basic.MSI_TEST ...
> #      SKIP      MSI17 is disabled
> #            OK  pci_ep_basic.MSI_TEST
> ok 9 pci_ep_basic.MSI_TEST # SKIP MSI17 is disabled
> #  RUN           pci_ep_basic.MSIX_TEST ...
> # pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
> # pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X1
> # pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
> # pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X2
> # pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
> # pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X3
> # pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
> # pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X4
> # pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
> # pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X5
> # pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
> # pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X6
> # pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
> # pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X7
> # pci_endpoint_test.c:146:MSIX_TEST:Expected 0 (0) == ret (-5)
> # pci_endpoint_test.c:146:MSIX_TEST:Test failed for MSI-X8
> #      SKIP      MSI-X9 is disabled
> #            OK  pci_ep_basic.MSIX_TEST
> ok 10 pci_ep_basic.MSIX_TEST # SKIP MSI-X9 is disabled
> #  RUN           pci_ep_data_transfer.memcpy.READ_TEST ...
> #            OK  pci_ep_data_transfer.memcpy.READ_TEST
> ok 11 pci_ep_data_transfer.memcpy.READ_TEST
> #  RUN           pci_ep_data_transfer.memcpy.WRITE_TEST ...
> #            OK  pci_ep_data_transfer.memcpy.WRITE_TEST
> ok 12 pci_ep_data_transfer.memcpy.WRITE_TEST
> #  RUN           pci_ep_data_transfer.memcpy.COPY_TEST ...
> #            OK  pci_ep_data_transfer.memcpy.COPY_TEST
> ok 13 pci_ep_data_transfer.memcpy.COPY_TEST
> # PASSED: 13 / 13 tests passed.
> # 7 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
> # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:7 error:0
> 
> lspci output displays all three BARs with this series,
> 
> 0005:01:00.0 Unassigned class [ff00]: NVIDIA Corporation Device 229b
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 165
>         IOMMU group: 13
>         Region 0: Memory at 2b28001000 (64-bit, non-prefetchable) [size=256]
>         Region 2: Memory at 2800000000 (64-bit, prefetchable) [size=128K]
>         Region 4: Memory at 2b28000000 (64-bit, non-prefetchable) [size=4K]
> 
> Manikanta Maddireddy (5):
>   PCI: endpoint: Add reserved region type for MSI-X Table and PBA
>   PCI: endpoint: Allow only_64bit on BAR_RESERVED
>   PCI: tegra194: Make BAR0 programmable and remove 1MB size limit
>   PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as 64-bit
>     BAR_RESERVED
>   misc: pci_endpoint_test: Add Tegra194 and Tegra234 device table
>     entries
> 
>  drivers/misc/pci_endpoint_test.c           |  7 ++++
>  drivers/pci/controller/dwc/pcie-tegra194.c | 46 +++++++++++++++++++---
>  include/linux/pci-epc.h                    |  9 ++---
>  3 files changed, 51 insertions(+), 11 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
