Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbdGPOxf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Jul 2017 10:53:35 -0400
Date: Sun, 16 Jul 2017 08:53:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: ryzen X370: iommu - unusable huge groups
Message-ID: <20170716085334.7ae210d2@w520.home>
In-Reply-To: <95b7f350-76f7-daff-be4a-f3fc70589ba9@01019freenet.de>
References: <95b7f350-76f7-daff-be4a-f3fc70589ba9@01019freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 16 Jul 2017 07:44:01 +0200
Andreas Hartmann <andihartmann@01019freenet.de> wrote:

> Hello!
> 
> I've got a Asus X370-Pro motherboard with enabled iommu. Unfortunately,
> the group 0 is mostly all of the system :-).
> 
> [    2.602426] iommu: Adding device 0000:00:01.0 to group 0
> [    2.602440] iommu: Adding device 0000:00:01.3 to group 0
> [    2.603368] iommu: Adding device 0000:03:00.0 to group 0
> [    2.603377] iommu: Adding device 0000:03:00.1 to group 0
> [    2.603385] iommu: Adding device 0000:03:00.2 to group 0
> [    2.603396] iommu: Adding device 0000:1d:00.0 to group 0
> [    2.603406] iommu: Adding device 0000:1d:02.0 to group 0
> [    2.603417] iommu: Adding device 0000:1d:03.0 to group 0
> [    2.603428] iommu: Adding device 0000:1d:04.0 to group 0
> [    2.603439] iommu: Adding device 0000:1d:06.0 to group 0
> [    2.603450] iommu: Adding device 0000:1d:07.0 to group 0
> [    2.603466] iommu: Adding device 0000:24:00.0 to group 0
> [    2.603481] iommu: Adding device 0000:25:00.0 to group 0
> [    2.603498] iommu: Adding device 0000:26:00.0 to group 0
> [    2.603513] iommu: Adding device 0000:27:00.0 to group 0


Update your motherboard BIOS, AMD AGESA 1.0.0.6 is supposed to
enable ACS in the PCIe root ports.  Thanks,

Alex
