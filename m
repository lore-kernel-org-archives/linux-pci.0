Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:57820 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752296AbcLQRpc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Dec 2016 12:45:32 -0500
From: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Date: Sat, 17 Dec 2016 10:09:21 -0700
Message-Id: <1481994562-9283-1-git-send-email-logang@deltatee.com>
Subject: [RFC 0/1] New PCI Switch Management Driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

[Appologies: this is a resend for some people. Due to a configuration
error the original email was rejected by the mailing lists. I hope
this one makes it!]

We're looking to get some initial feedback on a new driver for
a line of PCIe switches produced and produced and sold by Microsemi.
The goal is to get the process moving to get this code included in
upstream hopefully for 4.11. Facebook is currently gearing up to
use this hardware in its Open Compute Platform and is pushing to
have this driver in the upstream kernel.

The following patch briefly describes the hardware and provides
the first draft of driver code. Currently, the driver works and
has been tested but is not feature complete. Thus, we are not looking
to get it merged immediately. However we would like some early review,
specifically on the interfaces and core concepts so that we don't
do a lot of work down a path the community would reject. Barring any
objections to this RFC, we will flesh out all the features
and provide a completed patch for inclusion in the coming weeks.

Work on a userspace tool, that utilizes this driver, is also being
done at [1]. The tool is currently also a bit of a skeleton and
will be fleshed out assuming there are no serious objections to our
userspace interface. In the end, the tool will be released with a
GPL license.

The patch is based off of the v4.9 release.

Thanks for your review,

Logan

[1] https://github.com/sbates130272/switchtec-user

Logan Gunthorpe (1):
  MicroSemi Switchtec management interface driver

 Documentation/switchtec.txt    |  54 +++
 MAINTAINERS                    |   9 +
 drivers/pci/Kconfig            |   1 +
 drivers/pci/Makefile           |   1 +
 drivers/pci/switch/Kconfig     |  13 +
 drivers/pci/switch/Makefile    |   1 +
 drivers/pci/switch/switchtec.c | 824 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/switch/switchtec.h | 119 ++++++
 8 files changed, 1022 insertions(+)
 create mode 100644 Documentation/switchtec.txt
 create mode 100644 drivers/pci/switch/Kconfig
 create mode 100644 drivers/pci/switch/Makefile
 create mode 100644 drivers/pci/switch/switchtec.c
 create mode 100644 drivers/pci/switch/switchtec.h

--
2.1.4
