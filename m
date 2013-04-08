Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:55866 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935818Ab3DHUca (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2013 16:32:30 -0400
Received: by mail-oa0-f54.google.com with SMTP id n12so6630854oag.27
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2013 13:32:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130328082436.317d698a@skate>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364395234-11195-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAAfodu2t4j4ZASzdaKV0QarffXRwMgkMESGy=dDq1oMfTANEeg@mail.gmail.com> <20130328082436.317d698a@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 8 Apr 2013 14:32:09 -0600
Message-ID: <CAErSpo61=gqnNkUYhsu88UUBRQN0SBynG07mby1f3HJUm=oZKA@mail.gmail.com>
Subject: Re: [PATCHv7 04/17] pci: infrastructure to add drivers in drivers/pci/host
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Neil Greatorex <neil@fatboyfat.co.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Mitch Bradley <wmb@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 28, 2013 at 1:24 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Neil Greatorex,
>
> On Thu, 28 Mar 2013 00:28:02 +0000, Neil Greatorex wrote:
>
>> Surely this patch should include the drivers/pci/host/Makefile or it will
>> not build?
>
> Ah, correct. I'll fix that up in the v8. Thank you for noticing!

With the fix, looks OK to me.

Bjorn
