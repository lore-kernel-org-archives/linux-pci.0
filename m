Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA0C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 04:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0644C222BB
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 04:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OxJmUX5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfBMEwJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:52:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36960 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbfBMEwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2019 23:52:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id c8so933622wrs.4
        for <linux-pci@vger.kernel.org>; Tue, 12 Feb 2019 20:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXA/qvdpSx6JXTBhI/uFT9HoAq1/F1TFzcciALG1AYs=;
        b=OxJmUX5zQu5U6nrWnmxyDZyIuzCHbmDqxo+0G/z+Nh7rAVwTVumF8bRmnw87IP2bcW
         BQhkBgm0rrKU5HynC+ee43mZmGnYUX43ZJBtZqCGEJVMFhShcNudiFz8SDcEG74xNi3L
         LDUF92CzYPCWvmHvrkntBmg1uRdUNRpUNOly0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXA/qvdpSx6JXTBhI/uFT9HoAq1/F1TFzcciALG1AYs=;
        b=s5j9Nmqh6jFsWGIdYXYO9swquBcJE3tmFLsdMrxJaDDU2GjJmW4p0mTLKY+iis6Tm2
         S8t05wTQxooaxJDukJtimz77n1LXouIBVbffyJAApj/jmDUOkdzH5SLnrmY4bU0xXBgl
         jBYIs1A55WMpqRtvjdgog2jngQDDh2jAkFKjFJKShfgUYNzziLBFyFcpUDh2HeZ1kPmZ
         fy4DnA0wezZ+BY65HKaFhKV7RuDdEc5SQ4CyJChEHNEQmFUwNh1XQ1DY6KsnsCTHmnE4
         Fo66KNbxZCEoy0zfMKMQPinqdCk9fqJVHmJoHrcmOo68wLMyU1PDlMyHnO7bgZAq76Cl
         Xfaw==
X-Gm-Message-State: AHQUAuYa4VnVzGaNknFUHoM8LVMgZacVpQPMygsu+n8OTgIowWPfhUlQ
        VB7s+BugoLgw5VFzFnHpy5WJ65V0l//7k9rnWlHl0A==
X-Google-Smtp-Source: AHgI3Ia9QVrR7br4MRK/M7rJ+G5f/NiBxxfA6Jw199UR3vcvgzFs81rCJPzaWmpkA6Nd6HDqBEBF0m54vJdp+E4EINQ=
X-Received: by 2002:adf:f70c:: with SMTP id r12mr5684356wrp.54.1550033526805;
 Tue, 12 Feb 2019 20:52:06 -0800 (PST)
MIME-Version: 1.0
References: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
 <1549342622-9929-3-git-send-email-srinath.mannam@broadcom.com> <20190212183739.GB918@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190212183739.GB918@e107981-ln.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 13 Feb 2019 10:21:55 +0530
Message-ID: <CABe79T6L5mCc5zoyRUD-bPk7UdxOv_Yz3vyUNYg=Edw-u2mGzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: iproc: Add PCIe 32bit outbound memory configuration
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Thanks for review, please see my comments below inline.

On Wed, Feb 13, 2019 at 12:07 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Feb 05, 2019 at 10:27:01AM +0530, Srinath Mannam wrote:
> > Add configuration to support IPROC PCIe host controller outbound memory
> > window mapping with SOC address range inside 4GB boundary, which is 32 bit
> > AXI address.
>
> I do not understand what this means, explain it to me and rewrite the
> commit log accordingly.
>
This is about "I/O regions" addressing given through ranges DT property.
In the current driver "I/O regions" address mapping to corresponding
PCI memory address in controller outbound registers
is supports above 32-bit address.
> What does this solve ? Why do we need this patch or rephrased, what
> is missing in the current driver ?
With this patch, If ranges DT property has below 32-bit I/O regions
address then it will be added in the outbound mapping.
This will help to access I/O region from CPU in 32-bit.
I will update commit log and send next patch set.
Ex:
1. ranges DT property for current driver is,
    ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
    I/O region address is 0x400000000
2. ranges DT property with this patch,
    ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
    I/O region address is 0x42000000

Regards,
Srinath.
>
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
>
> Review tags should be given on public mailing lists, these ones seem
> to come from non-public review cycles in which case you must drop
> them.
>
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
>
> See above, I do not understand clearly what this means.
>
> Lorenzo
>
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
