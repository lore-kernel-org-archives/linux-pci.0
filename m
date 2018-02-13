Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:26205
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751682AbeBMGXY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Feb 2018 01:23:24 -0500
Date: Mon, 12 Feb 2018 22:23:10 -0800
From: Jayachandran C <jnair@caviumnetworks.com>
To: George Cherian <george.cherian@cavium.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Message-ID: <20180213062244.GA4198@jc-sabre>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 02, 2018 at 07:00:46AM +0000, George Cherian wrote:
> The PCIe Controller on Cavium ThunderX2 processors does not
> respond to downstream CFG/ECFG cycles when root port is
> in power management D3-hot state.
> 
> In our tests the above mentioned errata causes the following crash when
> the downstream endpoint config space is accessed, while root port is in
> D3 state.
> 
> [   12.775202] Unhandled fault: synchronous external abort (0x96000610) at 0x0000000000000000
> [   12.783453] Internal error: : 96000610 [#1] SMP
> [   12.787971] Modules linked in: aes_neon_blk ablk_helper cryptd
> [   12.793799] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.8.0-32-generic #34
> [   12.800659] Hardware name: Cavium Inc. Unknown/Unknown, BIOS 1.0 01/01/2018
> [   12.807607] task: ffff808f346b8d80 task.stack: ffff808f346b4000
> [   12.813518] PC is at pci_generic_config_read+0x5c/0xf0
> [   12.818643] LR is at pci_generic_config_read+0x48/0xf0
> [   12.823767] pc : [<ffff000008506f34>] lr : [<ffff000008506f20>] pstate: 204000c9
> [   12.831148] sp : ffff808f346b7bf0
> [   12.834449] x29: ffff808f346b7bf0 x28: ffff000008e2b848
> [   12.839750] x27: ffff000008dc3070 x26: ffff000008d516c0
> [   12.845050] x25: 0000000000000040 x24: ffff00000937a480
> [   12.850351] x23: 000000000000006c x22: 0000000000000000
> [   12.855651] x21: ffff808f346b7c84 x20: 0000000000000004
> [   12.860951] x19: ffff808f31076000 x18: 0000000000000000
> [   12.866251] x17: 000000001b3613e6 x16: 000000007f330457
> [   12.871551] x15: 0000000067268ad7 x14: 000000005c6254ac
> [   12.876851] x13: 00000000f1e100cb x12: 0000000000000030
> [   12.882151] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> [   12.887452] x9 : ff656d6e626d686f x8 : 7f7f7f7f7f7f7f7f
> [   12.892752] x7 : ffff808f310da108 x6 : 0000000000000000
> [   12.898052] x5 : 0000000000000003 x4 : ffff808f3107a800
> [   12.903352] x3 : 000000000030006c x2 : 0000000000000014
> [   12.908652] x1 : ffff000020000000 x0 : ffff00002030006c
> [   12.913952]
> [   12.915431] Process swapper/0 (pid: 1, stack limit = 0xffff808f346b4020)
> [   12.922118] Stack: (0xffff808f346b7bf0 to 0xffff808f346b8000)
> [   12.927850] 7be0:                                   ffff808f346b7c30 ffff000008506e2c
[...]
> [   13.269819] [<ffff000008506f34>] pci_generic_config_read+0x5c/0xf0
> [   13.275987] [<ffff000008506e2c>] pci_bus_read_config_dword+0xb4/0xd8
> [   13.282328] [<ffff0000085089f4>] pcie_capability_read_dword+0x64/0xb8
> [   13.288757] [<ffff000008513d28>] __pci_dev_reset+0x90/0x328
> [   13.294317] [<ffff0000085142d4>] pci_probe_reset_function+0x24/0x30
> [   13.300571] [<ffff000008518754>] pci_create_sysfs_dev_files+0x18c/0x2a0
> [   13.307173] [<ffff000008d9a974>] pci_sysfs_init+0x38/0x60
> [   13.312560] [<ffff000008083b4c>] do_one_initcall+0x5c/0x170
> [   13.318122] [<ffff000008d60dfc>] kernel_init_freeable+0x1c0/0x27c
> [   13.324205] [<ffff000008980d90>] kernel_init+0x18/0x110
> [   13.329416] [<ffff000008083690>] ret_from_fork+0x10/0x40
> [   13.334716] Code: 7100069f 540003c0 71000a9f 54000240 (b9400001)
> [   13.340805] ---[ end trace fc992038acd29ec3 ]---
> 
> Fix this by adding a quirk that prevents the root port from 
> entering D3 state. This is seen on both Ax/Bx variants of the processor.
> 
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 10684b1..2eb08a8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1154,6 +1154,18 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
>  
>  /*
> + * Cavium's Thunder-X2 Processors root port doesnot handle cfg/ecfg access to
> + * downstream properly if root port is put into D3
> + */

This comment can be fixed up a bit.

> +
> +static void quirk_no_rootport_d3(struct pci_dev *pdev)
> +{
> +	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM, 0x9084, quirk_no_rootport_d3);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xaf84, quirk_no_rootport_d3);
> +
> +/*
>   * Some ATA devices break if put into D3
>   */

Bjorn, if you need an ack for ThunderX2:
Acked-by: Jayachandran C <jnair@caviumnetworks.com>

This fixes the crash seen on ThunderX2 with a few PCI cards. We had worked
around the crash earlier by passing "pcie_port_pm=off" on kernel command line.

JC.
