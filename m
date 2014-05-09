Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:64882 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619AbaEIGOt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 May 2014 02:14:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joerg Roedel <joro@8bytes.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org,
	James Bottomley <jbottomley@parallels.com>,
	linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 1/4] DMA-API: Clarify physical/bus address distinction
Date: Fri, 09 May 2014 08:12:02 +0200
Message-ID: <119388463.n2RtThRsle@wuerfel>
In-Reply-To: <20140508204854.17877.59304.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140508204257.17877.4639.stgit@bhelgaas-glaptop.roam.corp.google.com> <20140508204854.17877.59304.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 08 May 2014 14:48:54 Bjorn Helgaas wrote:
> The DMA-API documentation sometimes refers to "physical addresses" when it
> really means "bus addresses."  Sometimes these are identical, but they may
> be different if the bridge leading to the bus performs address translation.
> Update the documentation to use "bus address" when appropriate.
> 
> Also, consistently capitalize "DMA", use parens with function names, use
> dev_printk() in examples, and reword a few sections for clarity.
> 
> No functional change; documentation changes only.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks great!

Acked-by: Arnd Bergmann <arnd@arndb.de>
