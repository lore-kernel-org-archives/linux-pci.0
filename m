Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Mar 2015 18:02:11 +0100
From: Greg KH <greg@kroah.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>
Subject: Re: [PATCH v3 00/10] pci: fix unhandled interrupt on shutdown
Message-ID: <20150324170211.GA1989@kroah.com>
References: <1427211032-2270-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427211032-2270-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 24, 2015 at 04:42:25PM +0100, Michael S. Tsirkin wrote:
> Fam Zheng noticed that pci shutdown disables msi and msix of a device while
> device is still active. This was intended to fix kexec with fusion devices but
> had the unintended effect of breaking even regular shutdown when using virtio.
> 
> As a result, people reported VMs being hung on shutdown,
> with traces that look like this:
> 
> ...
> 
>   [<ffffffff815f367b>] ? _raw_spin_unlock_irqrestore+0x1b/0x40
>   [<ffffffff812e068f>] pci_bus_read_config_word+0x9f/0xb0
>   [<ffffffff812e205c>] pci_read_config_word+0x1c/0x20
>   [<ffffffff812e5ea3>] pci_intx+0x33/0xb0
>   [<ffffffff81304ddd>] pci_msix_shutdown+0x8d/0x90
>   [<ffffffff812ead26>] pci_device_shutdown+0x46/0x60
>   [<ffffffff813b4258>] device_shutdown+0xc8/0x180
>   [<ffffffff810761c5>] kernel_power_off+0x35/0x80
>   [<ffffffff81077ceb>] SYSC_reboot+0x18b/0x260
>   [<ffffffff811c5bb5>] ? d_free+0x55/0x60
>   [<ffffffff811cf414>] ? mntput+0x24/0x40
>   [<ffffffff811b1613>] ? __fput+0x183/0x270
>   [<ffffffff81077dee>] SyS_reboot+0xe/0x10
>   [<ffffffff815fc819>] system_call_fastpath+0x16/0x1b
> 
> ...
> 
> as well as the messages that look like this:
> BUG: soft lockup - CPU#2 stuck for 22s!  [poweroff:1964]
> 
> The same problem would affect any driver which doesn't register
> a level interrupt handler when using msix.
> 
> I think the fix is to avoid touching device on shutdown:
> we clear bus master anyway, so we won't get any more
> msi interrupts, and bus reset will clear the msi/msix
> state eventually.
> 
> The patch that added the code in question is from
> 	d52877c7b1afb8c37ebe17e2005040b79cb618b0:
>         "pci/irq: let pci_device_shutdown to call pci_msi_shutdown v2"
> from 2008, but it turns out that in 2011 the following commit
>     commit d5dea7d95c48d7bc951cee4910a7fd9c0cd26fb0
>         "PCI: msi: Disable msi interrupts when we initialize a pci device"
> fixed the issue in a more robust way.  The only thing left to do is to
> fix configurations with CONFIG_PCI_MSI disabled, and then
> d52877c7b1afb8c37ebe17e2005040b79cb618b0 can be reverted.
> 
> Status:
> 
> Patches 1-6 work well for me.
> Given they affect all pci devices, and the bug has been there since 2.6 times,
> I think there's no rush: we can merge them for 4.1.
> 
> At the same time, once merged, patches 1-4 will likely make a good stable
> candidate.
> 
> Patches 7-10 compiled only, will need maintainer ack.
> 
> Please review, and consider at least 1-6 for 4.1.
> 
> Changes from v3:
> 	move code from probe to device enumeration
> 	add patches to unexport pci_msi_off
> 
> Michael S. Tsirkin (10):
>   pci: export functions for msi/msix ctrl
>   pci: move pci_msi_init_pci_dev to pci.c
>   pci: drop some duplicate code
>   pci: don't disable msi/msix at shutdown
>   pci: make msi/msix shutdown functions static
>   virtio_pci: drop msi_off on probe
>   ntb: drop pci_msi_off call on probe
>   mic: drop pci_msi_off call on probe
>   pci: drop pci_msi_off calls from quirks
>   pci: unexport pci_msi_off
> 
>  drivers/pci/pci.h                  | 25 +++++++++++++--
>  include/linux/pci.h                |  5 ---
>  drivers/misc/mic/host/mic_intr.c   |  2 --
>  drivers/ntb/ntb_hw.c               |  2 --
>  drivers/pci/msi.c                  | 62 ++++++++------------------------------
>  drivers/pci/pci-driver.c           |  2 --
>  drivers/pci/pci.c                  | 26 ++++------------
>  drivers/pci/probe.c                | 16 ++++++++++
>  drivers/pci/quirks.c               |  2 --
>  drivers/virtio/virtio_pci_common.c |  3 --
>  10 files changed, 57 insertions(+), 88 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
