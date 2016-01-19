Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:19388 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755745AbcASQgt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Jan 2016 11:36:49 -0500
Date: Tue, 19 Jan 2016 16:36:36 +0000
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@infradead.org>
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
Message-ID: <20160119163635.GA4716@localhost.localdomain>
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

On Tue, Jan 19, 2016 at 08:02:20AM -0800, Christoph Hellwig wrote:
> As this seems to require special drivers to bind to it, and Intel
> people refuse to even publicly tell what the code does I'd like
> to NAK this code until we get an explanation and use cases for it.

We haven't opened the h/w specification, but we've been pretty open with
what it provides, how the code works, and our intended use case. The
device provides additional pci domains for people who need more than
the 256 busses a single domain provides.

What information may I provide to satisfy your use case concerns? Are
you wanting to know what devices we have in mind that require additional
domains?
