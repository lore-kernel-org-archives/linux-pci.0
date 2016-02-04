Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:63250 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbcBDNN3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 08:13:29 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Vineet.Gupta1@synopsys.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v7 2/2] add new platform driver for PCI RC
Date: Thu, 04 Feb 2016 14:12:40 +0100
Message-ID: <5558330.K4tT8JUImA@wuerfel>
In-Reply-To: <56B331BF.2000406@synopsys.com>
References: <cover.1454349430.git.jpinto@synopsys.com> <2915520.tvWP9ESSNu@wuerfel> <56B331BF.2000406@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 04 February 2016 11:10:55 Joao Pinto wrote:
> > The "synopsys" can go away, it's already in the vendor field of the
> > string. "ipk" is still a bit unspecific, I was hoping to see a specific
> > chip and/or version of the PCIe part. Something like
> > 
> >       compatible = "snps,ipk2040-pcie", "snps,ipk-pcie", "snps,dw-pcie-1.23", "snps,dw-pcie";
> > 
> > which would indicate that there is a chip called "ipk2040" in a family called "ipk",
> > and this includes the designware pcie implementation in version 1.23.
> > 
> 
> "snps,dw-pcie" seems a good idea!
> 

Just to clarify: I really meant you should put all four of the strings
into the compatible property.

	Arnd
