Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:7344
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751333AbdF2X5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2017 19:57:15 -0400
From: Stephen Hemminger <sthemmin@microsoft.com>
To: Jork Loeser <Jork.Loeser@microsoft.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        KY Srinivasan <kys@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Subject: RE: [PATCH] hv: fix msi affinity when device requests all possible
 CPU's
Date: Thu, 29 Jun 2017 23:57:12 +0000
Message-ID: <MWHPR21MB0703BA4E9B4F990C09323BFDCCD20@MWHPR21MB0703.namprd21.prod.outlook.com>
References: <20170628232204.15227-1-sthemmin@microsoft.com>
 <DM5PR21MB0476CFFA739B74FBB3B6F42DA0D20@DM5PR21MB0476.namprd21.prod.outlook.com>
 <MWHPR21MB0639EC5C9B141D0591D1D957F1D20@MWHPR21MB0639.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB0639EC5C9B141D0591D1D957F1D20@MWHPR21MB0639.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Patch still needed for 4.12

-----Original Message-----
From: Jork Loeser=20
Sent: Thursday, June 29, 2017 3:08 PM
To: stephen@networkplumber.org; KY Srinivasan <kys@microsoft.com>; bhelgaas=
@google.com
Cc: linux-pci@vger.kernel.org; devel@linuxdriverproject.org; Stephen Hemmin=
ger <sthemmin@microsoft.com>
Subject: RE: [PATCH] hv: fix msi affinity when device requests all possible=
 CPU's

> -----Original Message-----
> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Wednesday, June 28, 2017 4:22 PM
> To: KY Srinivasan <kys@microsoft.com>; bhelgaas@google.com
> Cc: linux-pci@vger.kernel.org; devel@linuxdriverproject.org; Stephen
> Hemminger <sthemmin@microsoft.com>
> Subject: [PATCH] hv: fix msi affinity when device requests all possible C=
PU's
>=20
> When Intel 10G (ixgbevf) is passed to a Hyper-V guest with SR-IOV, the dr=
iver
> requests affinity with all possible CPU's (0-239) even those CPU's are no=
t online
> (and will never be). Because of this the device is unable to correctly ge=
t MSI
> interrupt's setup.
>=20
> This was caused by the change in 4.12 that converted this affinity into a=
ll
> possible CPU's (0-31) but then host reports an error since this is larger=
 than the
> number of online cpu's.
>=20
> Previously, this worked (up to 4.12-rc1) because only online cpu's would =
be put
> in mask passed to the host.
>=20
> This patch applies only to 4.12.
> The driver in linux-next needs a a different fix because of the changes t=
o PCI
> host protocol version.

The vPCI patch in linux-next has the issue fixed already.

Regards,
Jork
