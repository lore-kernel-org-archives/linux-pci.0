Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0127.outbound.protection.outlook.com ([207.46.100.127]:34304
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750786AbaJ1MoC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Oct 2014 08:44:02 -0400
Date: Tue, 28 Oct 2014 20:15:17 +0800
From: Huang Rui <ray.huang@amd.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jason Chang <jason.chang@amd.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 18/19] PCI: Add quirk to prevent AMD NL USB3 DRD to
 bind with xHCI driver
Message-ID: <20141028121516.GA3208@hr-slim.amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
 <1414497280-3126-19-git-send-email-ray.huang@amd.com>
 <544F86C7.3060100@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <544F86C7.3060100@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 28, 2014 at 03:06:31PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 10/28/2014 2:54 PM, Huang Rui wrote:
> 
> >The AMD Nolan (NL) SoC contains a DesignWare USB3 Dual-Role Device that can
> >be operated either as a USB Host or a USB Device.  In the AMD NL platform,
> >this device ([1022:7912]) has a class code of PCI_CLASS_SERIAL_USB_XHCI
> >(0x0c0330), which means the xhci driver will claim it.
> 
> >But the dwc3 driver is a more specific driver for this device, and we'd
> >prefer to use it instead of xhci.  To prevent xhci from claiming the
> >device, change the class code to 0x0c03fe, which the PCI r3.0 spec defines
> >as "USB device (not host controller)".  The dwc3 driver can then claim it
> >based on its Vendor and Device ID.
> 
> >Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >Cc: Bjorn Helgaas <bhelgaas@google.com>
> >Cc: Jason Chang <jason.chang@amd.com>
> >Signed-off-by: Huang Rui <ray.huang@amd.com>
> >---
> >  drivers/pci/quirks.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> 
> >diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >index 90acb32..1152bef 100644
> >--- a/drivers/pci/quirks.c
> >+++ b/drivers/pci/quirks.c
> >@@ -379,6 +379,26 @@ static void quirk_ati_exploding_mce(struct pci_dev *dev)
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
> >
> >  /*
> >+ * In the AMD NL platform, this device ([1022:7912]) has a class code of
> >+ * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
> >+ * claim it.
> >+ * But the dwc3 driver is a more specific driver for this device, and we'd
> >+ * prefer to use it instead of xhci. To prevent xhci from claiming the
> >+ * device, change the class code to 0x0c03fe, which the PCI r3.0 spec
> >+ * defines as "USB device (not host controller)". The dwc3 driver can then
> >+ * claim it based on its Vendor and Device ID.
> >+ */
> >+static void quirk_amd_nl_class(struct pci_dev *pdev)
> >+{
> >+	/*
> >+	 * Use 'USB Device' (0x0x03fe) instead of PCI header provided
> 
>     0x0c03fe, you mean?

Yes. That's a typo, 'USB Device' class code should be 0x0c03fe, will
update.

> 
> >+	 */
> >+	pdev->class = 0x0c03fe;
> >+}
> >+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
> 
>    I'm not sure it was a good idea to declare the ID in pci_ids.h --
> it's been long discouraged.
> 

You're right. But PCI_DEVICE_ID_AMD_NL_USB will be used on two
drivers(pci and dwc3). It also might be used for identifying AMD NL
chip for another drivers in future.

Thanks,
Rui
