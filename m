Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:36262 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035062AbcIVV5D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 17:57:03 -0400
Received: by mail-yb0-f176.google.com with SMTP id u125so59551600ybg.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Sep 2016 14:57:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160922211436.GA69457@google.com>
References: <1474578027-64292-1-git-send-email-rajatja@google.com> <20160922211436.GA69457@google.com>
From: Rajat Jain <rajatja@google.com>
Date: Thu, 22 Sep 2016 14:56:21 -0700
Message-ID: <CACK8Z6HWnh46X02EBR9MX8_fFvhZUgc96PkwArxwnOFCYyueGw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: Increase the Max Credit update interval.
To: Brian Norris <briannorris@chromium.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 22, 2016 at 2:14 PM, Brian Norris <briannorris@chromium.org> wrote:
> (Nit: I think the $subject is typically 'PCI: rockchip: ...'.)
>
> Hi Rajat,
>
> On Thu, Sep 22, 2016 at 02:00:27PM -0700, Rajat Jain wrote:
>> The register value gets lost on a Link speed/width change, and the
>> ideal fix should reprogram this on that event (refer "Link Bandwidth
>> Management Interrupt Enable" & "Link Autonomous Bandwidth Interrupt Enable"
>> in link control reg?).
>
> Oh, that that reminds me (sorry for not noticing this earlier): Rockchip
> did add handling of those two interrupt bits. See:
>
>         } else if (reg & PCIE_CLIENT_INT_PHY) {
>                 dev_dbg(dev, "phy link changes\n");
>                 rockchip_pcie_clr_bw_int(rockchip);
>         }

Oh I did not notice this. I'll try it out..

>
> Do you ever see such interrupts? In any case, it's possible we could do
> the re-programming there, just to be sure, though I'm not sure we can
> test it well.
>
> Brian
