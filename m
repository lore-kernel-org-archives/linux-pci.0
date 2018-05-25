Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:41367
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966518AbeEYLn3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 May 2018 07:43:29 -0400
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Date: Fri, 25 May 2018 11:43:25 +0000
Message-ID: <BN6PR21MB0161399BFB7B0A7DCBB0691FCA690@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Dexuan Cui
> Sent: Wednesday, May 23, 2018 5:12 PM
> To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>; 'Bjorn Helgaas'
> <bhelgaas@google.com>; 'linux-pci@vger.kernel.org' <linux-
> pci@vger.kernel.org>; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; 'olaf@aepfle.de' <olaf@aepfle.de>;
> 'apw@canonical.com' <apw@canonical.com>; 'jasowang@redhat.com'
> <jasowang@redhat.com>
> Cc: 'linux-kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>; 'drive=
rdev-
> devel@linuxdriverproject.org' <driverdev-devel@linuxdriverproject.org>;
> Haiyang Zhang <haiyangz@microsoft.com>; 'vkuznets@redhat.com'
> <vkuznets@redhat.com>; 'marcelo.cerri@canonical.com'
> <marcelo.cerri@canonical.com>
> Subject: [PATCH] PCI: hv: Do not wait forever on a device that has disapp=
eared
>=20
>=20
> Before the guest finishes the device initialization, the device can be re=
moved
> anytime by the host, and after that the host won't respond to the guest's
> request, so the guest should be prepared to handle this case.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 46 ++++++++++++++++++++++++++++++++-----=
--
> ----

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Thank you!
