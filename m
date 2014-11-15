Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:47875 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbaKOE0Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Nov 2014 23:26:16 -0500
Received: by mail-qg0-f54.google.com with SMTP id q108so12758510qgd.41
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2014 20:26:15 -0800 (PST)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 14 Nov 2014 21:25:55 -0700
Message-ID: <CAErSpo7m9xMy9buOmF==8H_VSkBBqPZD1_OCPYjEz_1Q1n4y0Q@mail.gmail.com>
Subject: Re: DMA_ALIAS_DEVFN issue
To: "Allan, Bruce W" <bruce.w.allan@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex, add a subject]

On Fri, Nov 14, 2014 at 6:49 PM, Allan, Bruce W <bruce.w.allan@intel.com> wrote:
> Let's try this again as plain text...
>
> For a PCIe device with SR-IOV support enabled (e.g. the PF device ID is 0xf001 at 0000:07:00.0 and the 16 VFs have device ID 0xf002 at 0000:07:01.0 through 0000:07:02.7), if the hardware attempts a DMA read/write of memory that was mapped by the PF devfn but instead uses a requester id of one of the VF devfns (enabled but not yet assigned to a VM) it fails and generates log messages similar to:
>
> [  416.800881] dmar: DRHD: handling fault status reg 2
> [  416.800887] dmar: DMAR:[DMA Read] Request device [07:02.2] fault addr ffff0000
> DMAR:[fault reason 02] Present bit in context entry is clear
>
> Shouldn't a DMA alias quirk that sets the PCI_DEV_FLAGS_DMA_ALIAS_DEVFN flag and dma_alias_devfn to the PF devfn for all VF devfns work-around this issue, or am I misunderstanding what a DMA alias quirk is supposed to do?  If a DMA alias quirk cannot resolve this, what is the most appropriate way to handle this?
>
> Thanks,
> Bruce.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
