Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:21231 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932210AbdCIPmW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2017 10:42:22 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "agraf@suse.de" <agraf@suse.de>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: [QUESTION]: Same IO bus address in different _CRS methods
Date: Thu, 9 Mar 2017 15:41:03 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E2046C6AC@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn and all

I have a question regarding bus addresses for IO resources in the ACPI table.

The question is if from an ACPI perspective it is legal to have two entries in
separate _CRS methods using the same IO bus address.

As an example please see the code at the bottom: we have the same bus address
starting at 0x0 with (obviously) different offsets leading to different CPU
physical addresses. Is this legal?

p.s. full DSDT is here:
https://git.linaro.org/people/heyi.guo/OpenPlatformPkg.git/tree/Chips/Hisilicon/Hi1610/Hi1610AcpiTables/Dsdt/D03Pci.asl?h=estuary-rp

Many thanks
Gab

----

  Device (PCI0)
  {
    Name (_HID, "HISI0080") // PCI Express Root Bridge
    Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
    Name(_SEG, 0) // Segment of this Root complex
    Name(_BBN, 0) // Base Bus Number
    Name(_CCA, 1)
    Method (_CRS, 0, Serialized) { // Root complex resources

[...]

        QWordIO (
          ResourceProducer,
          MinFixed,
          MaxFixed,
          PosDecode,
          EntireRange,
          0x0, // Granularity
          0x0, // Min Base Address
          0xffff, // Max Base Address
          0xb7ff0000, // Translate
          0x10000 // Length
        )
      }) // Name(RBUF)
      Return (RBUF)
    } // Method(_CRS)


// PCIe Root bus
  Device (PCI1)
  {
    Name (_HID, "HISI0080") // PCI Express Root Bridge
    Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
    Name(_SEG, 1) // Segment of this Root complex
    Name(_BBN, 0xe0) // Base Bus Number
    Name(_CCA, 1)
    Method (_CRS, 0, Serialized) { // Root complex resources

[...]

        QWordIO (
          ResourceProducer,
          MinFixed,
          MaxFixed,
          PosDecode,
          EntireRange,
          0x0, // Granularity
          0x0, // Min Base Address
          0xffff, // Max Base Address
          0xbdff0000, // Translate
          0x10000 // Length
        )
      }) // Name(RBUF)
      Return (RBUF)
    } // Method(_CRS)
