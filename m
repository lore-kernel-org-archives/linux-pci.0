Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:33311 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753590AbdKXQun (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Nov 2017 11:50:43 -0500
MIME-Version: 1.0
In-Reply-To: <1511538800-8275-4-git-send-email-mmaddireddy@nvidia.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com> <1511538800-8275-4-git-send-email-mmaddireddy@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 24 Nov 2017 17:50:42 +0100
Message-ID: <CAJZ5v0ghcwSHdrbZd_=XA=tHz7=aTUVd66dHkMYRNyXpnqP84w@mail.gmail.com>
Subject: Re: [PATCH 03/10] PM / QoS: Fix device resume latency for non PM QoS devices
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>, vidyas@nvidia.com,
        kthota@nvidia.com, linux-tegra@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 24, 2017 at 4:53 PM, Manikanta Maddireddy
<mmaddireddy@nvidia.com> wrote:
> In 'commit 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")'
> PM QoS resume latency modified 0 as "no latency at all". However
> dev_pm_qos_raw_read_value() returns 0 for devices which doesn't have
> PM QoS constraints. This is blocking runtime suspend for these devices
> in rpm_check_suspend_allowed(). Return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
> when PM QoS constraints are not available for a particular device.
>
> Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")

That commit has been reverted, so this patch is not applicable and
therefore the whole series isn't.

What kernel is it based off?

Thanks,
Rafael
