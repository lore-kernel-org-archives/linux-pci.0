Return-Path: <SRS0=8RdT=A3=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=8RdT=A3=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jork Loeser <jloeser@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] ACPI / PCI: Bail early in acpi_pci_add_bus() if there is no ACPI handle
Date: Tue, 26 Sep 2017 22:21:38 +0200
Message-ID: <2811281.qHMMmbt7BC@aspire.rjw.lan>
In-Reply-To: <20170926202508.GQ15970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170914145014.2834-1-vkuznets@redhat.com> <20170926202508.GQ15970@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, September 26, 2017 10:25:08 PM CEST Bjorn Helgaas wrote:
> On Thu, Sep 14, 2017 at 04:50:14PM +0200, Vitaly Kuznetsov wrote:
> > Hyper-V instances support PCI pass-through which is implemented through
> > PV pci-hyperv driver. When a device is passed through a new root PCI bus
> > is created in the guest. The bus sits on top of VMBus and has no
> > associated information in ACPI. acpi_pci_add_bus() in this case proceeds
> > all the way to acpi_evaluate_dsm() with reports
> > 
> >     ACPI: \: failed to evaluate _DSM (0x1001)
> > 
> > While acpi_pci_slot_enumerate() and acpiphp_enumerate_slots() are protected
> > against ACPI_HANDLE() being NULL and do nothing acpi_evaluate_dsm() is not
> > and gives us the error. It seems the correct fix is to not do anything in
> > acpi_pci_add_bus() in such cases.
> > 
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Applied to pci/acpi for v4.15, thanks!
> 
> Rafael, let me know if you have any objections or if you'd rather take
> it yourself.

No objections, all is fine.

Thanks,
Rafael
