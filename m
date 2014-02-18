Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:57725 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbaBRSVv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 18 Feb 2014 13:21:51 -0500
Date: Tue, 18 Feb 2014 11:21:42 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140218182142.GF29304@obsidianresearch.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <1392726043-31088-4-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392726043-31088-4-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 18, 2014 at 12:20:43PM +0000, Will Deacon wrote:
> +
> +    // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
> +    ranges = <0x1000000 0x0 0x00000000  0x0 0x00000000  0x0 0x00010000>,
                                           ^^^^^^^^^^^^^^

This probably shouldn't be 0 in the example, nor in your kvm tool
output. For example purposes any value will do.

Regards,
Jason
