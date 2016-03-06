Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: two small PCI header cleanups
Date: Sun,  6 Mar 2016 16:17:52 +0100
Message-Id: <1457277475-8913-1-git-send-email-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move a header from asm-generic to Linux because it isn't a generic arch
implementation, and also implement the pci_dma_* helpers in common code.

