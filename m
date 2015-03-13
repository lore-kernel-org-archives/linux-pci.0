Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61796 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbbCMLHd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2015 07:07:33 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <rjui@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>,
	Paul Bolle <pebolle@tiscali.nl>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v6 2/4] pci: iProc: define iProc PCIe platform bus binding
Date: Fri, 13 Mar 2015 12:07:21 +0100
Message-ID: <2401049.ClHMSX33l5@wuerfel>
In-Reply-To: <20150312211448.GG7346@google.com>
References: <1426097169-20805-1-git-send-email-rjui@broadcom.com> <1426097169-20805-3-git-send-email-rjui@broadcom.com> <20150312211448.GG7346@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 12 March 2015 16:14:48 Bjorn Helgaas wrote:
> [+cc Rob, Pawel, Mark, Ian, Kumar]
> 
> On Wed, Mar 11, 2015 at 11:06:07AM -0700, Ray Jui wrote:
> > Document the Broadcom iProc PCIe platform interface device tree binding
> > 
> > Signed-off-by: Ray Jui <rjui@broadcom.com>
> > Reviewed-by: Scott Branden <sbranden@broadcom.com>
> 
> I'd like to get an ack for this from Arnd, Rob, or other device tree folks
> (CC'd).
> 

Sorry, I should have given my ack earlier. I've carefully reviewed the
previous versions and am happy with the current one.

Acked-by: Arnd Bergmann <arnd@arndb.de>

for the whole series.

	Arnd
