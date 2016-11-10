Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0109.outbound.protection.outlook.com ([104.47.41.109]:59904
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753532AbcKJHbo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 02:31:44 -0500
From: Dexuan Cui <decui@microsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>,
        "Hadden Hoppert" <haddenh@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] PCI: hv: clean-up and 2 fixes to the hot-remove case
Date: Thu, 10 Nov 2016 07:16:22 +0000
Message-ID: <MWHPR03MB2669C98A17A4B450BB0BA72EBFB80@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PATCH 1 is just a clean-up. There should be no functional change.

PATCH 2 and 3 are for device hot-remove case.=20
Currently the driver will stop working or even cause panic, if we do
hot add/remove quickly a few times. With the 2 patches, everything works
reliably in my tests now.

There can be still a potential issue with hot-remove when we unload=20
the driver at the same time. That would require more work of proper
synchronization among the 3 paths: the .probe/.remove, the channel callback=
,
and the offloaded hv_pci_devices_present()/hv_eject_device_work().

But for now, PATCH 2 and 3 do improve the situation a lot.

Dexuan Cui (3):
  PCI: hv: use the correct buffer size in new_pcichild_device()
  PCI: hv: fix hv_pci_remove() for hot-remove
  PCI: hv: delete the device earlier from hbus->children for hot-remove

 drivers/pci/host/pci-hyperv.c | 67 ++++++++++++++++++++++++++-------------=
----
 1 file changed, 40 insertions(+), 27 deletions(-)

--=20
2.7.4

