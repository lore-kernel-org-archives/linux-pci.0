Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <1486058763-7730-2-git-send-email-logang@deltatee.com>
 <20170210145124.GA24594@kroah.com>
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
Message-ID: <ca970e7a-b062-d351-9a04-49a9e05955b5@deltatee.com>
Date: Fri, 10 Feb 2017 09:48:37 -0700
MIME-Version: 1.0
In-Reply-To: <20170210145124.GA24594@kroah.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v2 1/4] MicroSemi Switchtec management interface driver
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey Greg,

Thanks so much for the review.

On 10/02/17 07:51 AM, Greg Kroah-Hartman wrote:
> On Thu, Feb 02, 2017 at 11:06:00AM -0700, Logan Gunthorpe wrote:
>> +	cdev = &stdev->cdev;
>> +	cdev_init(cdev, &switchtec_fops);
>> +	cdev->owner = THIS_MODULE;
>> +	cdev->kobj.parent = &dev->kobj;
> 
> Minor nit, the kobject in a cdev is unlike any other kobject you have
> ever seen, don't mess with it, it's not doing anything like you think it
> is doing.  So no need to set the parent field.

Ok, that makes sense. I'll do a v3 shortly.

I copied this from drivers/dax/dax.c so when I have a spare moment I'll
submit a patch to remove it from there as well.

Just to make sure I get this right without extra churn: does this look
correct?


        cdev = &stdev->cdev;
        cdev_init(cdev, &switchtec_fops);
        cdev->owner = THIS_MODULE;

        rc = cdev_add(&stdev->cdev, dev->devt, 1);
        if (rc)
                goto err_cdev;

        dev = &stdev->dev;
        dev->devt = MKDEV(MAJOR(switchtec_devt), minor);
        dev->class = switchtec_class;
        dev->parent = &pdev->dev;
        dev->groups = switchtec_device_groups;
        dev->release = stdev_release;
        dev_set_name(dev, "switchtec%d", minor);

        rc = device_register(dev);
        if (rc) {
                cdev_del(&stdev->cdev);
                put_device(dev);
                return ERR_PTR(rc);
        }


Thanks,

Logan
