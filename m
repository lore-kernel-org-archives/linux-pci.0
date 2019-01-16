Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CE9C43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 17:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D248620675
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 17:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391492AbfAPRIL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:08:11 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37239 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbfAPRIL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 12:08:11 -0500
Received: by mail-qt1-f195.google.com with SMTP id t33so7982634qtt.4;
        Wed, 16 Jan 2019 09:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iut53ajDZwejWXOJq/UH8hYrcibU0xqZb3TTB/RaIWI=;
        b=f+16SA4we678ZL/MiUdvkBJpkBUoJJOVp+kqF7iWKKiA+zuiArJgRH51c18exwWhQF
         QK6W2IAQrb2vk+F9HyTKkOZnxQIbgmmUcFUARNRNs2+ffehKc5Kr70gP1WCLnYAg7ngg
         ykv0vCeVo4tssnjVaHBUK6EgLb+iNF6/HqxUWSVOPfadsyuEKNk/vYYEfHIYpdBfCH+d
         SNWfrs/vdWGAFg3kZ13gR+4eqGOC7pNClEWESiS3zw4P8RtH+9axuVfNUvjhdMequ15h
         0EI4vUTZs1ubuNv2yDvpC58nWIVzEBmV6kxDYQGYsH0lATg+us0kJOPJ0LP4oKfA5ZOg
         IORg==
X-Gm-Message-State: AJcUukcEoF4JccIJqzVIbY0PhozkXamszUmUqjzGRBKE+XsmTdYLThcn
        NHdJ5EZWRVGjpYlZ/ug4TaTgIW3+xJaSaUaob+A=
X-Google-Smtp-Source: ALg8bN6THlJ+VDFvaDKYtxZFBUshcqjqnem21NCamdeWBDwdiEawpdBfpUSWlt7ClPKe8zigd71B5fU/VrgPz8+dbIo=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr7985332qta.152.1547658489626;
 Wed, 16 Jan 2019 09:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
In-Reply-To: <20190116163253.23780-1-vincent.whitchurch@axis.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 18:07:53 +0100
Message-ID: <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <rabinv@axis.com>,
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

On Wed, Jan 16, 2019 at 5:33 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> The Virtio-over-PCIe framework living under drivers/misc/mic/vop implements a
> generic framework to use virtio between two Linux systems, given shared memory
> and a couple of interrupts.  It does not actually require the Intel MIC
> hardware, x86-64, or even PCIe for that matter.  This patch series makes it
> buildable on more systems and adds a loopback driver to test it without special
> hardware.
>
> Note that I don't have access to Intel MIC hardware so some testing of the
> patchset (especially the patch "vop: Use consistent DMA") on that platform
> would be appreciated, to ensure that the series does not break anything there.

Hi Vincent,

First of all, I think it is a very good idea to make virtio over PCIe avaialable
more generally. Your patches also make sense here, they mostly fix
portability bugs, so no objection there.

I think we need to take a step back though and discuss what combinations
we actually do want to support. I have not actually read the whole mic/vop
driver, so I don't know if this would be a good fit as a generic interface --
it may or may not be, and any other input would be helpful.

Aside from that, I should note that we have two related subsystems
in the kernel: the PCIe endpoint subsystem maintained by Kishon and
Lorenzo, and the NTB subsystem maintained by Jon, Dave and Allen.

In order to properly support virtio over PCIe, I would hope we can come
up with a user space interface that looks the same way for configuring
virtio drivers in mic, pcie-endpoint and ntb, if at all possible. Have
you looked at those two subsystems?

        Arnd
