Return-Path: <SRS0=SBir=45=bombadil.srs.infradead.org=BATV+39f16232e601ddf73510+5021+infradead.org+hch@kernel.org>
Return-Path: <SRS0=SBir=45=bombadil.srs.infradead.org=BATV+39f16232e601ddf73510+5021+infradead.org+hch@kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: helgaas@kernel.org
Cc: rakesh@tuxera.com,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: avoid null pointer rereference during FLR
Date: Tue, 23 May 2017 07:42:01 +0200
Message-Id: <20170523054202.7985-1-hch@lst.de>
List-ID: <linux-pci.vger.kernel.org>

Hi all,

Rakesh reported a bug where a FLR can trivially crash his system.
The reason for that is that NVMe unbinds the driver from the PCI device
on an unrecoverable error, and that races with the reset_notify method.

This is fairly easily fixable by taking the device lock for a slightly
longer period.  Note that the other PCI error handling methods actually
have the same issue, but with them not taking the lock yet and me having
no good way to reproducibly call them I'm a little reluctant to touch
them, but it would be great if we could fix those issues as well.
