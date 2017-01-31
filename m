Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:58015 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbdAaSzW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jan 2017 13:55:22 -0500
To: Jonathan Corbet <corbet@lwn.net>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
 <1485882204-26947-2-git-send-email-logang@deltatee.com>
 <20170131172630.GB12595@kroah.com>
 <57658098-b24a-cb25-b2e3-ccf8fcbf8fe5@deltatee.com>
 <20170131104916.0f187309@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Wei Zhang <wzhang@fb.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cb0beb92-3f7e-e661-d6c4-430ba1a09b78@deltatee.com>
Date: Tue, 31 Jan 2017 11:32:24 -0700
MIME-Version: 1.0
In-Reply-To: <20170131104916.0f187309@lwn.net>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH 1/1] MicroSemi Switchtec management interface driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 31/01/17 10:49 AM, Jonathan Corbet wrote:
> The good news is that your switchtec.txt file is already 99% in the RST
> format, so there is little or nothing to do there.
> 
> The bad news is that we don't quite have a place for it yet.  This is
> really user-space developer documentation, and we don't have a sub-book
> for that.  I expect that to change pretty soon, and I might even toss
> together a bare beginning for 4.11, but that hasn't happened yet.
> 
> If you would like to learn the ropes and make one, that would be more than
> great :)  Alternatively, I'd suggest just leaving the document as-is, and
> I'll put it toward the top of the list of things to move into place once I
> get that book started.

Thanks Jon. I took a look at the documentation and it doesn't look too
difficult. But I don't really feel qualified to make some of the
decisions necessary to create the new book. (ie names, locations, etc.)
And I don't really want that churn in this patchset. So we'll leave it
where it is for now.

I have cleaned up some of the RST format for v2 though.

Logan
