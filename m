Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
To: Keith Busch <keith.busch@intel.com>,
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
        Wei Zhang <wzhang@fb.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 10 Feb 2017 10:57:20 -0700
Message-Id: <1486749440-24309-1-git-send-email-logang@deltatee.com>
In-Reply-To: <20170210145124.GA24594@kroah.com>
References: <20170210145124.GA24594@kroah.com>
Subject: [PATCH] switchtec: cleanup cdev init
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per a suggestion from Greg Kroah-Hartman [1], don't set the cdev's
kobject parent. This allows us to use device_register instead of init
and add.

[1] https://lkml.org/lkml/2017/2/10/370
---
 drivers/pci/switch/switchtec.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 82bfd18..014eaec 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1222,24 +1222,23 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 		return ERR_PTR(minor);
 
 	dev = &stdev->dev;
-	device_initialize(dev);
 	dev->devt = MKDEV(MAJOR(switchtec_devt), minor);
-	dev->class = switchtec_class;
-	dev->parent = &pdev->dev;
-	dev->groups = switchtec_device_groups;
-	dev->release = stdev_release;
-	dev_set_name(dev, "switchtec%d", minor);
 
 	cdev = &stdev->cdev;
 	cdev_init(cdev, &switchtec_fops);
 	cdev->owner = THIS_MODULE;
-	cdev->kobj.parent = &dev->kobj;
 
 	rc = cdev_add(&stdev->cdev, dev->devt, 1);
 	if (rc)
 		goto err_cdev;
 
-	rc = device_add(dev);
+	dev->class = switchtec_class;
+	dev->parent = &pdev->dev;
+	dev->groups = switchtec_device_groups;
+	dev->release = stdev_release;
+	dev_set_name(dev, "switchtec%d", minor);
+
+	rc = device_register(dev);
 	if (rc) {
 		cdev_del(&stdev->cdev);
 		put_device(dev);
-- 
2.1.4
