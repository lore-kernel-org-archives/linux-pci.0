Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:55980 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbdAaRtV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jan 2017 12:49:21 -0500
Date: Tue, 31 Jan 2017 10:49:16 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Logan Gunthorpe <logang@deltatee.com>
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
Subject: Re: [PATCH 1/1] MicroSemi Switchtec management interface driver
Message-ID: <20170131104916.0f187309@lwn.net>
In-Reply-To: <57658098-b24a-cb25-b2e3-ccf8fcbf8fe5@deltatee.com>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
        <1485882204-26947-2-git-send-email-logang@deltatee.com>
        <20170131172630.GB12595@kroah.com>
        <57658098-b24a-cb25-b2e3-ccf8fcbf8fe5@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 31 Jan 2017 10:35:44 -0700
Logan Gunthorpe <logang@deltatee.com> wrote:

> > And don't dump a .txt file into Documentation/ anymore, people are
> > working to move to the newer format.  
> 
> Fair. I wasn't sure where a good place to put it was. Any suggestions?

We're working toward a rational document hierarchy using the sphinx system:

	https://lwn.net/Articles/692704/
	https://lwn.net/Articles/692704/
	https://static.lwn.net/kerneldoc/doc-guide/index.html

The good news is that your switchtec.txt file is already 99% in the RST
format, so there is little or nothing to do there.

The bad news is that we don't quite have a place for it yet.  This is
really user-space developer documentation, and we don't have a sub-book
for that.  I expect that to change pretty soon, and I might even toss
together a bare beginning for 4.11, but that hasn't happened yet.

If you would like to learn the ropes and make one, that would be more than
great :)  Alternatively, I'd suggest just leaving the document as-is, and
I'll put it toward the top of the list of things to move into place once I
get that book started.

Thanks,

jon
