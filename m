Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42079 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeAXEHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jan 2018 23:07:11 -0500
Received: by mail-qt0-f195.google.com with SMTP id c2so7162541qtn.9
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2018 20:07:11 -0800 (PST)
Date: Tue, 23 Jan 2018 23:07:08 -0500
From: Jon Mason <jdmason@kudzu.us>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ntb_hw_switchtec: Make function
 switchtec_ntb_remove() static
Message-ID: <20180124040707.GB20474@kudzu.us>
References: <1516673361-170397-1-git-send-email-weiyongjun1@huawei.com>
 <14b5eb05-c152-6a30-d590-881600a8a72f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14b5eb05-c152-6a30-d590-881600a8a72f@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 09:35:52AM -0700, Logan Gunthorpe wrote:
> Looks good, thanks.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Applied to ntb-next

Thanks,
Jon

> 
> Logan
> 
> 
> On 22/01/18 07:09 PM, Wei Yongjun wrote:
> > Fixes the following sparse warnings:
> > 
> > drivers/ntb/hw/mscc/ntb_hw_switchtec.c:1552:6: warning:
> >   symbol 'switchtec_ntb_remove' was not declared. Should it be static?
> > 
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >   drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > index a1d547b6..f624ae2 100644
> > --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > @@ -1549,8 +1549,8 @@ static int switchtec_ntb_add(struct device *dev,
> >   	return rc;
> >   }
> > -void switchtec_ntb_remove(struct device *dev,
> > -			  struct class_interface *class_intf)
> > +static void switchtec_ntb_remove(struct device *dev,
> > +				 struct class_interface *class_intf)
> >   {
> >   	struct switchtec_dev *stdev = to_stdev(dev);
> >   	struct switchtec_ntb *sndev = stdev->sndev;
> > 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/14b5eb05-c152-6a30-d590-881600a8a72f%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
