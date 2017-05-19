Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0125.outbound.protection.outlook.com ([104.47.42.125]:9673
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750764AbdESNs1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 May 2017 09:48:27 -0400
From: KY Srinivasan <kys@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
CC: Stephen Hemminger <stephen@networkplumber.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>
Subject: RE: [PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
Date: Fri, 19 May 2017 13:48:19 +0000
Message-ID: <BN6PR03MB2481B828A99B097BEE7C4717A0E50@BN6PR03MB2481.namprd03.prod.outlook.com>
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
        <1495134870-18225-5-git-send-email-jloeser@linuxonhyperv.com>
        <20170518165854.46fd92fa@xeon-e3>
        <CY4PR21MB06313801D2312E9686F3520AF1E50@CY4PR21MB0631.namprd21.prod.outlook.com>
 <87k25dupt3.fsf@vitty.brq.redhat.com>
In-Reply-To: <87k25dupt3.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Vitaly Kuznetsov [mailto:vkuznets@redhat.com]
> Sent: Friday, May 19, 2017 3:03 AM
> To: Jork Loeser <Jork.Loeser@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Greg Kroah-
> Hartman <gregkh@linuxfoundation.org>; helgaas@kernel.org;
> olaf@aepfle.de; Stephen Hemminger <sthemmin@microsoft.com>; linux-
> pci@vger.kernel.org; jasowang@redhat.com; linux-kernel@vger.kernel.org;
> marcelo.cerri@canonical.com; apw@canonical.com;
> devel@linuxdriverproject.org; leann.ogasawara@canonical.com
> Subject: Re: [PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
>=20
> Jork Loeser <Jork.Loeser@microsoft.com> writes:
>=20
> >> -----Original Message-----
> >> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> >> Sent: Thursday, May 18, 2017 16:59
> >>
> >> > From: Jork Loeser <jloeser@microsoft.com>
> >> >
> >> > Update the Hyper-V vPCI driver to use the Server-2016 version of the
> >> > vPCI protocol, fixing MSI creation and retargeting issues.
> >> >
> >> > Signed-off-by: Jork Loeser <jloeser@microsoft.com>
> >>
> >> This patch conflicts with already submitted patch that removes
> >> vmbus_cpu_number_to_vp_number()
> >>
> >> commit 4b28e5c28cc32652d200a31795e38ee6c819a4a2
> >> Author: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> Date:   Mon May 15 13:38:26 2017 -0700
> >>
> >>     hyper-v: globalize vp_index
> >>
> >>     To support implementing remote TLB flushing on Hyper-V with a
> hypercall
> >>     we need to make vp_index available outside of vmbus module.
> Rename and
> >>     globalize.
> >
> > Thank you Stephen, easy enough to adapt.
> >
> > Bjorn, Greg, Vitaly: Do you have an ETA on when Vitaly's patch will be =
in the
> PCI or linux-next branch so I can rev?
> >
>=20
> I was a bit surprised to see that these patches missed 4.12, K. Y. ACKed
> them:
>=20
> https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdriverd
> ev.linuxdriverproject.org%2Fpipermail%2Fdriverdev-devel%2F2017-
> May%2F105466.html&data=3D02%7C01%7Ckys%40microsoft.com%7Ce1b07306
> cc1d433acb3108d49e9e412b%7C72f988bf86f141af91ab2d7cd011db47%7C1%7
> C0%7C636307849924808831&sdata=3D0JsGx0Ax1DN6Zak8%2BHjLNiaVZBcq%2F
> O2%2F7DrlUtUz1%2BU%3D&reserved=3D0
>=20
> and no other concerns were expressed.
>=20
> To my understanding these patches should go through Greg's char-misc
> tree. K. Y., Greg, please let me know if I need to rebase/resend.

My mistake; I was thinking perhaps they will go through x86 tree. Please re=
send, I will take it
through Greg's tree.

K. Y
>=20
> --
>   Vitaly
