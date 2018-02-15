Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033088AbeBOPSB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Feb 2018 10:18:01 -0500
Subject: [PATCH v1 0/2] PCI: Sparc 64-bit resource fixups
From: Bjorn Helgaas <helgaas@kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org
Date: Thu, 15 Feb 2018 09:17:58 -0600
Message-ID: <20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm trying to make some progress on this old series from Yinghai [1].
There's a lot more to do than just these first two patches, but maybe a
tiny bit of incremental progress is better than none.

The first patch ("Support arbitrary host bridge address offset") is
unchanged from Yinghai's posting except for the changelog.

I'm interested in feedback about the second ("Reserve System ROM and Video
ROM") patch because it changes something that *looks* wrong to me, but I
don't know anything about the Sparc address map.

If this is on the right track, I'd like to merge these via my PCI tree in
the hope that I can include more of Yinghai's patches as well.

[1] https://lkml.kernel.org/r/20170421050500.13957-1-yinghai@kernel.org

---

Bjorn Helgaas (1):
      sparc/PCI: Reserve System ROM and Video ROM outside of PCI space

Yinghai Lu (1):
      sparc/PCI: Support arbitrary host bridge address offset


 arch/sparc/kernel/pci.c        |    6 ++--
 arch/sparc/kernel/pci_common.c |   54 +++++++++++++++++++---------------------
 arch/sparc/kernel/pci_impl.h   |    4 +++
 arch/sparc/mm/init_64.c        |   17 +++++++++++++
 4 files changed, 50 insertions(+), 31 deletions(-)
