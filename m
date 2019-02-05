Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDCDC282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 20:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1DD2175B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549400365;
	bh=c1uzF/wt7HGydovVoUsiezVXCEqKkSExz23pNpCoy40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UhBJq4biMqBxtq42JjU/QHh28yn1xNQHf3paFYpYhToIovbLAX5ydZwNMd9EyUbxk
	 dqfcuGnMWB5GyX/jET5bJNDME1fZka12qPku7e4fTqn4ndFjeejRhA0ACmHsZoDHO4
	 AdgYeQcHCRu/HgWc0KIDXaxYX1LkDmeLm0OgL9sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfBEU7Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEU7Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Feb 2019 15:59:24 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA0520818;
        Tue,  5 Feb 2019 20:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549400363;
        bh=c1uzF/wt7HGydovVoUsiezVXCEqKkSExz23pNpCoy40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFwLsb6OgVYBn3UHvgSKfiNPpjC9YcA7nmNG6jJd9i8FjIvjXDIRZ4SUyRbVAe+HJ
         f1UJmKb3dLz8n2a8GQS/XqoJnCmS7LKpGt+Z8zPNX0BH17NuM5MO+qfNz4sPyyYB4C
         2WtPSvdrq1pTgGdIZj2c0IQlFL/PyGCra/Daf22U=
Date:   Tue, 5 Feb 2019 14:59:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Youn <john.youn@synopsys.com>
Subject: Re: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
Message-ID: <20190205205922.GB7268@google.com>
References: <87o97wrbef.fsf@mntmn.com>
 <CAErSpo4T91kbXXuMSCqrDk=_HD+6GZ64WVZsvhSOtW=L89Pf0g@mail.gmail.com>
 <30102591E157244384E984126FC3CB4F639BEC73@us01wembx1.internal.synopsys.com>
 <30102591E157244384E984126FC3CB4F639BECAB@us01wembx1.internal.synopsys.com>
 <20190201085906.tqp6ysbb65n7jfkv@wunner.de>
 <30102591E157244384E984126FC3CB4F639BF351@us01wembx1.internal.synopsys.com>
 <20190205200957.GA7268@google.com>
 <30102591E157244384E984126FC3CB4F639C0F73@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30102591E157244384E984126FC3CB4F639C0F73@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 05, 2019 at 08:38:58PM +0000, Thinh Nguyen wrote:
> Hi Bjorn,
> 
> Bjorn Helgaas wrote:
> > On Fri, Feb 01, 2019 at 08:27:00PM +0000, Thinh Nguyen wrote:
> >> Lukas Wunner wrote:
> >>> On Thu, Jan 31, 2019 at 11:46:23PM +0000, Thinh Nguyen wrote:
> >>>> --- a/drivers/pci/quirks.c
> >>>> +++ b/drivers/pci/quirks.c
> >>>> @@ -629,6 +629,9 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)
> >>>>  {
> >>>>         u32 class = pdev->class;
> >>>>  
> >>>> +       if (class != PCI_CLASS_SERIAL_USB_XHCI)
> >>>> +               return;
> >>>> +
> >>>>         switch (pdev->device) {
> >>>>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:
> >>>>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:
> >>> Please use DECLARE_PCI_FIXUP_CLASS_HEADER() instead.
> >> Sure. That's a better option. Can you test this with your setup?
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index b0a413f3f7ca..f46e7de9e15d 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -639,8 +639,8 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)
> >>                 break;
> >>         }
> >>  }
> >> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
> >> -                        quirk_synopsys_haps);
> >> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
> >> +               PCI_CLASS_SERIAL_USB_XHCI, 0, quirk_synopsys_haps);
> >>  
> >>  /*
> >>   * Let's make the southbridge information explicit instead of having to
> >>
> >>
> > Can we get a formal patch, including details about the issue (I assume
> > Synopsys released two different parts with Device ID 0xabcd) and a
> > signed-off-by?
> >
> > I'd like to get this into for-linus as soon as possible for v5.0.
> 
> I already submitted a patch for this. Please review patch subject
> "[PATCH] PCI: Check for USB xHCI class for HAPS platform".

OK, maybe I'm missing something.  I don't see it on the linux-pci list
[1] or the PCI patchwork [2] yet.  Maybe it's still making its way
through the mailing list servers.  If you have a URL to the archive or
patchwork, let me know.

Bjorn

[1] https://lore.kernel.org/linux-pci/
[2] https://patchwork.ozlabs.org/project/linux-pci/list
