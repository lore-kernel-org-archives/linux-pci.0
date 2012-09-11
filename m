Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36227 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab2IKDsd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Sep 2012 23:48:33 -0400
Message-ID: <1347335307.2603.13.camel@pasglop>
Subject: Re: Improvements to MSI-X API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-pci@vger.kernel.org
Cc: Matthew Wilcox <matthew@wil.cx>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Sep 2012 13:48:27 +1000
In-Reply-To: <1347335238.2603.12.camel@pasglop>
References: <1347335238.2603.12.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2012-09-11 at 13:47 +1000, Benjamin Herrenschmidt wrote:
> Hi folks !
> 
> A while back, Matthew was mentioning (iirc) some work on improving the
> MSI-X APIs to be a bit less inflexible, for example by allowing setting
> up individual MSI-X interrupts independently at runtime.
> 
> Is that still something being worked on ?
> 
> Another thing I've got poked about by some folks working on a new
> adapter is that they would like the ability to control aliasing if we
> cannot provide all the MSI-X. IE. IF the adapter has 16 sources but we
> can only provide 10, they want the driver to be able to enable all 16,
> but configure some of them to shoot the same message to the same
> address.
> 
> This is useful in the case where the sources aren't really separate
> queues but totally different type of messages, to be able to do some
> fine grained control of what goes where, as the HW doesn't do that sort
> of aliasing itself.

Note that a way to avoid problems with existing kernels & APIs might be
in HW to:

 - Have a "mandatory" interrupt (MSI-X entry 0 ?)
 - Have the HW route any unconfigured source to that interrupt

IE. Enforce the aliasing.

Cheers,
Ben.


