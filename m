Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0123C4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 03:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D12620652
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 03:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C2HGrofr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfDCDL6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:11:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39455 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfDCDL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 23:11:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so6200939wmk.4
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2019 20:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOsg6KbhYLxtnJPk5ktRy/YMbya5ZDgO5Ntlax/ZgsU=;
        b=C2HGrofr582q+vezNcaNw/4zOoTI5MWaXuCAluzImLKp0lErO51V+YalVuBu1zM03m
         mN4TleLkwdPFMXstCbC3aO8JzajwM+0MqMkg3VYKpmJ1TxuVI5Z4ShTK6YnTA9Ge0o1r
         FW2nhIssagGZwQb3+Upi2P5sughC43y2SAP5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOsg6KbhYLxtnJPk5ktRy/YMbya5ZDgO5Ntlax/ZgsU=;
        b=mcJYgagw+K7ipHcboZl1Mz0xQ28YO6ZGqNubCyYXF2gGnkCO46L0roX1GxoZtZU/PK
         F5e0TrYFO+i1WGsWAhYlfA6s0sB5eoeBZVvV/zoxjW2VaQZMXzK8ctFNOadND5w7JxH9
         971LL7Z4gAwNUi042ZYPMWM3A4tgPki8/bdx9XF1O1b7Y2+ugAyawjXeGEklwssPzfXe
         gdOKdl3qJdv2QfeQnS5Vh6hedJzuICGO/tlZASXDz5ifS6UTctC13vMWyQQeet7GUBEh
         n9DHcX1fnH3b3Bwbx2hUXnyLg+X1XlCe3tu+lNoc50Jmse+spP0DlPRISPz/DrKG6Gk9
         AvTA==
X-Gm-Message-State: APjAAAUjSa1NThOGzlygYv05+4/Mz8ftJCdmWbNF2Ymnn1u85Ot+DO+p
        sE71NA6Sktzo2l3Ne0lmfehtqrfqdM7+HvDNBUjwpw==
X-Google-Smtp-Source: APXvYqzIg/sbwKb0idpuZU0QB4hz/btIbr64An3MA7txpWoQtJj9Bb4+5XKcf8G/tdEOQZ0yw5k5VW/USYtnY+TFMyk=
X-Received: by 2002:a1c:9e96:: with SMTP id h144mr219884wme.33.1554261116396;
 Tue, 02 Apr 2019 20:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
 <1551415936-30174-3-git-send-email-srinath.mannam@broadcom.com>
 <20190329173515.GA10367@e107981-ln.cambridge.arm.com> <CABe79T7LwFLST0dwwswv8sdqHcn0T4ked5WtcNpM78XUDUN3Jw@mail.gmail.com>
 <20190401164416.GA8616@e107981-ln.cambridge.arm.com> <e7d3e5a1-db5c-8438-f10f-81b87aba0e03@broadcom.com>
 <CABe79T7uLo+68P0Yr7jpgn1+4H01qhoPRjX05gszin3FXkBZ5w@mail.gmail.com>
 <20190402102639.GB22708@e107981-ln.cambridge.arm.com> <CABe79T5O-1EWVrR1vZ27LWuxTBqN4_x37bkpfKxfm1ZB+oDUvA@mail.gmail.com>
 <20190402133851.GA26122@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190402133851.GA26122@e107981-ln.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 3 Apr 2019 08:41:44 +0530
Message-ID: <CABe79T7JdOh0Lpr2vhWX5QPE5nuP9hZeviSB9E3tVteeAX89fw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: iproc: Add outbound configuration for 32-bit
 I/O region
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abhishek Shah <abhishek.shah@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Please see my reply below,

On Tue, Apr 2, 2019 at 7:08 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Apr 02, 2019 at 04:16:13PM +0530, Srinath Mannam wrote:
>
> [...]
>
> > > Ok - I start to understand. What does it mean in HW terms that your
> > > 32bit AXI address region size is 32MB ? Please explain to me in details.
> > >
> > In our PCIe controller HW, AXI address from 0x42000000 to 0x44000000
> > of 32MB size and .
> > AXI address from 0x400000000 to 0x480000000 of 2GB size are provided
> > to map ob address.
> > First IO region is inside 32bit address and second IO region is
> > outside 32bit address.
> > This code change is to map first IO region(0x42000000 to 0x44000000).
> >
> > > IIUC you are using an OARR0 of 128MB in size to map a 32MB address
> > > region, that's what I understand this patch does (and the lowest index
> > > corresponds to the smallest possible size - it is far from clear by
> > > looking at the patch).
> > Yes, lowest index corresponds to smallest possible size (128MB).
> > In our controller we have multiple windows like OARR0, OARR1, OARR2,
> > OARR3 all supports multiple sizes from 128MB to 1024MB.
> > These details are given at the top of this driver file, as shown
> > below. all windows supports 128MB size still we must use OARR0 window
> > to configure first IO region(0x42000000 to 0x44000000).
> >
> > static const struct iproc_pcie_ob_map paxb_v2_ob_map[] = {
> >         {
> >                 /* OARR0/OMAP0 */
> >                 .window_sizes = { 128, 256 },
> >                 .nr_sizes = 2,
> >         },
> >         {
> >                 /* OARR1/OMAP1 */
> >                 .window_sizes = { 128, 256 },
> >                 .nr_sizes = 2,
> >         },
> >         {
> >                 /* OARR2/OMAP2 */
> >                 .window_sizes = { 128, 256, 512, 1024 },
> >                 .nr_sizes = 4,
> >         },
> >         {
> >                 /* OARR3/OMAP3 */
> >                 .window_sizes = { 128, 256, 512, 1024 },
> >                 .nr_sizes = 4,
> >         },
> > };
>
> Ok so this patch allows mapping an AXI I/O window that is smaller
> than OARR possible sizes, why it was not done from the beginning
> I really do not know.
>
Same Iproc driver we use for multiple SOCs, in previous SOCs does not
have 32-bit AXI address region to map ob.
In the present SOC, 32-bit AXI address region is available so that
this change is added.

> Now explain this to me please:
>
> > This patch add outbound window configuration to map below 32-bit I/O range
> > with corresponding PCI memory, which helps to access I/O region in ARM
> > 32-bit and one to one mapping of I/O region to PCI memory.
> >
> > Ex:
> > 1. ranges DT property given for current driver is,
> >     ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
> >     I/O region address is 0x400000000
> > 2. ranges DT property can be given after this patch,
> >     ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
> >     I/O region address is 0x42000000
>
> Why 1:1 AXI<->PCI address mapping is not possible in (1), how does the
> current code works on 32-bit systems and what's the benefit your change
> is bringing.
non-prefetchable memory range can only support 32-bit addresses, so
that we have taken 32-bit PCI bus address in (1).
current code does not work in 32-bit systems. In the present SOC with
this new change we can access from 32-bit CPU.

Regards,
Srinath.
>
> Thanks,
> Lorenzo
