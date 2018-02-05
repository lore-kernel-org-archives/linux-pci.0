Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753166AbeBEPk0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Feb 2018 10:40:26 -0500
Date: Mon, 5 Feb 2018 08:40:25 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Q: uio_pci_generic
Message-ID: <20180205084025.52129a85@w520.home>
In-Reply-To: <CAJ2oMhKRmSb-XFp2eeGEWqivL60C0uD22Yx1EdZ5ziAMOvmUUQ@mail.gmail.com>
References: <CAJ2oMhKRmSb-XFp2eeGEWqivL60C0uD22Yx1EdZ5ziAMOvmUUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 5 Feb 2018 15:58:22 +0200
Ran Shalit <ranshalit@gmail.com> wrote:

> Hello,
> 
> 
> I can't find in uio_pci_generic.c any usage of DMA.
> Is it that the driver does not use DMA in transactions between device
> and host ? If not - isn't it a sort disadvantage ?

AIUI, uio_pci_generic doesn't officially support DMA because there's no
way that a userspace driver can safely support DMA without an IOMMU
isolating the device.  Otherwise the userspace driver can use the
device to read and write data anywhere it wants, which is also sort of
a disadvantage.  Of course this doesn't seem to stop anyone from doing
DMA with uio_pci_generic, but you're not likely to get much support for
such uses.  Instead, you might want to be looking at vfio, which does
make use of (and require) IOMMU support in order to more safely allow
userspace drivers to use DMA.  Thanks,

Alex
