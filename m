Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42077 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbdKZWcC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Nov 2017 17:32:02 -0500
Date: Sun, 26 Nov 2017 16:31:55 -0600
From: Rob Herring <robh@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com,
        frowand.list@gmail.com, bhelgaas@google.com, rjw@rjwysocki.net,
        tglx@linutronix.de, vidyas@nvidia.com, kthota@nvidia.com,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 2/9] of: Export of_pci_range_to_resource()
Message-ID: <20171126223155.ip6sfcoocvqyeiyr@rob-hp-laptop>
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
 <1511638333-22951-3-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511638333-22951-3-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 26, 2017 at 01:02:06AM +0530, Manikanta Maddireddy wrote:
> Tegra PCIe host driver parses of_pci_range from device tree and converts
> to resource. Export of_pci_range_to_resource() to allow Tegra PCIe host
> driver to be compiled as loadable kernel module.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * commit message update
> 
>  drivers/of/address.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
