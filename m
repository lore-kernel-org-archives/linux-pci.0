Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:65160 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbcEINMk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2016 09:12:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH v2 1/2] Documentation: DT: bindings: Add Broadcom STB PCIe bindings
Date: Mon, 09 May 2016 15:12:12 +0200
Message-ID: <20692845.Ts1cTL7t9V@wuerfel>
In-Reply-To: <572BBF2E.5010606@broadcom.com>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com> <4513390.VWu0VVAxOl@wuerfel> <572BBF2E.5010606@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 05 May 2016 14:46:22 Florian Fainelli wrote:
> 
> > 
> >> +- brcm,gen: integer that indicates desired forced generation of link: 1 => 2.5
> >> +  Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps. Will override the auto-negotation if
> >> +  specified.
> > 
> > to repeat my earlier comment from v1:
> > 
> > Shouldn't the link generation be probed automatically?
> 
> It is, but if the property is present, we can foce the link negotiation,
> We have had cases where this was desired and helpful.
> 

Right, I missed that this is listed as 'optional', so that seems
perfectly fine.

Thanks,

	Arnd
