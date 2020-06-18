Return-Path: <SRS0=agHd=77=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76187C433DF
	for <linux-pci@archiver.kernel.org>; Thu, 18 Jun 2020 16:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5230420888
	for <linux-pci@archiver.kernel.org>; Thu, 18 Jun 2020 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592497209;
	bh=F4EKKVD63ZNNXKxGjMy9cPTLD8rZHt304z9GhkHF/sQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=ZnDnbTEcgSsewd9YXto1L9XKzDZAzg2pgll4SJw84GbnkYmA/2G7t7jSckyqa4gaG
	 g2ZYM+dwHWOpLSrdShzTOfLmpMkKdltGo+3mHJT06mWyif1YHUcA3UWdgriYQdu9q8
	 XvVmYy5OH6a4xkFNzXFkghxW8jeydi5cyC1EUwbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgFRQUI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731272AbgFRQUH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 12:20:07 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 588AA206FA;
        Thu, 18 Jun 2020 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592497206;
        bh=F4EKKVD63ZNNXKxGjMy9cPTLD8rZHt304z9GhkHF/sQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fBXtPEv9aoLHp39uoccgngEBXoFOnBLjeHLCaucM9EsvZxs+9cJVyfF+VqVQ8ucwI
         jV8JYjgsjoGOnBfPlBursSpE8/y1SWKfV/LtuGCluTCQd8S5UVj8LjqDm/lHflFWZK
         NCUru1nzv9orSdOmr/g35U22LTV731XRnXqmMwTQ=
Date:   Thu, 18 Jun 2020 11:20:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        sean.v.kelley@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linuxarm@huawei.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] PCI/AER: Add partial initial support for RCiEPs
 using RCEC or firmware first
Message-ID: <20200618162004.GA2102664@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618094829.00007d46@Huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 18, 2020 at 09:48:29AM +0100, Jonathan Cameron wrote:
> On Wed, 17 Jun 2020 11:25:55 -0700
> "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> > On 6/17/20 10:36 AM, Sean V Kelley wrote:
> > > On Tue, 2020-06-16 at 14:24 -0500, Bjorn Helgaas wrote:  
> > >> On Fri, May 22, 2020 at 01:31:34AM +0800, Jonathan Cameron wrote:  

> > IIUC, we are trying to solve multiple issues here.
> > 
> > 1. Error detection and recovery support for RCiEPs and RCEC.
> > 2. Firmware first exception for case 1.
> > 3. AEPI based handling for case 1 (I think this is the case Jonathan is
> > trying to handle)
> 
> I'm not sure it separates that cleanly but the flow I'm interested
> in is firmware first with errors reported using APEI / GHESv2 etc.
> 
> In particular without an RCEC, as it should (I think) play no part
> in that path.  One of the main aims of me bringing this forwards at
> this stage is to establish whether I need to get our hardware teams
> to put an RCEC in place for future hardware or not.  Right now we have
> some work arounds in place as we can reroute some of these errors directly
> to device interrupts.
> 
> We haven't been able to come up with a reason why we need an RCEC given
> our approach to error handling.

If you only want to use ACPI APEI and you never need native AER
support, you may not need an RCEC.  But note that an RCEC *is*
required if you want PME messages or Function Readiness Status (FRS)
for RCiEPs.

> > >>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > >>> index 14bb8f54723e..d34be4483f73 100644
> > >>> --- a/drivers/pci/pcie/err.c
> > >>> +++ b/drivers/pci/pcie/err.c
> > >>> @@ -153,6 +153,67 @@ pci_ers_result_t pcie_do_recovery(struct
> > >>> pci_dev *dev,
> > >>>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> > >>>   	struct pci_bus *bus;  
> > I am curious what bus (dev->subordinate) does RCEC and RCiEP belongs to 
> > ?
> 
> I'm not quite sure what you are asking so...
> 
> They are effectively the same as root ports, and so sit on a bus specified
> via ACPI. In our case IORT. The root complex includes a bunch of bus
> numbers on which these devices can be discovered.
> 0, 74, 78, 7a, 7b, 7c, 80, b4, ba, bb, b8, bc on the 2 socket machine I have
> to hand.  Those buses have a mix of root ports, and RCiEPs on them.

I don't know much about IORT, but it's not the way we discover these
devices.

RCiEPs and RCECs should be discovered the same way as Root Ports: a
PNP0A03 device in the ACPI namespace describes a PCI host bridge, and
the _CRS method of that PNP0A03 device contains a bus number range.
The base of that range is the root "bus" on which Root Ports, RCiEPs,
RCECs, and possibly some Conventional PCI devices exist.

The machine Jonathan mentioned above should have 12 PNP0A03 devices,
one for each of the root buses he listed.

> As to subordinate (i.e. where they bridge to) I don't think it would have
> any meaning.   For reference I checked one of our RCiEPs and it's set
> to 0 on the config space.

RCiEPs and RCECs are type 0 devices, so they're not bridges.  They
have no secondary bus.
