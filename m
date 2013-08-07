Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:14296
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756961Ab3HGDfV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Aug 2013 23:35:21 -0400
From: Zang Roy-R61911 <r61911@freescale.com>
To: Leon Ravich <lravich@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@men.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: RE: PCIE device errors after linux kernel upgrade
Date: Wed, 7 Aug 2013 03:35:17 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B2A60F6@039-SN2MPN1-013.039d.mgd.msft.net>
References: <CAPWoNkJ3NKM-_g93LdRpjvdNFtLt-Pjpg4d4oEKC9CvkpzZ-Wg@mail.gmail.com>
 <CAPWoNkLQUbFG2vZ7wqoqqVNj4uxKz3Fa_vsSH=1_TDD=XC1f2A@mail.gmail.com>
 <CAErSpo5ZZgdpkK+QdQUEnNCEXcG_T+QBWTVoQnMTghxkX7n2HA@mail.gmail.com>
 <20130806070703.GA20622@jtlinux>
 <CAPWoNkKo6Cfg0Hr2QYBXVnUrC-UQwES65UUHfSvR3nBvZrfFoA@mail.gmail.com>
In-Reply-To: <CAPWoNkKo6Cfg0Hr2QYBXVnUrC-UQwES65UUHfSvR3nBvZrfFoA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> fei.zang=freescale.com@lists.ozlabs.org] On Behalf Of Leon Ravich
> Sent: Tuesday, August 06, 2013 3:26 PM
> To: Johannes Thumshirn
> Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; linuxppc-dev
> Subject: Re: PCIE device errors after linux kernel upgrade
> 
> Hi Johannes
> no panic just reboot.
> it is not the first read, it takes few minutes of work with pcie to
> reboot.

You may need to check the error code in EDAC driver as Johannes suggested.
Roy

