Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:23944 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab3GXEBJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2013 00:01:09 -0400
Message-ID: <51EF516F.6010102@huawei.com>
Date: Wed, 24 Jul 2013 12:00:47 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH] PCI: Separate stop and remove devices in pciehp
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org> <1374261258-23036-2-git-send-email-yinghai@kernel.org> <CAErSpo78DU3bPwkVOt=1XD08y9iD38+wUOp2+GVxO7P68TOOjg@mail.gmail.com> <CAE9FiQUyVUssJx8eZK9kabS99CD6ry-UnJ9q1-q+f53Fx+tjng@mail.gmail.com> <20130723155645.GA18422@google.com> <CAE9FiQUQirapRONeb1ndOoKsiYviyXJVx3wZTcgzJj7bHX-1xQ@mail.gmail.com>
In-Reply-To: <CAE9FiQUQirapRONeb1ndOoKsiYviyXJVx3wZTcgzJj7bHX-1xQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,
   The third patch make pci_stop_dev call pci_disable_sriov(dev).
It looks asymmetrical, because pci_enable_sriov(dev, NR_VIRTFN) always
be called by device driver. Why not work around this in device driver like ixgbe?
I'm not familiar with SRIOV, so I'm just a bit puzzled.

Thanks!
Yijing.

------------------------------------------------------------
Some driver (like ixgbe) does not call pci_disable_sriov() if
sriov is enabled via /sys/.../sriov_numvfs setting.
ixgbe does allow driver for PF get detached, but still have VFs
around.

But how about PF get removed via /sys or pciehp finally?

During hot-remove, VF will still hold one ref to PF and it
prevent PF to be removed.
That make the next hot-add fails, as old PF dev struct is still around.

We need to add pci_disable_sriov() calling during stop PF .

Need this one for v3.11

-v2: Accoring to Bjorn, move that calling to pci_stop_dev.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>
Cc: Donald Dutile <ddutile@redhat.com>
Cc: Greg Rose <gregory.v.rose@intel.com>

---
 drivers/pci/remove.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/pci/remove.c
===================================================================
--- linux-2.6.orig/drivers/pci/remove.c
+++ linux-2.6/drivers/pci/remove.c
@@ -25,6 +25,8 @@ static void pci_stop_dev(struct pci_dev
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
 		device_del(&dev->dev);
+		/* remove VF, if PF driver skip that */
+		pci_disable_sriov(dev);
 		dev->is_added = 0;
 	}

