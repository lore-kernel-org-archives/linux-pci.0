Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39600C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 12:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D5E20855
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 12:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfAQMjp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:39:45 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42656 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfAQMjp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 07:39:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so11056219qtq.9;
        Thu, 17 Jan 2019 04:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=949CkYqovZVuyrEra8i6ETtjiOyejpzRupZ62jVpBcM=;
        b=GzPs5wUfrVRxSLJQIOLIdFTRDn49Mzh+WsrgIt56eyotOEDMU9jJBpcLLZIU/sHKGX
         wuueKeTDRfKfG6CkLP+0uwn+HY4/UWm83dgtmdRKQtxcnUWFfHsAeZCa6++KE1eWcS+e
         GgxJ87mrc2Mxey57cF+a+qmj0qgeXqduMvi0G0GwFuWlr7bnql2j2GpXWP3+4XyFXXr0
         rmBcMOXEYlk7r4sN1vcRl9uM4LivkIyr817BtqFz5G0/7o5hMLFCJXZMOFOEv7u3o/Ko
         mFNrFiOgaDzC5nv7J7g8zIxUrJb89uUhRP+yp1bbQrV3xQ6TcQ+KHwYfr+QwMg73MX/Y
         Ma7g==
X-Gm-Message-State: AJcUukd4xbfHJzr5sKQKiSMXZI9qlI3NuJ0L9rEVGJklL3Vf/KAZUh1P
        X216JFEdzPXObl8PudDWkPad4+Uay5e/PGRIPGE=
X-Google-Smtp-Source: ALg8bN7Y+BsS3HFCaeZ5V6zZxudaxgbAwIr5a0Zeg/+zj9LAgvku+dzWLdBQ4TeqQJ2aICrN0UyczlwwDSTx5zPfC/E=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr11164733qte.212.1547728783775;
 Thu, 17 Jan 2019 04:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com> <20190117105441.eqediwlekofp2srg@axis.com>
In-Reply-To: <20190117105441.eqediwlekofp2srg@axis.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Jan 2019 13:39:27 +0100
Message-ID: <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 17, 2019 at 11:54 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Wed, Jan 16, 2019 at 06:07:53PM +0100, Arnd Bergmann wrote:
> > On Wed, Jan 16, 2019 at 5:33 PM Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > > The Virtio-over-PCIe framework living under drivers/misc/mic/vop implements a
> > > generic framework to use virtio between two Linux systems, given shared memory
> > > and a couple of interrupts.  It does not actually require the Intel MIC
> > > hardware, x86-64, or even PCIe for that matter.  This patch series makes it
> > > buildable on more systems and adds a loopback driver to test it without special
> > > hardware.
> > >
> > > Note that I don't have access to Intel MIC hardware so some testing of the
> > > patchset (especially the patch "vop: Use consistent DMA") on that platform
> > > would be appreciated, to ensure that the series does not break anything there.
> >
> > I think we need to take a step back though and discuss what combinations
> > we actually do want to support. I have not actually read the whole mic/vop
> > driver, so I don't know if this would be a good fit as a generic interface --
> > it may or may not be, and any other input would be helpful.
>
> The MIC driver as a whole is uninteresting as a generic interface since
> it is quite tied to the Intel hardware.  The VOP parts though are
> logically separated and have no relation to that hardware, even if the
> ioctls are called MIC_VIRTIO_*.
>
> The samples/mic/mpssd/mpssd.c code handles both the boot of the MIC
> (sysfs) and the VOP parts (ioctls).

Right, I wasn't talking about the MIC driver here, just the VOP
stuff. Since that comes with an ioctl interface that you want to keep
using on other hardware, this still means we have to review if it is
a good fit as a general-purpose API.

> > Aside from that, I should note that we have two related subsystems
> > in the kernel: the PCIe endpoint subsystem maintained by Kishon and
> > Lorenzo, and the NTB subsystem maintained by Jon, Dave and Allen.
> >
> > In order to properly support virtio over PCIe, I would hope we can come
> > up with a user space interface that looks the same way for configuring
> > virtio drivers in mic, pcie-endpoint and ntb, if at all possible. Have
> > you looked at those two subsystems?
>
> pcie-endpoint is a generic framework that allows Linux to act as an
> endpoint and set up the BARs, etc.  mic appears to have Intel
> MIC-specific code for this (pre-dating pcie-endpoint) but this is
> separate from the vop code.  pcie-endpoint and vop do not have
> overlapping functionality and can be used together.

What we need to find out though is whether the combination of vop
with pcie-endpoint provides a good abstraction for what users
actually need when want to use e.g. a virtio-net connection on top
of PCIe endpoint hardware.

> I'm not familiar with NTB, but from a quick look it seems to be tied to
> special hardware, and I don't see any virtio-related code there.  A vop
> backend for NTB-backend would presumably work to allow virtio
> functionality there.

Correct, and again we have to see if this is a good interface. The NTB
and PCIe-endpoint interfaces have a number of differences and a
number of similarities. In particular they should both be usable with
virtio-style drivers, but the underlying hardware differs mainly in how
it is probed by the system: an NTB is seen as a PCI device attached
to two host bridges, while and endpoint is typically a platform_device
on one side, but a pci_dev on the other side.

Can you describe how you expect a VOP device over NTB or
PCIe-endpoint would get created, configured and used?
Is there always one master side that is responsible for creating
virtio devices on it, with the slave side automatically attaching to
them, or can either side create virtio devices? Is there any limit on
the number of virtio devices or queues within a VOP device?

       Arnd
