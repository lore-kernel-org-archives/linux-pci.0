Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:33292 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbdHASRx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Aug 2017 14:17:53 -0400
To: Jon Mason <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-7-logang@deltatee.com> <20170801181452.GE4186@kudzu.us>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c4235dc9-90d0-1e68-7c73-c2a5bec83712@deltatee.com>
Date: Tue, 1 Aug 2017 12:17:47 -0600
MIME-Version: 1.0
In-Reply-To: <20170801181452.GE4186@kudzu.us>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 06/16] ntb: ensure ntb_mw_get_align() is only called
 when the link is up
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey,

On 01/08/17 12:14 PM, Jon Mason wrote:
> This also looks like a bug fix.  However, given that it is a little more
> invasive and no one reporting any problems with it, I'm less apt to
> pull it into the bug-fixes branch without anyone compilaining of a
> bug (lest I break something in -stable).

Yes, 6 and 7 change a semantic of that function. I wouldn't call them
bug fixes. But you can't pull 7 without pulling 6, as 7 would break
everything unless the change in 6 occurs.

Thanks,

Logan
