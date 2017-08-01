Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:34179 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752103AbdHAW1E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Aug 2017 18:27:04 -0400
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
 <20170725205753.4735-15-logang@deltatee.com> <20170801191050.GJ4186@kudzu.us>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <dda576ad-d3ca-814b-f0cf-478cbb61adf2@deltatee.com>
Date: Tue, 1 Aug 2017 16:26:57 -0600
MIME-Version: 1.0
In-Reply-To: <20170801191050.GJ4186@kudzu.us>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 14/16] switchtec_ntb: implement scratchpad registers
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 01/08/17 01:10 PM, Jon Mason wrote:
> It would probaly be better if I remarked about the SPADs in the actual
> patch about the SPADS :)
> 
> The whole point of using the SPADs in the NTB driver was to workaround
> the problems establishing a connection between the two sides of the
> NTB and where everything lives.  So, using a MW to get around the
> SPADs is sort of backwards (and slightly funny).  I realize you are
> trying to use the existing transport with minimal changes to enable
> your hardware, and thus this makes logical sense to you.  However, if
> the SPADs are not really needed, then we should either remove them
> from the transport (or use them for something else).
>
> Per my comment in the other patch, I'm amenable to take this series
> as-is, assuming you are willing to address this design issue in the
> near future.  Thoughts?

Yes, I agree. I'd be willing to help but it seems the clients are
written the way they are for the other drivers, so it's their needs
(which I'm not fully aware of) that have to be considered.

I've also made all the other changes you sent as well as the file rename
Dave requested. Once I see the bug fix patch you were going to pull hit
ntb-next I'll rebase, test and resubmit.

Thanks,

Logan
