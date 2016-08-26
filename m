Return-Path: <lftan.linux@gmail.com>
Return-Path: <lftan.linux@gmail.com>
MIME-Version: 1.0
Sender: lftan.linux@gmail.com
In-Reply-To: <20160825135650.GB11257@localhost>
References: <1472104796-20737-1-git-send-email-lftan@altera.com> <20160825135650.GB11257@localhost>
From: Ley Foon Tan <lftan@altera.com>
Date: Fri, 26 Aug 2016 08:42:53 +0800
Message-ID: <CAFiDJ5_-HwgH+SBap+akHmtCG8GF8KuXWfsbULuk5xMFqCWO5g@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: altera: Retrain link in rootport mode only
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 25, 2016 at 9:56 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Aug 25, 2016 at 01:59:56PM +0800, Ley Foon Tan wrote:
>> Altera PCIe IP can be configured as rootport or device and they might have
>> same vendor ID. It will cause the system hang issue if Altera PCIe is in
>> endpoint mode and work with other PCIe rootport that from other vendors.
>> Moved retrain function to before pci_scan_root_bus and removed _FIXUP.
>> Add _altera_pcie_cfg_read() and _altera_pcie_cfg_write() to use struct
>> altera_pcie as argument instead of struct pci_bus.
>
> I think this makes sense.  Can you split this into two patches:
>
>   - Rework the config accessors
>   - Move retrain from the quirk to altera_pcie_host_init()
Okay, will resend this.
Thanks.

> I also want to look through the other host bridge drivers and see if
> there's any consistency in naming and structure of the config accessors.
> The pattern of a wrapper that takes "struct pci_bus *, unsigned int devfn,
> ..." that calls an internal function that takes the driver structure
> instead of the "struct pci_bus *" might be useful in other drivers as well.
