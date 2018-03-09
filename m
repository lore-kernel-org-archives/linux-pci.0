Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:38750
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932677AbeCITie (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 14:38:34 -0500
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
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jack Morgenstein <jackm@mellanox.com>
Subject: RE: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Date: Fri, 9 Mar 2018 19:38:10 +0000
Message-ID: <BL0PR2101MB11087BE0B3B91040BE99EF5ACADE0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-7-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-7-decui@microsoft.com>
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
> stable@vger.kernel.org; Jack Morgenstein <jackm@mellanox.com>
> Subject: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg(=
)
>=20
> 1. With the patch "x86/vector/msi: Switch to global reservation mode"
> (4900be8360), the recent v4.15 and newer kernels always hang for 1-vCPU
> Hyper-V VM with SR-IOV. This is because when we reach
> hv_compose_msi_msg() by request_irq()  -> request_threaded_irq() ->
> __setup_irq()->irq_startup()  -> __irq_startup() -> irq_domain_activate_i=
rq() -
> > ... ->
> msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is disabl=
ed in
> __setup_irq().
>=20
> Fix this by polling the channel.
>=20
> 2. If the host is ejecting the VF device before we reach hv_compose_msi_m=
sg(),
> in a UP VM, we can hang in hv_compose_msi_msg() forever, because at this
> time the host doesn't respond to the CREATE_INTERRUPT request. This issue
> also happens to old kernels like v4.14, v4.13, etc.
>=20
> Fix this by polling the channel for the PCI_EJECT message and
> hpdev->state, and by checking the PCI vendor ID.
>=20
> Note: actually the above issues also happen to a SMP VM, if "hbus->hdev-
> >channel->target_cpu =3D=3D smp_processor_id()" is true.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> Tested-by: Chris Valean <v-chvale@microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> ---

Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
