Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-hk2apc01on0139.outbound.protection.outlook.com ([104.47.124.139]:63328
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750782AbeCFSVw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Mar 2018 13:21:52 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 0/6] some fixes to the pci-hyperv driver.
Date: Tue, 6 Mar 2018 18:21:45 +0000
Message-ID: <20180306182128.23281-1-decui@microsoft.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes in v2 are:

Patch 1, 6: no change since v1.
Patch 2,4,5: I added these new patches, as suggested by Michael Kelley.
Patch 3: Removed the unnecessary drain_workqueue(), as suggested by Michael=
 Kelley.

Changes in v3 are:

Patch 5: minimized the scope of the spinlock, as suggested by Michael Kelle=
y.

Dexuan Cui (6):
  PCI: hv: fix a comment typo in _hv_pcifront_read_config()
  PCI: hv: hv_eject_device_work(): remove the bogus test
  PCI: hv: serialize the present/eject work items
  PCI: hv: remove hbus->enum_sem
  PCI: hv: hv_pci_devices_present(): only queue a new work when
    necessary
  PCI: hv: fix 2 hang issues in hv_compose_msi_msg()

 drivers/pci/host/pci-hyperv.c | 116 ++++++++++++++++++++++++++++++++------=
----
 1 file changed, 90 insertions(+), 26 deletions(-)

--=20
2.7.4
