Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33982 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbaEHJYg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 May 2014 05:24:36 -0400
Date: Thu, 8 May 2014 02:24:28 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org,
	James Bottomley <jbottomley@parallels.com>,
	linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 1/5] DMA-API: Clarify physical/bus address distinction
Message-ID: <20140508092428.GB27651@kroah.com>
References: <20140506223250.17968.27054.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140506224819.17968.2922.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140506224819.17968.2922.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 06, 2014 at 04:48:19PM -0600, Bjorn Helgaas wrote:
> The DMA-API documentation sometimes refers to "physical addresses" when it
> really means "bus addresses."  Sometimes these are identical, but they may
> be different if the bridge leading to the bus performs address translation.
> Update the documentation to use "bus address" when appropriate.
> 
> Also, consistently capitalize "DMA", use parens with function names, use
> dev_printk() in examples, and reword a few sections for clarity.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for cleaning this up.

