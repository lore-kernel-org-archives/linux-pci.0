Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:43517 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752112AbdFSU1x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jun 2017 16:27:53 -0400
To: Jon Mason <jdmason@kudzu.us>
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170619200659.GA20437@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c8ef3317-37cb-f43b-3422-fae89fdc1d0e@deltatee.com>
Date: Mon, 19 Jun 2017 14:27:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170619200659.GA20437@kudzu.us>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 19/06/17 02:07 PM, Jon Mason wrote:
> I think this code is of quality enough to go from an RFC to a standard
> patch, and we can nit pick it to death there ;-)

Thanks!

> Please rebase on ntb-next (which I believe you are already doing), and
> resbutmit.

I'll try to get the rebase done and all the feedback so far applied by
the end of the week and resend a v1.

> I'm thinking that we'll want to keep this series all in one place.
> So, #2 sounds like the best option.  But, I need Bjorns $0.02 on this.

I was thinking #2 was the best choice as well but really it's for you
maintainers to decide. And, yes, we'd want to get Bjorn's ack.

> FYI, I ran smatch on the patches and got this.  Please correct them in
> v2 (or v1 of the non-RFC...however you want to think of it).
> drivers/pci/switch/switchtec.c:484 switchtec_dev_read() error: double unlock 'mutex:&stdev->mrpc_mutex'
> drivers/pci/switch/switchtec.c:506 switchtec_dev_read() error: double unlock 'mutex:&stdev->mrpc_mutex'
> drivers/pci/switch/switchtec.c:513 switchtec_dev_read() warn: inconsistent returns 'mutex:&stdev->mrpc_mutex'.

This looks like a false positive to me. The code looks correct. smatch
may have been confused by the fact that the lock is taken by two calls
to the static function 'lock_mutex_and_test_alive'.

This is also part of the switchtec management driver that's already in
the kernel and not part of the NTB related patches I sent.

Logan
