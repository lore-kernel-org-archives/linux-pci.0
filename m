Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:60697 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbcEDNJb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 May 2016 09:09:31 -0400
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REPOST] Extend PCIE_BUS_PEER2PEER to set MRSS=128 to fix CNS3xxx BM DMA.
References: <m3h9fghbfh.fsf@t19.piap.pl> <20160421154234.GB32739@localhost>
	<20160502165322.GC24851@localhost>
Date: Wed, 04 May 2016 15:09:27 +0200
In-Reply-To: <20160502165322.GC24851@localhost> (Bjorn Helgaas's message of
	"Mon, 2 May 2016 11:53:22 -0500")
Message-ID: <m3y47qdl6g.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> It looks like 498a92d42596 merely fixed a warning, at the expense of
> breaking DMA on Cavium.  Reverting it would bring the warning back, but
> that's better than broken DMA.

Perhaps we should change PCIE_BUS_PEER2PEER to also write MRRS anyway.

I realize the CNS3xxx patch is some sort of clever workaround, and that
PCIE_BUS_PEER2PEER (which normally comes from kernel command line
parameter "pcie_bus_peer2peer") was not exactly intended for this. But
if one asks for "peer2peer" (which means limiting transfers to 128
bytes), how could it all work if the bus mastering read requests are
not equally limited?


BTW s/MRSS/MRRS/g
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
