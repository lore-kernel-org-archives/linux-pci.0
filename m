Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59365 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770AbcATUnN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Jan 2016 15:43:13 -0500
Date: Wed, 20 Jan 2016 14:43:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>,
	"Derrick, Jonathan" <jonathan.derrick@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Veal, Bryan E" <bryan.e.veal@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160120204308.GD7973@localhost>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
 <8D943B239464E04C9184454D8B3F5CFF0ABF18EC@ORSMSX101.amr.corp.intel.com>
 <20160115220631.GA14080@localhost>
 <20160119153822.GA3979@localhost.localdomain>
 <20160119160220.GA22059@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160119160220.GA22059@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph,

On Tue, Jan 19, 2016 at 08:02:20AM -0800, Christoph Hellwig wrote:
> 
> As this seems to require special drivers to bind to it, and Intel
> people refuse to even publicly tell what the code does I'd like
> to NAK this code until we get an explanation and use cases for it.

I saw responses from Keith and Bryan, and I hope they answer your
questions.  As far as I can tell, the VMD driver is grossly similar to
other host bridge drivers we've already merged, and I don't think we
have public specs for all of them.

Unless you have further concerns, I'm going to ask Linus to pull this
tomorrow, along with the rest of the PCI changes for v4.5.

Bjorn
