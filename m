Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755606AbdKNXNL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Nov 2017 18:13:11 -0500
Date: Tue, 14 Nov 2017 17:13:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: treding@nvidia.com, bhelgaas@google.com, rajatja@google.com,
        yinghai@kernel.org, david.daney@cavium.com, Julia.Lawall@lip6.fr,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com
Subject: Re: [PATCH V2 3/4] PCI: tegra: Apply sw fixups to support ASPM-L1
 Sub-States
Message-ID: <20171114231307.GA13646@bhelgaas-glaptop.roam.corp.google.com>
References: <1509423769-10522-1-git-send-email-vidyas@nvidia.com>
 <1509423769-10522-4-git-send-email-vidyas@nvidia.com>
 <20171107225007.GA22847@bhelgaas-glaptop.roam.corp.google.com>
 <ef7d193c-c114-d0c6-e450-c00ae3ab2d51@nvidia.com>
 <20171108174829.GE28427@bhelgaas-glaptop.roam.corp.google.com>
 <c387c65f-6e87-639e-0bf5-2324a745ba5a@nvidia.com>
 <20171110212900.GB19895@bhelgaas-glaptop.roam.corp.google.com>
 <7b61f849-2a0a-528e-aa6f-b259fda2294b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <7b61f849-2a0a-528e-aa6f-b259fda2294b@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 12, 2017 at 05:21:47PM +0530, Vidya Sagar wrote:
> On Saturday 11 November 2017 02:59 AM, Bjorn Helgaas wrote:
> >On Fri, Nov 10, 2017 at 03:37:10PM +0530, Vidya Sagar wrote:

> >>LTR_L1.2_THRESHOLD time is for the device to enter into and exit
> >>from L1.2 state.
> >That doesn't feel right to me.  Device characteristics are normally
> >communicated via "capabilities" registers, not programmed by the OS in
> >"control" registers.  The OS needs to be able to configure arbitrary
> >plug-in devices without having device-specific details built into it.
> But there is no capability register/field for LTR_L1.2_THRESHOLD either for
> root ports or end points

Sorry, I didn't state that clearly.  I agree that LTR_L1.2_THRESHOLD
should be the time required to enter and exit the L1.2 state.

What doesn't make sense to me is that the OS would have to have
device-specific quirks built into it instead of being able to discover
what it needs via "capabilities" registers.  If it did, we would have
no way to configure a plug-in switch unless we added a quirk for every
device.  That would be a serious design error in the L1 Substates
feature.

Assume we have an Endpoint connected to a Root Port.  We should set
LTR_L1.2_THRESHOLD to the time it takes to transition the Link from L0
to L1.2 and back to L0.  Then we will enter L1.2 only if the Endpoint
has reported that it can tolerate at least that much latency.

>From sec 5.5.3.3.1, Figures 5-16 and 5-17, it looks like the latency
to go from L1.0 to L1.2 and back to L0 should be at least the sum of:

  T(POWER_OFF)       max 2us (from Table 5-11)
  T(L1.2)            min 4us (from Table 5-11)
  T(POWER_ON)        from L1 PM Substates Control 2 register
  T(COMMONMODE)      from L1 PM Substates Control 1 register

This doesn't include (a) the time from L0 to L1.0 and (b) the gap
between T(POWER_ON) and T(COMMONMODE).  I don't know how to learn
those.  But I think we know how to compute T(POWER_ON) and
T(COMMONMODE) by taking the max of Port T_POWER_ON and Port
Common_Mode_Restore_Time for the two ends of the Link.

Your lspci output (below) shows:

  Root Port: Port T_POWER_ON = 70us
  Root Port: Port Common_Mode_Restore_Time = 30us
  Endpoint:  Port T_POWER_ON = 10us
  Endpoint:  Port Common_Mode_Restore_Time = 10us

That would make T(POWER_ON) = max(70us, 10us) = 70us
and T(COMMONMODE) = max(30us, 10us) = 30us.

So I would think the LTR_L1.2_THRESHOLD should be at least

  2us + 4us + 70us + 30us = 106us

Your hardware folks came up with 55us, but I don't know how.  I guess
they're using information not visible to the OS?  

Can you explain where I'm going wrong in my calculations?  I think we
should be able to relate the values from the L1 PM Substates
Capabilities register to the timing diagrams in sec 5.5.3.3.1 somehow.

> Here is the L1 SS registers dumps for both root port and end point
> 00:01.0 PCI bridge: NVIDIA Corporation Device 0fae (rev a1) (prog-if
> 00 [Normal decode])
>     Capabilities: [140 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>               PortCommonModeRestoreTime=30us PortTPowerOnTime=70us
>         L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                T_CommonMode=30us LTR1.2_Threshold=56320ns
>         L1SubCtl2: T_PwrOn=70us
> 
> 01:00.0 Non-Volatile memory controller: Sandisk Corp Device 5001
> (prog-if 02 [NVM Express])
>     Capabilities: [2c0 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>               PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                T_CommonMode=0us LTR1.2_Threshold=56320ns
>         L1SubCtl2: T_PwrOn=70us

Bjorn
