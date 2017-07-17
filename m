Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: host: pci_quirks: Force hard reset of Renesas
 uPD72020x USB controller
To: Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20170710155230.8622-1-marc.zyngier@arm.com>
 <20170710155230.8622-3-marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
From: Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <596CA772.2010603@intel.com>
Date: Mon, 17 Jul 2017 15:02:58 +0300
MIME-Version: 1.0
In-Reply-To: <20170710155230.8622-3-marc.zyngier@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10.07.2017 18:52, Marc Zyngier wrote:
> The Renesas uPD72020x XHCI controller seems to suffer from a
> really annoying bug, where it may retain some of its DMA programming
> across a XHCI reset, and despite the driver correctly programming new
> DMA addresses. This is visible if the device has been using 64bit DMA
> addresses, and is then switched to using 32bit DMA addresses. The top
> 32bits of the address (now zero) are ignored are replaced by the 32bit
> from the *previous* programming. Sticking with 64bit DMA always works,
> but doesn't seem very appropriate.
>
> A PCI reset of the device restores the normal functionnality, which
> is done at probe time. Unfortunately, this has to be done before
> any quirk has been discovered, hence the intrusive nature of the fix.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/usb/host/pci-quirks.c | 20 ++++++++++++++++++++
>   drivers/usb/host/pci-quirks.h |  1 +
>   drivers/usb/host/xhci-pci.c   |  7 +++++++
>   3 files changed, 28 insertions(+)
>

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
