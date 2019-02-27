Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F79C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 13:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FACE2075B
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 13:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfB0N25 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:28:57 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46430 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfB0N25 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 08:28:57 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id e5999ebf1e3cd455; Wed, 27 Feb 2019 14:28:55 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Dongdong Liu <liudongdong3@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        mika.westerberg@linux.intel.com,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: Question about Hotplug and PME deadlock issue
Date:   Wed, 27 Feb 2019 14:27:23 +0100
Message-ID: <1678598.KZoi8r3LJQ@aspire.rjw.lan>
In-Reply-To: <20190227123159.r5qts23qupqxiwcx@wunner.de>
References: <c7697e7c-e1af-13e4-8491-0a3996e6ab5d@huawei.com> <20190227123159.r5qts23qupqxiwcx@wunner.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, February 27, 2019 1:31:59 PM CET Lukas Wunner wrote:
> On Wed, Feb 27, 2019 at 07:52:16PM +0800, Dongdong Liu wrote:
> > We do some test to trigger hotplug while do sysfs "remove" operation,
> > then met a deadlock issue.
> > 
> > pciehp 0000:00:0c.0:pcie004: Slot(0-1): Link Up
> > echo 1 > 0000\:00\:0c.0/remove
> > 
> > PME and hotplug share an MSI/MSI-X vector.
> > The sysfs "remove" operation will call the below function.
> > remove_store()
> >   pci_stop_and_remove_bus_device_locked()
> >     pci_lock_rescan_remove()
> >     pci_stop_and_remove_bus_device()
> >       ...
> >       pcie_pme_remove()
> >         synchronize_irq()   // Here will wait for hotplug IRQ handler
> >     pci_unlock_rescan_remove();
> 
> This is (at least) a bug in the PME driver.  I'm not familiar with
> that driver, so adding Keith Busch to cc.
> 
> The bug is that pcie_pme_remove() invokes pcie_pme_suspend(), which
> calls synchronize_irq(), which waits for the hardirq handlers and
> IRQ threads of all drivers sharing the IRQ to finish.
> 
> pcie_pme_remove() then calls free_irq() which *again* waits for a
> running hardirq handler and thread to finish, however it does not
> wait for those of drivers sharing the IRQ to finish since 4.19,
> see commit 519cc8652b3a ("genirq: Synchronize only with single thread
> on free_irq()").
> 
> I think the invocation of synchronize_irq() in pcie_pme_suspend() is
> unnecessary when called from pcie_pme_remove(), it's been there since
> the driver was added by Rafael with commit c7f486567c1d ("PCI PM: PCIe
> PME root port service driver"), adding him to cc as well.

Thanks!

AFAICS, the only part of pcie_pme_suspend() that needs to be done on
remove is the one under data->lock.  I'll cut a patch to make that
change.

Cheers,
Rafael

