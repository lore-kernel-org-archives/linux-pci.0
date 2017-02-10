Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 Feb 2017 15:51:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
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
Subject: Re: [PATCH v2 1/4] MicroSemi Switchtec management interface driver
Message-ID: <20170210145124.GA24594@kroah.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <1486058763-7730-2-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486058763-7730-2-git-send-email-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 02, 2017 at 11:06:00AM -0700, Logan Gunthorpe wrote:
> +	cdev = &stdev->cdev;
> +	cdev_init(cdev, &switchtec_fops);
> +	cdev->owner = THIS_MODULE;
> +	cdev->kobj.parent = &dev->kobj;

Minor nit, the kobject in a cdev is unlike any other kobject you have
ever seen, don't mess with it, it's not doing anything like you think it
is doing.  So no need to set the parent field.

thanks,

greg k-h
