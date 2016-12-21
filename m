Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932753AbcLUMWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2016 07:22:14 -0500
Date: Wed, 21 Dec 2016 04:22:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: John Crispin <john@phrozen.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] pci: add kernel config option for disabling common PCI
 quirks
Message-ID: <20161221122213.GA32563@infradead.org>
References: <1482306784-29224-1-git-send-email-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482306784-29224-1-git-send-email-john@phrozen.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 21, 2016 at 08:53:04AM +0100, John Crispin wrote:
> This patch has been lingering inside the OpenWrt for some years. I am not
> sure if this is the best way to remove the quirks from the build. Let me
> know if you prefer a different way of solving this.

As a start negative options (_DISABLE_) are very confusing, I would
recommend to turn this into a postive option with a default y.

On what grounds did you decide which quirks to keep and which to
remove?
