Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:57911 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751820AbdAaSZ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jan 2017 13:25:29 -0500
From: Logan Gunthorpe <logang@deltatee.com>
To: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Wei Zhang <wzhang@fb.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 31 Jan 2017 10:03:23 -0700
Message-Id: <1485882204-26947-1-git-send-email-logang@deltatee.com>
Subject: [PATCH 0/1] DRAFT: New Microsemi PCI Switch Management Driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

This is a continuation of the RFC we posted lasted month [1] which
proposes a management driver for Microsemi's Switchtec line of PCI
switches. This hardware is still looking to be used in the Open
Compute Platform

To make this entirely clear: the Switchtec products are compliant
with the PCI specifications and are supported today with the standard
in-kernel driver. However, these devices also expose a management endpoint
on a separate PCI function address which can be used to perform some
advanced operations. This is a driver for that function. See the patch
for more information.

Since the RFC, we've made the changes requested by Greg Kroah-Hartman
and Keith Busch, and we've also fleshed out a number of features. We've
added a couple of IOCTLs and sysfs attributes which are documented in
the patch. Significant work has also been done on the userspace tool
which is available under a GPL license at [2]. We've also had testing
done by some of the interested parties.

We hope to see this work included in either 4.11 or 4.12 assuming a
smooth review process.

The patch is based off of the v4.9 release.

Thanks for your review,

Logan

[1] https://www.spinics.net/lists/linux-pci/msg56897.html
[2] https://github.com/sbates130272/switchtec-user

--

Changes since RFC:

* Fixed incorrect use of the drive model as pointed out by Greg
  Kroah-Hartman
* Used devm functions as suggested by Keith Busch
* Added a handful of sysfs attributes to the switchtec class
* Added a handful of IOCTLs to the switchtec device
* A number of miscelaneous bug fixes

--

Logan Gunthorpe (1):
  MicroSemi Switchtec management interface driver

 Documentation/ABI/testing/sysfs-class-switchtec |   96 ++
 Documentation/ioctl/ioctl-number.txt            |    1 +
 Documentation/switchtec.txt                     |   80 ++
 MAINTAINERS                                     |   11 +
 drivers/pci/Kconfig                             |    1 +
 drivers/pci/Makefile                            |    1 +
 drivers/pci/switch/Kconfig                      |   13 +
 drivers/pci/switch/Makefile                     |    1 +
 drivers/pci/switch/switchtec.c                  | 1320 +++++++++++++++++++++++
 drivers/pci/switch/switchtec.h                  |  266 +++++
 include/uapi/linux/switchtec_ioctl.h            |  129 +++
 11 files changed, 1919 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-switchtec
 create mode 100644 Documentation/switchtec.txt
 create mode 100644 drivers/pci/switch/Kconfig
 create mode 100644 drivers/pci/switch/Makefile
 create mode 100644 drivers/pci/switch/switchtec.c
 create mode 100644 drivers/pci/switch/switchtec.h
 create mode 100644 include/uapi/linux/switchtec_ioctl.h

--
2.1.4
