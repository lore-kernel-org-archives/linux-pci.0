Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:35393 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbdBWWTS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Feb 2017 17:19:18 -0500
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <2eb2b814-d621-5d8d-8366-4c4e9f789208@deltatee.com>
 <e27a2363-1b11-f74b-532d-7de089875c90@deltatee.com>
 <20170223221452.GA18601@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
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
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bc97d07e-f822-6df4-5695-5aa341271df0@deltatee.com>
Date: Thu, 23 Feb 2017 15:19:09 -0700
MIME-Version: 1.0
In-Reply-To: <20170223221452.GA18601@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v2 0/4] New Microsemi PCI Switch Management Driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks Bjorn! I understand your busy and we appreciate your time in this
matter.

I'll prepare a v3 with a collected set of tags shortly. We're more than
happy to clean this up to make your job as easy as possible. We were
just looking for direction in how to move this forward.

Logan

On 23/02/17 03:14 PM, Bjorn Helgaas wrote:
> On Thu, Feb 23, 2017 at 01:36:51PM -0700, Logan Gunthorpe wrote:
>> Hello,
>>
>> We're still waiting on any kind of response from Bjorn. (If you're
>> listening please say something!)
>>
>> Does anyone have any suggestions for dealing with an unresponsive
>> maintainer? Or a way for us to move forward with this quickly and get it
>> merged?
> 
> I try to deal with regressions first and other bug fixes second.
> After that, I look at things that add new functionality.  I try to
> look at the new stuff in roughly chronological order, as you would see
> here:
> 
> https://patchwork.ozlabs.org/project/linux-pci/list/?order=date&page=1
> 
> If other folks have feedback, as they did on your 12/17, 1/31, and
> even the 2/2 posting, I generally let that get sorted out before I
> look at it.  I apologize that I haven't responded to your queries
> about posting a v3 vs updating v2.
> 
> To answer that question, it's much simpler for me to deal with a
> fresh, clean new series than it is to tweak things in an
> already-posted series, partly because a series with discussion other
> than simple acks and reviewed-bys looks more like work-in-progress.
> 
> Bjorn
> 
