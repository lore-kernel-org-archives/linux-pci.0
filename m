Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0114.outbound.protection.outlook.com ([157.56.110.114]:34313
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751038AbaJaDMk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 23:12:40 -0400
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Jason Chang <jason.chang@amd.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Huang Rui <ray.huang@amd.com>
Subject: [PATCH v5 0/8] usb: dwc3: add support for AMD Nolan SoC
Date: Fri, 31 Oct 2014 11:11:11 +0800
Message-ID: <1414725079-11490-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

The series of patches add AMD Nolan (NL) SoC support for DesignWare USB3
OTG IP with PCI bus glue layer. This controller supported hibernation, LPM
erratum and used the 2.80a IP version and amd own phy. Current
implementation support both simulation and SoC platform. And already tested
with gadget zero and msc tool. It works well on file storage gadget.


These patches are rebased on balbi/testing/next, and only send the rest
ones which are not applied.

Changes from v4 -> v5
- Rebase rest ones which are not applied on testing/next.
- Fix some typos.
- Add comments of hibernation patch.

Changes from v3 -> v4
- Add comment on hibernation patch
- Fix typos of commit log and comments
- Remove WARN_ON for temporary solution of FPGA board
- Rename tx deemph to tx de-emphasis
- Add documentation under Documentation/devicetree/bindings/usb/dwc3.txt
- Check FPGA flag on usb3 and usb2 suspend phy quirk
- Refine description of PCI quirk patch
- Remove amd_nl_plat flag at dwc3 structure
- Make HIRD threshold configurable

Changes from v2 -> v3
- Confirmed these quirks will be needed in product level
- Move AMD configuration patch to the last one with all quirk flags
- Make all quirks as 1-bit field instead of single-bits on a 32-bit
  variable
- Add all quirks DeviceTree counterparts
- Make LPM erratum configurable
- Add PCI ID into pci_ids.h because it will be used both on PCI and DWC3
  device driver.

Changes from v1 -> v2
- Remove dual role function temporarily
- Add pci quirk to avoid to bind with xhci driver
- Distinguish between simulation board and soc
- Break down all the special quirks


Thanks,
Rui

Huang Rui (8):
  usb: dwc3: add Tx de-emphasis quirk
  usb: dwc3: add disable usb3 suspend phy quirk
  usb: dwc3: add disable usb2 suspend phy quirk
  PCI: Add support for AMD Nolan USB3 DRD
  PCI: Prevent xHCI driver from claiming AMD Nolan USB3 DRD device
  usb: dwc3: add support for AMD Nolan platform
  usb: dwc3: make HIRD threshold configurable
  usb: dwc3: point host-mode hibernation enablement not device-mode

 Documentation/devicetree/bindings/usb/dwc3.txt |  8 ++++
 drivers/pci/quirks.c                           | 20 ++++++++++
 drivers/usb/dwc3/core.c                        | 53 +++++++++++++++++++++++++-
 drivers/usb/dwc3/core.h                        | 21 ++++++++++
 drivers/usb/dwc3/dwc3-pci.c                    | 26 +++++++++++++
 drivers/usb/dwc3/gadget.c                      |  8 +---
 drivers/usb/dwc3/platform_data.h               |  8 ++++
 include/linux/pci_ids.h                        |  1 +
 8 files changed, 138 insertions(+), 7 deletions(-)

-- 
1.9.1

