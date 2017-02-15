Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751328AbdBOQh3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Feb 2017 11:37:29 -0500
Date: Wed, 15 Feb 2017 10:37:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: two small PCI documentation fixups
Message-ID: <20170215163725.GF19040@bhelgaas-glaptop.roam.corp.google.com>
References: <20170215075823.3024-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170215075823.3024-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 15, 2017 at 08:58:21AM +0100, Christoph Hellwig wrote:
> Avoid mentioning deprecated APIs and make the text a little
> easier to understand.

Applied to pci/msi for v4.11, thanks!
