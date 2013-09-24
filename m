Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40439 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752720Ab3IXOMa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2013 10:12:30 -0400
Date: Tue, 24 Sep 2013 10:12:29 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Andy Lutomirski <luto@amacapital.net>,
	USB list <linux-usb@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: ehci-pci D3cold logspam
In-Reply-To: <CAErSpo4SGnM4Ycy=YRbdMox2b0JE=P=J_1-7HpPMwEy+=rJDjQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1309241011520.1243-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 23 Sep 2013, Bjorn Helgaas wrote:

> d010e5769 ("PCI / ACPI: Use dev_dbg() instead of dev_info() in
> acpi_pci_set_power_state()") might be part of the solution.  That was
> done in response to https://bugzilla.kernel.org/show_bug.cgi?id=60636,
> which looks basically the same as your complaint.
> 
> But if we are indeed polling every two seconds, even a dev_dbg() seems
> like overkill to me.  Rafael or Lan can probably provide a better
> answer here.
> 
> As for the "setting latency timer" messages, I really doubt those are
> useful to anybody.  If nobody objects, I'll just drop it, e.g.:
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b821a62..55a947b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2854,7 +2854,7 @@ void __weak pcibios_set_master(struct pci_dev *dev)
>                 lat = pcibios_max_latency;
>         else
>                 return;
> -       dev_printk(KERN_DEBUG, &dev->dev, "setting latency timer to %d\n", lat);
> +
>         pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
>  }

No objection from me.

Alan Stern

