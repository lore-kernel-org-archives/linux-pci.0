Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33576 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdBWUzN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2017 15:55:13 -0500
Date: Thu, 23 Feb 2017 21:55:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
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
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v2 0/4] New Microsemi PCI Switch Management Driver
Message-ID: <20170223205505.GA10576@kroah.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <2eb2b814-d621-5d8d-8366-4c4e9f789208@deltatee.com>
 <e27a2363-1b11-f74b-532d-7de089875c90@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e27a2363-1b11-f74b-532d-7de089875c90@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 23, 2017 at 01:36:51PM -0700, Logan Gunthorpe wrote:
> Hello,
> 
> We're still waiting on any kind of response from Bjorn. (If you're
> listening please say something!)
> 
> Does anyone have any suggestions for dealing with an unresponsive
> maintainer? Or a way for us to move forward with this quickly and get it
> merged?

It's the middle of the merge window, nothing new can go in right now.
Wait until after 4.11-rc1 comes out before expecting for maintainers to
be able to start reviewing and discussing new things like this.

patience please,

greg k-h
