Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 8 Mar 2016 08:32:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] pci: move pci_dma_* helpers to common code
Message-ID: <20160308073255.GA15647@lst.de>
References: <1457277475-8913-1-git-send-email-hch@lst.de> <1457277475-8913-4-git-send-email-hch@lst.de> <20160307182848.GC13818@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160307182848.GC13818@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 07, 2016 at 12:28:48PM -0600, Bjorn Helgaas wrote:
> I wonder if we can consolidate a little more pci_dma_*-related stuff
> in pci-dma-compat.h, e.g.,

Looks fine to me.
