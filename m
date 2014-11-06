Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54546 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbaKFNaZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Nov 2014 08:30:25 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: add missing DT binding for linux,pci-domain property
Date: Thu, 06 Nov 2014 14:29:55 +0100
Message-ID: <2623446.GSBHC8coOR@wuerfel>
In-Reply-To: <20141106123642.GT8916@e106497-lin.cambridge.arm.com>
References: <1415101660-26450-1-git-send-email-l.stach@pengutronix.de> <3491668.yjzKoIEZd4@wuerfel> <20141106123642.GT8916@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 06 November 2014 12:36:42 Liviu Dudau wrote:
> > ACPI is easy here, because it already requires the domain to be
> > explicit.
> 
> I was thinking more along the line of code sharing.
> 

I don't think it's worth it here. In general, it's a good idea,
but the way that ACPI represents PCI is very different. In particular,
it doesn't support multiple kinds of host controllers, only ECAM
config space registers with no special setup code for other hardware
registers. The domain is part of the addressing mechanism for finding
the right ECAM register.

	Arnd
