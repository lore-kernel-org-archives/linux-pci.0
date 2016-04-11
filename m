Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:37442 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbcDKRlN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2016 13:41:13 -0400
Subject: Re: [PATCH v4 2/2] PCI: tegra: Support per-lane PHYs
To: Thierry Reding <thierry.reding@gmail.com>
References: <1460131994-24493-1-git-send-email-thierry.reding@gmail.com>
 <1460131994-24493-2-git-send-email-thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <570BE1B6.5000808@wwwdotorg.org>
Date: Mon, 11 Apr 2016 11:41:10 -0600
MIME-Version: 1.0
In-Reply-To: <1460131994-24493-2-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/08/2016 10:13 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The current XUSB pad controller bindings are insufficient to describe
> PHY devices attached to USB controllers. New bindings have been created
> to overcome these restrictions. As a side-effect each root port now is
> assigned a set of PHY devices, one for each lane associated with the
> root port. This has the benefit of allowing fine-grained control of the
> power management for each lane.

Same here.

http://www.spinics.net/lists/devicetree/msg118644.html

