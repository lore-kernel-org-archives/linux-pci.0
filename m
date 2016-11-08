Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbcKHXaz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Nov 2016 18:30:55 -0500
Date: Tue, 8 Nov 2016 17:29:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: bhelgaas@google.com, shawn.lin@rock-chips.com, luto@kernel.org,
        Sergey.Semin@t-platforms.ru, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI: Fix kernel panic of root-port-less PCIe enum due to
 ASPM
Message-ID: <20161108232957.GH14322@bhelgaas-glaptop.roam.corp.google.com>
References: <1475746455-20665-1-git-send-email-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475746455-20665-1-git-send-email-fancer.lancer@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Serge,

On Thu, Oct 06, 2016 at 12:34:15PM +0300, Serge Semin wrote:
> Hello linux folks,
> 
>     Sometime ago I discovered a kernel panic popping up when PCI subsystem was
> trying to enumerate PCI express bus with ASPM service enabled. Here it is:
> 
> [    5.089667] CPU 0 Unable to handle kernel paging request at virtual
> address 00000060, epc == 80317004, ra == 80316ac8
> [    5.120952] Oops[#1]:
>           ...
> [    5.528438] Call Trace:
> [    5.535640] [<80317004>] pcie_aspm_init_link_state+0x6c0/0x814
> [    5.552843] [<80300c44>] pci_scan_slot+0x140/0x148
> [    5.566957] [<80301dcc>] pci_scan_child_bus+0x50/0x1b0
> [    5.582096] [<80301944>] pci_scan_bridge+0x25c/0x694
> [    5.596724] [<80301e78>] pci_scan_child_bus+0xfc/0x1b0
> [    5.611862] [<80301944>] pci_scan_bridge+0x25c/0x694
> [    5.626488] [<80301e78>] pci_scan_child_bus+0xfc/0x1b0
> [    5.641628] [<8030215c>] pci_scan_root_bus+0x64/0x124
> [    5.656528] [<804ca298>] pcibios_scanbus+0xa8/0x188
> 
>     I more than sure you are familiar with the issue, since I've found the
> mailing discussion: "PCI: avoid NULL deref in alloc_pcie_link_state"
> https://patchwork.kernel.org/patch/2751651/
> https://bugzilla.kernel.org/show_bug.cgi?id=60111

I'm trying to puzzle out a few things here.  Maybe you can help me out?

- Does this issue exist in current upstream kernels?  Your dmesg shows a
  v3.19-based kernel.  c8fc9339409d ("PCI/ASPM: Use dev->has_secondary_link
  to find downstream links"), which appeared in v4.2, fixes a problem very
  similar to what you're reporting.

- When we dereference the NULL pointer, which device did we call
  pcie_aspm_init_link_state() for?

- https://bugzilla.kernel.org/attachment.cgi?id=240981 is the failing dmesg
  log, and it shows "vgaarb: device added: PCI:0000:04:00.0".
  
  Your lspci output (https://bugzilla.kernel.org/attachment.cgi?id=241001)
  shows 04:00.0 is a downstream port, but vga_arbiter_add_pci_device() only
  prints that message for VGA class devices.

  https://bugzilla.kernel.org/attachment.cgi?id=240991, the successful
  dmesg log, shows "vgaarb: device added: PCI:0000:06:00.0".  That makes
  more sense because 06:00.0 is class 0300, which is a VGA device.

Bjorn
