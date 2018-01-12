Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934152AbeALO0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jan 2018 09:26:51 -0500
Subject: Re: Regression (sort of): PCI/portdrv: Turn off PCIe services during
 shutdown
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org
References: <20180112104929.GA10599@wunner.de>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ece49947-e75a-baff-9c4a-6f47bd154642@codeaurora.org>
Date: Fri, 12 Jan 2018 09:26:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180112104929.GA10599@wunner.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lukas,

On 1/12/2018 5:49 AM, Lukas Wunner wrote:
> Hi Sinan,
> 
> I updated to 4.15 this week and noticed a regression (if one may call it
> that, it's more like a very noticeable annoyance) affecting machines
> with Thunderbolt controllers wherein a reboot or shutdown is delayed by
> 8 seconds, caused by

Sorry for that.

I wonder if we can separate remove from shutdown and just disable the IRQs
in shutdown case rather than turning off the slot power etc.

Let me see if I can come up with a quick patch.

> On the one hand, your commit message sounds as though the change merely
> addresses a *potential* issue, so one could argue that if it causes
> *real* issues such as delayed reboots, it's probably not a good idea.
> On the other hand I do see your point since a user might surprise-remove
> a device from a hotplug slot during shutdown, and we clearly wouldn't want
> to act on that.

We are seeing the problem on our platform (QDF2400). It is just sporadic. 
That's why, the commit message was loosely worded.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
