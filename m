Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59929 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754824AbcHSBat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2016 21:30:49 -0400
Date: Thu, 18 Aug 2016 15:11:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, alex.williamson@redhat.com,
        noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
        liranl@mellanox.com
Subject: Re: [PATCH V3 2/3] vfio/pci: Allow control SR-IOV through sysfs
 interface
Message-ID: <20160818221110.GB25395@infradead.org>
References: <1471505357-78110-1-git-send-email-ilyal@mellanox.com>
 <1471505357-78110-3-git-send-email-ilyal@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471505357-78110-3-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 10:29:16AM +0300, Ilya Lesokhin wrote:
> +static int vfio_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
> +{
> +	if (!num_vfs) {
> +		pci_disable_sriov(pdev);
> +		return 0;
> +	}
> +
> +	return pci_enable_sriov_with_override(pdev,
> +					      num_vfs,
> +					     "vfio-pci");
> +}

I have to admit that I don't really like this API.  Would it be
major burden for use case to just have a flag instead that disables
automatic driver attachments for VFs and requires manual binding
instead?
