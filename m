Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v2 0/6] some fixes to the pci-hyperv driver.
Date: Mon, 5 Mar 2018 19:22:11 +0000
Message-ID: <20180305192134.32207-1-decui@microsoft.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes since v1 are:

Patch 1, 6: no change since v1.

Patch 2,4,5: I added these new patches, as suggested by Michael Kelley.

Patch 3: Removed the unnecessary drain_workqueue(), as suggested by Michael=
 Kelley.


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
