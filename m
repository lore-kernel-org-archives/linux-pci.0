Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
Date: Wed, 24 May 2017 20:43:08 +0000
Message-ID: <BLUPR03MB1412AD9B6C5B4575F354EC4CCAFE0@BLUPR03MB1412.namprd03.prod.outlook.com>
References: <1495658355-13103-1-git-send-email-haiyangz@exchange.microsoft.com>
In-Reply-To: <1495658355-13103-1-git-send-email-haiyangz@exchange.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Haiyang Zhang [mailto:haiyangz@exchange.microsoft.com]
> Sent: Wednesday, May 24, 2017 4:39 PM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; vkuznets@redhat.com; driverdev-
> devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
>=20
> [This sender failed our fraud detection checks and may not be who they
> appear to be. Learn about spoofing at http://aka.ms/LearnAboutSpoofing]
>=20
> From: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> This patch uses the lower 16 bits of the serial number as PCI
> domain, otherwise some drivers may not be able to handle it.
>=20
> Besides Nvidia drivers, we also found X.org, and DPDK handle
> only 16 bit PCI domain.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---

According to Stephen Hemminger <sthemmin@microsoft.com>, there are
additional programs, like X.org, DPDK, are also using 16-bit only
PCI domain numbers. So, I'm submitting this patch for re-consideration.

Thanks,
- Haiyang
