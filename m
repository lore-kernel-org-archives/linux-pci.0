Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753866AbeENOPw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 10:15:52 -0400
Date: Mon, 14 May 2018 07:15:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Bauer, Scott" <scott.bauer@intel.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: Re: [PATCH] PCI/VMD: White list for fast interrupt handlers
Message-ID: <20180514141551.GA21817@infradead.org>
References: <20180508160022.30954-1-keith.busch@intel.com>
 <20180509043828.GA9413@infradead.org>
 <20180509152652.GA823@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180509152652.GA823@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 09, 2018 at 09:26:53AM -0600, Keith Busch wrote:
> I'm not aware of an easier way you can direct-assign an entire PCIe domain
> to a virtual machine. :)

libvirt will handle it just fine for you.
