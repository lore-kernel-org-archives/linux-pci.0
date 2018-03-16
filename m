Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0130.outbound.protection.outlook.com ([104.47.125.130]:62592
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752347AbeCPT5G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Mar 2018 15:57:06 -0400
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
Date: Fri, 16 Mar 2018 19:54:36 +0000
Message-ID: <KL1P15301MB0006B990BEA39A8179D5F8CFBFD70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006E2FA71F87B312D9DECA4BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180316105424.GA24198@e107981-ln.cambridge.arm.com>
 <KL1P15301MB00064DA6B4D221123B5241CFBFD70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180316183158.GA13569@red-moon>
In-Reply-To: <20180316183158.GA13569@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Friday, March 16, 2018 11:32
> ...
>=20
> OK, patch series reworked and queued in my pci/hv branch please have
> a look and let me know if that looks OK for you, I won't ask Bjorn
> to move it into -next till you give me the go-ahead.
>=20
> Lorenzo

Yes, it looks good!
Thanks for updating the commit logs!
I'll try to follow the writing style in future.  :-)

BTW, I hope these two still have the chance to go in v4.16:
PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()
PCI: hv: Serialize the present and eject work items

Thanks,
-- Dexuan
