Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35326 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeHFV5S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2018 17:57:18 -0400
Received: by mail-yw1-f65.google.com with SMTP id s68-v6so1039057ywg.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Aug 2018 12:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com> <20180723140143.1a46902f@cakuba.netronome.com>
 <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com> <fc04618a-3b3b-58bd-edd5-cbde11638d7b@mellanox.com>
 <1b914780-e342-6aee-ffb2-ef81ac3ddd29@gmail.com> <7424c5ba-ae44-3d8d-9dd5-360e17b6e3b9@mellanox.com>
 <c0f2f79b1fe1491287b35e70ba76902a@ausx13mps321.AMER.DELL.COM>
In-Reply-To: <c0f2f79b1fe1491287b35e70ba76902a@ausx13mps321.AMER.DELL.COM>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 6 Aug 2018 14:46:28 -0500
Message-ID: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
To: Alex_Gagniuc@dellteam.com
Cc: Tal Gilboa <talgi@mellanox.com>, mr.nuke.me@gmail.com,
        jakub.kicinski@netronome.com, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>, Austin.Bolen@dell.com,
        Shyam.Iyer@dell.com,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        ariel.elior@cavium.com, michael.chan@broadcom.com,
        ganeshgr@chelsio.com, tariqt@mellanox.com,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 6, 2018 at 1:39 PM <Alex_Gagniuc@dellteam.com> wrote:
>
> On 08/05/2018 02:06 AM, Tal Gilboa wrote:
> > On 7/31/2018 6:10 PM, Alex G. wrote:
> >> On 07/31/2018 01:40 AM, Tal Gilboa wrote:
> >> [snip]
> >>>>>> @@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct
> >>>>>> pci_dev *dev)
> >>>>>>        /* Advanced Error Reporting */
> >>>>>>        pci_aer_init(dev);
> >>>>>> +    /* Check link and detect downtrain errors */
> >>>>>> +    pcie_check_upstream_link(dev);
> >>>>
> >>>> This is called for every PCIe device right? Won't there be a
> >>>> duplicated print in case a device loads with lower PCIe bandwidth
> >>>> than needed?
> >>>
> >>> Alex, can you comment on this please?
> >>
> >> Of course I can.
> >>
> >> There's one print at probe() time, which happens if bandwidth < max. I
> >> would think that's fine. There is a way to duplicate it, and that is if
> >> the driver also calls print_link_status(). A few driver maintainers who
> >> call it have indicated they'd be fine with removing it from the driver,
> >> and leaving it in the core PCI.
> >
> > We would be fine with that as well. Please include the removal in your
> > patches.
>
> What's the proper procedure? Do I wait for confirmation from Bjorn
> before knocking on maintainer's doors, or do I William Wallace into
> their trees and demand they merge the removal (pending Bjorn's approval
> on the other side) ?

Post a v4 series that does the PCI core stuff as well as removing the
driver code.

Bjorn
