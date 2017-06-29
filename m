Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:57981 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751819AbdF2VgO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2017 17:36:14 -0400
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
To: "'Logan Gunthorpe'" <logang@deltatee.com>,
        <linux-ntb@googlegroups.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: "'Jon Mason'" <jdmason@kudzu.us>,
        "'Dave Jiang'" <dave.jiang@intel.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Kurt Schwemmer'" <kurt.schwemmer@microsemi.com>,
        "'Stephen Bates'" <sbates@raithlin.com>,
        "'Serge Semin'" <fancer.lancer@gmail.com>
References: <20170629032648.3073-1-logang@deltatee.com> <20170629032648.3073-7-logang@deltatee.com> <000301d2f103$3310ca60$99325f20$@dell.com> <079047c1-6612-2814-e147-844fabd56b75@deltatee.com> <000401d2f114$3499f2b0$9dcdd810$@dell.com> <63c4b0fa-2f03-6313-2d60-c6dab53bc3a5@deltatee.com> 
In-Reply-To: 
Subject: RE: [PATCH 06/16] ntb: add check and comment for link up to mw_count and mw_get_align
Date: Thu, 29 Jun 2017 17:35:50 -0400
Message-ID: <000501d2f11f$af340d70$0d9c2850$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Let me try that again...

From: Hubbe, Allen
> From: Logan Gunthorpe
> > On 6/29/2017 2:13 PM, Allen Hubbe wrote:
> > > Unfortunately, it is to work around hardware errata.  That is not so trivial to fix.
> >
> > Can you describe more what the work around is doing? Can you share the
> > code? It seems odd that a workaround is based on the alignment
> > restrictions of the mws.
> 
> Sure, while not making any claim that this is ready for upstream.
> 
> It is not a workaround for alignment restrictions of the mws.  It is a restriction to avoid the use of
> doorbells and scratchpads.  Memory windows are used exclusively.
> 
> Read msi-x local <addr,data> and send that to the peer:

https://github.com/ntrdma/ntrdma/blob/master/drivers/ntc/ntc_ntb_msi.c#L583

> Transform peer's addr to the memory window region:

https://github.com/ntrdma/ntrdma/blob/master/drivers/ntc/ntc_ntb_msi.c#L603

> Append a dma immediate value operation after other operations, to write the data at addr:

https://github.com/ntrdma/ntrdma/blob/master/drivers/ntc/ntc_ntb_msi.c#L1195

> 
> Above describes the workaround.
> 
> Used in the context of a rdma-over-ntb driver here:
> https://github.com/ntrdma/ntrdma/blob/master/drivers/infiniband/hw/ntrdma/ntrdma_qp.c#L1585
> 
> >
> > Logan
