Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33790 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeAVXdz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jan 2018 18:33:55 -0500
Date: Mon, 22 Jan 2018 15:33:52 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] PCI: Move managed resource alloc to devres
Message-ID: <20180122233352.li5ns3h5bbtfcejf@dtor-ws>
References: <20180121211432.GA15151@lenoch>
 <20180121211538.GC15151@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180121211538.GC15151@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 21, 2018 at 10:15:39PM +0100, Ladislav Michl wrote:
> devm_pci_remap_cfgspace() is using devm_ioremap_release()
> devres release function. Move it to devres along with
> similar PCI functions to allow hiding devm_ioremap_release()
> from public.

So we are sharing this function:

void devm_ioremap_release(struct device *dev, void *res)
{
	iounmap(*(void __iomem **)res);
}

and we want to hide it, and for that we are moving a lot of PCI-specific
stuff into lib/devres.c. If anything, I'd say we should move more PCI
stuff _out_ of lib/devres.c, and if we wait to make local copy and call
it devm_pci_cfgspace_release() that woudl be fine with me.

Anyway, up to the maintainers.

Thanks.

-- 
Dmitry
