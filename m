Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:62770 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbbIWIC3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 04:02:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3 0/6] PCI: generic: Misc. bug fixes/enhancements
Date: Wed, 23 Sep 2015 10:02:17 +0200
Message-ID: <3557997.kiXsJrjb3K@wuerfel>
In-Reply-To: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 22 September 2015 16:49:11 David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> While using the pci-host-generic driver to add PCI support for the
> Cavium ThunderX processors, several bugs were discovered.  This patch
> set fixes the bugs, a follow-on set will add the ThunderX support.
> 

Looks good overall, except for one patch that I commented on.

	Arnd
