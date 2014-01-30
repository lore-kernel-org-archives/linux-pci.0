Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59288 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbaA3OSg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 09:18:36 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [RFC PATCH V3 0/4] APM X-Gene PCIe controller
Date: Thu, 30 Jan 2014 15:17:51 +0100
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Landley <rob@landley.net>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@apm.com, jcm@redhat.com
References: <1390599168-13150-1-git-send-email-tinamdar@apm.com>
In-Reply-To: <1390599168-13150-1-git-send-email-tinamdar@apm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201401301517.51352.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 24 January 2014, Tanmay Inamdar wrote:
> This patch adds support for AppliedMicro X-Gene PCIe host controller. The
> driver is tested on X-Gene platform with different gen1/2/3 PCIe endpoint
> cards.
> 
> X-Gene PCIe controller driver has depedency on the pcie arch support for
> arm64. The arm64 pcie arch support is not yet part of mainline Linux kernel
> and approach for arch support is under discussion with arm64 maintainers.
> The reference patch can be found here --> https://lkml.org/lkml/2013/10/23/244
> 
> If someone wishes to test PCIe on X-Gene, arch support patch must be applied
> before the patches in this patch set.

This is starting to look really good now. I have a few small comments left,
otherwise it can get merged. As mentioned in one of my review comments, it
would be good to have the arch support patch posted along with the driver.

	Arnd

