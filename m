Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:14993
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755432Ab3I3Wll (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2013 18:41:41 -0400
Message-ID: <1380580888.24959.525.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with
 Layerscape
From: Scott Wood <scottwood@freescale.com>
To: Lian Minghuan-b31939 <B31939@freescale.com>
CC: Timur Tabi <timur@tabi.org>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 30 Sep 2013 17:41:28 -0500
In-Reply-To: <5248D94E.7080904@freescale.com>
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>
		<1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
	 <CAOZdJXUF3ibW5iuB-2p5bhPp-Uw9MVKzqZiDdukMfi4f1d3Phw@mail.gmail.com>
	 <5248D94E.7080904@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-09-30 at 09:52 +0800, Lian Minghuan-b31939 wrote:
> Hi Timur,
> 
> Thanks for your comments.
> 
> How about PCI_FSL_COMMON?

Why not just have one symbol, which is used in the makefile in both
drivers/pci and arch/<whatever>?

-Scott



