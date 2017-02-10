Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <1486058763-7730-2-git-send-email-logang@deltatee.com>
 <20170210145124.GA24594@kroah.com>
 <ca970e7a-b062-d351-9a04-49a9e05955b5@deltatee.com>
 <20170210165550.GA23959@kroah.com>
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
Message-ID: <9a1d4150-b329-1a69-9efd-f06da32afe02@deltatee.com>
Date: Fri, 10 Feb 2017 10:03:10 -0700
MIME-Version: 1.0
In-Reply-To: <20170210165550.GA23959@kroah.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v2 1/4] MicroSemi Switchtec management interface driver
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/02/17 09:55 AM, Greg Kroah-Hartman wrote:
> Yes, but try it yourself to verify it really is correct :)

Yes, of course... turns out it wasn't. I accidentally refereed to dev
before I assigned it. I had mainly just wanted your feedback to ensure
that switching to device_register made sense.

> And it can just be an add-on patch, no need to respin a whole new
> version for just that simple change, it doesn't hurt anything as-is,
> it's just "not needed".

Ok... How should I do that exactly? Attempt to reply to the thread with
another patch?

Thanks,

Logan
