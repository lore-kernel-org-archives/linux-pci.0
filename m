Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37090 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbcCHVx3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Mar 2016 16:53:29 -0500
Date: Tue, 8 Mar 2016 15:53:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-pci@vger.kernel.org, Thomas Renninger <trenn@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Borislav Petkov <bp@suse.de>,
	Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 0/4] PCI: aer_inject cleanups and verbosity
Message-ID: <20160308215326.GF27132@localhost>
References: <20160218130928.67dbf63b@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160218130928.67dbf63b@endymion>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 18, 2016 at 01:09:28PM +0100, Jean Delvare wrote:
> As discussed earlier, here are a few cleanups and verbosity adjustments
> to the aer_inject driver.
> 
> [PATCH 1/4] PCI: aer_inject: Fix error codes
> [PATCH 2/4] PCI: aer_inject: Use dev_warn()
> [PATCH 3/4] PCI: aer_inject: Log actual error causes
> [PATCH 4/4] PCI: aer_inject: Log error injections

Applied all four to pci/aer for v4.6, thanks, Jean!
