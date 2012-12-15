Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58602 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab2LOBHD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Dec 2012 20:07:03 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2803804pad.19
        for <linux-pci@vger.kernel.org>; Fri, 14 Dec 2012 17:07:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121212163749.GA17371@arm.com>
References: <20121212163749.GA17371@arm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 15 Dec 2012 01:06:41 +0000
Message-ID: <CACxGe6uZATX2uBjuDUsJ489-jmvFbLm-NQ6Q3SGqRVky9XGJYg@mail.gmail.com>
Subject: Re: [PATCH] pci: Provide support for parsing PCI DT ranges property
To: Andrew Murray <Andrew.Murray@arm.com>
Cc: linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Michal Simek <monstr@monstr.eu>,
	Rob Herring <robherring2@gmail.com>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Rob Herring <rob.herring@calxeda.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Liviu Dudau <liviu.dudau@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 12, 2012 at 4:37 PM, Andrew Murray <Andrew.Murray@arm.com> wrote:
> DT bindings for PCI host bridges often use the ranges property to describe
> memory and IO ranges - this binding tends to be the same across architectures
> yet several parsing implementations exist, e.g. arch/mips/pci/pci.c,
> arch/powerpc/kernel/pci-common.c, arch/sparc/kernel/pci.c and
> arch/microblaze/pci/pci-common.c (clone of PPC). Some of these duplicate
> functionality provided by drivers/of/address.c.

Hi Andrew,

Thanks for looking into this. This definitely needs to be done.

However, I cannot merge this patch as-is because it actually makes
things worse by adding yet another implementation of the parsing code.
Plus it doesn't actually have any users.  :-)

Instead, move the existing code that you need out of
arch/powerpc/kernel/pci-common.c into a shared place and add in the
features you need. Bonus points if you fixup microblaze or others at
the same time.

g.
