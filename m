Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:27256 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757077Ab2JDQOW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Oct 2012 12:14:22 -0400
Date: Thu, 4 Oct 2012 18:14:21 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Andreas Hartmann <andihartmann@01019freenet.de>,
	<kvm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: vfio: missing patch in linux 3.6
Message-ID: <20121004161421.GV4009@amd.com>
References: <506DA799.5090603@01019freenet.de>
 <1349364399.2759.42.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1349364399.2759.42.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 04, 2012 at 09:26:39AM -0600, Alex Williamson wrote:
> On Thu, 2012-10-04 at 17:13 +0200, Andreas Hartmann wrote:
> > Hello Alex,
> > 
> > I just tested vfio as part of linux 3.6 and detected, that it doesn't
> > work because of the following missing patch:
> > 
> > http://news.gmane.org/find-root.php?group=gmane.linux.kernel.pci&article=16422
> > 
> > Could you please get it applied for the next stable release?
> 
> Hi Andreas,
> 
> This patch needs to go through Bjorn's PCI tree, but as noted in the
> comments I have some outstanding questions that need to be answered,
> probably by Joerg.  Thanks,

What are the open questions? I have confirmation from the hardware
people that the south bridges are peer-2-peer safe. Other questions?


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

