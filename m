Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333ABC43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 15:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DBE2175B
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 15:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DBE2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbeKNB4l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:56:41 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731811AbeKNB4l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 20:56:41 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9CB011FFFE0DB;
        Tue, 13 Nov 2018 15:57:56 +0000 (GMT)
Received: from FRAEMA702-CHM.china.huawei.com (10.206.14.51) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 15:57:58 +0000
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.76]) by
 FRAEMA702-CHM.china.huawei.com ([169.254.2.148]) with mapi id 14.03.0415.000;
 Tue, 13 Nov 2018 16:57:48 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>, Lukas Wunner <lukas@wunner.de>
Subject: RE: Qemu Guest kernel 4.20-rc1 PCIe hotplug issue
Thread-Topic: Qemu Guest kernel 4.20-rc1 PCIe hotplug issue
Thread-Index: AdR7RP5EYT33x2cVTRiE4AudJSgcHP///SQA///uY1CAABsPAP//6WQQgAA6joD//+e+AA==
Date:   Tue, 13 Nov 2018 15:57:47 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8387DF7B5@FRAEML521-MBX.china.huawei.com>
References: <5FC3163CFD30C246ABAA99954A238FA8387DD344@FRAEML521-MBX.china.huawei.com>
 <20181113122522.GA2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF43F@FRAEML521-MBX.china.huawei.com>
 <20181113125910.GB2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF51F@FRAEML521-MBX.china.huawei.com>
 <20181113150749.GC2500@lahna.fi.intel.com>
In-Reply-To: <20181113150749.GC2500@lahna.fi.intel.com>
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
> Sent: 13 November 2018 15:08
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Wangzhou (B)
> <wangzhou1@hisilicon.com>; Linuxarm <linuxarm@huawei.com>; Lukas
> Wunner <lukas@wunner.de>
> Subject: Re: Qemu Guest kernel 4.20-rc1 PCIe hotplug issue

[...]
 
> > Right. As I mentioned in my previous mail, I missed the fact that you are
> updating
> > the ctrl->slot_ctrl with cmd value while in my test I did my update with the
> value
> > returned by pcie_capability_read_word().
> 
> OK, I see.
> 
> > > However, I think we are missing check for PCI_EXP_SLTCTL_CCIE in
> > > pciehp_isr().
> >
> > Ok.
> >
> > > Here's an updated patch, can you try and see if it makes any difference?
> >
> > I just tried this and it works. Thanks.
> 
> Can you still check that the previous one (without _CCIE check) works?

Yes, it works for me without _CCIE.

> > See few comments below.
> >
> > > diff --git a/drivers/pci/hotplug/pciehp_hpc.c
> > > b/drivers/pci/hotplug/pciehp_hpc.c
> > > index 7dd443aea5a5..da2cbe892444 100644
> > > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > > @@ -156,9 +156,9 @@ static void pcie_do_write_cmd(struct controller
> *ctrl,
> > > u16 cmd,
> > >  	slot_ctrl |= (cmd & mask);
> > >  	ctrl->cmd_busy = 1;
> > >  	smp_mb();
> > > +	ctrl->slot_ctrl = slot_ctrl;
> >
> > Does it make more sense if we can move this before smp_mb()?. Also I am
> not
> > sure updating the  ctrl->slot_ctrl before actually the hardware is
> programmed
> > with that value will result in any other race conditions? TBH, I am not that
> familiar
> > with this code and I leave that to you :)
> 
> Both are good questions :)
> 
> For the moving ctrl->slot_ctrl before pcie_capability_write_word(), I
> think we should be fine and this is actually more correct because if we
> are unmasking interrupts they may trigger immediately making
> pciehp_isr() find wrong values in ctrl->slot_ctrl (as can be seen in the
> issue you reported).

Ok. I was more concerned about an unsolicited event triggering the _isr
while we are modifying the ctrl->slot_ctrl. But that's ok I think as the _isr
reads the hw status anyway. 

> The smb_mb() thing is not that clear (at least to me) because it is used
> in two places in the driver and both seem to be making write to
> ctrl->cmd_busy visible to other CPUs but I don't see where we deal with
> the read part.
> 
> I may be missing something, though.

I think the read part is in wait_event_timeout() which evaluates the condition.
The wake_up is called from the pciehp_isr().  Since the flag is being updated
in both process level and interrupt handler context, smp_mb() is used. I think
the same now applies to  ctrl->slot_ctrl now as this being used in process
context and interrupt context as well.

Thanks,
Shameer
