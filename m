Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435D6C282C5
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 08:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB3B218A2
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 08:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nr04hESD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfAXInn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:43:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40985 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfAXInm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 03:43:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so5486241wrs.8
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2019 00:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcC/ahQ5gPh5GGtxDUwG3QmvMzNYe68M+L0cnRtfxnA=;
        b=Nr04hESD3WKZRwFKATaiNJz5yZrxXRW94oywd4/jIsFQTiUzIgZplRxM/B4oSzbrNa
         eBa5F2fFneULcsuNhDo8I0jC69EYWL+AYtzRsa9N4zBiB+VGTvsZivIHWAu808/P4FzP
         ow24WLWSkrddwFjhCTo1bacoF/xjnEetDdoTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcC/ahQ5gPh5GGtxDUwG3QmvMzNYe68M+L0cnRtfxnA=;
        b=cibnvNc0d5fl2Jr9Q0BU1WliD5xhixQmn3jnViasW3DQxwV4WjeqZE1VZaWOuKmfkp
         VwjEwdZGpa8sDR8+d5uUbSfRaMeJ8SxnzsJdvSA879daqaTVNhpXRL90G1CF/Y5D3gD8
         43pOnC0EAHROud782PCOp7PVFN8/HjatAPWCZGlWp/JuiaLJAoMhnObII0PVQcma3FRM
         Z1yuOoAHOo3HbnZ1NJU3jECnNMYa9ID4isGJUWNrFROZB2s9E4uTisitg8BgcKAtUxmk
         vdvbmaxDQpKfGoi1+M/UYNw3TJ8R/Lt1bAJDspK2hTJgzMjGSHVNjEQ9j4O0T4vEDEFI
         gUYA==
X-Gm-Message-State: AJcUukcr6GQRz11aJjn7BF6PG/3QGO8tqI8vHCwvxnYfHuuhRoq4OtGK
        dcVIwGO971dauqjLGzJ/CLYh0WnVjJ9kTiW/Tjk6Uw==
X-Google-Smtp-Source: ALg8bN6x2BxQNBWDyBvML0RVKhEpb5CLTfuYY/s0DVIdJrc/fJV0l7oRPQHJdU62bjXa5KRgXAGCN9k6zvu+gB8otQw=
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr6178425wrm.83.1548319420857;
 Thu, 24 Jan 2019 00:43:40 -0800 (PST)
MIME-Version: 1.0
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
 <1547785403-32268-3-git-send-email-srinath.mannam@broadcom.com> <20190118150851.GC25249@google.com>
In-Reply-To: <20190118150851.GC25249@google.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 24 Jan 2019 14:13:29 +0530
Message-ID: <CABe79T4Pk4BtqaeV_hsJb+PXRoz9ToregVtqskcMqAiwtJSyMQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: iproc: CRS state check in config request
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for review, please see my comments below inline.

On Fri, Jan 18, 2019 at 8:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jan 18, 2019 at 09:53:22AM +0530, Srinath Mannam wrote:
> > In the current implementation, config read of 0xffff0001 data
> > is assumed as CRS completion. but sometimes 0xffff0001 can be
> > a valid data.
> > IPROC PCIe RC has a register to show config request status flags
> > like SC, UR, CRS and CA.
> > So that extra check is added in the code to confirm the CRS
> > state using this register before reissue config request.
>
> s/. but/.  But/  (Sentences start with a capital letter.)
will change. Thanks.
>
> Please wrap this text correctly.  If it's a single paragraph, wrap it so
> the lines are filled.  It *looks* like it's intended to be separate
> paragraphs; they should be separated by blank lines.
will change. Thanks.
>
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index 13ce80f..ee89d56 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -63,6 +63,10 @@
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
> > @@ -300,6 +304,9 @@ enum iproc_pcie_reg {
> >       IPROC_PCIE_IARR4,
> >       IPROC_PCIE_IMAP4,
> >
> > +     /* config read status */
> > +     IPROC_PCIE_CFG_RD_STATUS,
> > +
> >       /* link status */
> >       IPROC_PCIE_LINK_STATUS,
> >
> > @@ -370,6 +377,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
> >       [IPROC_PCIE_IMAP3]              = 0xe08,
> >       [IPROC_PCIE_IARR4]              = 0xe68,
> >       [IPROC_PCIE_IMAP4]              = 0xe70,
> > +     [IPROC_PCIE_CFG_RD_STATUS]      = 0xee0,
> >       [IPROC_PCIE_LINK_STATUS]        = 0xf0c,
> >       [IPROC_PCIE_APB_ERR_EN]         = 0xf40,
> >       [IPROC_PCIE_ORDERING_CFG]       = 0x2000,
> > @@ -501,10 +509,12 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
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
> > @@ -525,6 +535,15 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
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
> > @@ -603,7 +622,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
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
