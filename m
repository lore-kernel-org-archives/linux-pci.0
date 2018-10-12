Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AC5C43441
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 10:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618B42087D
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 10:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618B42087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeJLRyW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:54:22 -0400
Received: from foss.arm.com ([217.140.101.70]:49218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeJLRyW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 13:54:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1823F;
        Fri, 12 Oct 2018 03:22:38 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2317B3F5B7;
        Fri, 12 Oct 2018 03:22:35 -0700 (PDT)
Date:   Fri, 12 Oct 2018 11:22:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Honghui Zhang <honghui.zhang@mediatek.com>
Cc:     bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        ulf.hansson@linaro.org, marc.zyngier@arm.com,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        youlin.pei@mediatek.com, yt.shen@mediatek.com,
        sean.wang@mediatek.com
Subject: Re: [PATCH v6 2/9] PCI: mediatek: Fixup class ID for MT7622 as
 PCI_CLASS_BRIDGE_PCI
Message-ID: <20181012102230.GA23257@e107981-ln.cambridge.arm.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
 <1538969088-7136-3-git-send-email-honghui.zhang@mediatek.com>
 <20181008172337.GA13538@e107981-ln.cambridge.arm.com>
 <1539054495.6246.31.camel@mhfsdcap03>
 <20181011113748.GA3574@e107981-ln.cambridge.arm.com>
 <1539331289.6246.61.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539331289.6246.61.camel@mhfsdcap03>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 12, 2018 at 04:01:29PM +0800, Honghui Zhang wrote:
> On Thu, 2018-10-11 at 12:38 +0100, Lorenzo Pieralisi wrote:
> > On Tue, Oct 09, 2018 at 11:08:15AM +0800, Honghui Zhang wrote:
> > > On Mon, 2018-10-08 at 18:23 +0100, Lorenzo Pieralisi wrote:
> > > > On Mon, Oct 08, 2018 at 11:24:41AM +0800, honghui.zhang@mediatek.com wrote:
> > > > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > > > 
> > > > > The PCIe controller of MT7622 has TYPE 1 configuration space type, but
> > > > > the HW default class type values is invalid.
> > > > > 
> > > > > The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class
> > > > > type for MT7622") have set the class ID for MT7622 as
> > > > > PCI_CLASS_BRIDGE_HOSTe, but it's not workable for MT7622:
> > > > > 
> > > > > In __pci_bus_assign_resources, the framework only setup bridge's
> > > > > resource window only if class type is PCI_CLASS_BRIDGE_PCI. Or it
> > > > > will leave the subordinary PCIe device's MMIO window un-touched.
> > 
> > Can you please provide me with a full log of the issue ?
> > 
> > What is the bug this patch is actually fixing ?
> > 
> > > > > Fixup the class type to PCI_CLASS_BRIDGE_PCI as most of the controller
> > > > > driver do.
> > > > 
> > > > I think that this patch is correct but the commit log fails to pin point
> > > > the problem. The IP you are programming is a root port, that's why you
> > > > have to have the proper class code, the patch looks fine but I would
> > > > like to peek Bjorn's brain on this since it is a fundamental concept.
> > > > 
> > > 
> > > I'm a bit confused with the concepts of PCI_CLASS_BRIDGE_HOST and
> > > PCI_CLASS_BRIDGE_PCI, from PCI express spec,
> > > 4.0r1.0(PCI_Express_Base_4.0r1.0_September-27-2017-c), Host Bridge is
> > > "part of a Root Complex that connects a host CPU or CPUs to a
> > > Hierarchy". While Root Complex defines as "A defined System Element that
> > > includes at least one Host Bridge, Root port, or Root complex Integrated
> > > Endpoint".
> > > 
> > > But according to my understanding, most of the root port IPs integrated
> > > with a "PCI_CLASS_BRIDGE_PCI", which has type 1 configuration space and
> > > could be saw as a pci device when using lspci.
> > > 
> > > And for MT7622, it integrated with block of internal control registers,
> > > type 1 configuration space, and is considered as a root complex.
> > 
> > I assume you mean a type 1 config header here. I do not think it
> > is mandatory for a host bridge to have a type 1 config header
> > (and related bridge windows + primary/secondary/subordinate bus
> > numbers) but I do not know how the IP you are programming is
> > designed.
> 
> Yes, MT7622 has the type 1 config header and related bridge windows and
> primary/secondary/subordinate bus numbers.
> 
> > 
> > If the host bridge needs its memory window to be configured you can
> > easily do that in the driver (with driver specific code) without
> > requiring the generic PCI resource core to do that for you, the host
> > bridge is the root of the bus I do not see any reason why it should
> > be up to core PCI code to assign it, it is preprogrammed.
> > 
> Thanks for explain this.
> Yes, the MT7622 bridge needs its memory window to be configured but I
> prefer the PCI resource core to do this for the following reasons:
> 1. MTK have MT7622 and MT2712, they pretty much using the same IP, but
> have different memory window base. Currently we using device tree to
> pass the memory window base. Take using of PCI resource core code to
> parse and assign those resource will release the burden of driver.
> 2. I do not want to re-implement the resource parse code to get the
> memory base from device node. And hard code the memory base in driver is
> not quite elegant.
> 3. Most of the host driver which I referenced are using the PCI resource
> core to help with it's memory window configure, I guess following the
> majority way maybe better even they may have slit different of the IP
> design from MTK.
> 4. Passing the memory base in device node make it more flexible to
> change the memory window base (in the HW acceptable range) in case of
> some special EP device required some special PCI address range.
> 5. MT7622 and MT2712 have the pretty much same IP only MT7622's HW has
> set the class type to an un-proper class type. Set it to the same values
> as MT2712 is an easy way to fix.

We do what needs to be done. From what you are saying, your IP
implements a config 1 type header and that defines it as a PCI-to-PCI
bridge (eg a root port, of sorts).

The points you are making above are software, I understand them but
that's not what we are discussing here.

I want you to define the class of your IP according to what your IP
is and it seems _reasonable_ to me to define the IP as a PCI-to-PCI
bridge class from the information you are providing.

I would like you to:

1) Rewrite the commit log and explain why your IP needs class
   reprogramming. I do not care about driver software complexity,
   I want you to describe how HW works. I do not want you to define
   a class for your IP because that makes the driver simpler, I want
   you to define a class for your IP to describe to the kernel what
   that IP really is, which is different things.
2) Define and report the bug you are fixing in the commit log
3) Provide a Fixes: tag pointing at the faulty commit

Thanks for your time providing information.

Lorenzo

> thanks.
> > > I'm not sure which CLASS type it should have:
> > > From PCI_Code-ID_r_1_10__v8-Nov_2017, class type of
> > > 0x0604(PCI_CLASS_BRIDGE_PCI) is defined as a PCI-to-PCI bridge, not
> > > literally suitable for MT7622(which is a root complex)(In my personal
> > > opinion). But it is the only workable CLASS type for MT7622 in current
> > > kernel.
> > > 
> > > > If the kernel does not assign resources unless it detects a
> > > > PCI_CLASS_BRIDGE_PCI this means that for components that are
> > > > actually PCI_CLASS_BRIDGE_HOST their register set must come
> > > > preprogrammed unless I am missing something.
> > > > 
> > > 
> > > In the function pci_request_resource_alignment, it will by pass the
> > > resource assignment for PCI_CLASS_BRIDGE_HOST, though I'm not figured
> > > out why.
> > > 
> > > > I would like to get to the bottom of this since it is a fundamental
> > > > enumeration concept.
> > > > 
> > > 
> > > Do you like me to re-write the commit message for this patch and put the
> > > above information in? Or just not mention the PCI_CLASS_BRIDGE_HOST
> > > assign resource routine?
> > 
> > I want to understand where the problem is and whether it is right to
> > define the component as a PCI bridge rather than a host bridge.
> > 
> 
> I will update the commit message (put some of the above reasons in the
> commit message) and send a new version of this patch if it's acceptable
> for you.
> 
> Thanks
> > Lorenzo
> 
> 
> 
