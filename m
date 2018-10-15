Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26363C04AA5
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 18:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D714B2098A
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 18:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXylUm/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D714B2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeJPCVH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbeJPCVG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Oct 2018 22:21:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C936820881;
        Mon, 15 Oct 2018 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539628481;
        bh=0wGknTDXHGwARsgpyFMqwApUa3bFI0O8XZ31gBJKngc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXylUm/mjLOZ7OqkjoaZO4BA2yGx1me2UEO1x1ZaGelv5draKv6rnjysydv06QvST
         xPLo38SY3VfF9L69iVFJYaZIXaoCZlONsN3PGMBE+I6LQngukqCW1h/s5WfuJHbq5i
         07jGTJ9smZGypBBmQqNY28EVBUTsrqBR9h6KF+t0=
Date:   Mon, 15 Oct 2018 13:34:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Honghui Zhang <honghui.zhang@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, ryder.lee@mediatek.com,
        marc.zyngier@arm.com, linux-pci@vger.kernel.org,
        sean.wang@mediatek.com, linux-kernel@vger.kernel.org,
        yt.shen@mediatek.com, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, bhelgaas@google.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/9] PCI: mediatek: Fixup class ID for MT7622 as
 PCI_CLASS_BRIDGE_PCI
Message-ID: <20181015183435.GB5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
 <1538969088-7136-3-git-send-email-honghui.zhang@mediatek.com>
 <20181008172337.GA13538@e107981-ln.cambridge.arm.com>
 <1539054495.6246.31.camel@mhfsdcap03>
 <20181011113748.GA3574@e107981-ln.cambridge.arm.com>
 <1539331289.6246.61.camel@mhfsdcap03>
 <20181012102230.GA23257@e107981-ln.cambridge.arm.com>
 <20181012141202.GV5906@bhelgaas-glaptop.roam.corp.google.com>
 <1539571343.6246.74.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539571343.6246.74.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 15, 2018 at 10:42:23AM +0800, Honghui Zhang wrote:
> On Fri, 2018-10-12 at 09:12 -0500, Bjorn Helgaas wrote:
> > On Fri, Oct 12, 2018 at 11:22:30AM +0100, Lorenzo Pieralisi wrote:
> > > On Fri, Oct 12, 2018 at 04:01:29PM +0800, Honghui Zhang wrote:
> > >> On Thu, 2018-10-11 at 12:38 +0100, Lorenzo Pieralisi wrote:
> > >>> On Tue, Oct 09, 2018 at 11:08:15AM +0800, Honghui Zhang wrote:
> > >>>> On Mon, 2018-10-08 at 18:23 +0100, Lorenzo Pieralisi wrote:
> > >>>>> On Mon, Oct 08, 2018 at 11:24:41AM +0800, honghui.zhang@mediatek.com wrote:
> > >>>>>> From: Honghui Zhang <honghui.zhang@mediatek.com>
> > >>>>>> 
> > >>>>>> The PCIe controller of MT7622 has TYPE 1 configuration
> > >>>>>> space type, but the HW default class type values is
> > >>>>>> invalid.
> > >>>>>> 
> > >>>>>> The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID
> > >>>>>> and class type for MT7622") have set the class ID for
> > >>>>>> MT7622 as PCI_CLASS_BRIDGE_HOSTe, but it's not workable
> > >>>>>> for MT7622:
> > >>>>>> 
> > >>>>>> In __pci_bus_assign_resources, the framework only setup
> > >>>>>> bridge's resource window only if class type is
> > >>>>>> PCI_CLASS_BRIDGE_PCI. Or it will leave the subordinary PCIe
> > >>>>>> device's MMIO window un-touched.
> > 
> > I think __pci_bus_assign_resources() should be testing dev->hdr_type
> > instead of dev->class.  The connection between "Header Type" and the
> > layout of the rest of the header is very explicit (PCI r3.0 sec 6.1,
> > PCIe r4.0 sec 7.5.1.1.9), and the reason for the switch statement in
> > __pci_bus_assign_resources() is precisely to determine which layout to
> > use.
> > 
> > There are several other uses of dev->class in setup-bus.c that I think
> > should also be changed to use dev->hdr_type.
> > 
> > If we make these changes in setup-bus.c, I suspect the class code you
> > assign won't matter too much.  There are a few other tests of the
> > class code to figure out whether to leave certain things untouched.
> > These seem a little hacky to me, but we're probably stuck with them
> > for now, so you should look and see whether they apply to your
> > situation.
> 
> If these change could be made in the PCI core, then the class code is no
> matter what will be workable for MT7622.
> 
> As Lorenzo point it out, it's more reasonable for MT7622 to defined as a
> PCI-to-PCI class code since the IP is defined as that. I intend to
> following Lorenzo's suggest to update the commit message and re-send
> this patch set for current solution.
> 
> > >>>> And for MT7622, it integrated with block of internal control
> > >>>> registers, type 1 configuration space, and is considered as a
> > >>>> root complex.
> > >>> 
> > >>> I assume you mean a type 1 config header here. I do not think it
> > >>> is mandatory for a host bridge to have a type 1 config header (and
> > >>> related bridge windows + primary/secondary/subordinate bus
> > >>> numbers) but I do not know how the IP you are programming is
> > >>> designed.
> > 
> > It is definitely not mandatory for a host bridge to have a type 1
> > header.  I'm not even sure that would make sense: the "Primary Bus
> > Number" would not apply to a host bridge (since a host bridge's
> > primary bus is some sort of CPU bus, not a PCI bus), and a type 1
> > device cannot perform address translation between its primary and
> > secondary buses, while a host bridge can.
> > 
> > A Root Port is a type 1 device where the primary bus is logically
> > internal to the Root Complex.  A host bridge bridges from the CPU bus
> > to that internal bus and might perform address translation.  The Root
> > Port must be a PCI device.  A host bridge, being a bridge *to* the PCI
> > domain, is not itself generally programmed via PCI config space and
> > might not even be visible as a device in PCI config space.
> > 
> Thanks for the explain. Per my understanding, MT7622 is more like a
> complex of Root Port and PCI-to-PCI bridge. It has type 1 header and has
> the ability to translate address between its primary and secondary
> buses.

Nope.  Logically speaking, the PCI device in question is a Root Port,
which is a bridge between a primary PCI bus (probably bus 0) that is
internal to the Root Complex, and a secondary PCI bus.  This bridge,
like all other PCI-to-PCI bridges, does no address translation.

The Root Complex *also* contains a host bridge from whatever the
upstream CPU bus is and the logical PCI bus 0 internal to the Root
Complex.  This host bridge can perform address translation.

The Root Port PCI device might also have device-specific PCI config
registers, and those might offer some control over the host bridge
part of the Root Complex.  There is probably an MMIO (non-PCI config
space) way to configure the Root Complex, since you may not be able to
access the PCI config space before the Root Complex is configured.

> I guess apply the class type as PCI_CLASS_BRIDGE_PCI is
> reasonable way to make its integrated internal bridge workable.

Nope, that's not the way this process works.  You proposed setting
the class code as "a way to make this work".  I did a bunch of
research to figure out the best way of solving this and pointed out
a defect in the PCI core.  Fixing that defect will solve your problem
and possibly others.

The correct next step is for you to make that PCI core change, test it
and make sure it works, and post that as part of your series.  If, in
addition, you want to change the class code of your device, you can
also do that, but that's a secondary, optional step as far as I'm
concerned.

Bjorn
