Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:60198 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbbFZUnt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2015 16:43:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Duc Dang <dhdang@apm.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	patches <patches@apm.com>, linux-kernel@vger.kernel.org,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH 1/1] pci: xgene: Enable huge outbound bar support
Date: Fri, 26 Jun 2015 22:43:32 +0200
Message-ID: <1674778.6xGik39Z0J@wuerfel>
In-Reply-To: <46305464.n5SOjGAhJb@wuerfel>
References: <1435280756-24455-1-git-send-email-dhdang@apm.com> <CADaLNDkck5TaG48sjF9y1wrXTzUeVkYOsXw7Dm8a629KqBafFg@mail.gmail.com> <46305464.n5SOjGAhJb@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 26 June 2015 22:35:08 Arnd Bergmann wrote:
> > >
> > > Can you configure one of the two windows as prefetchable for improved performance?
> > >
> > The new huge window will be prefetchable.
> 
> The DT marks it as non-prefetchable, so the kernel will now try to allocate
> space for non-prefetchable BARs from this area, which is a bug. If the second
> memory window is always prefetchable, you have to mark it accordingly in DT,
> to prevent it from being used for normal 64 bit BARs.

Forget what I wrote here, I just remembered that 64-bit BARs are by definition
prefetchable. You should still mark the range accordingly in DT for correct
operation, but it won't be used for non-prefetchable 64-bit BARs if you don't
because they do not exist.

	Arnd
