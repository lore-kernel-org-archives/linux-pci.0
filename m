Return-Path: <BATV+d7a49962a47fb612189d+4736+infradead.org+hch@bombadil.srs.infradead.org>
Return-Path: <BATV+d7a49962a47fb612189d+4736+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-pci@vger.kernel.org,
	helgaas@kernel.org,
	agordeev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: two pci_alloc_irq_vectors improvements
Date: Thu, 11 Aug 2016 07:11:03 -0700
Message-Id: <1470924665-25860-1-git-send-email-hch@lst.de>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, hi Alex,

below are two patches I'd love to see in 4.8 to improve the
pci_alloc_irq_vectors interface.  I've realized we need these while
starting a mass conversion of the MSI-X users to the new interface,
and getting it into 4.8 before users show up should make life a lot
easier.

The positive flags things comes out of the fact that a lot of driver
want MSI-X only without any fallback, or some elaborate differences
for the different interrupt schemes.  For example while most modern
devices use one MSI-X vector per queue and scale nicely from the
MSI to the MSI-X scheme many older devices use a MSI-X vector per
functionality in the ISR, so they might wan to allocate them
differently.

The second one ensures the legacy interrupt line is actually enabled
before using it, because some devices like MSI-X might actually have
it disable by default.
