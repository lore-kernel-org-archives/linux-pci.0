Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44867 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeEVVI2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 17:08:28 -0400
Received: by mail-vk0-f65.google.com with SMTP id x66-v6so11816883vka.11
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2018 14:08:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a0997fec-ba06-0d1d-a43d-fcc1600484f5@deltatee.com>
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com> <a0997fec-ba06-0d1d-a43d-fcc1600484f5@deltatee.com>
From: Doug Meyer <dmeyer@gigaio.com>
Date: Tue, 22 May 2018 14:08:27 -0700
Message-ID: <CA+GK6enp==Xb8w2mCCJGuJwWNNPuseuS-jvp00cVszgWvfbODA@mail.gmail.com>
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
To: Logan Gunthorpe <logang@deltatee.com>
Cc: kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-ntb <linux-ntb@googlegroups.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[resending because I forgot the mailing lists want plain text mode]


Dear Logan,

I agree. I'll add pci_disable_device().

Blessings,
Doug



On Thu, May 17, 2018 at 8:48 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Thanks for your hard work on this Doug!
>
> On 17/05/18 06:00 AM, dmeyer@gigaio.com wrote:
>
> > +     if (pci_enable_device(pdev)) {
> > +             dev_err(&pdev->dev, "Cannot enable Switchtec device\n");
> > +             return;
> > +     }
>
> I suspect we should probably cass pci_disable_device() before leaving
> this function so it's in the same state we started. Just like we unmap
> the mmio.
>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/a0997fec-ba06-0d1d-a43d-fcc1600484f5%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
