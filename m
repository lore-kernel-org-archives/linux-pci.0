Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f170.google.com ([209.85.213.170]:35163 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754269AbcIVWiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 18:38:05 -0400
Received: by mail-yb0-f170.google.com with SMTP id d69so59688846ybf.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Sep 2016 15:38:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACK8Z6HWnh46X02EBR9MX8_fFvhZUgc96PkwArxwnOFCYyueGw@mail.gmail.com>
References: <1474578027-64292-1-git-send-email-rajatja@google.com>
 <20160922211436.GA69457@google.com> <CACK8Z6HWnh46X02EBR9MX8_fFvhZUgc96PkwArxwnOFCYyueGw@mail.gmail.com>
From: Rajat Jain <rajatja@google.com>
Date: Thu, 22 Sep 2016 15:37:23 -0700
Message-ID: <CACK8Z6E9=Ga_VTC9JunwRRxRZAJx+sKv6g5WtFXd592VdoUyOw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: Increase the Max Credit update interval.
To: Brian Norris <briannorris@chromium.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for the tip Brian, I was able to test it too (for some reason
my system didn't fall apart on retraining the link to 5GT/s).

Sending out new one shortly.

On Thu, Sep 22, 2016 at 2:56 PM, Rajat Jain <rajatja@google.com> wrote:
> On Thu, Sep 22, 2016 at 2:14 PM, Brian Norris <briannorris@chromium.org> wrote:
>> (Nit: I think the $subject is typically 'PCI: rockchip: ...'.)
>>
>> Hi Rajat,
>>
>> On Thu, Sep 22, 2016 at 02:00:27PM -0700, Rajat Jain wrote:
>>> The register value gets lost on a Link speed/width change, and the
>>> ideal fix should reprogram this on that event (refer "Link Bandwidth
>>> Management Interrupt Enable" & "Link Autonomous Bandwidth Interrupt Enable"
>>> in link control reg?).
>>
>> Oh, that that reminds me (sorry for not noticing this earlier): Rockchip
>> did add handling of those two interrupt bits. See:
>>
>>         } else if (reg & PCIE_CLIENT_INT_PHY) {
>>                 dev_dbg(dev, "phy link changes\n");
>>                 rockchip_pcie_clr_bw_int(rockchip);
>>         }
>
> Oh I did not notice this. I'll try it out..
>
>>
>> Do you ever see such interrupts? In any case, it's possible we could do
>> the re-programming there, just to be sure, though I'm not sure we can
>> test it well.
>>
>> Brian
