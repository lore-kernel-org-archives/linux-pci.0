Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Alexander Graf <agraf@suse.de>, John Garry <john.garry@huawei.com>,
 Yuanzhichang <yuanzhichang@hisilicon.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "frowand.list@gmail.com"
 <frowand.list@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "brian.starkey@arm.com" <brian.starkey@arm.com>,
 "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V6 1/5] LIB: Indirect ISA/LPC port IO introduced
Date: Wed, 1 Feb 2017 12:29:39 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F9FC04A@lhreml507-mbx>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-2-git-send-email-yuanzhichang@hisilicon.com>
 <5dc0dc9c-124e-398f-a3b2-40059268e859@suse.de>
 <6d5523be-1841-18b9-9b83-6f7e591ed66b@huawei.com>
 <1a1f1e70-b6e7-f3c6-2b86-348b3d28edfe@suse.de>
In-Reply-To: <1a1f1e70-b6e7-f3c6-2b86-348b3d28edfe@suse.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "minyard@acm.org" <minyard@acm.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
 "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>,
 "kantyzc@163.com" <kantyzc@163.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex

> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]

[...]

> >>
> >> I like the extio idea. That allows us to handle all PIO requests on
> >> platforms that don't have native PIO support via different routes
> >> depending on the region they're in. Unfortunately we now we have 2
> >> frameworks for handling sparse PIO regions: One in extio, one in
> PCI.
> >>
> >> Why don't we just merge the two? Most of the code that has #ifdef
> >> PCI_IOBASE throughout the code base sounds like an ideal candidate
> to
> >> get migrated to extio instead. Then we only have a single framework
> to
> >> worry about ...
> >
> > To be clear, are you suggesting we merge the functionality from
> > pci_register_io_range(), pci_pio_to_address(), pci_address_to_pio()
> into
> > extio, so extio manages all PIO?
> 
> Yes, I guess so.
> 
> > And having a single type of node to
> > register PIO ranges, by amalgamating struct extio_node and io_range
> (as
> > Bjorn mentioned)?
> 
> I'm not quite sure I follow you here. Basically I think you want a
> generic "non-x86 PIO" framework that PCI just plugs into.
> 
> I don't think that necessarily means you want to statically allocate
> regions of that PIO space to separate (pseudo-)devices. Instead,
> everyone shares that space and should be able to fail gracefully if
> some
> space is already occupied.
> 
> > It would make sense. We would be somewhat decoupling PIO from PCI.
> 
> Yes :).
> 
> > I think that other architectures, like PPC, and other code would need
> to
> > be fixed up to handle this.
> 
> I think only PPC, Microblaze and ARM are using this. Grep for
> PCI_IOBASE. It's not that many.
> 
> > We need to consider all the other challenges/obstacles to this.
> 
> Well, getting our abstraction levels right to me sounds like it's worth
> the obstacles.
> 

I have had a quick look and I think it should not be too difficult to
unify the two frameworks.

I'll follow up soon on this thread with a code sketch

Thanks
Gab

[...]

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
