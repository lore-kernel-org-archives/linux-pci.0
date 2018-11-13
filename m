Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D2C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 12:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791662243E
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 12:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791662243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbeKMWea convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:34:30 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732963AbeKMWea (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 17:34:30 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id DC159CEBE105E;
        Tue, 13 Nov 2018 12:36:29 +0000 (GMT)
Received: from FRAEML704-CAH.china.huawei.com (10.206.14.35) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 12:36:31 +0000
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.76]) by
 FRAEML704-CAH.china.huawei.com ([10.206.14.35]) with mapi id 14.03.0415.000;
 Tue, 13 Nov 2018 13:36:20 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>, Lukas Wunner <lukas@wunner.de>
Subject: RE: Qemu Guest kernel 4.20-rc1 PCIe hotplug issue
Thread-Topic: Qemu Guest kernel 4.20-rc1 PCIe hotplug issue
Thread-Index: AdR7RP5EYT33x2cVTRiE4AudJSgcHP///SQA///uY1A=
Date:   Tue, 13 Nov 2018 12:36:20 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8387DF43F@FRAEML521-MBX.china.huawei.com>
References: <5FC3163CFD30C246ABAA99954A238FA8387DD344@FRAEML521-MBX.china.huawei.com>
 <20181113122522.GA2500@lahna.fi.intel.com>
In-Reply-To: <20181113122522.GA2500@lahna.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: mika.westerberg@linux.intel.com
> [mailto:mika.westerberg@linux.intel.com]
> Sent: 13 November 2018 12:25
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Wangzhou (B)
> <wangzhou1@hisilicon.com>; Linuxarm <linuxarm@huawei.com>; Lukas
> Wunner <lukas@wunner.de>
> Subject: Re: Qemu Guest kernel 4.20-rc1 PCIe hotplug issue
> 
> +Lukas
> 
> On Tue, Nov 13, 2018 at 11:45:42AM +0000, Shameerali Kolothum Thodi wrote:
> > Hi Mika,
> 
> Hi,
> 
> > Since the commit commit 720d6a671a6e("PCI: pciehp: Do not handle events
> > if interrupts are masked"), the hotplug support on Qemu Guest(4.120-rc1)
> > with a vfio passthrough device seems to be broken. This is on an ARM64
> platform.
> >
> > I am booting a Guest with below command line options with the intention of
> > hot add a ixgbevf dev later,
> >
> > ./qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-version=3 -cpu
> host \
> >  -kernel Image_4.20-rc1 \
> >  -initrd rootfs-iperf.cpio \
> >  -device ioh3420,id=rp1 \
> >  -net none \
> >  -m 4096 \
> >  -nographic -D -d -enable-kvm \
> >  -append "console=ttyAMA0 root=/dev/vda -m 4096 rw
> pciehp.pciehp_debug=1
> >   pcie_ports=native searlycon=pl011,0x9000000"
> >
> > But receives this on boot,
> >
> > [    1.327852] pciehp 0000:00:01.0:pcie004: Timeout
> > on hotplug command 0x03f1 (issued 1016 msec ago)
> > [    1.335842] pciehp 0000:00:01.0:pcie004: Timeout on hotplug command
> > 0x03f1 (issued 1024 msec ago)
> > [    3.847843] pciehp 0000:00:01.0:pcie004: Failed to check link status
> > [    3.855843] pciehp 0000:00:01.0:pcie004: Timeout on hotplug command
> > 0x02f1 (issued 2520 msec ago)
> > [    4.879846] pciehp 0000:00:01.0:pcie004: Timeout on hotplug command
> > 0x06f1 (issued 1024 msec ago)
> > [    5.911840] pciehp 0000:00:01.0:pcie004: Timeout on hotplug command
> > 0x06f1 (issued 2056 msec ago)
> > [    6.927844] pciehp 0000:00:01.0:pcie004: Timeout on hotplug command
> > 0x07f1 (issued 1016 msec ago)
> > [    7.951843] pciehp 0000:00:01.0:pcie004: Timeout on hotplug command
> > 0x0771 (issued 1024 msec ago)
> >
> > Trying to hot add using "device_addvfio-
> pci,host=0000:01:10.1,id=net0,bus=rp1"
> > doesn't work either. And if I boot the guest with an assigned device
> > (-device vfio-pci,host=0000:01:10.1,id=net0,bus=rp1), I can see the dev listed
> in
> > the Guest but then hot remove doesn't work.
> >
> > This all works on 4.19 and bisect points to the above mentioned commit,
> where an
> > additional check is added in pciehp_isr(),
> >
> > -	 * Interrupts only occur in D3hot or shallower (PCIe r4.0, sec 6.7.3.4).
> > +	 * Interrupts only occur in D3hot or shallower and only if enabled
> > +	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).
> >  	 */
> > -	if (pdev->current_state == PCI_D3cold)
> > +	if (pdev->current_state == PCI_D3cold ||
> > +	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
> >  		return IRQ_NONE;
> >
> > I think this doesn't work for the first time, where the cmd with
> PCI_EXP_SLTCTL_HPIE bit set
> > is written,
> > pciehp_probe()
> >   pcie_init_notification()
> >     pcie_enable_notification()
> >        pcie_do_write_cmd()
> >
> > to begin with, ctrl->slot_ctrl = 0 in pciehp_isr() as this is only set once the
> write
> > is returned.
> >
> > Or else I am missing something here. Please take a look and let me know.
> 
> Thanks for the detailed report and analysis. I think you are right and
> the ctrl->slot_ctrl is only set after the actual value has been
> programmed to the hardware, so if there was interrupt "pending" it will
> trigger immediately (just to find ctrl->slot_ctrl == 0).
> 
> I wonder if the following change helps here?
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c
> b/drivers/pci/hotplug/pciehp_hpc.c
> index 7dd443aea5a5..cd9eae650aa5 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -156,9 +156,9 @@ static void pcie_do_write_cmd(struct controller *ctrl,
> u16 cmd,
>  	slot_ctrl |= (cmd & mask);
>  	ctrl->cmd_busy = 1;
>  	smp_mb();
> +	ctrl->slot_ctrl = slot_ctrl;

Actually I tried this one, but it doesn't help in this case as the initial 
pcie_capability_read_word() returns the slot_ctrl without PCI_EXP_SLTCTL_HPIE
bit set.  It looks to me  pcie_enable_notification() function enables this,

	if (!pciehp_poll_mode)
		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;

I don't know this is as per the spec or not as the initial cap read doesn't seems to
have the PCI_EXP_SLTCTL_HPIE bit set.

Thanks,
Shameer

>  	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
>  	ctrl->cmd_started = jiffies;
> -	ctrl->slot_ctrl = slot_ctrl;
> 
>  	/*
>  	 * Controllers with the Intel CF118 and similar errata advertise

