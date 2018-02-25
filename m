Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:2226
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751557AbeBYJat (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 25 Feb 2018 04:30:49 -0500
Subject: Re: [PATCH next V1 4/7] PCI: Print PCI device link status in kernel
 log
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>
References: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
 <1516030541-6626-5-git-send-email-talgi@mellanox.com>
 <20180222195744.GB16519@bhelgaas-glaptop.roam.corp.google.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <02c5c188-fb1f-4582-541a-2770fd13da3c@mellanox.com>
Date: Sun, 25 Feb 2018 11:30:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180222195744.GB16519@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/22/2018 9:57 PM, Bjorn Helgaas wrote:>
> Suggested text:
> 
>    pci_info(dev, "available bandwidth %dGB/s (capable of %dGB/s)\n", ...
> 
> I'm not sure this merits a pci_warn().  In some cases a user might be
> able to move the device to a different slot or something, but I'm sure
> there are platforms where it is impossible for the user to do anything
> about this, and I don't think we need to warn about that.

We face a lot of customer "bugs" due to lower than expected PCIe 
bandwidth. I think an info print would be too light in this case. Even 
if the user has nothing to do it should be aware of the problem.
