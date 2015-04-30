Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:53237 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbbD3GkO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2015 02:40:14 -0400
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNL00GVXX70AK40@mailout3.w1.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 30 Apr 2015 07:40:12 +0100 (BST)
From: Pavel Fedin <p.fedin@samsung.com>
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
	'Arnd Bergmann' <arnd@arndb.de>
Cc: 'Jayachandran C' <jchandra@broadcom.com>,
	'Will Deacon' <Will.Deacon@arm.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, 'Liviu Dudau' <Liviu.Dudau@arm.com>,
	'Sergey Dyasly' <s.dyasly@samsung.com>
References: <1430307599-20536-1-git-send-email-jchandra@broadcom.com>
 <6662179.AoBfCMOsxD@wuerfel> <20150429174356.GA20947@red-moon>
In-reply-to: <20150429174356.GA20947@red-moon>
Subject: RE: [RFC PATCH 1/2] PCI: generic: remove dependency on hw_pci
Date: Thu, 30 Apr 2015 09:40:10 +0300
Message-id: <"00b001d08310$82022b40$860681c0$@fedin"@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> The other bit missing is MSI handling, that should still be implemented.

 Hello! I decided to have a voice here.
 I am currently working on a virtualization project, and i have made some
experimental additions to PCI-Generic code which enable PCI-X support. I
wanted to upstream this, but as far as i can see, you are refactoring
everything here.
 Personally i think that pci_common_init_dev() is a good thing and it should
not be removed. Even more, perhaps it needs to be expanded with PCI-X
support. My current code adds a piece very similar to
mvebu_pcie_msi_enable(), which reads "msi-parent" property and then calls
of_pci_find_msi_chip_by_node().
 MVEBU driver then fills in hw.msi_ctrl with the obtained pointer and calls
pci_common_init(), which is the same as pci_common_init_dev(NULL, hw). My
modified Generic driver now does the same. So, the question is - may be we
should extract "msi-parent" handling from MVEBU and move it into
pci_common_init_dev() ?
 Just IMHO copy-pasting this function over and over again in all drivers is
a bad idea.

 And one more. pci_common_init_dev() currently does not assign bus->msi,
therefore IRQ domain operations do not work. I have fixed this too, but
perhaps it's another story...

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia


