Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BCBC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 05:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E16D2086C
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 05:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vv59NeIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfDAFfC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:35:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54778 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfDAFfC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 01:35:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so7686254wml.4
        for <linux-pci@vger.kernel.org>; Sun, 31 Mar 2019 22:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRAuIUGaFSr94uLgX3ADRQgsKDLwcK6arp5c8ahQ7tI=;
        b=Vv59NeIBeEp83M0BZWfWvqmR8TEkMmChusc9f5XndlRn315QeUrMxgNi2zj1PRkb6M
         SI4THy5zTGQ3L5tw1DTVNxIpcy36+EQQ8gL8bsKLaGOXcSBaGZXFanPV3ZwUNJ+sv+Bf
         jNh67vUqRSk0rn3gPObBiyrJNXrDq4oYiL/pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRAuIUGaFSr94uLgX3ADRQgsKDLwcK6arp5c8ahQ7tI=;
        b=mFditpbNTKnBEknqAO6d9js0c31rMaqIkHOzZki4ojlad7+DZbkt4H3TBotdC53SrG
         NOXMoLVZ8kskRa7MGAY6bU1ng1pMZSbGu2eVJRhSBNE3Gn48gp9qhkh7U4FfiwpqG531
         +pZaACj1mJctyDobxA+EvQkcS8UCNm4xF7sc4rnE6cQgSKbO7vxgfn2iYZNG8eenUYmU
         JmPab+qqyNT7i4bVv/xVKrGiwju8IPMQJQ1kzQo7V2gWdbD6KD65/PnTCAxGpdtnpZjU
         k6bdlRxSB85KA7GOIh8Ig9IUdlBEAfoBj7hR3/ygXgw/nyOwKCw5HMbzt+GprPxDBtRv
         A3nw==
X-Gm-Message-State: APjAAAX7OoemlPqfRhFcp99V+Gg1/Yv7FPr3TMIPiRMKBOySzvsblgjP
        9Y7rBxdAQF9Rxmo5mI0HCGRHijBebgx/NMbucNlvYA==
X-Google-Smtp-Source: APXvYqw4f7wZn7qVGFgSxyjPeUCcSfix6LKXp1qFUIoEKrzbLLyupFqbsq40Cj1S1fWQKwdDkhhrg89sFr4DoPcKuJw=
X-Received: by 2002:a1c:4844:: with SMTP id v65mr11119819wma.139.1554096899482;
 Sun, 31 Mar 2019 22:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
 <1551415936-30174-3-git-send-email-srinath.mannam@broadcom.com> <20190329173515.GA10367@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190329173515.GA10367@e107981-ln.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Mon, 1 Apr 2019 11:04:48 +0530
Message-ID: <CABe79T7LwFLST0dwwswv8sdqHcn0T4ked5WtcNpM78XUDUN3Jw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: iproc: Add outbound configuration for 32-bit
 I/O region
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Please see my reply below,

On Fri, Mar 29, 2019 at 11:06 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Mar 01, 2019 at 10:22:16AM +0530, Srinath Mannam wrote:
> > In the present driver outbound window configuration is done to map above
> > 32-bit address I/O regions with corresponding PCI memory range given in
> > ranges DT property.
> >
> > This patch add outbound window configuration to map below 32-bit I/O range
> > with corresponding PCI memory, which helps to access I/O region in ARM
> > 32-bit and one to one mapping of I/O region to PCI memory.
> >
> > Ex:
> > 1. ranges DT property given for current driver is,
> >     ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
> >     I/O region address is 0x400000000
> > 2. ranges DT property can be given after this patch,
> >     ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
> >     I/O region address is 0x42000000
>
> I was applying this patch but I don't understand the commit log and
> how it matches the code, please explain it to me and I will reword
> it.
Iproc PCIe host controller supports outbound address translation
feature to translate AXI address to PCI bus address.
IO address ranges (AXI and PCI) given through ranges DT property have
to program to controller outbound window registers.
Present driver has the support for only 64bit AXI address. so that
ranges DT property has given as 64bit AXI address and 32 bit
PCI bus address.
But with this patch 32-bit AXI address also could be programmed to
Iproc host controller outbound window registers. so that ranges
DT property can have 32bit AXI address which can map to 32-bit PCI bus address.
Example given in commit log is describing ranges DT property changes
with and without this patch.
In the case, without this patch AXI address is more than 32bit
"0x400000000". and with this patch AXI address is 32-bit "0x42000000".
PCI bus address is 32 bit address in both the cases "0x40000000" and 0x42000000.

Regards,
Srinath.
> Thanks,
> Lorenzo
>
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index b882255..080f142 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> >                       resource_size_t window_size =
> >                               ob_map->window_sizes[size_idx] * SZ_1M;
> >
> > -                     if (size < window_size)
> > -                             continue;
> > +                     /*
> > +                      * Keep iterating until we reach the last window and
> > +                      * with the minimal window size at index zero. In this
> > +                      * case, we take a compromise by mapping it using the
> > +                      * minimum window size that can be supported
> > +                      */
> > +                     if (size < window_size) {
> > +                             if (size_idx > 0 || window_idx > 0)
> > +                                     continue;
> > +
> > +                             /*
> > +                              * For the corner case of reaching the minimal
> > +                              * window size that can be supported on the
> > +                              * last window
> > +                              */
> > +                             axi_addr = ALIGN_DOWN(axi_addr, window_size);
> > +                             pci_addr = ALIGN_DOWN(pci_addr, window_size);
> > +                             size = window_size;
> > +                     }
> >
> >                       if (!IS_ALIGNED(axi_addr, window_size) ||
> >                           !IS_ALIGNED(pci_addr, window_size)) {
> > --
> > 2.7.4
> >
