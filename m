Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdFQFKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jun 2017 01:10:05 -0400
Date: Sat, 17 Jun 2017 07:09:59 +0200
From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Jon Mason' <jdmason@kudzu.us>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>,
        'Stephen Bates' <sbates@raithlin.com>,
        Sergey.Semin@t-platforms.ru
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
Message-ID: <20170617050959.GC6040@kroah.com>
References: <20170615203729.9009-1-logang@deltatee.com>
 <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
 <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
 <20170616163324.GA15472@mobilestation>
 <883bdb76-972c-7de9-0208-2d0933f192d4@deltatee.com>
 <20170616183824.GA5175@mobilestation.tp-local.ru>
 <33b6c321-c0af-7340-8e8e-e929a00005c7@deltatee.com>
 <20170616202100.GA24969@mobilestation.tp-local.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170616202100.GA24969@mobilestation.tp-local.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 16, 2017 at 11:21:00PM +0300, Serge Semin wrote:
> On Fri, Jun 16, 2017 at 01:34:59PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> > Now, if you'd like to actually review the code I'd be happy to address
> > any concerns you find. I won't be responding to any more philosophical
> > arguments or bike-shedding over the format of the patch.
> > 
> 
> I don't want to review a patchset, which isn't properly formated.

Ah, but the patchset does seem to properly formatted.  At least it's
easy for me to review as-published, while a much smaller number of
patches, making much larger individual patches, would be much much
harder to review.

But what do I know...

Oh wait, I review more kernel patches than anyone else :)

Logan, given that you need to rebase these on the "new" ntb api (and why
the hell is that tree on github? We can't take kernel git pulls from
github), is it worth reviewing this patch series as-is, or do you want
us to wait?

thanks,

greg k-h
