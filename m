Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751733AbdJTNbs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Oct 2017 09:31:48 -0400
Date: Fri, 20 Oct 2017 08:31:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dongdong Liu <liudongdong3@huawei.com>,
        Charles Chenxin <charles.chenxin@huawei.com>,
        linuxarm@huawei.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 2/3] PCI/portdrv: Remove excessive comments
Message-ID: <20171020133143.GG6332@bhelgaas-glaptop.roam.corp.google.com>
References: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171019230115.17806.52138.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171020070731.GD11101@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171020070731.GD11101@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 20, 2017 at 09:07:31AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 19, 2017 at 06:01:15PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Remove some wordy and repetitive comments so we can see the code better.
> > The register field #defines should be enough of a hook to find relevant
> > descriptions in the spec.  No functional change.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Of course my comments were actually useful ;-)

Oops, I thought I was mainly removing stuff I had added myself :)
I added back this single comment in place of the three essentially
similar ones:


+	/*
+	 * The Interrupt Message Number indicates which vector is used, i.e.,
+	 * the MSI-X table entry or the MSI offset between the base Message
+	 * Data and the generated interrupt message.  See PCIe r3.1, sec
+	 * 7.8.2, 7.10.10, 7.31.2.
+	 */
 	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
 		u16 reg16;
 
-		/*
-		 * Per PCIe r3.1, sec 6.1.6, "PME and Hot-Plug Event
-		 * interrupts (when both are implemented) always share the
-		 * same MSI or MSI-X vector, as indicated by the Interrupt
-		 * Message Number field in the PCI Express Capabilities
-		 * register".
-		 *
-		 * Per sec 7.8.2, "For MSI, the [Interrupt Message Number]
-		 * indicates the offset between the base Message Data and
-		 * the interrupt message that is generated."
-		 *
-		 * "For MSI-X, the [Interrupt Message Number] indicates
-		 * which MSI-X Table entry is used to generate the
-		 * interrupt message."
-		 */
 		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
 		entry = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
 		if (entry >= nr_entries)

...
