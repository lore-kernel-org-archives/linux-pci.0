Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:43064 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaHRQYc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Aug 2014 12:24:32 -0400
Date: Mon, 18 Aug 2014 18:24:26 +0200
From: Gerhard Sittig <gsi@denx.de>
To: linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Detlev Zundel <dzu@denx.de>
Subject: Re: [PATCH RFC v1 0/4] PCI NTB: prepare for more hardware support
Message-ID: <20140818162426.GQ28369@book.gsilab.sittig.org>
References: <1407336835-30586-1-git-send-email-gsi@denx.de>
 <20140806150112.GG28369@book.gsilab.sittig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140806150112.GG28369@book.gsilab.sittig.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[ adjusted Jon Mason's email address ]

On Wed, 2014-08-06 at 17:01 +0200, Gerhard Sittig wrote:
> 
> On Wed, 2014-08-06 at 16:53 +0200, Gerhard Sittig wrote:
> > 
> > The current implementation of the PCI non-transparent bridge
> > support exclusively supports Intel hardware.  This series
> > prepares for the introduction of other vendor's hardware support,
> > by separating the generic 'data transport' driver from the
> > specific 'hardware support' driver.
> 
> For the record:  Email to Jon Mason, the original NTB driver
> author, bounced with SMTP error 550.  The MAINTAINERS file's
> "NTB DRIVER" section might need an update.  Is the address
> listed under "NETERION 10GbE DRIVERS" correct, or is it a
> coincidence that the name matches?

For the record:  In personal conversation Jon acknowledged his
new/other email address, that was listed in the MAINTAINERS file
as well.  The NTB entry should receive an update.


Jon is busy moving and changing jobs.  Is there any other
feedback, test results, opinions, requests, remarks?


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
