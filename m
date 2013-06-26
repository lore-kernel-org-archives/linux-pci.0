Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38313 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab3FZCuF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2013 22:50:05 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so30468961ied.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2013 19:50:04 -0700 (PDT)
Received: from google.com ([172.29.124.56])
        by mx.google.com with ESMTPSA id l9sm6352895igt.5.2013.06.25.19.50.03
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 19:50:03 -0700 (PDT)
Date: Tue, 25 Jun 2013 20:50:01 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Subject: Current open PCI defects
Message-ID: <20130626025001.GA25384@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here's a list of the current PCI defects open in https://bugzilla.kernel.org

Hint: maintainers really like it when people take the initiative to
resolve open issues.

Regressions (8 total):

  15388	After suspend to ram, laptop doesn't connect to the wired network. Sky2 error. Marvell 88E8036
  41622	[REGRESSION][BISECTED] Notebook crashes upon detecting the PCI subsystem with kernels >= 2.6.24-rc7
  42606	PCI I/O range not assigned under newer kernels
  44881	pci_find_upstream_pcie_bridge() warning
  57331	pci_disable_link_state() doesn't disable L1
  57961	ExpressCard hot-remove and hot-add not recognized by acpiphp
  59311	14e4:16bc SD card slot not working on Acer Aspire One 756
  59411	Several new kmemleaks related to acpiphp

Others (31 total):

  10461	PCI resource assignments fail due to poor allocation strategy
  15508	pciehp failing to recognise expresscards after a suspend/resume cycle
  16119	jmb38x recognized and works only if a card is plugged in during boot
  16470	pci_raw_set_power_state does not return an error if power state fails to change.
  24712	pciehp: resume problem: PCMCIA card insert not detected after resume
  29922	irqpoll crash
  29982	PCI Device conflicts with GART
  35452	Devices not available after resume from suspend to RAM
  40802	Kernel does not detect JMicron card reader unless a card is inserted when the PCI bus is scanned
  42552	PCI BAR Conflicts with E820 Area
  43041	Internal SD card reader is not working on Dell XPS L501x
  43192	various ExpressCards are not recognized
  43331	error updating BAR
  44021	Internal SD card reader is not working on Dell XPS 17 L502X
  47381	Screaming IRQ with Radeon HD4670 AGP / HDMI audio
  48451	error reserving uninitialized BAR
  50161	Dell Precision T5400 Workstation has incorrect CRS for PCI host bridge window
  50671	bnx2: No interrupt was generated using MSI, switching to INTx mode
  52211	"pci=nocrs" required to get BAR address assignment for SR-IOV capable card on IBM M4 x3650
  52531	Unify pcibios_resource_survey(), etc
  52591	xhci module fails when booting in UEFI mode
  54411	kernel panic when parallel remove pci device triggered by sysfs/pci interface
  54801	ExpressCard hotplug with acpiphp doesn't work unless pcie_aspm=force used
  54921	pciehp/xhci ExpressCard failure on Dell Vostro 3550
  54981	ExpressCard hotplug fails except with pcie_ports=native
  57311	Unexpected return value of pci_dma_mapping_error() when process is killed by signal
  57321	Using pci_reset_function() when doing unbind in parallel is problematic
  59191	host bridge apertures not really enforced on PA-RISC ?
  59391	pcie_aspm=off breaks pciehp on Dell Vostro 3550 (unlike pcie_aspm=compat)
  59531	Error recovery slot_reset() callback called while device is frozen
  60111	NULL pointer deref in ASPM alloc_pcie_link_state() on non-compliant topology
