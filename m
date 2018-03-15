Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v4 0/4] PCI: hv: Add 4 cosmetic patches
Date: Thu, 15 Mar 2018 14:21:18 +0000
Message-ID: <KL1P15301MB00066C8F7CDF90BE9D2B7412BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The 4 patches should go in v4.16.

There is no code change since v3:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1628496.html

I just split the original 6 patches to 2 series, and this is series 2.

I fixed the order of Signed-off-by/Tested-by/Cc, etc., and fixed the
other format issues in changelog (I hope I have fixed all of them).

Dexuan Cui (4):
  PCI: hv: Fix a comment typo in _hv_pcifront_read_config()
  PCI: hv: Remove the bogus test in hv_eject_device_work()
  PCI: hv: Remove hbus->enum_sem
  PCI: hv: Only queue a new work in hv_pci_devices_present() if
    necessary

 drivers/pci/host/pci-hyperv.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

--=20
2.7.4
