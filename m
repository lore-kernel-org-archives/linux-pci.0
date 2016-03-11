Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60925 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbcCKLR4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 06:17:56 -0500
Message-ID: <1457693533.24238.99.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: Reuse PHB number on pci_controller add if
 available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	mpe@ellerman.id.au, paulus@samba.org, imunsie@au1.ibm.com,
	mikey@neuling.org, andrew.donnellan@au1.ibm.com,
	bhelgaas@google.com
Date: Fri, 11 Mar 2016 21:52:13 +1100
In-Reply-To: <20160310231823.GA5270@gwshan>
References: <1457633505-19857-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
	 <1457633505-19857-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
	 <1457645698.24238.76.camel@kernel.crashing.org>
	 <20160310231823.GA5270@gwshan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2016-03-11 at 10:18 +1100, Gavin Shan wrote:
> However, PowerKVM guest doesn't have it. I guess it's a problem,
> right?

What is the number we use for the TCE h-calls ? I think it's from the
first part of the dma window property no ?

Cheers,
Ben.
 
