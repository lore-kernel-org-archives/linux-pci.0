Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14081 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdKYTq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Nov 2017 14:46:56 -0500
Subject: Re: [PATCH 03/10] PM / QoS: Fix device resume latency for non PM QoS
 devices
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC: Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>, <vidyas@nvidia.com>,
        <kthota@nvidia.com>, <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
 <1511538800-8275-4-git-send-email-mmaddireddy@nvidia.com>
 <CAJZ5v0ghcwSHdrbZd_=XA=tHz7=aTUVd66dHkMYRNyXpnqP84w@mail.gmail.com>
 <20171124203940.GA12811@mithrandir>
 <CAJZ5v0h1EdMV5u-5noMv_1_OpS13nH2NW_6Aua9+LMoWH0tL2w@mail.gmail.com>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <d6abebcf-5397-33d4-f41f-a96f3c81ac14@nvidia.com>
Date: Sun, 26 Nov 2017 01:16:42 +0530
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h1EdMV5u-5noMv_1_OpS13nH2NW_6Aua9+LMoWH0tL2w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 25-Nov-17 5:32 AM, Rafael J. Wysocki wrote:
> On Fri, Nov 24, 2017 at 9:39 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
>> On Fri, Nov 24, 2017 at 05:50:42PM +0100, Rafael J. Wysocki wrote:
>>> On Fri, Nov 24, 2017 at 4:53 PM, Manikanta Maddireddy
>>> <mmaddireddy@nvidia.com> wrote:
>>>> In 'commit 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")'
>>>> PM QoS resume latency modified 0 as "no latency at all". However
>>>> dev_pm_qos_raw_read_value() returns 0 for devices which doesn't have
>>>> PM QoS constraints. This is blocking runtime suspend for these devices
>>>> in rpm_check_suspend_allowed(). Return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
>>>> when PM QoS constraints are not available for a particular device.
>>>>
>>>> Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
>>>
>>> That commit has been reverted, so this patch is not applicable and
>>> therefore the whole series isn't.
>>>
>>> What kernel is it based off?
>>
>> It looks like this might have crept in via commit 0759e80b84e3 ("PM /
>> QoS: Fix device resume latency framework"). But checking more closely,
>> that commit actually incorporates this change already.
>>
>> According to the git log the correct commit for this showed up in
>> linux-next only today, which is probably why Manikanta missed it.
> 
> Well, it's been in the Linus' tree for a week, though.
> 
> Thanks,
> Rafael
> 
I dropped this patch in V2.

Thanks,
Manikanta
