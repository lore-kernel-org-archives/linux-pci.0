Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:57303 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbaHTTkQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Aug 2014 15:40:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH] drivers: pci: convert generic host controller to DT host bridge creation API
Date: Wed, 20 Aug 2014 21:39:27 +0200
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	"linux-pci" <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
References: <1407861695-25549-1-git-send-email-Liviu.Dudau@arm.com> <201408201327.57376.arnd@arndb.de> <20140820123112.GG13147@bart.dudau.co.uk>
In-Reply-To: <20140820123112.GG13147@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201408202139.27678.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 20 August 2014, Liviu Dudau wrote:
> That has been the general approach of my patchset up to v9. But, as Bjorn has
> mentioned in his v8 review and I have put in my cover letter, the regular
> aproach means that architectures that use pci_scan_root_bus() will have to
> drop their one liner and replace it with the more verbose of_create_pci_host_bridge()
> followed by pci_scan_child_bus() and pci_bus_add_devices() (basically, the content
> of pci_scan_root_bus()). For those architectures it will lead to a net increase of
> lines of code.

I'll try to get hold of Bjorn here and discuss it with him in person. I'd
rather see a few extra lines in each driver than the complexity of callback
funtions.

> The patch for pci-host-generic.c is the first to use the callback setup function, but
> not the only one. My PCI host bridge driver for Juno has the same need, and I'm betting
> all other host bridge controllers will use it as it will be the only opportunity to
> finish the controller setup before we start scanning the child busses. I'm trying to
> balance ease of read vs ease of use here and it is the best version I've come up with
> so far.

My main objection to the new approach is that it's different from most other
subsystems doing the same thing. For a person reading the pci host driver
implementation, when they are familiar with other device drivers, I think it's
much clearer what is going on when smaller functions are called in sequence
than to see one function passed into some other interface that you now have
to read as well in order to understand when it gets called.

	Arnd
