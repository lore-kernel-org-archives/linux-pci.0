Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16734C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 16:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AF020855
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 16:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfAQQ0I (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:26:08 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:57947 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfAQQ0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 11:26:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 9FEA518539;
        Thu, 17 Jan 2019 17:26:04 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id elemmEWAGOdJ; Thu, 17 Jan 2019 17:26:03 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 9E9F318572;
        Thu, 17 Jan 2019 17:26:02 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37DDC1A084;
        Thu, 17 Jan 2019 17:26:02 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B7551A082;
        Thu, 17 Jan 2019 17:26:02 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 17:26:02 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 1E700313C;
        Thu, 17 Jan 2019 17:26:02 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 1542B80B46; Thu, 17 Jan 2019 17:26:02 +0100 (CET)
Date:   Thu, 17 Jan 2019 17:26:01 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190117162601.tbmi4ounrnktzjga@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com>
 <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com>
 <CAK8P3a17cw3LrbGOf=TxyfK70CHDy-bjbYkvrsvaQ9OM8nPeFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a17cw3LrbGOf=TxyfK70CHDy-bjbYkvrsvaQ9OM8nPeFQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 17, 2019 at 04:53:25PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 17, 2019 at 4:19 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> > On Thu, Jan 17, 2019 at 01:39:27PM +0100, Arnd Bergmann wrote:
> > > Can you describe how you expect a VOP device over NTB or
> > > PCIe-endpoint would get created, configured and used?
> >
> > Assuming PCIe-endpoint:
> >
> > On the RC, a vop-host-backend driver (PCI driver) sets up some shared
> > memory area which the RC and the endpoint can use to communicate the
> > location of the MIC device descriptors and other information such as the
> > MSI address.  It implements vop callbacks to allow the vop framework to
> > obtain the address of the MIC descriptors and send/receive interrupts
> > to/from the guest.
> >
> > On the endpoint, the PCIe endpoint driver sets up (hardcoded) BARs and
> > memory regions as required to allow the endpoint and the root complex to
> > access each other's memory.
> >
> > On the endpoint, the vop-guest-backend, via the shared memory set up by
> > the vop-host-backend, obtains the address of the MIC device page and the
> > MSI address, and a method to receive vop interrupts from the host.  This
> > information is used to implement the vop callbacks allowing the vop
> > framework to access to the MIC device page and send/receive interrupts
> > from/to the host.
> 
> Ok, this seems fine so far. So the vop-host-backend is a regular PCI
> driver that implements the VOP protocol from the host side, and it
> can talk to either a MIC, or another guest-backend written for the PCI-EP
> framework to implement the same protocol, right?

Yes, but just to clarify:  the placement of the device page and the way
to communicate the location of the device page address and any other
information needed by the guest-backend are hardware-specific so there
is no generic vop-host-backend implementation which can talk to both a
MIC and to something else.

> > vop (despite its name) doesn't care about PCIe.  The vop-guest-backend
> > doesn't actually need to talk to the PCIe endpoint driver.  The
> > vop-guest-backend can be probed via any means, such as via a device tree
> > on the endpoint.
> >
> > On the RC, userspace opens the vop device and adds the virtio devices,
> > which end up in the MIC device page set up by the vop-host-backend.
> >
> > On the endpoint, when the vop framework (via the vop-guest-backend) sees
> > these devices, it registers devices on the virtio bus and the virtio
> > drivers are probed.
> 
> Ah, so the direction is fixed, and it's the opposite of what Christoph
> and I were expecting. This is probably something we need to discuss
> a bit. From what I understand, there is no technical requirement why
> it has to be this direction, right?

I don't think the vop framework itself has any such requirement.

The MIC uses it in this way (see Documentation/mic/mic_overview.txt) and
it also makes sense (to me, at least) if one wants to treat the endpoint
like one would treat a virtualized guest.

> What I mean is that the same vop framework could work with
> a PCI-EP driver implementing the vop-host-backend and
> a PCI driver implementing the vop-guest-backend? In order
> to do this, the PCI-EP configuration would need to pick whether
> it wants the EP to be the vop host or guest, but having more
> flexibility in it (letting each side add virtio devices) would be
> harder to do.

Correct, this is my understanding also.

> > On the RC, userspace implements the device end of the virtio
> > communication in userspace, using the MIC_VIRTIO_COPY_DESC ioctl.  I
> > also have patches to support vhost.
> 
> This is a part I don't understand yet. Does this mean that the
> normal operation is between a user space process on the vop-host
> talking to the kernel on the vop-guest?

Yes.  For example, the guest mounts a 9p filesystem with virtio-9p and
the 9p server is implemented in a userspace process on the host.  This
is again similar to virtualization.

> I'm a bit worried about the ioctl interface here, as this combines the
> configuration side with the actual data transfer, and that seems
> a bit inflexible.
>
> > > Is there always one master side that is responsible for creating
> > > virtio devices on it, with the slave side automatically attaching to
> > > them, or can either side create virtio devices?
> >
> > Only the master can create virtio devices.  The virtio drivers run on
> > the slave.
> 
> Ok.
> 
> > > Is there any limit on
> > > the number of virtio devices or queues within a VOP device?
> >
> > The virtio device information (mic_device_desc) is put into the MIC
> > device page whose size is limited by the ABI header in
> > include/uapi/linux/mic_ioctl.h (MIC_DP_SIZE, 4096 bytes).  So the number
> > of devices is limited by the limit of the number of device descriptors
> > that can fit in that size.  There is also a per-device limit on the
> > number of vrings (MIC_VRING_ENTRIES) and vring entries
> > (MIC_VRING_ENTRIES) in the ABI header.
> 
> Ok, so you can have multiple virtio devices (e.g. a virtio-net and
> virtio-console) but not an arbitrary number? I suppose we can always
> extend it later if that becomes a problem.

Yes.
