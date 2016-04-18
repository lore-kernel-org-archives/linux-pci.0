Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:54384 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbcDRQuT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2016 12:50:19 -0400
Subject: Re: [PATCH v5 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1460991105-22861-1-git-send-email-thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <57151048.2090806@wwwdotorg.org>
Date: Mon, 18 Apr 2016 10:50:16 -0600
MIME-Version: 1.0
In-Reply-To: <1460991105-22861-1-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/18/2016 08:51 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The XUSB pad controller allows PCIe lanes to be controlled individually,
> providing fine-grained control over their power state. Previous attempts
> at describing the XUSB pad controller in DT had erroneously assumed that
> all PCIe lanes were driven by the same PHY, and hence the PCI host
> controller would reference only a single PHY.
>
> Moving to a representation of per-lane PHYs requires that the operating
> system driver for the PCI host controller have access to the set of PHY
> devices that make up the connection of each root port in order to power
> up and down all of the lanes as necessary.

The series,
Acked-by: Stephen Warren <swarren@nvidia.com>

