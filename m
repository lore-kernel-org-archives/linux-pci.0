Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34911 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdBSVnZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Feb 2017 16:43:25 -0500
MIME-Version: 1.0
In-Reply-To: <20e55da4-b3c1-7c57-15cf-b0aa52442e18@deltatee.com>
References: <20170210145124.GA24594@kroah.com> <1486749440-24309-1-git-send-email-logang@deltatee.com>
 <20e55da4-b3c1-7c57-15cf-b0aa52442e18@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 19 Feb 2017 13:43:23 -0800
Message-ID: <CAA9_cmfbJEPhCj_Ukav841zW5P=uYkTir4jFRTKyOvzHmJNmVg@mail.gmail.com>
Subject: Re: [PATCH] switchtec: cleanup cdev init
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Wei Zhang <wzhang@fb.com>, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Stephen Bates <stephen.bates@microsemi.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 18, 2017 at 12:22 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Hi,
>
> Please don't apply this patch and instead apply the switchtec driver as
> we submitted in v2. As per the discussion in [1], not using the cdev's
> kobj parent results in incorrect reference counting and a possible use
> of the cdev after its containing structure is freed.

Is this race present for all file operations? I've only seen it with
mmap() and late faults. So if these other drivers do not support mmap
it's not clear they can trigger the failure.
