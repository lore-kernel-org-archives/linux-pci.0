Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:49286 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbeAWG6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jan 2018 01:58:18 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992781AbeAWG6PWVPTV (ORCPT <rfc822;linux-pci@vger.kernel.org>
        + 1 other); Tue, 23 Jan 2018 07:58:15 +0100
Date: Tue, 23 Jan 2018 07:58:07 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] PCI: Move managed resource alloc to devres
Message-ID: <20180123065807.GA30349@lenoch>
References: <20180121211432.GA15151@lenoch>
 <20180121211538.GC15151@lenoch>
 <20180122233352.li5ns3h5bbtfcejf@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180122233352.li5ns3h5bbtfcejf@dtor-ws>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 22, 2018 at 03:33:52PM -0800, Dmitry Torokhov wrote:
> On Sun, Jan 21, 2018 at 10:15:39PM +0100, Ladislav Michl wrote:
> > devm_pci_remap_cfgspace() is using devm_ioremap_release()
> > devres release function. Move it to devres along with
> > similar PCI functions to allow hiding devm_ioremap_release()
> > from public.
> 
> So we are sharing this function:
> 
> void devm_ioremap_release(struct device *dev, void *res)
> {
> 	iounmap(*(void __iomem **)res);
> }
> 
> and we want to hide it, and for that we are moving a lot of PCI-specific
> stuff into lib/devres.c. If anything, I'd say we should move more PCI
> stuff _out_ of lib/devres.c, and if we wait to make local copy and call
> it devm_pci_cfgspace_release() that woudl be fine with me.

Well, that's fine with me too. Will send v2 without all these changes.

> Anyway, up to the maintainers.
> 
> Thanks.

Thank you,
	ladis
