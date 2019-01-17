Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E78C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCB520652
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 16:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfAQQSU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:18:20 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45128 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbfAQQSU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 11:18:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id y78so6277874qka.12;
        Thu, 17 Jan 2019 08:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbyU6DABQlQUu0Tvo/yIMkfmtsqZt+GuYhN0wrtNSyk=;
        b=kX/nNx+Z+c/FGGgZbKK8vgQ/ricXO8kNZiNHaXSzk7TkR91VBVLGunNDBsNxOrAJ3U
         fVsDOtKfLIlGAxaS49NX3HfEsM/Gm9y9Ip6oVCl9x4T1d2jMm7Mxl7A3z01FhVdYdNeT
         bZxDDnFjTOIzOd2BlXfdD7FnoovqCDYgRdkrWGHJzk6eCN71fob97yFQuvZQd/Y4OzZm
         8FbjTEpDvXg4CJvrLN2pr/zawxq0vacEAf1ZUSYw89Ft/6YeriFQYTYAUpVCN+02nl7o
         4Rhi7zXjP2aIiwDVXrQ8HPWs2jeoX3Buf1vNyYzqAetQQk5+KlDOj0/Fcca7hUSnHcY6
         pa6w==
X-Gm-Message-State: AJcUukdhJ9ohu64q+DQlwGQWURRSRFCiIZs2qWxgMogaztu4FHR00GkU
        EcbNZFVGsuD3kJfQcxVISVE9xThtC1lyVLNSz/k=
X-Google-Smtp-Source: ALg8bN4wVgtDXBX7+plwp7vCWvd6X17QeZxw7P5RxPNaPMqc6N9+IE7G4m8jEcDnoViybhnZXg97fxyltqtjNwPfBPg=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr10967732qkf.107.1547741898800;
 Thu, 17 Jan 2019 08:18:18 -0800 (PST)
MIME-Version: 1.0
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com> <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com> <20190117152142.GB20359@infradead.org>
 <20190117153206.2flxqb26tbdrwp4z@axis.com> <20190117154612.GA6262@infradead.org>
In-Reply-To: <20190117154612.GA6262@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Jan 2019 17:18:02 +0100
Message-ID: <CAK8P3a14oW-615mT-iW+C_TNmEpST7V0L4XVic3LSnvCzXh4pA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
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

On Thu, Jan 17, 2019 at 4:46 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Jan 17, 2019 at 04:32:06PM +0100, Vincent Whitchurch wrote:
> > If I understand you correctly, I think you're talking about the RC
> > running the virtio drivers and the endpoint implementing the virtio
> > device?  This vop stuff is used for the other way around: the virtio
> > device is implement on the RC and the endpoint runs the virtio drivers.
>
> Oh.  That is really weird and not that way I'd implement it..

It does make sense to me for the very special requirements of the MIC
device, which has a regular PC-style server that provides the environment
for a special embedded device inside of a PCIe card, so the PCI-EP
stuff is just used as a transport here going one way, and then the
configuration of the devices implemented through it goes the other
way, providing network connectivity and file system to the embedded
machine on the PCI-EP.

This is actually very similar to a setup that I considered implementing
over USB, where one might have an embedded machine (or a bunch
of them on a USB hub) connected to a USB host port, and then
use it in the opposite way of a regular gadget driver, by providing
a virtfs over USB to the gadget with files residing on a disk on the
USB host.

Apparently Vincent has the same use case that both the Intel
MIC folks and I had here, so doing it like this is clearly useful.
On the other hand, I agree that there are lots of other use cases
that need the opposite, so we should try to come up with a
design that can cover both.
An example of this might be a PCIe-endpoint device providing
network connectivity to the host using a vhost-net device, which
ideally just shows up as a device on the host as a virtio-net
without requiring any configuration.

So for configuring this, I think it'd like to see a way to have
either the PCI-EP or the PCI-host side be the one that can
create virtio devices that show up on the other end. This
configuration is currently done using an ioctl interface, which
was probably the easiest to do for the MIC case, but for
consistency with the PCI-EP framework, using configfs
is probably better.

A different matter is the question of what a virtio device
talks to. A lot of virtio devices are fundamentally
asymmetric (9pfs, rng, block, ...), so you'd have to
have the virtio device on one side, and a user space
or vhost driver on the other. The VOP driver seems to assume
that it's always the slave that uses virtio, while the
master side (which could be on the PCI EP or PCI
host for the sake of this argument) implements it in user
space or otherwise. Is this a safe assumption, or can
we imagine cases where this would be reversed as well?

        Arnd
