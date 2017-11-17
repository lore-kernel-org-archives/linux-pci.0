Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758445AbdKQOzJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2017 09:55:09 -0500
Date: Fri, 17 Nov 2017 06:55:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Neo Jia <cjia@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        alex.williamson@redhat.com, Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH 1/1] Change pci_enable_sriov, pci_disable_sriov and
 pci_reset_function to non-GPL symbol.
Message-ID: <20171117145504.GA31760@infradead.org>
References: <1510773058-1482-1-git-send-email-cjia@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510773058-1482-1-git-send-email-cjia@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 15, 2017 at 11:10:58AM -0800, Neo Jia wrote:
> This will allow proprietary linux drivers to adopt SR-IOV spec from
> PCI-SIG, also switch pci_reset_function to non-GPL symbol as it mainly
> does pci config space access per spec.

Clear NAK.  Thos were added intentional, and even if they were changed
your driver would still be a derived work and had to be published under
a GPLv2-compatible license.
