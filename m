Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdA1Jta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jan 2017 04:49:30 -0500
Date: Fri, 27 Jan 2017 23:36:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20170128073605.GA20114@infradead.org>
References: <20161208193253.GK25959@localhost.localdomain>
 <20161212234226.GA7973@bhelgaas-glaptop.roam.corp.google.com>
 <20161213005547.GA12844@localhost.localdomain>
 <20161213205012.GA29950@bhelgaas-glaptop.roam.corp.google.com>
 <20161213231840.GD12113@localhost.localdomain>
 <B58D82457FDA0744A320A2FC5AC253B93D82F37D@fmsmsx104.amr.corp.intel.com>
 <20170120213550.GA16618@localhost.localdomain>
 <20170121073140.GA26396@wunner.de>
 <20170121084243.GA24706@kroah.com>
 <20170123160452.GA10771@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170123160452.GA10771@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Or to put it the other way around - why even start an operation
that will fail?

We have a pretty similar issue in file system land: A file system
must handle failure from the storage device at any time to provide
data integrity.  But that doesn't mean we can't optimize for the
case where a device is toast (host removed, fails any I/O, etc).
In that case we mark the file system as shutdown and stop submitting
more I/O, potentially avoiding up to hours of recovery time.

It would be helpful for everyone up and down the stack to do these
don't do anyting stupid if you can avoid it starting from the lowest
layers.
