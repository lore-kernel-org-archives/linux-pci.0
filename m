Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:46792 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505AbcBIQOz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 11:14:55 -0500
Subject: Re: [PATCH] PCI: tegra: Update for new XUSB pad controller bindings
To: Thierry Reding <thierry.reding@gmail.com>
References: <1455029465-9211-1-git-send-email-thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <56BA107A.9050201@wwwdotorg.org>
Date: Tue, 9 Feb 2016 09:14:50 -0700
MIME-Version: 1.0
In-Reply-To: <1455029465-9211-1-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/09/2016 07:51 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The current XUSB pad controller bindings are insufficient to describe
> PHY devices attached to USB controllers. New bindings have been created
> to overcome these restrictions.

New bindings have been created? Which ones; there were several attempts 
to enhance the bindings, but I wasn't aware that any of them had passed 
through review and been accepted.

