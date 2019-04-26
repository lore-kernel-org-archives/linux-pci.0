Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F726C43218
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 13:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A8A2077B
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 13:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGmzSrbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfDZNVa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:21:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41926 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfDZNVa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 09:21:30 -0400
Received: by mail-io1-f66.google.com with SMTP id r10so2902140ioc.8;
        Fri, 26 Apr 2019 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ZNOtvepFevmzmMtAUynEOqUF3jb2beeDOj9721fg26s=;
        b=nGmzSrblxYDMUcPBuYBgpHf4YKWS/UFdqu0FexfPA3zAWdOyUVLwBKg1uVOt74zMKh
         E1K3XPO75+jzOWsDlU0ITQKjqiMg3Y6yVbQ59SxeZEgIVX5xiCwd7XdLg6gX+b6kMOv/
         OZdQu7sRGRQZUcWiTszrqjKZuDtqE+VBlpAA1hkzbv1w8Sd3mF9jb0ufhlsUZVEUc8TE
         HYa7e2ev3V/drC5fUHUvPvvmb+MVnW63mDbdb1EtI6z5S2bJgH98iL+aixU8vebQauDt
         sL0IWTKcj/kv+OSMno76VEqiiByouh5QLaVwHymzzUqtUYqKqjy3a2I2h0eWHYmnSPOx
         xveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ZNOtvepFevmzmMtAUynEOqUF3jb2beeDOj9721fg26s=;
        b=g90JshFAKaCYP0bPZan3zSqPixvNaC3GkS5znZMVvkfKliOyJMMB7IVjyXinSvrrsp
         IcliKUMdJ5OMpgvMrYIdc60xL9w691UfJajGS7jW1dXKrwkHOmIqRGSKPzzlpAO+ilEA
         cedVAlMf1Ucrl6OChKnodaXhAkrTmFeG88caC/3GAU5c1oyz3jZZHXYhkmpRhM0cU9mH
         o610IYbV8ZFi4o8jIwy8ib/9lMuFUQVJYRO/ExWJUYyNQCpFTP25SJcmuowW0KI9bee6
         8JWQ4676shK4VDhv+nIoI+vjatFPav9ywweTJ6dhg4EMiVKAB6HhTV0Wn2d9gk6McwOR
         UQLw==
X-Gm-Message-State: APjAAAW8gDlWp/xGceMjWlE1wmk4NrB5birME9Mo/f8BYlRQN1ryk2Lw
        bbzjJh5VIuryFXDMpp12dYAxRFFFavI+7b9orhdjBLWL
X-Google-Smtp-Source: APXvYqx2FjAOr6/Bc+db7gR/r8ORgt4vjRbHsXytKCPPhiKbZhc0s15k4d/98Qv0NV/Fy09ma4NEwe8unOTfutFrn88=
X-Received: by 2002:a05:6602:20d6:: with SMTP id 22mr24484648ioz.163.1556284889287;
 Fri, 26 Apr 2019 06:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <bug-203435-193951@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203435-193951@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Fri, 26 Apr 2019 08:21:18 -0500
Message-ID: <CABhMZUV2bSHUeZErR8=AQrBvuJHeKEMfQJbGTVRgcxZcXp6i2g@mail.gmail.com>
Subject: Re: [Bug 203435] New: Xilinx pcie endpoint DMA not functional for
 ZynqMP PS AXI-PXI DMA endpoint
To:     linux-pci@vger.kernel.org
Cc:     dtyree@newagemicro.com, Michal Simek <michal.simek@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci, Xilinx and DMA engine folks]

I'm not sure what to do with this report.  It mentions "vivado" and
xilinx_ps_pcie_platform.c, neither of which seems to be in mainline or
linux-next.  A Google search suggests that Vivado is a Xilinx product;
maybe this bug report should be directed there?

On Fri, Apr 26, 2019 at 7:09 AM <bugzilla-daemon@bugzilla.kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=203435
>
>             Bug ID: 203435
>            Summary: Xilinx pcie endpoint DMA not functional for ZynqMP PS
>                     AXI-PXI DMA endpoint
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 4.14.0
>           Hardware: Other
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: dtyree@newagemicro.com
>         Regression: No
>
> The ps_pcie_dma-1.00.a driver does not work as an endpoint. I'd be happy to
> help fix/enable/test this out, but I do not understand what the intent was.
>
> The rootdma option is the only one allowed / documented through device-tree and
> kernel docs. It does not cover the epdma branches in the code that require that
> drivers/dma/xilinx/xilinx_ps_pcie_platform.c:18:#define PLATFORM_DRIVER_NAME
>           "ps_pcie_pform_dma"
>
> be available. I am not sure if this was intended to be the endpoint.
>
> The vivado build for the pcie endpoint will not enable the endpoint DMA
> channels. I would expect that to be done through device-tree/PCIe BAR
> configuration reads (for sizes) to set up the channels, but I can't find
> anything that may other than the mystery of epdma with PLATFORM_DRIVER_NAME.
>
> Because the fsbl does not enable the AXI-DMA the rootdma channel enable check
> fails on line xilinx_ps_pcie_platform.c:1832
>         channel->chan_base =
>         (struct DMA_ENGINE_REGISTERS *)((__force char *)(xdev->reg_base) +
>                                  (channel_number * DMA_CHANNEL_REGS_SIZE));
>
>         if (((channel->chan_base->dma_channel_status) &
>                                 DMA_STATUS_DMA_PRES_BIT) == 0) {
>                 dev_err(&platform_dev->dev,
>                         "Hardware reports channel not present\n");
>                 return -ENOTSUPP;
>         }
>
> Is there a different way to access use the PS AXI-PCIe DMA?
>
> Can anyone offer some advice? Have I misunderstood the dis-functionality of the
> epdma -vs- rootdma branching?
>
> Thanks
