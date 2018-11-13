Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01243C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 10:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABC122511
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 10:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABC122511
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbeKMUV2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:21:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731978AbeKMUV2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 15:21:28 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0A8096CDF7994;
        Tue, 13 Nov 2018 18:23:58 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 13 Nov 2018
 18:23:53 +0800
Date:   Tue, 13 Nov 2018 10:23:44 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Pick up the acpi numa node value if it is
 specified at the device level.
Message-ID: <20181113102344.000078c1@huawei.com>
In-Reply-To: <8a0fd569-fa52-b884-ef0d-18aab1ef8c3f@geanix.com>
References: <20180912152140.3676-1-Jonathan.Cameron@huawei.com>
        <20180912152140.3676-2-Jonathan.Cameron@huawei.com>
        <e4bd3423-ae2a-262c-1391-f9741ac4fdd0@geanix.com>
        <20181113092435.00004466@huawei.com>
        <8a0fd569-fa52-b884-ef0d-18aab1ef8c3f@geanix.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 13 Nov 2018 10:35:29 +0100
Martin Hundebøll <martin@geanix.com> wrote:

> Hi Jonathan,
> 
> On 13/11/2018 10.24, Jonathan Cameron wrote:
> > On Mon, 12 Nov 2018 20:40:35 +0100
> > Martin Hundebøll <martin@geanix.com> wrote:
> >   
> >> Hi Jonathan,
> >>
> >> I'm afraid this change made my system unbootable :(  
> > Hi Martin,
> > 
> > Thanks for the report!  
> >>
> >> Testing both v4.20-rc1 and v4.20-rc2 resulting in nothing but a black
> >> screen, with no sign of life from either the keyboard or the network.
> >>
> >> Bisecting changes from v4.19 led me to this commit, and the system boots
> >> again with the change reverted.
> >>
> >> I know little about ACPI and PCI, so please tell the kind of debug/log
> >> you need.  
> > The ACPI DSDT would be where I would start.  Please send the output of
> > $cat /sys/firmware/acpi/tables/DSDT > DSDT.asl
> > (under whatever boots for you)
> > 
> > If you want to look further yourself, you'll need to disassemble this using
> > the iASL compiler.  That is usually in a package called something like
> > acpica-tools or can be built from source from
> > 
> > https://github.com/acpica/acpica
> > 
> > iasl -d DSDT.asl
> > 
> > This should generate a plain text file called DSDL.dsl.
> > 
> > Send us that and hopefully it'll be obvious what is wrong!
> > Given we haven't had lots of reports, I'm going to guess there is something
> > unusual in the table, but we'll see.  
> 
> Judging from the stderr output of the iasl command, additional ACPI 
> tables were needed to do a full disassembly, so I ended up with:
> 
> iasl -e SSDT1.asl SSDT2.asl SSDT3.asl SSDT4.asl SSDT5.asl SSDT6.asl 
> SSDT7.asl  -d DSDT.asl
> 
> I've attached the output.

So a couple of possibilities come to mind.

1) There are _PXM entries for
_SB.PCI0 - Looks like a root port. Bus number of 0
_SB.S0D1 - Looks like a root port. Bus number of 1
_SB.S0D2 - Looks like a root port. Bus number of 2
_SB.S0D3 - Looks like a root port. Bus number of 3

covering nodes 0 - 3 which seems reasonable but the kernel log is recording that
no NUMA information was found - and you didn't attach an SRAT table along with the
others earlier so I'm going to guess there wasn't one?

I suspect that will cause us all sorts of fun issues as I don't think the code
verifies the node exists - or at the very least there is one path that isn't.

I'll fake up some equivalents on a machine here and see whether a few well placed
sanity checks will fix it.

2) We are successfully associating a lot of other stuff a little earlier
in the process for ACPI than previously so we 'might' cause a side effect where
data (that is presumably wrong) is now visible.

This one looks less likely to me...

3) Something that someone who knows more about ACPI than me will spot!

Thanks,

Jonathan

p.s. Rule one of ACPI. If it is possible to break it and still have common OSes
booting then people will manage to do so... 

> 
> Thanks,
> Martin
> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >>
> >> Thanks,
> >> Martin
> >>
> >> On 12/09/2018 17.21, Jonathan Cameron wrote:  
> >>> The ACPI specification allows you to provide _PXM entries for devices based
> >>> on their location on a particular bus.  Let us use that if it is provided
> >>> rather than just assuming it makes sense to put the device into the proximity
> >>> domain of the root.
> >>>
> >>> An example DSDT entry that will supply this is:
> >>>
> >>>     Device (PCI2)
> >>>     {
> >>>       Name (_HID, "PNP0A08") // PCI Express Root Bridge
> >>>       Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
> >>>       Name(_SEG, 2) // Segment of this Root complex
> >>>       Name(_BBN, 0xF8) // Base Bus Number
> >>>       Name(_CCA, 1)
> >>>       Method (_PXM, 0, NotSerialized) {
> >>>         Return(0x00)
> >>>       }
> >>>
> >>> ...
> >>>       Device (BRI0) {
> >>>         Name (_HID, "19E51610")
> >>>         Name (_ADR, 0)
> >>>         Name (_BBN, 0xF9)
> >>>         Device (CAR0) {
> >>>           Name (_HID, "97109912")
> >>>           Name (_ADR, 0)
> >>>           Method (_PXM, 0, NotSerialized) {
> >>>             Return(0x02)
> >>>           }
> >>>         }
> >>>       }
> >>>     }
> >>>
> >>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> ---
> >>>    drivers/pci/pci-acpi.c | 5 +++++
> >>>    1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> >>> index 738e3546abb1..f2f5f0ddd60e 100644
> >>> --- a/drivers/pci/pci-acpi.c
> >>> +++ b/drivers/pci/pci-acpi.c
> >>> @@ -753,10 +753,15 @@ static void pci_acpi_setup(struct device *dev)
> >>>    {
> >>>    	struct pci_dev *pci_dev = to_pci_dev(dev);
> >>>    	struct acpi_device *adev = ACPI_COMPANION(dev);
> >>> +	int node;
> >>>    
> >>>    	if (!adev)
> >>>    		return;
> >>>    
> >>> +	node = acpi_get_node(adev->handle);
> >>> +	if (node != NUMA_NO_NODE)
> >>> +		set_dev_node(dev, node);
> >>> +	
> >>>    	pci_acpi_optimize_delay(pci_dev, adev->handle);
> >>>    
> >>>    	pci_acpi_add_pm_notifier(adev, pci_dev);
> >>>     
> >>  
> > 
> >   
> 


