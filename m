Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45237 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865AbcASQCV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2016 11:02:21 -0500
Date: Tue, 19 Jan 2016 08:02:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Derrick, Jonathan" <jonathan.derrick@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Veal, Bryan E" <bryan.e.veal@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160119160220.GA22059@infradead.org>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
 <8D943B239464E04C9184454D8B3F5CFF0ABF18EC@ORSMSX101.amr.corp.intel.com>
 <20160115220631.GA14080@localhost>
 <20160119153822.GA3979@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160119153822.GA3979@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


As this seems to require special drivers to bind to it, and Intel
people refuse to even publicly tell what the code does I'd like
to NAK this code until we get an explanation and use cases for it.
