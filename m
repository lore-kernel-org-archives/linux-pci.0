Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:7296
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750811AbdE3WNk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 May 2017 18:13:40 -0400
From: KY Srinivasan <kys@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Jork Loeser <Jork.Loeser@microsoft.com>
CC: "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>
Subject: RE: [PATCH-v2 0/5] Hyper-V vPCI: use vPCI protocol version 1.2
Date: Tue, 30 May 2017 22:13:27 +0000
Message-ID: <MWHPR03MB249617898B766619AAEA5C9BA0F00@MWHPR03MB2496.namprd03.prod.outlook.com>
References: <1495658488-13199-1-git-send-email-jloeser@linuxonhyperv.com>
 <20170530194506.GA4664@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170530194506.GA4664@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: devel [mailto:driverdev-devel-bounces@linuxdriverproject.org] On
> Behalf Of Bjorn Helgaas
> Sent: Tuesday, May 30, 2017 12:45 PM
> To: Jork Loeser <Jork.Loeser@microsoft.com>
> Cc: olaf@aepfle.de; Stephen Hemminger <sthemmin@microsoft.com>;
> linux-pci@vger.kernel.org; jasowang@redhat.com; linux-
> kernel@vger.kernel.org; marcelo.cerri@canonical.com; apw@canonical.com;
> devel@linuxdriverproject.org; vkuznets@redhat.com;
> leann.ogasawara@canonical.com
> Subject: Re: [PATCH-v2 0/5] Hyper-V vPCI: use vPCI protocol version 1.2
>=20
> On Wed, May 24, 2017 at 01:41:23PM -0700, Jork Loeser wrote:
> > From: Jork Loeser <jloeser@microsoft.com>
> >
> > Update the Hyper-V vPCI driver to use the Server-2016 version of the vP=
CI
> > protocol, fixing MSI creation and retargeting issues.
> >
> > Changes since v1:
> > - reduced spew in protocol negotiation (Dan Carpenter)
> > - work-around work racing Hyper-V patch (Stephen Hemminger)
> > - formatting (Dan)
> >
> > Jork Loeser (5):
> >   Hyper-V vPCI: Minor format and semantic fix
> >   Hyper-V vPCI: Use page allocation for hbus structure
> >   PCI-HyperV vPCI: Temporary own CPU-number-to-vCPU-number infra
> >   Hyper-V vPCI: Add vPCI version protocol negotiation
> >   Hyper-V vPCI: use vPCI protocol version 1.2
> >
> >  arch/x86/include/uapi/asm/hyperv.h |   6 +
> >  drivers/pci/host/pci-hyperv.c      | 445
> ++++++++++++++++++++++++++++++-------
> >  2 files changed, 370 insertions(+), 81 deletions(-)
>=20
> Waiting for a maintainer ack:

Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>

Acked-by: K. Y. Srinivasan <kys@microsoft.com>
>=20
>   Hyper-V CORE AND DRIVERS
>   M:      "K. Y. Srinivasan" <kys@microsoft.com>
>   M:      Haiyang Zhang <haiyangz@microsoft.com>
>   M:      Stephen Hemminger <sthemmin@microsoft.com>
>   ...
>   F:      drivers/pci/host/pci-hyperv.c
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdriverd
> ev.linuxdriverproject.org%2Fmailman%2Flistinfo%2Fdriverdev-
> devel&data=3D02%7C01%7Ckys%40microsoft.com%7C08ff2147e87e4b9957090
> 8d4a794658f%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6363177
> 03190907906&sdata=3DET7UEDnBub1iNEOAb509JrjEZxKZjyhmLSubVzYZtic%3D
> &reserved=3D0
