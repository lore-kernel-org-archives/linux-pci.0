Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346DFC43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1BD20851
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfAQPxo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:53:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46201 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfAQPxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 10:53:44 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so11748162qtm.13;
        Thu, 17 Jan 2019 07:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0OV2Id2E9KVotc3xUhiXVtj7cZu96i1mVsYZoWbA0g=;
        b=NiDS5KIWFjJ6ht7DkNH3ljjVWv7weqpvMmZOF+9rtSl7iaVScU1FKc4ndmPYC3QdRT
         xUO9VTaas0THevbKTWYC+NRJhvWOFx1+fWzz61aAmnevTjECAz8FCZEJyVgRkUnCgRaI
         RxNrMkS6CQU+jpHnxIdmQqZhtZP6qUocpqDInRmfwv0ih4udRbZspreM1mNfnyFEv4XL
         3o8o7s93TEIOFkFklAVTyAgh8EZ8ihM+MsgqFaGcJRyFg8fHvKFvt71bfn5t65DB/sNR
         1adUxH/J/KPuLPCGq3KeSIjvlrlwGMfHFUtowbMJibgulOh0f6SOXWWBN29sUNucZmMN
         agxA==
X-Gm-Message-State: AJcUukfyXDgqgcW+adzXb4Dwp6mcKvpZH6fWRN6sq76583+wEv66Zg/V
        Qr1mx9+rBSNQCu7rapMCRJefoWZD0dmyC/ImP98=
X-Google-Smtp-Source: ALg8bN5YKhO+CL7Xqnhr+kfEQaiU3Tp01mwY77s/PpQk2hxrNgpVPuTj1n8Ad25Gd4T/NwQiJ2Zg2PJgccsYVZiF04A=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr11596508qvm.149.1547740422624;
 Thu, 17 Jan 2019 07:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com> <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com>
In-Reply-To: <20190117151906.odvozs6kz3uvx32y@axis.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Jan 2019 16:53:25 +0100
Message-ID: <CAK8P3a17cw3LrbGOf=TxyfK70CHDy-bjbYkvrsvaQ9OM8nPeFQ@mail.gmail.com>
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

On Thu, Jan 17, 2019 at 4:19 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Thu, Jan 17, 2019 at 01:39:27PM +0100, Arnd Bergmann wrote:
> > Correct, and again we have to see if this is a good interface. The NTB
> > and PCIe-endpoint interfaces have a number of differences and a
> > number of similarities. In particular they should both be usable with
> > virtio-style drivers, but the underlying hardware differs mainly in how
> > it is probed by the system: an NTB is seen as a PCI device attached
> > to two host bridges, while and endpoint is typically a platform_device
> > on one side, but a pci_dev on the other side.
> >
> > Can you describe how you expect a VOP device over NTB or
> > PCIe-endpoint would get created, configured and used?
>
> Assuming PCIe-endpoint:
>
> On the RC, a vop-host-backend driver (PCI driver) sets up some shared
> memory area which the RC and the endpoint can use to communicate the
> location of the MIC device descriptors and other information such as the
> MSI address.  It implements vop callbacks to allow the vop framework to
> obtain the address of the MIC descriptors and send/receive interrupts
> to/from the guest.
>
> On the endpoint, the PCIe endpoint driver sets up (hardcoded) BARs and
> memory regions as required to allow the endpoint and the root complex to
> access each other's memory.
>
> On the endpoint, the vop-guest-backend, via the shared memory set up by
> the vop-host-backend, obtains the address of the MIC device page and the
> MSI address, and a method to receive vop interrupts from the host.  This
> information is used to implement the vop callbacks allowing the vop
> framework to access to the MIC device page and send/receive interrupts
> from/to the host.

Ok, this seems fine so far. So the vop-host-backend is a regular PCI
driver that implements the VOP protocol from the host side, and it
can talk to either a MIC, or another guest-backend written for the PCI-EP
framework to implement the same protocol, right?

> vop (despite its name) doesn't care about PCIe.  The vop-guest-backend
> doesn't actually need to talk to the PCIe endpoint driver.  The
> vop-guest-backend can be probed via any means, such as via a device tree
> on the endpoint.
>
> On the RC, userspace opens the vop device and adds the virtio devices,
> which end up in the MIC device page set up by the vop-host-backend.
>
> On the endpoint, when the vop framework (via the vop-guest-backend) sees
> these devices, it registers devices on the virtio bus and the virtio
> drivers are probed.

Ah, so the direction is fixed, and it's the opposite of what Christoph
and I were expecting. This is probably something we need to discuss
a bit. From what I understand, there is no technical requirement why
it has to be this direction, right?

What I mean is that the same vop framework could work with
a PCI-EP driver implementing the vop-host-backend and
a PCI driver implementing the vop-guest-backend? In order
to do this, the PCI-EP configuration would need to pick whether
it wants the EP to be the vop host or guest, but having more
flexibility in it (letting each side add virtio devices) would be
harder to do.

> On the RC, userspace implements the device end of the virtio
> communication in userspace, using the MIC_VIRTIO_COPY_DESC ioctl.  I
> also have patches to support vhost.

This is a part I don't understand yet. Does this mean that the
normal operation is between a user space process on the vop-host
talking to the kernel on the vop-guest?

I'm a bit worried about the ioctl interface here, as this combines the
configuration side with the actual data transfer, and that seems
a bit inflexible.

> > Is there always one master side that is responsible for creating
> > virtio devices on it, with the slave side automatically attaching to
> > them, or can either side create virtio devices?
>
> Only the master can create virtio devices.  The virtio drivers run on
> the slave.

Ok.

> > Is there any limit on
> > the number of virtio devices or queues within a VOP device?
>
> The virtio device information (mic_device_desc) is put into the MIC
> device page whose size is limited by the ABI header in
> include/uapi/linux/mic_ioctl.h (MIC_DP_SIZE, 4096 bytes).  So the number
> of devices is limited by the limit of the number of device descriptors
> that can fit in that size.  There is also a per-device limit on the
> number of vrings (MIC_VRING_ENTRIES) and vring entries
> (MIC_VRING_ENTRIES) in the ABI header.

Ok, so you can have multiple virtio devices (e.g. a virtio-net and
virtio-console) but not an arbitrary number? I suppose we can always
extend it later if that becomes a problem.

       Arnd
