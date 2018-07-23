Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388133AbeGWV5D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Jul 2018 17:57:03 -0400
Date: Mon, 23 Jul 2018 15:54:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Honghui Zhang <honghui.zhang@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Linux
Message-ID: <20180723205403.GA167818@bhelgaas-glaptop.roam.corp.google.com>
References: <5b5555e19b5af_5e922b08291e2f60744cb@node1.mail>
 <CAErSpo7wy1CZvozUX+vnj0W_-m85M=TBUYp3N=W1wB57=_8kXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7wy1CZvozUX+vnj0W_-m85M=TBUYp3N=W1wB57=_8kXw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Gustavo]

On Mon, Jul 23, 2018 at 02:12:49PM -0500, Bjorn Helgaas wrote:
> Hi Honghui,
> 
> Would you consider doing a minor patch to fix the issue Coverity
> reported below (not checking the return value from
> devm_pci_remap_iospace())?

Never mind, I see Gustavo has already posted such a patch:

https://lkml.kernel.org/r/20180720150158.GA10922@embeddedor.com

Thanks, Gustavo!

> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Sun, Jul 22, 2018 at 11:13 PM
> Subject: New Defects reported by Coverity Scan for Linux
> To: <bhelgaas@google.com>
> 
> ...
> ** CID 1438089:  Error handling issues  (CHECKED_RETURN)
> /drivers/pci/controller/pcie-mediatek.c: 1112 in mtk_pcie_request_resources()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 1438089:  Error handling issues  (CHECKED_RETURN)
> /drivers/pci/controller/pcie-mediatek.c: 1112 in mtk_pcie_request_resources()
> 1106            pci_add_resource(windows, &pcie->busn);
> 1107
> 1108            err = devm_request_pci_bus_resources(dev, windows);
> 1109            if (err < 0)
> 1110                    return err;
> 1111
> >>>     CID 1438089:  Error handling issues  (CHECKED_RETURN)
> >>>     Calling "devm_pci_remap_iospace" without checking return value (as is done elsewhere 5 out of 6 times).
> 1112            devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
> 1113
> 1114            return 0;
> 1115     }
> 1116
> 1117     static int mtk_pcie_register_host(struct pci_host_bridge *host)
