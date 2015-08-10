Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36704 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbHJWy4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 18:54:56 -0400
Received: by ioeg141 with SMTP id g141so185032246ioe.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 15:54:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150810173322.GD32452@google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150729160701.GC31170@google.com>
	<CAE9FiQWBuTq2gH_-UjrCrOgtgFw05=RLXXAqkWFz4cTxHPCcdA@mail.gmail.com>
	<CAE9FiQXcj7Y+tqXPoFmYAuw-cTdpg1rzVzbkuGd-hA9O=QveXw@mail.gmail.com>
	<20150810173322.GD32452@google.com>
Date: Mon, 10 Aug 2015 15:54:55 -0700
Message-ID: <CAE9FiQW7+Tt7N9Ktg25+fhW7Hk3XjaE=MCYv7Y+vVeR0jjESNw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] PCI: Fix ATS deadlock
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Gregor Dick <gdick@solarflare.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 10, 2015 at 10:33 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
...
> Huh, I don't see anything obvious there.  Where does it hang?  Boot?
> Driver attach?  Can you give me any hints, or maybe try the attached patch?
> Is there anything funny about those particular devices?  Maybe some
> "lspci -vv" output?

with debug patch:

[   79.691788] calling  qla2x00_module_init+0x0/0x21c @ 1
[   79.711206] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA
Driver: 8.07.00.18-k.
[   79.731379] qla2xxx [0000:45:00.0]-001d: : Found an ISP2532 irq 30
iobase 0xffffc900311ae000.
[   79.733945] qla2xxx 0000:45:00.0: enabling Mem-Wr-Inval
[   82.381363] qla2xxx 0000:45:00.0: flush; cached ena 0 qdep 0,
current ena 0 qdep -19
[   82.397008] qla2xxx 0000:45:00.0: flush; cached ena 0 qdep 0,
current ena 0 qdep -19
[   82.621261] qla2xxx 0000:45:00.0: flush; cached ena 0 qdep 0,
current ena 0 qdep -19
[   82.625717] scsi host0: qla2xxx
[   87.646633] qla2xxx [0000:45:00.0]-00fb:0: QLogic QEM3572 -
SG-XPCIEFCGBE-Q8-Z Sun StorageTek Dual 8Gb FC Dual GbE HBA.
[   87.647145] qla2xxx [0000:45:00.0]-00fc:0: ISP2532: PCIe (5.0GT/s
x8) @ 0000:45:00.0 hdma+ host#=0 fw=5.10.00 (90d5).
[   87.663408] qla2xxx [0000:45:00.1]-001d: : Found an ISP2532 irq 31
iobase 0xffffc9003120e000.
[   87.684329] qla2xxx 0000:45:00.1: enabling Mem-Wr-Inval
[   90.331021] qla2xxx 0000:45:00.1: flush; cached ena 1 qdep 121,
current ena 0 qdep -19
...


Looks like ats in the device_domain_info is not initialized to 0.
after set it 0, it will work.


Index: linux-2.6/drivers/iommu/intel-iommu.c
===================================================================
--- linux-2.6.orig/drivers/iommu/intel-iommu.c
+++ linux-2.6/drivers/iommu/intel-iommu.c
@@ -2281,6 +2292,8 @@ static struct dmar_domain *dmar_insert_d
        info->dev = dev;
        info->domain = domain;
        info->iommu = iommu;
+       info->ats.enabled = 0;
+       info->ats.qdep = 0;

        spin_lock_irqsave(&device_domain_lock, flags);
        if (dev)
