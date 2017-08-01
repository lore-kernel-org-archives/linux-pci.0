Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:37759 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbdHASQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2017 14:16:24 -0400
Received: by mail-qt0-f176.google.com with SMTP id 16so13958088qtz.4
        for <linux-pci@vger.kernel.org>; Tue, 01 Aug 2017 11:16:23 -0700 (PDT)
Date: Tue, 1 Aug 2017 14:16:20 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v3 05/16] ntb: ntb_test: ensure the link is up before
 trying to configure the mws
Message-ID: <20170801181620.GF4186@kudzu.us>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-6-logang@deltatee.com>
 <20170801180731.GC4186@kudzu.us>
 <46065aa6-0fe8-59d5-63dc-3beb66b69154@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46065aa6-0fe8-59d5-63dc-3beb66b69154@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 01, 2017 at 12:09:18PM -0600, Logan Gunthorpe wrote:
> 
> On 01/08/17 12:07 PM, Jon Mason wrote:
> > On Tue, Jul 25, 2017 at 02:57:42PM -0600, Logan Gunthorpe wrote:
> >> After the link tests, there is a race on one side of the test for
> >> the link coming up. It's possible, in some cases, for the test script
> >> to write to the 'peer_trans' files before the link has come up.
> >>
> >> To fix this, we simply use the link event file to ensure both sides
> >> see the link as up before continuning.
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> > 
> > This looks like a bug fix.  Assuming this is the case, I can pull it
> > out, add a "Fixes" line, and add it to my bug fixes branch.  Is this
> > the case?
> 
> Sure, yup, if you'd like to do that I'm fine with it. Technically, I
> don't think the bug can be triggered until the patches later in the
> series are applied.

Given how trivial it is, I think closing the loop here on this would
be a good thing (and one less patch for your v4).

> 
> Thanks,
> 
> Logan
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/46065aa6-0fe8-59d5-63dc-3beb66b69154%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
