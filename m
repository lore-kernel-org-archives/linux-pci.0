Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0130.outbound.protection.outlook.com ([104.47.125.130]:16244
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751576AbeCPRl4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Mar 2018 13:41:56 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: RE: [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
Date: Fri, 16 Mar 2018 17:41:27 +0000
Message-ID: <KL1P15301MB00064DA6B4D221123B5241CFBFD70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006E2FA71F87B312D9DECA4BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180316105424.GA24198@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180316105424.GA24198@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Friday, March 16, 2018 03:54
> ...
> Dexuan,
> while applying/updating these patches I notice this one may be squashed
> into: https://patchwork.ozlabs.org/patch/886266/
>=20
> since they logically belong in the same patch. Are you OK with me doing
> that ? Is my reading correct ?
> Lorenzo

I'm OK.=20
I used two patches
[PATCH v4 1/2] PCI: hv: Serialize the present and eject work items
[PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
only because the first fixed a real issue and hence IMO should go into
stable kernels, and the second is only a cleanup patch, which doesn't
need go into stable kernels.

Either way is ok to me.=20
Please feel free to do whatever you think is better. :-)

Thanks,
-- Dexuan
