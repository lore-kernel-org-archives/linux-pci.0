Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54413 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759128AbaCUO6O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 10:58:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Phil.Edworthy@renesas.com,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Date: Fri, 21 Mar 2014 15:57:25 +0100
Message-ID: <6044873.2S2Xlhp0hC@wuerfel>
In-Reply-To: <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com> <532C5ADE.4030708@cogentembedded.com> <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 21 March 2014 14:53:48 Phil.Edworthy@renesas.com wrote:
> 
> > > +      reg = <0 0xfe000000 0 0x80000>;
> > > +      #address-cells = >;
> > > +      #size-cells = <2>;
> > > +      device_type = "pci";
> > 
> >     This legacy property is only meaningful for the true OF firmware and 
> thus 
> > have been phased out (it's only actively used for the memory nodes).
> Ok, thanks for pointing this out.
> 

I think the code still relies on it for PCI though.

	Arnd
