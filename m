Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:12104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbeILU1r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Sep 2018 16:27:47 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <bhelgaas@google.com>
CC: <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/1] PCI: support numa node specification on a per device basis.
Date: Wed, 12 Sep 2018 16:21:39 +0100
Message-ID: <20180912152140.3676-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ACPI specification allows individual PCI devices to be associated
with proximity domains that may or may not be the same as the host bridge
below which they are attached.   This is done with the _PXM method.
Unfortunately Linux doesn't take any notice of this as it would normally
be done during the device_add but that stage the ACPI firmware node
is not yet associated with the device as this is not done until the
call to acpi_pci_find_companion which is called form acpi_platform_notify
only after the device_add.

The easiest place to make this association seems to be pci_acpi_setup,
but there are lots of alternative possibilities.

Jonathan Cameron (1):
  pci: Pick up the acpi numa node value if it is specified at the device
    level.

 drivers/pci/pci-acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.18.0
