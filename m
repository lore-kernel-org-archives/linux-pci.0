Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pu1apc01on0119.outbound.protection.outlook.com ([104.47.126.119]:53944
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752274AbeCOS2h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Mar 2018 14:28:37 -0400
From: Dexuan Cui <decui@microsoft.com>
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>
CC: "'bhelgaas@google.com'" <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: RE: [PATCH v4 1/2] PCI: hv: Serialize the present and eject work
 items
Date: Thu, 15 Mar 2018 18:28:21 +0000
Message-ID: <KL1P15301MB00065FB13CC4AFC4C64DFBB3BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006C96F94181FFB93A222D8BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180315170131.GA22134@e107981-ln.cambridge.arm.com>
 <KL1P15301MB00064712309002FB85341ACDBFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB00064712309002FB85341ACDBFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Dexuan Cui
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > I need to know either what commit you are fixing (ie Fixes: tag - which
> > is preferrable) or you tell me which kernel versions we are targeting
> > for the stable backport.
> > Lorenzo
>=20
> Sorry.  Here I was hesitant to add a "Fixes:" because the bug was there t=
he first
> day
> when the driver was introduced.
>=20
> Please use
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsof=
t
> Hyper-V VMs")
> or
> Cc: <stable@vger.kernel.org> # v4.6+

BTW, the bug here is a race condtion which couldn't be easily hit in the pa=
st,
probably because most of the time only one PCI device was only added into t=
he
VM once. But now it's becoming typical that a VM can have 4 GPU devices so =
we
start to notice this bug. With 7 Mellanox VFs assigned to a VM, we can easi=
ly
reproduce the bug by "hot-remove and hot-add VFs" test:

general protection fault: 0000 [#1] SMP
...
Workqueue: events hv_eject_device_work [pci_hyperv]
task: ffff8800ed5e5400 ti: ffff8800ee674000 task.ti: ffff8800ee674000
RIP: 0010:[<ffffffffc025c5ce>]  ... hv_eject_device_work+0xbe/0x160 [pci_hy=
perv]
...
Call Trace:
 [<ffffffff8183c3a6>] ? __schedule+0x3b6/0xa30
 [<ffffffff8109a585>] process_one_work+0x165/0x480
 [<ffffffff8109a8eb>] worker_thread+0x4b/0x4c0
 [<ffffffff8109a8a0>] ? process_one_work+0x480/0x480
 [<ffffffff810a0c25>] kthread+0xe5/0x100
 [<ffffffff810a0b40>] ? kthread_create_on_node+0x1e0/0x1e0
 [<ffffffff81840f0f>] ret_from_fork+0x3f/0x70
 [<ffffffff810a0b40>] ? kthread_create_on_node+0x1e0/0x1e0
Code: ...
RIP  [<ffffffffc025c5ce>] hv_eject_device_work+0xbe/0x160 [pci_hyperv]
...
BUG: unable to handle kernel paging request at ffffffffffffffd8
IP: [<ffffffff810a12d0>] kthread_data+0x10/0x20
PGD 1e0d067 PUD 1e0f067 PMD 0
Oops: 0000 [#2] SMP
=20
Thanks,
-- Dexuan
