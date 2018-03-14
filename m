Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34637 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeCNI4D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 04:56:03 -0400
Date: Wed, 14 Mar 2018 09:56:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
        mheyne@amazon.de, liang-min.wang@intel.com,
        mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de,
        dwmw@amazon.co.uk
Subject: Re: [pci PATCH v6 5/5] pci-pf-stub: Add PF driver stub for PFs
        that function only to enable VFs
Message-ID: <20180314085601.GD28796@lst.de>
References: <20180313212508.3553.65326.stgit@localhost.localdomain> <20180313213054.3553.89366.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313213054.3553.89366.stgit@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> +
> +/**
> + * pci_pf_stub_white_list - White list of devices to bind pci-pf-stub onto
> + *
> + * This table provides the list of IDs this driver is supposed to bind
> + * onto. You could think of this as a list of "quirked" devices where we
> + * are adding support for SR-IOV here since there are no other drivers
> + * that they would be running under.
> + *
> + * Layout of the table below is as follows:
> + * { Vendor ID, Device ID,
> + *   SubVendor ID, SubDevice ID,
> + *   Class, Class Mask,
> + *   private data (not used) }
> + */

No need to document the PCI device table format in a random driver.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
