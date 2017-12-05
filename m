Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752283AbdLEROn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Dec 2017 12:14:43 -0500
Date: Tue, 5 Dec 2017 11:14:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: mathias.nyman@intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Lee <asmt.swfae@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] xhci: Fix front USB ports on ASUS PRIME B350M-A
Message-ID: <20171205171440.GA23510@bhelgaas-glaptop.roam.corp.google.com>
References: <20171205162242.4057-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171205162242.4057-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, linux-pm]

On Wed, Dec 06, 2017 at 12:22:42AM +0800, Kai-Heng Feng wrote:
> The board in question has three XHCI HCs:
> 02:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] USB 3.1 XHCI Controller [1022:43bb] (rev 02)
> 04:00.0 USB controller [0c03]: ASMedia Technology Inc. Device [1b21:1343]
> 0a:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] USB3 Host Controller [1022:145c]
> 
> The front ports are connected to HC [1022:43bb] (02:00.0).
> 
> After plugging high speed devices into front ports several times, it
> stops responding to high speed devices. Super speed devices can still
> get detected though.
> 
> When I plugged a high speed device, [1b21:1343] (04:00.0) also got woke
> up:
> [  140.834823] xhci_hcd 0000:02:00.0: // Setting command ring address to 0xff73b001
> [  140.838220] xhci_hcd 0000:02:00.0: xhci_resume: starting port polling.
> [  140.838226] xhci_hcd 0000:02:00.0: xhci_hub_status_data: stopping port polling.
> [  140.838266] xhci_hcd 0000:02:00.0: xhci_suspend: stopping port polling.
> [  140.838362] xhci_hcd 0000:02:00.0: // Setting command ring address to 0xff73b001
> [  140.858908] xhci_hcd 0000:04:00.0: // Setting command ring address to 0xfffd9001
> [  140.862745] xhci_hcd 0000:04:00.0: xhci_resume: starting port polling.
> [  140.862754] xhci_hcd 0000:04:00.0: xhci_hub_status_data: stopping port polling.
> [  140.862760] xhci_hcd 0000:04:00.0: xhci_hub_status_data: stopping port polling.
> [  140.862787] xhci_hcd 0000:04:00.0: xhci_suspend: stopping port polling.
> [  140.862811] xhci_hcd 0000:04:00.0: // Setting command ring address to 0xfffd9001
> 
> Seems like [1022:43bb] is wired to [1b21:1343] internally.
> 
> Both HCs support D3hot PME, so I tried to disable D3cold on them.
> Turns out disable D3cold on [1b21:1343] (04:00.0) can workaround the
> issue for [1022:43bb] (02:00.0).
> 
> Also, [1022:43bb] (02:00.0) sometimes failed to suspend:
> [  549.114587] xhci_hcd 0000:02:00.0: WARN: xHC CMD_RUN timeout
> [  549.114608] suspend_common(): xhci_pci_suspend+0x0/0xc0 returns -110
> [  549.114638] xhci_hcd 0000:02:00.0: can't suspend (hcd_pci_runtime_suspend returned -110)
> [  549.116744] usb usb3: root hub lost power or was reset
> [  549.116746] usb usb4: root hub lost power or was reset
> 
> Based on previous guesswork, the issue can be workaround by doing PCI
> reset on [1b21:1343] (04:00.0).

Naive questions: Does this indicate that xhci_hcd is lacking something
in the "resume from D3cold" path?  Is there a bugzilla for this?  If
not, can you open one and attach the complete dmesg log and complete
"lspci -vv" output (as root)?  Google found some possibly related
issues but I can't quite tie them together yet.

I don't have an issue with the quirk per se, but in general I think
it's better to debug an issue than simply avoid it.

> Cc: Joe Lee <asmt.swfae@gmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/quirks.c          | 2 ++
>  drivers/usb/host/pci-quirks.c | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 10684b17d0bd..380061dae51d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1699,6 +1699,8 @@ static void quirk_radeon_pm(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
>  
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1343, pci_d3cold_disable);
> +
>  #ifdef CONFIG_X86_IO_APIC
>  static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
>  {
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 161536717025..8c4318671e37 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1176,6 +1176,9 @@ bool usb_xhci_needs_pci_reset(struct pci_dev *pdev)
>  	    (pdev->device == 0x0014 || pdev->device == 0x0015))
>  		return true;
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1343)
> +		return true;
> +
>  	return false;
>  }
>  EXPORT_SYMBOL_GPL(usb_xhci_needs_pci_reset);
> -- 
> 2.14.1
> 
