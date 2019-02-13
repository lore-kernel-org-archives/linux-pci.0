Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707E0C282CA
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 03:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25440222BA
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 03:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DmyEk0sG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfBMD5e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:57:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33820 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbfBMD5e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2019 22:57:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so866244wmd.1
        for <linux-pci@vger.kernel.org>; Tue, 12 Feb 2019 19:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfUvnKqx0/LCU+eBTQY2ytjcTCXtaG67jN7oy6DeBZA=;
        b=DmyEk0sGurpgvmp4zIbLlSavXJkeT8OZWWI0bFMWGU1Iy8YxY1BbMtrTb7GDOEID99
         60/WqKQYCvwBGERow7H8/Tk8/doa+iZLN76e+5S4DULYQqFWsFFp3wfaBnrWnmqfGhqJ
         1NdsTi5MoIcYn9dGdfh1mNULZBORZiWeJRADw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfUvnKqx0/LCU+eBTQY2ytjcTCXtaG67jN7oy6DeBZA=;
        b=OGCbdyuRQXwafn0WSJvtkDeDk2hK1YauYg+5I3eVJnD4sFg1PuyXhKT5NMiqdl+RIX
         e1xdI5/25IKzGZrD8332gg+u2JEA+R8ZWgitjQCuaLd+KYjAduof6WPmFLWTBws3gi4S
         11rtuP738L/JoTGPpCOIp+W54MoXDwIc1fS759XCiZ5BZAvcRQP25IMxiS24P47Ljsjm
         Pk4wb4U+N+MPzUqrnivcUYoLP58URD9alt82Lrw8RZ8UP5sUJTAkm7YFSSN3S4GaN+Xh
         lED18wNvxrg687oUYglrqMDJIdGkw2UFSIWSxtB2fKFGeIeh1U+R+cqiYLrVt/SetVO0
         2s6A==
X-Gm-Message-State: AHQUAuYHv0B/CMhx9JKJj+XjYnrVSV3OgZb51/Nd9ISCvyJ6fGJLmwFI
        nTb0W1BoOCJpIrI/X+5ssSIMcJYBFXQUoTWGLc1YRA==
X-Google-Smtp-Source: AHgI3Ia+Ybgq1NcDCke4TcYxmJzsqF0zyJuDauqjrhCCq+tYDyGb+ztr4H22Bc/QI/RYhgnZsh63YTkQ2pkmLP8AF4I=
X-Received: by 2002:a1c:c44c:: with SMTP id u73mr1504168wmf.45.1550030251533;
 Tue, 12 Feb 2019 19:57:31 -0800 (PST)
MIME-Version: 1.0
References: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
 <1549342622-9929-2-git-send-email-srinath.mannam@broadcom.com> <20190212181208.GA918@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190212181208.GA918@e107981-ln.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 13 Feb 2019 09:27:20 +0530
Message-ID: <CABe79T7prLa-hPWOfESPYabA_HNvdcc52ztkNJfyLoLv+w7i0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: iproc: Add CRS check in config read
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Thanks for review, please see my comments below inline.

On Tue, Feb 12, 2019 at 11:42 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Feb 05, 2019 at 10:27:00AM +0530, Srinath Mannam wrote:
> > In the current implementation, config read output data 0xffff0001 is
> > assumed as CRS completion. But sometimes 0xffff0001 can be a valid data.
> >
> > IPROC PCIe host controller has a register to show config read request
> > status flags like SC, UR, CRS and CA. So that extra check is added to
> > confirm the CRS using status flags before reissue config read.
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index c20fd6b..b882255 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -60,6 +60,10 @@
> >  #define APB_ERR_EN_SHIFT             0
> >  #define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
> >
> > +#define CFG_RD_SUCCESS                       0
> > +#define CFG_RD_UR                    1
> > +#define CFG_RD_CRS                   2
> > +#define CFG_RD_CA                    3
> >  #define CFG_RETRY_STATUS             0xffff0001
> >  #define CFG_RETRY_STATUS_TIMEOUT_US  500000 /* 500 milliseconds */
> >
> > @@ -289,6 +293,9 @@ enum iproc_pcie_reg {
> >       IPROC_PCIE_IARR4,
> >       IPROC_PCIE_IMAP4,
> >
> > +     /* config read status */
> > +     IPROC_PCIE_CFG_RD_STATUS,
> > +
> >       /* link status */
> >       IPROC_PCIE_LINK_STATUS,
> >
> > @@ -350,6 +357,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
> >       [IPROC_PCIE_IMAP3]              = 0xe08,
> >       [IPROC_PCIE_IARR4]              = 0xe68,
> >       [IPROC_PCIE_IMAP4]              = 0xe70,
> > +     [IPROC_PCIE_CFG_RD_STATUS]      = 0xee0,
>
> So, with the *current* code, on controllers that does not support this
> register you won't be able to get any HW whose config space register
> value reads 0xffff0001 to work, is that correct ?
>
Yes, this feature(register) is available only in "iProc PCIe PAXB v2"
controller for other controllers it will not applicable.

Regards,
Srinath.
> Lorenzo
>
> >       [IPROC_PCIE_LINK_STATUS]        = 0xf0c,
> >       [IPROC_PCIE_APB_ERR_EN]         = 0xf40,
> >  };
> > @@ -474,10 +482,12 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
> >       return (pcie->base + offset);
> >  }
> >
> > -static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
> > +static unsigned int iproc_pcie_cfg_retry(struct iproc_pcie *pcie,
> > +                                      void __iomem *cfg_data_p)
> >  {
> >       int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
> >       unsigned int data;
> > +     u32 status;
> >
> >       /*
> >        * As per PCIe spec r3.1, sec 2.3.2, CRS Software Visibility only
> > @@ -498,6 +508,15 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
> >        */
> >       data = readl(cfg_data_p);
> >       while (data == CFG_RETRY_STATUS && timeout--) {
> > +             /*
> > +              * CRS state is set in CFG_RD status register
> > +              * This will handle the case where CFG_RETRY_STATUS is
> > +              * valid config data.
> > +              */
> > +             status = iproc_pcie_read_reg(pcie, IPROC_PCIE_CFG_RD_STATUS);
> > +             if (status != CFG_RD_CRS)
> > +                     return data;
> > +
> >               udelay(1);
> >               data = readl(cfg_data_p);
> >       }
> > @@ -576,7 +595,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> >       if (!cfg_data_p)
> >               return PCIBIOS_DEVICE_NOT_FOUND;
> >
> > -     data = iproc_pcie_cfg_retry(cfg_data_p);
> > +     data = iproc_pcie_cfg_retry(pcie, cfg_data_p);
> >
> >       *val = data;
> >       if (size <= 2)
> > --
> > 2.7.4
> >
