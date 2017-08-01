Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:33256 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbdHASJY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Aug 2017 14:09:24 -0400
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
 <20170725205753.4735-6-logang@deltatee.com> <20170801180731.GC4186@kudzu.us>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <46065aa6-0fe8-59d5-63dc-3beb66b69154@deltatee.com>
Date: Tue, 1 Aug 2017 12:09:18 -0600
MIME-Version: 1.0
In-Reply-To: <20170801180731.GC4186@kudzu.us>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 05/16] ntb: ntb_test: ensure the link is up before
 trying to configure the mws
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 01/08/17 12:07 PM, Jon Mason wrote:
> On Tue, Jul 25, 2017 at 02:57:42PM -0600, Logan Gunthorpe wrote:
>> After the link tests, there is a race on one side of the test for
>> the link coming up. It's possible, in some cases, for the test script
>> to write to the 'peer_trans' files before the link has come up.
>>
>> To fix this, we simply use the link event file to ensure both sides
>> see the link as up before continuning.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> This looks like a bug fix.  Assuming this is the case, I can pull it
> out, add a "Fixes" line, and add it to my bug fixes branch.  Is this
> the case?

Sure, yup, if you'd like to do that I'm fine with it. Technically, I
don't think the bug can be triggered until the patches later in the
series are applied.

Thanks,

Logan
