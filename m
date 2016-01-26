Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58266 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966657AbcAZQqK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2016 11:46:10 -0500
Date: Tue, 26 Jan 2016 08:46:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>,
	"Derrick, Jonathan" <jonathan.derrick@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Veal, Bryan E" <bryan.e.veal@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160126164609.GC15979@infradead.org>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
 <8D943B239464E04C9184454D8B3F5CFF0ABF18EC@ORSMSX101.amr.corp.intel.com>
 <20160115220631.GA14080@localhost>
 <20160119153822.GA3979@localhost.localdomain>
 <20160119160220.GA22059@infradead.org>
 <20160120204308.GD7973@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160120204308.GD7973@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 20, 2016 at 02:43:08PM -0600, Bjorn Helgaas wrote:
> I saw responses from Keith and Bryan, and I hope they answer your
> questions.  As far as I can tell, the VMD driver is grossly similar to
> other host bridge drivers we've already merged, and I don't think we
> have public specs for all of them.
> 
> Unless you have further concerns, I'm going to ask Linus to pull this
> tomorrow, along with the rest of the PCI changes for v4.5.

I still think it's a bad idea to merge something odd like this without
a good explanation or showing what devices can actually sit under it.

But you're the maintainer in the end..
