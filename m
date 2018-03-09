Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0131.outbound.protection.outlook.com ([104.47.32.131]:40444
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932183AbeCITgw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 14:36:52 -0500
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/6] PCI: hv: fix a comment typo in
 _hv_pcifront_read_config()
Date: Fri, 9 Mar 2018 19:36:49 +0000
Message-ID: <BL0PR2101MB1108E9E17C9C35BA1A2E5311CADE0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-2-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-2-decui@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Dexuan Cui
> Sent: Tuesday, March 6, 2018 1:22 PM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
> Haiyang Zhang <haiyangz@microsoft.com>; vkuznets@redhat.com;
> marcelo.cerri@canonical.com; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; Dexuan Cui <decui@microsoft.com>;
> stable@vger.kernel.org
> Subject: [PATCH v3 1/6] PCI: hv: fix a comment typo in
> _hv_pcifront_read_config()
>=20
> No functional change.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Fixes: bdd74440d9e8 ("PCI: hv: Add explicit barriers to config space acce=
ss")
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---

Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
