Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.130]:56456 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbaB0NWU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 08:22:20 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-kernel@lists.linaro.org
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] pci: Create pci_host_bridge before its associated bus in pci_create_root_bus.
Date: Thu, 27 Feb 2014 14:22:13 +0100
Message-ID: <6845675.ZDsMtaSPuS@wuerfel>
In-Reply-To: <1393506402-11474-3-git-send-email-Liviu.Dudau@arm.com>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com> <1393506402-11474-3-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 27 February 2014 13:06:40 Liviu Dudau wrote:
> Before commit 7b5436635800 the pci_host_bridge was created before the root bus.
> As that commit has added a needless dependency on the bus for pci_alloc_host_bridge()
> the creation order has been changed for no good reason. Revert the order of
> creation as we are going to depend on the pci_host_bridge structure to retrieve the
> domain number of the root bus.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 

Looks good to me.

	Arnd
