Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38163 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753397Ab2ARQ3R (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2012 11:29:17 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B701120F31
	for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2012 11:29:16 -0500 (EST)
Date: Wed, 18 Jan 2012 08:28:58 -0800
From: Greg KH <greg@kroah.com>
To: Martin Burnicki <martin.burnicki@meinberg.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCI card not accessible; I/O ports at <ignored>
Message-ID: <20120118162858.GB22156@kroah.com>
References: <4F16EA07.4000607@meinberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F16EA07.4000607@meinberg.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 18, 2012 at 04:49:27PM +0100, Martin Burnicki wrote:
> Hi folks,
> 
> I'm maintaining the driver software for the PCI cards manufactured
> by our company, Meinberg Funkuhren in Germany. Basically our Linux
> driver supports all our PCI cards on all Linux kernels 2.6.x and
> 3.x. The PCI cards are e.g. GPS receivers, radio clocks, or IRIG
> time code receivers.

Nice, any reason why these drivers aren't in the main kernel.org tree?

thanks,

greg k-h
