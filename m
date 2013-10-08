Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59329 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754509Ab3JHHVk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 03:21:40 -0400
Date: Tue, 8 Oct 2013 09:21:37 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Make mvebu_pcie_align_resource() static
Message-ID: <20131008092137.0ed32a32@skate>
In-Reply-To: <20131007233846.11805.50302.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131007233846.11805.50302.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Mon, 07 Oct 2013 17:38:46 -0600, Bjorn Helgaas wrote:
> mvebu_pcie_align_resource() is only used inside pci-mvebu.c, so
> make it static.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I'm obviously fine with that, but there is already a patch "[PATCH V2
2/3] PCI: mvebu: make local functions static" hanging around to do the
same.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
