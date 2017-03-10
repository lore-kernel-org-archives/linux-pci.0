Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0055.outbound.protection.outlook.com ([104.47.41.55]:48256
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755134AbdCJI2T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Mar 2017 03:28:19 -0500
Subject: Re: IOMMU suuport for Ryzen / x370?
To: Andreas Hartmann <andihartmann@01019freenet.de>,
        <linux-pci@vger.kernel.org>
References: <658a7e9c-7dff-f62e-e2ba-fe151fdbe7d2@01019freenet.de>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Message-ID: <2b69d0e8-6e17-6c2f-9f91-b828ba701e45@amd.com>
Date: Fri, 10 Mar 2017 15:28:08 +0700
MIME-Version: 1.0
In-Reply-To: <658a7e9c-7dff-f62e-e2ba-fe151fdbe7d2@01019freenet.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 3/10/17 12:10, Andreas Hartmann wrote:
> Hello all!
>
>
> I've got just one quick question: Is there already usable support for
> IOMMU in an actual released kernel (chipset x370)? I would need it for
> virtualization with vfio / vfio_pci to passthrough PCI and PCIIE cards
> to kvm VMs as I'm already doing it with FX 8350 processor (AMD 990X
> chipset).

Yes, this should have been supported since v4.9.

Thanks
Suravee

>
>
> Thanks,
> regards,
> Andreas
>
