Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] New Microsemi PCI Switch Management Driver
To: Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <2eb2b814-d621-5d8d-8366-4c4e9f789208@deltatee.com>
 <e27a2363-1b11-f74b-532d-7de089875c90@deltatee.com>
CC: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <ff4346ab-5a56-c9e1-efb7-7a289e663bbb@fb.com>
Date: Thu, 23 Feb 2017 13:52:15 -0700
MIME-Version: 1.0
In-Reply-To: <e27a2363-1b11-f74b-532d-7de089875c90@deltatee.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/23/2017 01:36 PM, Logan Gunthorpe wrote:
> Hello,
> 
> We're still waiting on any kind of response from Bjorn. (If you're
> listening please say something!)
> 
> Does anyone have any suggestions for dealing with an unresponsive
> maintainer? Or a way for us to move forward with this quickly and get it
> merged?
> 
> ie. Can anyone else pick this up through another route? In the end, it's
> just a fairly basic driver and doesn't touch any core PCI functionality
> and we've had a fair amount of review from other kernel contributors,
> all of which we've addressed.

I'll add that we're already using this driver internally, would be
great to get it into mainline.

What is holding this up?

-- 
Jens Axboe
