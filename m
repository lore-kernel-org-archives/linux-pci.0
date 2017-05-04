Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:39674 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdEDUm3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2017 16:42:29 -0400
Subject: Re: [PATCH 1/2] PCI: tegra: Support MSI 64-bit addressing
To: Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20170504201032.32633-1-thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <031f173d-20af-efbf-17f1-ad6d9a2d0158@wwwdotorg.org>
Date: Thu, 4 May 2017 14:42:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170504201032.32633-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/04/2017 02:10 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The MSI target address can reside beyond the 32-bit boundary on devices
> with more than 2 GiB of system memory. The PCI host bridge on Tegra can
> easily support 64-bit addresses, so make sure to pass the upper 32 bits
> of the target address to endpoints when allocating MSI entries.

The series,
Acked-by: Stephen Warren <swarren@nvidia.com>

Should the first patch in the series be CC: stable since it fixes a bug?
