Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:57684 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbdAaRgc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jan 2017 12:36:32 -0500
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
 <1485882204-26947-2-git-send-email-logang@deltatee.com>
 <20170131172630.GB12595@kroah.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <57658098-b24a-cb25-b2e3-ccf8fcbf8fe5@deltatee.com>
Date: Tue, 31 Jan 2017 10:35:44 -0700
MIME-Version: 1.0
In-Reply-To: <20170131172630.GB12595@kroah.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH 1/1] MicroSemi Switchtec management interface driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 31/01/17 10:26 AM, Greg Kroah-Hartman wrote:
> That's one big patch to review, would you want to do that?

Sorry, will do.

> Can you break it up into smaller parts?  At least put the documentation
> separately, right?

Ha, funny. Last time I sent a patch someone asked for the documentation
to be in the same patch. But I can easily split this up.

> And don't dump a .txt file into Documentation/ anymore, people are
> working to move to the newer format.

Fair. I wasn't sure where a good place to put it was. Any suggestions?

> Also, please rebase against Linus's tree at the least, we can't go back
> in time and apply this to the 4.9 kernel tree.

Will do.

> Why a .h file for a single .c file?

I wanted to keep the hardware defining structs and macros in a separate
file for future expansion. This hardware is also capable of some NTB
functions which may find it's way into the kernel in the future.

> Also, why a whole new directory?

We didn't feel it fit in the pci director which was for standard pci
stuff. We're more than open to other suggestions as to where this code
belongs.

Thanks,

Logan

