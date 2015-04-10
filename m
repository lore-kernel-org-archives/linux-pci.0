Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42815 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014AbbDJJkR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 05:40:17 -0400
Message-ID: <1428658811.2796.2.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: layerscape: Simplify
 platform_get_resource_byname() failure checking
From: Lucas Stach <l.stach@pengutronix.de>
To: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Fri, 10 Apr 2015 11:40:11 +0200
In-Reply-To: <DM2PR0301MB064005C336CD164FD8C0A061E2FA0@DM2PR0301MB0640.namprd03.prod.outlook.com>
References: <20150409194923.19293.96454.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	 <DM2PR0301MB064005C336CD164FD8C0A061E2FA0@DM2PR0301MB0640.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 10.04.2015, 02:08 +0000 schrieb
Minghuan.Lian@freescale.com:
> Hi Bjorn,
> 
> Thanks for your improvement.
> I notice my new patches to add support arm32 and arm64 for designware
> and layerscape also have the similar issues, I will fix and submit
> them v2 .
> Could you tell me whether it is acceptable that I add a new file
> pcie-designware-base.c  to re-implement designware PCIe driver for
> compatible with arm32 and arm64.  The benefit  is that  the new
> implementation is simple clear and platform-independent. In addition,
> MSI driver will be split to a separate file. But we may need to push
> other platform PCIe maintainer to port the driver based on
> pcie-designware-base.c .
> 
In that case you probably should have put the other maintainers of
designware based PCI drivers on CC for your patches. You will not gain
momentum for such a radical change if you fail to address the right
people.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

