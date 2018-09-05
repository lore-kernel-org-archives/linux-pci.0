Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeIEHhR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 03:37:17 -0400
Subject: Re: RFC on PCI Device Lock
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <87682473-6ffe-f7df-e8f8-3d00e8247621@kernel.org>
 <20180904165202.4e5bb59d@t450s.home>
 <17720f56-2caa-2d2e-b655-867debf55934@kernel.org>
 <20180904204649.415491f8@t450s.home>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <571b8341-f6fd-d92a-7091-f4fb02a2aadf@kernel.org>
Date: Tue, 4 Sep 2018 20:09:16 -0700
MIME-Version: 1.0
In-Reply-To: <20180904204649.415491f8@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/4/2018 7:46 PM, Alex Williamson wrote:
> #define PCI_RESET_DEV_SPECIFIC	(1 << 0)
> #define PCI_RESET_FLR		(1 << 1)
> #define PCI_RESET_PM		(1 << 2)
> #define PCI_RESET_SLOT		(1 << 3)
> #define PCI_RESET_BUS		(1 << 4)
> 
> #define PCI_RESET_ANY		(~0)
> #define PCI_RESET_FUNC		(PCI_RESET_DEV_SPECIFIC | \
> 				 PCI_RESET_FLR | PCI_RESET_PM)
> #define PCI_RESET_LINK		(PCI_RESET_SLOT | PCI_RESET_BUS)

I should be able to put something together using __pci_reset_function_locked()
shortly.

This is not that difficult to implement.
