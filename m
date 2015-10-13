Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:59265 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbbJMJ56 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2015 05:57:58 -0400
Date: Tue, 13 Oct 2015 11:57:55 +0200
From: Martin Mares <mj@ucw.cz>
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCHv2] x86/pci: Initial commit for new VMD device driver
Message-ID: <mj+md-20151013.095510.53052.nikam@ucw.cz>
References: <1443721454-25467-1-git-send-email-keith.busch@intel.com>
 <20151006231412.GF29420@localhost>
 <alpine.LNX.2.00.1510062331220.23840@localhost.lm.intel.com>
 <20151008134702.GK27633@localhost>
 <alpine.LNX.2.00.1510082115120.27742@localhost.lm.intel.com>
 <20151009180910.GB16112@localhost>
 <alpine.LNX.2.00.1510091855080.27742@localhost.lm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1510091855080.27742@localhost.lm.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> Assuming we can change pciutils to use 'int' for domain, and have a
> driver for this new device merged in the near future, I'm not too worried
> about users and distros with older utils. I don't think this a device
> someone could turn on by accident, so their shouldn't be any fallout if
> I properly communicate the dependencies to those who do want to enable it.

I would prefer using an explicit 32-bit type instead of an int,
but otherwise I am fine with the change.

We probably should keep the same naming convention of sysfs entries
on buses whose domain number fits in 16 bits and use 8-digit domain
number only in cases where it is really needed.

				Martin
