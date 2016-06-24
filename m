Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:41352 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbcFXWgG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2016 18:36:06 -0400
Received: from localhost.localdomain ([127.0.0.1]:59204 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27042986AbcFXWgCwkj-Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 25 Jun 2016 00:36:02 +0200
Date: Sat, 25 Jun 2016 00:35:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-mips@linux-mips.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jayachandran C <jchandra@broadcom.com>,
	Ganesan Ramalingam <ganesanr@broadcom.com>,
	David Daney <david.daney@cavium.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: PCI_PROBE_ONLY clean-up
Message-ID: <20160624223548.GB10098@linux-mips.org>
References: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160624155021.GD5930@linux-mips.org>
 <20160624184602.GG32461@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160624184602.GG32461@hexapodia.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 24, 2016 at 11:46:02AM -0700, Andy Isaacson wrote:

> I don't remember the details, unfortunately, but my general recollection
> is similar -- CFE on bcm1480 was doing a fairly good job of configuring
> PCI, and I think we needed to preserve the configuration for Reasons
> rather than letting the kernel change things away from the CFE setup.
> 
> I unfortunately no longer have any 1480 hardware to test on, nor do I
> know who's left at BCM who might be able to validate this change.

I still have a small pile of Sibyte hardware of various description,
including BCM91480 and can test.

  Ralf
