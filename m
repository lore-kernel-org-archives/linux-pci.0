Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58837 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdJ0Ghw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2017 02:37:52 -0400
Date: Thu, 26 Oct 2017 23:37:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: sbates@raithlin.com
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, akpm@linux-foundation.org, mingo@kernel.org,
        cdall@linaro.org, marc.zyngier@arm.com, zohar@linux.vnet.ibm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, logang@deltatee.com, tom@talpey.com
Subject: Re: [PATCH] pci: Add a acs_disable option for pci kernel parameter
Message-ID: <20171027063745.GA19799@infradead.org>
References: <1509071869-18771-1-git-send-email-sbates@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509071869-18771-1-git-send-email-sbates@raithlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 26, 2017 at 08:37:49PM -0600, sbates@raithlin.com wrote:
> From: Stephen Bates <sbates@raithlin.com>
> 
> On some servers the BIOS sets up ACS on any valid pci_dev in the
> system. The kernel has no way of backing this out since the kernel
> only turns ACS capabilities on.
> 
> This patch adds a new boot option to the pci kernel parameter called
> "acs_disable" that will disable ACS. This is useful for PCI peer to
> peer communication but can cause problems when IOVA isolation is
> required and an IOMMU is enabled. Use with care.

Eww.  Can we please add smbios quirks for the systems where you've
observed this? (we probably also want to keep the option just in case).
