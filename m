Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754827AbcHSBdM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2016 21:33:12 -0400
Date: Thu, 18 Aug 2016 15:09:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, alex.williamson@redhat.com,
        noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
        liranl@mellanox.com
Subject: Re: [PATCH V3 1/3] pci: Extend PCI IOV API
Message-ID: <20160818220926.GA25395@infradead.org>
References: <1471505357-78110-1-git-send-email-ilyal@mellanox.com>
 <1471505357-78110-2-git-send-email-ilyal@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471505357-78110-2-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 10:29:15AM +0300, Ilya Lesokhin wrote:
> 1. Add pci_enable_sriov_with_override to allow
> enabling sriov with a driver override
> on the VFs.
> 
> 2. Expose pci_iov_set_numvfs and pci_iov_resource_size
> to make them available for other modules

Please use EXPORT_SYMBOL_GPL for such low-level exports.
