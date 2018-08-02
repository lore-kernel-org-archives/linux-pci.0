Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:41578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbeHBNrU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Aug 2018 09:47:20 -0400
Date: Thu, 2 Aug 2018 04:56:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC] PCI: add support for Immediate Readiness
Message-ID: <20180802115627.GA27976@infradead.org>
References: <20180802113635.7097-1-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180802113635.7097-1-felipe.balbi@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> +	unsigned int	immediate:1;	/* Supports Immediate Readiness */

That name is a bit too generic.  immediate_ready (or imm_ready if you
need it short) would be a lot more descriptive.
