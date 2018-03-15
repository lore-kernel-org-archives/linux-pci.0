Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-hk2apc01on0137.outbound.protection.outlook.com ([104.47.124.137]:6114
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751873AbeCOOU7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Mar 2018 10:20:59 -0400
From: Dexuan Cui <decui@microsoft.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH v4 0/2] PCI: hv: Fix some real issues
Date: Thu, 15 Mar 2018 14:20:35 +0000
Message-ID: <KL1P15301MB00063BF6E1FA30CAF7BE9A7BBFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The 2 patches should go in v4.16.

They should go in old stable kernels too, especially this one should go in
v4.15:
  PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()
Otherwise, a UP v4.15 VM can 100% hang when we pass through a VF
to the VM that runs on Hyper-V.

There is no code change since v3:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1628496.html

I just split the original 6 patches to 2 series, and this is series 1.

I fixed the order of Signed-off-by/Tested-by/Cc, etc., and added a Fixes:
tag, and fixed the other format issues in changelog. I hope I didn't omit
anything this time. :-)

Dexuan Cui (2):
  PCI: hv: Serialize the present and eject work items
  PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()

 drivers/pci/host/pci-hyperv.c | 75 +++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 71 insertions(+), 4 deletions(-)

--=20
2.7.4
