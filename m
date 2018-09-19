Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB00C433F4
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 22:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E5821527
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 22:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vxK6ZN3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E5821527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbeITDwa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732719AbeITDwa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 23:52:30 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253852146E;
        Wed, 19 Sep 2018 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537395150;
        bh=xE6pRQfmg1KTW69i/cJdt2N4PjPVLamiFTIchFHtu5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vxK6ZN3vn9bDylu/MDBPYh/Siw4Y0VeQMH4xxT3aj9TO15Si1KTKPYGt7BHS3BUqu
         3O863rv0r1+YvPsdOKPEXLtP1Luyx4V5ULBBJ73XkSYhgKUjLrO3BRIEuLAsSK8CHG
         shT/ZioRr7fSrvoNKaN+6dLx6ZJ0vYfOztjTyRkY=
Date:   Wed, 19 Sep 2018 17:12:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Oliver <oohall@gmail.com>, linux-pci@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Device Tree <devicetree@vger.kernel.org>
Subject: Re: PCI: Enforce bus address limits in resource allocation
Message-ID: <20180919221228.GB261184@bhelgaas-glaptop.roam.corp.google.com>
References: <abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com>
 <20180918132056.GA254348@bhelgaas-glaptop.roam.corp.google.com>
 <b5883e58-861a-807e-f4c8-3745b006ce0d@cisco.com>
 <20180918184706.GA13616@bhelgaas-glaptop.roam.corp.google.com>
 <b6281224-18cf-50af-aa38-6b048d741854@cisco.com>
 <20180918204834.GB13616@bhelgaas-glaptop.roam.corp.google.com>
 <CAOSf1CHcDqrwy5W-GAjJ-x+rBwbRMLoVsM8D6veFVPPXmdAsZQ@mail.gmail.com>
 <4ba13a62-a2b4-662d-4f55-779312aa7871@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ba13a62-a2b4-662d-4f55-779312aa7871@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 19, 2018 at 02:13:28PM -0700, Daniel Walker wrote:
> On 09/19/2018 07:25 AM, Oliver wrote:
> > On Wed, Sep 19, 2018 at 6:48 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > [+cc Rob, Frank, devicetree list,
> > > 
> > > thread starts here:
> > > https://lkml.kernel.org/r/abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com
> > > 
> > > dmesg snippets here:
> > > https://lkml.kernel.org/r/20180918184706.GA13616@bhelgaas-glaptop.roam.corp.google.com]
> > > 
> > > On Tue, Sep 18, 2018 at 11:56:20AM -0700, Daniel Walker wrote:
> > > > On 09/18/2018 11:47 AM, Bjorn Helgaas wrote:
> > > > > On Tue, Sep 18, 2018 at 07:24:02AM -0700, Daniel Walker wrote:
> > > > > > On 09/18/2018 06:20 AM, Bjorn Helgaas wrote:
> > > > > > > On Fri, Sep 14, 2018 at 08:16:35AM -0700, Daniel Walker wrote:
> > > > > > > > I have a powerpc system with PCI, and some devices attached to
> > > > > > > > the PCI bus.  In 3.10 everything worked fine, then we moved to
> > > > > > > > 4.9 and we had some issues.  I was able to bisect the issue down
> > > > > > > > to the patch in the subject line.
> > > > > > > > 
> > > > > > > > f75b99d PCI: Enforce bus address limits in resource allocation
> > > > > > > > 
> > > > > > > >    From 3.10 here is part of the PCI initialization,
> > > > > > > > 
> > > > > > > > |pci 0001:0e:00.0: BAR 0: assigned [mem 0xfc0000000-0xfc00fffff pref]|
> > > > > > > > |pci 0001:07:09.0: PCI bridge to [bus 0e]|
> > > > > > > > |pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]|
> > > > > > > >                    |||In this section the memory resource for the bridge is
> > > > > > > > 64bit, and the device "BAR 0" gets a 64bit range. However, it seems the
> > > > > > > > device is 32bit.|
> > > > > 
> > > > > > > > |Now fast forward to 4.9 we get this,|
> > > > > > > 
> > > > > > > > pci 0001:0e:00.0: BAR 0: no space for [mem size 0x00100000 pref]
> > > > > > > > pci 0001:0e:00.0: BAR 0: failed to assign [mem size 0x00100000 pref]
> > > > > > > > pci 0001:07:09.0: PCI bridge to [bus 0e]
> > > > > > > > pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]
> > > > > > > > 
> > > > > > > > |Here it seems to have a larger size, I'm not sure where the size is coming
> > > > > > > > from.
> > > > > > > 
> > > > > > > The size is 0x00100000 (1MB), which is the same size as
> > > > > > > [mem 0xfc0000000-0xfc00fffff pref].
> > > > > > > 
> > > > > > > The size is normally discovered by probing the BAR (write all 1's to
> > > > > > > the BAR then read it back to find which bits are writable and which
> > > > > > > are read-only).  On powerpc we might learn it from DT instead.  But in
> > > > > > > any case, we to get the same 1MB size, which is the same size as the
> > > > > > > bridge window.  So this should still work unless there are other BARs
> > > > > > > in that window.
> > > > > > 
> > > > > > As far as I know there is only one BAR connected to this window.
> > > > > > 
> > > > > > It kind of strikes me as an off-by-one problem because it says "no space"
> > > > > > but the window is the same size as what's requested. With the patch removed
> > > > > > you get the whole window assigned.
> > > > > > 
> > > > > > In the context of the patch if you change the pci_32_bit to pci_64_bit for
> > > > > > the region when calling pci_bus_alloc_from_region() in the 32bit case this
> > > > > > problem disappears. I do have CONFIG_ARCH_DMA_ADDR_T_64BIT enabled in my
> > > > > > config.
> > > > > > 
> > > > > > > > I was able to work around the issue by setting IORESOURCE_MEM_64 on
> > > > > > > > the resource for this device. I also was able to work around it by setting
> > > > > > > > "max = avail.end" to "max = (-1);" inside pci_bus_alloc_resource(). |
> > > > > > > > ||
> > > > > > > > ||I don't know if the problem is the patch, or something else inside our
> > > > > > > > system, but any thoughts are appreciated.
> > > > > > > 
> > > > > > > It seems like we think the bridge window contains only 64-bit space
> > > > > > > and therefore contains nothing usable by the 32-bit BAR.
> > > > > > > 
> > > > > > > You said later that the same problem exists on v4.19-rc4.  Can you
> > > > > > > collect the complete dmesg log with that kernel?  That should tell us
> > > > > > > about any host bridge address translation.
> > > > > > 
> > > > > > Sure. I have attached the dmesg.
> > > > > 
> > > > > The relevant parts are below.  I think your DT is incorrect.  Either
> > > > > it neglects to describe the host bridge address translation for the
> > > > > ffb240000.pcie and ffb250000.pcie bridges, or it incorrectly describes
> > > > > the BARs of devices below those bridges as 32-bit BARs when they are
> > > > > really 64-bit BARs.
> > > > 
> > > > I don't know if the DTS is correct, it very well could be incorrect. Here
> > > > are the relevant parts of the DTS. The BAR at issue is connected to PCI1.
> > > 
> > > The DTS matches what I pointed out in the dmesg log.  I think you need
> > > to reconcile it with your hardware and firmware, which I don't know
> > > anything about, so I don't know what else I can do at this point.  I
> > > copied some DT folks in case they have advice.
> > > 
> > > >          pci0: pcie@ffb240000 {
> > > >                  compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4",
> > > > "fsl,qoriq-pcie";
> > > >                  device_type = "pci";
> > > >                  #size-cells = <2>;
> > > >                  #address-cells = <3>;
> > > >                  bus-range = <0x0 0xff>;
> > > >                  interrupts = <20 2 0 0>;
> > > >                  fsl,iommu-parent = <&pamu0>;
> > > >                  reg = <0xf 0xfb240000 0 0x10000>;
> > > >                  ranges = <0x03000000 0xf 0xe0000000 0xf 0xe0000000 0
> > > > 0x01000000>;
> > > > 
> > > >                  pcie@0 {
> > > >                          reg = <0 0 0 0 0>;
> > > >                          #size-cells = <2>;
> > > >                          #address-cells = <3>;
> > > >                          device_type = "pci";
> > > >                  };
> > > >          };
> > > > 
> > > >          pci1: pcie@ffb250000 {
> > > >                  compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4",
> > > > "fsl,qoriq-pcie";
> > > >                  device_type = "pci";
> > > >                  #size-cells = <2>;
> > > >                  #address-cells = <3>;
> > > >                  bus-range = <0 0xff>;
> > > >                  interrupts = <21 2 0 0>;
> > > >                  fsl,iommu-parent = <&pamu0>;
> > > >                  reg = <0xf 0xfb250000 0 0x10000>;
> > > > 
> > > >                  ranges = <0x03000000 0x4 0x00000000 0x4 0x00000000 0xc
> > > > 0x00000000>;
> > > > 
> > > >                  pcie@0 {
> > > >                          reg = <0 0 0 0 0>;
> > > >                          #size-cells = <2>;
> > > >                          #address-cells = <3>;
> > > >                          device_type = "pci";
> > > >                  };
> > > >          };
> > 
> > The upstream fsl-pci driver seems to configure the bridge windows
> > based on what's in the ranges property rather than just consuming it.
> > It might be possible to add some 32bit BAR space by tweaking the
> > ranges to something like:
> > 
> >          ranges = <0x02000000 0x0 0x80000000 0x4 0x0 0x0 0x80000000>;
> 
> I added this line for pci1 , and the initialization appears to be
> different.  I don't see the same "no space" lines (there is no
> reference to 0001:0e at all in that sequence). The unit test I have
> referenced below starts working.
> 
> Is it possible to identify all the BAR's in the window as 64bit ? We
> have shown that the device works fine with 64-bit addresses,
> although it's not identified as a 64-bit device. This device has no
> DTS entry currently.

PCI host bridges need DTS entries because they are not PCI devices
(they are bridges from a non-PCI bus to a PCI bus) and cannot be
discovered by the standard PCI enumeration protocol.

PCI devices are discoverable by generic PCI enumeration and typically
do not have DTS entries.  The PCI specs define the config space header
and how BARs work, including how to determine whether the BARs are 32
or 64 bits wide, so the Linux PCI core can figure all that out by
itself.

So the answer to your question is that the PCI device itself tells us
how wide its BARs are, and we can't just override that.  Part of the
enumeration process is that we write all 1's to each BAR and read it
back.  The low-order bits are read-only and they tell us what type the
BAR is (memory or I/O) and how wide it is (32 or 64 bits).

I assume we're talking about the 0001:0e:00.0 device.  I'm not
convinced that we've shown that this device works with 64-bit
addresses.  The dmesg you attached shows this:

  fsl-pci ffb250000.pcie: PCI host bridge to bus 0001:05
  pci_bus 0001:05: root bus resource [mem 0x400000000-0x47fffffff] (bus address [0x80000000-0xffffffff])
  FPGA_PCIE: resource start=440000000 end=441ffffff, name="PCI Bus 0001:0e"

This means the host bridge translates the CPU physical address range
[mem 0x400000000-0x47fffffff] to the PCI bus address range
[0x80000000-0xffffffff].  CPU addresses in that window are indeed
wider than 32 bits, but the bridge translate them into bus addresses
that all fit in 32 bits, and those are the addresses programmed into
the BARs.

I assume the "resource start=440000000" is pulled out of a struct
resource, which contains the CPU physical address.  The host bridge
would translate this to the PCI address

  0x80000000 + (0x440000000 - 0x400000000) = 0xc0000000

so the BAR should contain 0xc0000000.  "lspci -bs 0001:0e:00.0" should
show you that address.

Bjorn
