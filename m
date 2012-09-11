Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36218 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab2IKDr1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Sep 2012 23:47:27 -0400
Message-ID: <1347335238.2603.12.camel@pasglop>
Subject: Improvements to MSI-X API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-pci@vger.kernel.org
Cc: Matthew Wilcox <matthew@wil.cx>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Sep 2012 13:47:18 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi folks !

A while back, Matthew was mentioning (iirc) some work on improving the
MSI-X APIs to be a bit less inflexible, for example by allowing setting
up individual MSI-X interrupts independently at runtime.

Is that still something being worked on ?

Another thing I've got poked about by some folks working on a new
adapter is that they would like the ability to control aliasing if we
cannot provide all the MSI-X. IE. IF the adapter has 16 sources but we
can only provide 10, they want the driver to be able to enable all 16,
but configure some of them to shoot the same message to the same
address.

This is useful in the case where the sources aren't really separate
queues but totally different type of messages, to be able to do some
fine grained control of what goes where, as the HW doesn't do that sort
of aliasing itself.

Cheers,
Ben.


