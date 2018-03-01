Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162954AbeCAXZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2018 18:25:46 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w21NJ1JB075320
        for <linux-pci@vger.kernel.org>; Thu, 1 Mar 2018 18:25:46 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gerprwn3m-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 01 Mar 2018 18:25:45 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
        Thu, 1 Mar 2018 23:25:42 -0000
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI
 Memory
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Date: Fri, 02 Mar 2018 10:25:34 +1100
In-Reply-To: <595acefb-18fc-e650-e172-bae271263c4c@deltatee.com>
References: <20180228234006.21093-1-logang@deltatee.com>
         <1519876489.4592.3.camel@kernel.crashing.org>
         <1519876569.4592.4.camel@au1.ibm.com>
         <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
         <1519936477.4592.23.camel@au1.ibm.com>
         <CAPcyv4goHsYytq60ehJUori8Xq+Z0p8dV-8_oRALj244H4YtwQ@mail.gmail.com>
         <2079ba48-5ae5-5b44-cce1-8175712dd395@deltatee.com>
         <43ba615f-a6e1-9444-65e1-494169cb415d@deltatee.com>
         <1519945204.4592.45.camel@au1.ibm.com>
         <595acefb-18fc-e650-e172-bae271263c4c@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519946734.4592.48.camel@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-03-01 at 16:19 -0700, Logan Gunthorpe wrote:
> 
> On 01/03/18 04:00 PM, Benjamin Herrenschmidt wrote:
> > We use only 52 in practice but yes.
> > 
> > >   That's 64PB. If you use need
> > > a sparse vmemmap for the entire space it will take 16TB which leaves you
> > > with 63.98PB of address space left. (Similar calculations for other
> > > numbers of address bits.)
> > 
> > We only have 52 bits of virtual space for the kernel with the radix
> > MMU.
> 
> Ok, assuming you only have 52 bits of physical address space: the sparse 
> vmemmap takes 1TB and you're left with 3.9PB of address space for other 
> things. So, again, why doesn't that work? Is my math wrong

The big problem is not the vmemmap, it's the linear mapping.

Cheers,
Ben.
