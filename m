Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:53869 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbaBSGtH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Feb 2014 01:49:07 -0500
Date: Tue, 18 Feb 2014 23:48:50 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Liviu Dudau <liviu@dudau.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	Will Deacon <will.deacon@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140219064850.GD6186@obsidianresearch.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <5805232.JrD2FybBlg@wuerfel>
 <20140214220047.GA5394@bart.dudau.co.uk>
 <2312919.pM61KLBcYY@wuerfel>
 <20140218174125.GC29304@obsidianresearch.com>
 <20140219024427.GC5394@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140219024427.GC5394@bart.dudau.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 19, 2014 at 02:44:27AM +0000, Liviu Dudau wrote:
 
> I wish things were easier!

Yah, I've seen some of this complexity too..

A thought that crosses my head is to try and leave the entire arch
support intact and build a separate 'domain-driver-based' support
that completely replaces the arch support, a domain would use one or
the other but never both.

So pci_domain_nr could become:

  struct pci_domain_driver *drv = pci_get_domain_driver(bus);
  if (drv)
       return drv->domain_nr;
  else
       return _arch_pci_domain_nr(bus);

And other funcs would change effectively the same way.

> And if someone has a good idea on how to determine the domain # from
> DT we can pluck it into the pcibios_root_bridge_prepare() function
> (either the generic version or the arch specific one).

You can probably start with 'of_alias_get_id'..

Jason
