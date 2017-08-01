Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36877 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdHASHe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2017 14:07:34 -0400
Received: by mail-qk0-f194.google.com with SMTP id x77so2315899qka.4
        for <linux-pci@vger.kernel.org>; Tue, 01 Aug 2017 11:07:34 -0700 (PDT)
Date: Tue, 1 Aug 2017 14:07:31 -0400
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
Message-ID: <20170801180731.GC4186@kudzu.us>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725205753.4735-6-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 25, 2017 at 02:57:42PM -0600, Logan Gunthorpe wrote:
> After the link tests, there is a race on one side of the test for
> the link coming up. It's possible, in some cases, for the test script
> to write to the 'peer_trans' files before the link has come up.
> 
> To fix this, we simply use the link event file to ensure both sides
> see the link as up before continuning.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

This looks like a bug fix.  Assuming this is the case, I can pull it
out, add a "Fixes" line, and add it to my bug fixes branch.  Is this
the case?

Thanks,
Jon

> ---
>  tools/testing/selftests/ntb/ntb_test.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
> index 1c12b5855e4f..5fc7ad359e21 100755
> --- a/tools/testing/selftests/ntb/ntb_test.sh
> +++ b/tools/testing/selftests/ntb/ntb_test.sh
> @@ -333,6 +333,10 @@ function ntb_tool_tests()
>  	link_test $LOCAL_TOOL $REMOTE_TOOL
>  	link_test $REMOTE_TOOL $LOCAL_TOOL
>  
> +	#Ensure the link is up on both sides before continuing
> +	write_file Y $LOCAL_TOOL/link_event
> +	write_file Y $REMOTE_TOOL/link_event
> +
>  	for PEER_TRANS in $(ls $LOCAL_TOOL/peer_trans*); do
>  		PT=$(basename $PEER_TRANS)
>  		write_file $MW_SIZE $LOCAL_TOOL/$PT
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20170725205753.4735-6-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
