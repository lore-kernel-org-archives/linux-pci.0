Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:57867 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab3C0MuK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 08:50:10 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd14so8828700ieb.28
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 05:50:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130320210521.65261e77@skate>
References: <20130221154709.GA26660@arm.com>
	<20130320210521.65261e77@skate>
Date: Wed, 27 Mar 2013 13:50:09 +0100
Message-ID: <CACRpkdZ_iuz96JWjHcr+6ugRY29MPA-wiGWtQQJqk30iTQE--Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2] of/pci: Provide support for parsing PCI DT ranges property
From: Linus Walleij <linus.walleij@linaro.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Murray <Andrew.Murray@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 20, 2013 at 9:05 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> What is the status of the below patch? Both Marvell PCIe driver and
> Tegra PCIe driver need a way to parse the ranges = <...> property of
> the PCI DT node.
>
> Would it be possible to get this patch merged for 3.10, or get some
> review comments that would allow us to rework it in time for 3.10 ?

Thomas can you supply a Reviewed-by/Tested-by tag?
That certainly helps...

I was meaning to test it on the Integrator but I've been sidetracked.

It'd be good to take this through ARM SoC's DT branch so different
platforms can use it.

Yours,
Linus Walleij
