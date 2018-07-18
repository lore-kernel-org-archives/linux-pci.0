Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:34906
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731193AbeGRBVI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jul 2018 21:21:08 -0400
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Unify pci and normal dma direction definition
Date: Wed, 18 Jul 2018 00:45:24 +0000
Message-ID: <1531874719.3330.2.camel@hxt-semitech.com>
References: <1531463840-34651-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <20180717140335.GA23500@infradead.org>
In-Reply-To: <20180717140335.GA23500@infradead.org>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Christoph,

  I will send a v2 according to your comments.

Thanks.
Shunyong.

On Tue, 2018-07-17 at 07:03 -0700, Christoph Hellwig wrote:
> > 
> > diff --git a/include/linux/dma-direction.h b/include/linux/dma-
> > direction.h
> > index 3649a031893a..9d52716e9218 100644
> > --- a/include/linux/dma-direction.h
> > +++ b/include/linux/dma-direction.h
> > @@ -2,7 +2,7 @@
> >  #ifndef _LINUX_DMA_DIRECTION_H
> >  #define _LINUX_DMA_DIRECTION_H
> >  /*
> > - * These definitions mirror those in pci.h, so they can be used
> > + * These definitions mirror those in pci-dma-compat.h, so they can
> > be used
> >   * interchangeably with their PCI_ counterparts.
> >   */
> I think we can just drop this comment anymore.
> 
> > 
> > +#define PCI_DMA_BIDIRECTIONAL	(DMA_BIDIRECTIONAL)
> > +#define PCI_DMA_TODEVICE	(DMA_TO_DEVICE)
> > +#define PCI_DMA_FROMDEVICE	(DMA_FROM_DEVICE)
> > +#define PCI_DMA_NONE		(DMA_NONE)
> No need for the braces.
