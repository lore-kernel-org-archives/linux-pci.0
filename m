Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46443 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbdKWNXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Nov 2017 08:23:01 -0500
Date: Thu, 23 Nov 2017 05:23:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Neo Jia <cjia@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH 1/1] Change pci_enable_sriov, pci_disable_sriov and
 pci_reset_function to non-GPL symbol.
Message-ID: <20171123132300.GA10736@infradead.org>
References: <1510773058-1482-1-git-send-email-cjia@nvidia.com>
 <20171117145504.GA31760@infradead.org>
 <20171122230335.GA1228@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171122230335.GA1228@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Just to be clear, here the request is to allow proprietary driver continue
> supporting Linux OS when adopting SR-IOV - a PCIE virtualization technology
> standardized by PCI SIG.

And the anser in the previous mail was pretty clear: no.  And while
we're at it go talk to your lawyers again that you don't have a derived
work, because I suspect you do with such intimate entangling.
