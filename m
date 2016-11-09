Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753168AbcKIRCS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Nov 2016 12:02:18 -0500
Date: Wed, 9 Nov 2016 11:02:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH 0/2] PCI: Add quirk for Fintek F81504/508/512 on Skylake
Message-ID: <20161109170213.GI14322@bhelgaas-glaptop.roam.corp.google.com>
References: <1478510552-4883-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478510552-4883-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Peter,

On Mon, Nov 07, 2016 at 05:22:30PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> We had tested Fintek F81504/508/512 PCIe-to-UART/GPIO on Intel Skylake
> platform. It's maybe flood AER correctable error interrupt and slow down
> the system boot. It's the same issue about below link:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1521173

The issue in the Launchpad report above is a bug in the PCI AER
driver.  We need to fix that problem, not add quirks to avoid the
problem.

I think it's a pretty straightforward problem:
https://marc.info/?l=linux-pci&m=145140470807043

I haven't had time to fix it myself, so it'd be great if somebody
else would step up and fix it.

> and this IC will malfunctional after suspend/resume (S3, D0->D3->D0) on
> Skylake platform. 
> 
> The first patch will use parent AER interrupt mask to prevent generating
> correctable error interrupt, the  and second will prevent the IC malfunctional
> after D3.
> 
> Ji-Ze Hong (Peter Hong) (2):
>   PCI: Add quirk for Fintek F81504/508/512 AER issue
>   PCI: Add quirk for Fintek F81504/508/512 D3 issue
> 
>  drivers/pci/quirks.c    | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |  5 +++++
>  2 files changed, 55 insertions(+)
> 
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
