Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0113.outbound.protection.outlook.com ([207.46.100.113]:23146
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933633AbcECRPC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2016 13:15:02 -0400
From: Jake Oshins <jakeo@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Hadden Hoppert <haddenh@microsoft.com>
Subject: RE: [PATCH [RFC]] PCI: hv: add explicit fencing to config space
 access
Date: Tue, 3 May 2016 16:59:08 +0000
Message-ID: <DM2PR0301MB12325E6997FCCA61E2522B97AB7A0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1462278120-7859-1-git-send-email-vkuznets@redhat.com>
In-Reply-To: <1462278120-7859-1-git-send-email-vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Vitaly Kuznetsov [mailto:vkuznets@redhat.com]
> Sent: Tuesday, May 3, 2016 5:22 AM
> To: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org; Bjorn
> Helgaas <bhelgaas@google.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Jake
> Oshins <jakeo@microsoft.com>
> Subject: [PATCH [RFC]] PCI: hv: add explicit fencing to config space access
> 
> I'm trying to pass-through Broadcom BCM5720 NIC (Dell Device 1f5b) on Dell
> R720 server. Everything works fine when target VM has only one CPU, but
> SMP guests reboot when NIC driver is trying to access PCI config space
> (with  hv_pcifront_read_config/hv_pcifront_write_config). The reboot
> appears to be induced by the hypervisor and no crash is observed. Windows
> event logs are not helpful at all ('Virtual machine ... has quit
> unexpectedly'). The particular access point is always different and
> putting debug between them (printk/mdelay/...) moves the issue further
> away. The server model affects the issue as well: on Dell R420 I'm able to
> pass-through BCM5720 NIC to SMP guests without issues.
> 
> While I'm obviously failing to reveal the essence of the issue I was able
> to come up with a (possible) solution: if explicit fencing is put to
> hv_pcifront_read_config/hv_pcifront_write_config the issue goes away. The
> essential minimum is rmb() at the end on _hv_pcifront_read_config() and
> wmb() at the end of _hv_pcifront_write_config() but I'm not confident it
> will be sufficient for all hardware. I suggest the following fencing:
> 1) wmb()/mb() between choosing the function and writing to its space.
> 2) mb() before releasing the spinlock in both _hv_pcifront_read_config()/
>    _hv_pcifront_write_config to ensure that consecutive reads/writes to
>   the space won't get re-ordered as drivers may count on that.
> Config space access is not supposed to be performance-critical so this
> explicit fencing is not supposed to bring any slowdown.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Acked-by: Jake Oshins <jakeo@microsoft.com>


> ---
>  drivers/pci/host/pci-hyperv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index c17e792..7e9b2de 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -553,6 +553,8 @@ static void _hv_pcifront_read_config(struct
> hv_pci_dev *hpdev, int where,
>  		spin_lock_irqsave(&hpdev->hbus->config_lock, flags);
>  		/* Choose the function to be read. (See comment above) */
>  		writel(hpdev->desc.win_slot.slot, hpdev->hbus->cfg_addr);
> +		/* Make sure the function was chosen before we start
> reading. */
> +		mb();
>  		/* Read from that function's config space. */
>  		switch (size) {
>  		case 1:
> @@ -565,6 +567,11 @@ static void _hv_pcifront_read_config(struct
> hv_pci_dev *hpdev, int where,
>  			*val = readl(addr);
>  			break;
>  		}
> +		/*
> +		 * Make sure the write was done before we release the
> spinlock
> +		 * allowing consecutive reads/writes.
> +		 */
> +		mb();
>  		spin_unlock_irqrestore(&hpdev->hbus->config_lock, flags);
>  	} else {
>  		dev_err(&hpdev->hbus->hdev->device,
> @@ -592,6 +599,8 @@ static void _hv_pcifront_write_config(struct
> hv_pci_dev *hpdev, int where,
>  		spin_lock_irqsave(&hpdev->hbus->config_lock, flags);
>  		/* Choose the function to be written. (See comment above)
> */
>  		writel(hpdev->desc.win_slot.slot, hpdev->hbus->cfg_addr);
> +		/* Make sure the function was chosen before we start
> writing. */
> +		wmb();
>  		/* Write to that function's config space. */
>  		switch (size) {
>  		case 1:
> @@ -604,6 +613,11 @@ static void _hv_pcifront_write_config(struct
> hv_pci_dev *hpdev, int where,
>  			writel(val, addr);
>  			break;
>  		}
> +		/*
> +		 * Make sure the write was done before we release the
> spinlock
> +		 * allowing consecutive reads/writes.
> +		 */
> +		mb();
>  		spin_unlock_irqrestore(&hpdev->hbus->config_lock, flags);
>  	} else {
>  		dev_err(&hpdev->hbus->hdev->device,
> --
> 2.5.5

I'm honestly not as familiar with gcc or the Linux kernel as I should be.  When I wrote this code, I assumed that the writel() and writeb() macros would guarantee ordering.  (The analogous macros in Windows kernel programming that I'm more familiar with do so.)  Now that I look at this, I see that it's mostly just a wrapper around a volatile declaration.  This is clearly my error, and the fixes above seem good to me.

While I was developing this driver, I saw the exact behavior that you're describing, where configuring the VM with multiple virtual processors caused it to reset.  I dug in and, like you, expected to find messages in the Hyper-V event log telling me why it decided to reset my VM.  There were none, because from Hyper-V's point of view, the VM had initiated its own reset, and in a manner that is not unexpected.  When I debugged it, the underlying sequence was that the device had been programmed to generate an interrupt using a certain IDT entry and afterward, something had triggered an interrupt reaffinitization, using a different IDT entry.  There was no code that reprogrammed the device, however.  The resulting unexpected interrupt triggered a triple fault and the guest (Linux) reset.  Triple faults are normal reboots in some situations, so no log was generated.

I fixed the problem by changing the way that the IRQ domain code in the driver was implemented.  hv_set_affinity() doesn't actually set the affinity, since the final IDT entry isn't yet known.  Instead, you'll see the code to do that in hv_irq_unmask().

Of course, the problem that you're seeing may have nothing to do with the problem that I was seeing.  But, if the ordering of writes wasn't respected as the MSI registers were being written through PCI config space, then you'd get the wrong values for the MSI, and you'd see the same results.  This seems like a plausible explanation.  It isn't, of course, a root cause analysis.

Thank you for spending time on this,
Jake Oshins

