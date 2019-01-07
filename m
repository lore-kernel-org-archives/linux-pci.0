Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D30C43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 22:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794FA2087F
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 22:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfAGW5W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:57:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:56705 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfAGW5W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jan 2019 17:57:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 14:57:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="114916979"
Received: from jprestwo.jf.intel.com ([10.54.74.49])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jan 2019 14:57:21 -0800
Message-ID: <e0edb0e102ad2ba386a47e97b4e9930fdce71728.camel@linux.intel.com>
Subject: Re: [PATCH] PCI: quirks: add vendor ID for AR9462 card
From:   James Prestwood <james.prestwood@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Jan 2019 15:02:11 -0800
In-Reply-To: <20190107220811.GA165042@google.com>
References: <20190107213248.3034-1-james.prestwood@linux.intel.com>
         <20190107220811.GA165042@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-01-07 at 16:08 -0600, Bjorn Helgaas wrote:
> [+cc Alex, Bharat, LKML]
> 
> Hi James,
> 
> Thanks for finding this issue and for the patch.
> 
> Is there any chance you have a PCIe analyzer and could investigate
> what's going on at that level?  The bus reset should be fairly
> similar
> to what happens on a cold boot, and obviously *that* works, so I
> wonder if we can figure out what the difference here is.

I don't have a PCIe analyzer (unless thats just a piece of software I
could download). Maybe I should have included a cover letter about what
exactly is happening in my testing:

I am using PCI passthough with various wireless hardware, all of which
worked fine except this Ath9k card. If I tried to pass through this
card my host machine would completely lock up/freeze when starting the
VM, and I would have to hard reboot. I asked on the linux-wireless
mailing list (since it seemed to be specific to the Ath9k card) and it
was suggested to add that line to quirks.c, which did resolve the
issue.

Beyond that, its really all I know. I am not at all knowledgeable about
how PCI actually works :) (or really what this patch is even doing).
Since it was so simple and fixed my issue I figured I should try and
upstream it.

I wish I could be of more help hardware wise. If there is anything
software wise I could run to get more info I can do that.

Thanks,
James
> 
> If this is actually broken somehow in the hardware, can you dig up a
> hardware erratum and include a URL here?
> 
> If there's any chance we could fix or work around this in the kernel,
> I'd rather do that than extend this quirk to more devices.
> 
> FWIW, here's a similar report, which hasn't been resolved yet:
> 
https://lore.kernel.org/linux-pci/20181127083454.26560-1-Bharat.Bhushan@nxp.com
> 
> On Mon, Jan 07, 2019 at 01:32:48PM -0800, James Prestwood wrote:
> > This card has similar issues with bus reset as the others present
> > in
> > this list.
> > 
> > Signed-off-by: James Prestwood <james.prestwood@linux.intel.com>
> > ---
> >  drivers/pci/quirks.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index ef7143a274e0..d9d4a95b0309 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3379,6 +3379,7 @@
> > DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030,
> > quirk_no_bus_reset);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032,
> > quirk_no_bus_reset);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c,
> > quirk_no_bus_reset);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033,
> > quirk_no_bus_reset);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034,
> > quirk_no_bus_reset);
> >  
> >  /*
> >   * Root port on some Cavium CN8xxx chips do not successfully
> > complete a bus
> > -- 
> > 2.17.1
> > 

