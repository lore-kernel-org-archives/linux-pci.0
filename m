Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44478 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758086Ab3CYRBT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2013 13:01:19 -0400
Message-ID: <515082DB.1090801@wwwdotorg.org>
Date: Mon, 25 Mar 2013 11:01:15 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] PCI: tegra: Use new MSI chip infrastructure
References: <1363942307-9327-1-git-send-email-thierry.reding@avionic-design.de> <1363942307-9327-3-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1363942307-9327-3-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/22/2013 02:51 AM, Thierry Reding wrote:
> Implement an MSI chip that uses the Tegra PCIe controller's built-in
> support to provide MSI services to the root bus and its children.

Acked-by: Stephen Warren <swarren@nvidia.com>

Thierry, what Tegra-related PCIe patches will you posted for 3.10? If
it's just this, I'm happy for this to go through the PCI tree along with
patch 1/2. If you're still planning on doing the whole Tegra PCIe driver
conversion and move for 3.10, perhaps there are some additional
dependencies that require thinking about?
