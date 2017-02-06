Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:59102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdBFReO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 12:34:14 -0500
Date: Mon, 6 Feb 2017 09:34:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHv5 3/5] pci: No config access for disconnected devices
Message-ID: <20170206173413.GD25762@infradead.org>
References: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
 <1486144555-5526-4-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486144555-5526-4-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although a comment in the code explaining why return both an error
and set the returned value to all bits set might be helpful for
future readers of the code.
