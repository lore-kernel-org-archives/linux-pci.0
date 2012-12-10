Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:53183 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752036Ab2LJPyN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2012 10:54:13 -0500
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 24865-08 for <linux-pci@vger.kernel.org>;
 Mon, 10 Dec 2012 15:54:08 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: pci and pcie device-tree binding - range No cells
Date: Mon, 10 Dec 2012 15:52:46 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B70E7@saturn3.aculab.com>
In-Reply-To: <50C601B6.2080107@monstr.eu>
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com> <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com> <50C601B6.2080107@monstr.eu>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <monstr@monstr.eu>, "Rob Herring" <robherring2@gmail.com>
Cc: <linux-pci@vger.kernel.org>, <devicetree-discuss@lists.ozlabs.org>,
	"Thierry Reding" <thierry.reding@avionic-design.de>,
	"Rob Herring" <rob.herring@calxeda.com>,
	"linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Does it mean that pci is supposed be always 64 bit wide?
> And there is no option to have just 32bit values.

I certainly believe that all PCIe (not PCI) transfers are
nominally multiples of 64bit data.
There are (effectively) 8 byte-lane enables to allow partial word
transfers (I'm not sure whether disjoint subwords are valid).

Some PCIe slave->32bit bus bridges always do two slave cycles.
Even though, for a 32bit word transfer, one of them ends up having
no byte enables asserted.

	David



