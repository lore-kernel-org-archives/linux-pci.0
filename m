Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36338 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbaFNVVP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jun 2014 17:21:15 -0400
Received: by mail-ie0-f172.google.com with SMTP id lx4so3674330iec.17
        for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2014 14:21:14 -0700 (PDT)
Subject: [PATCH RFC 0/4] PCI: pciehp: Fix Command Completion handling
To: Yinghai Lu <yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Rajat Jain <rajatxjain@gmail.com>, linux-pci@vger.kernel.org
Date: Sat, 14 Jun 2014 15:21:12 -0600
Message-ID: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <CAE9FiQUbw7OUhRB+gKMxkuE9+nm9097+mwZ2z4adO8Hv_NjF1Q@mail.gmail.com>
References: <CAE9FiQUbw7OUhRB+gKMxkuE9+nm9097+mwZ2z4adO8Hv_NjF1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yinghai has been working on pciehp timeouts related to a hardware
erratum in Intel, AMD, and Nvidia hotplug controllers.  This affects
the way we wait for command completion on those controllers.

I had some suggestions about how to change pciehp to make this work
better in general, without having to check for specific vendors.  We
need something that works well on hardware that conforms to the spec,
as well as the stuff that doesn't.

I haven't heard anything for a while, so I wrote up these patches to
make my proposals concrete.  Unfortunately, I can't easily test any of
this, so I'm posting these for comment and possible testing if anybody
is ambitious.

The Intel erratum is CF118, described here:
http://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html
---

Bjorn Helgaas (4):
      PCI: pciehp: Make pcie_wait_cmd() self-contained
      PCI: pciehp: Wait for hotplug command completion lazily
      PCI: pciehp: Compute timeout from hotplug command start time
      PCI: pciehp: Remove assumptions about which commands cause completion events


 drivers/pci/hotplug/pciehp.h     |    2 +
 drivers/pci/hotplug/pciehp_hpc.c |   91 +++++++++++++++++---------------------
 2 files changed, 42 insertions(+), 51 deletions(-)
