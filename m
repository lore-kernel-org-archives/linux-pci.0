Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36868 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbJCSMj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 3 Oct 2015 14:12:39 -0400
Date: Sat, 3 Oct 2015 19:12:28 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/9] Further mvebu PCIe patches
Message-ID: <20151003181228.GI21513@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jason, Thomas,

Here are further PCIe patches which follow on from the previous set of
six I sent earlier in September.  This set:

* Separates the DT parsing from the use of this parsed data.
* Fixes memory leaks from kasprintf() and refcount leaks of the DT
  node where we break out from the loop early.
* Uses gpio_set_value_cansleep() so that GPIOs on I2C expanders can
  be used for the PCIe reset functionality.
* Switch to using devm_kcalloc() instead of devm_kzalloc(), which
  eliminates the multiplication, moving it into core code.
* Switch to using a gpio descriptor for the reset gpio, which can
  contain the active level information from DT.  (It would be nice
  if gpiolib automated some of the resource claiming there.)
* Make PERST# vs clock timing to match PCIe specifications.  PCIe
  specs require the clock to be running for 100us prior to releasing
  reset.
* Add the standard PCIe capability block in root port form to the
  emulated PCIe configuration block.  This allows the PCI layer to
  identify the "host bridge" as a PCIe device, and allows us to
  take advantage of the code in drivers/pci/pcie, particularly
  aspm for link power management.
* As a result of identifying ourselves as a PCIe root port, this
  eliminates the need to special case accesses to non-slot 0 in
  the driver; the lack of other "slots" is something which the
  generic PCI code knows about for PCIe root ports.

 drivers/pci/host/pci-mvebu.c | 404 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 305 insertions(+), 99 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
