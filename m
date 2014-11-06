Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34159 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbaKFPJJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Nov 2014 10:09:09 -0500
Message-ID: <1415286537.671.3.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: add missing DT binding for linux,pci-domain
 property
From: Lucas Stach <l.stach@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 06 Nov 2014 16:08:57 +0100
In-Reply-To: <2606632.6m38glseTk@wuerfel>
References: <1415101660-26450-1-git-send-email-l.stach@pengutronix.de>
	 <20141104120052.GE11102@e106497-lin.cambridge.arm.com>
	 <2606632.6m38glseTk@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Dienstag, den 04.11.2014, 13:07 +0100 schrieb Arnd Bergmann:
> On Tuesday 04 November 2014 12:00:52 Liviu Dudau wrote:
> > 
> > While the description is potentially correct, what it fails to explain is that the
> > choice of using the property or generating an unstable (across boots) unique
> > number is actually the choice of the host bridge driver at the moment. I know that
> > my earlier implementations were defaulting to the automatic numbering, but that has
> > been dropped from the final series as Rob Herring was objecting to it.
> > 
> > There is still scope to adopt a wide policy here, but for now it should say something
> > to the tune:
> > 
> >    If present this property assigns a fixed PCI domain number to a host bridge,
> >    otherwise an unstable (across boots) unique number will be assigned.
> >    If you decide to use the property to assign a fixed PCI domain number to a host
> >    bridge you have to ensure that all the host bridge drivers present in the system
> >    follow the same policy. Otherwise, potentially conflicting domain numbers
> >    may be assigned to root busses behind different host bridges.
> 
> But with the latest change to the domain handling, all drivers would implement
> this. I would just mention that Linux kernels older than 3.19 are probably
> going to ignore this property.
> 
Hm, I don't think we should stick those things into the binding docs, as
those should not be Linux specific. IMHO the time when the parsing of a
property gets implemented is a implementation detail that has nothing to
do with the binding. Besides vendors always screw with this timeframes
by doing backports.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

