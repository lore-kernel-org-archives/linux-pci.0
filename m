Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36542 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab3CABYC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2013 20:24:02 -0500
Received: by mail-ie0-f182.google.com with SMTP id k14so2953227iea.27
        for <linux-pci@vger.kernel.org>; Thu, 28 Feb 2013 17:24:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130221154709.GA26660@arm.com>
References: <20130221154709.GA26660@arm.com>
Date: Fri, 1 Mar 2013 02:24:00 +0100
Message-ID: <CACRpkda9pVafqMRrZ-h6ry6X57754bb4pWRW8CWbF0n37pkVNA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] of/pci: Provide support for parsing PCI DT ranges property
From: Linus Walleij <linus.walleij@linaro.org>
To: Andrew Murray <Andrew.Murray@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 21, 2013 at 4:47 PM, Andrew Murray <Andrew.Murray@arm.com> wrote:

> DT bindings for PCI host bridges often use the ranges property to describe
> memory and IO ranges - this binding tends to be the same across architectures
> yet several parsing implementations exist, e.g. arch/mips/pci/pci.c,
> arch/powerpc/kernel/pci-common.c, arch/sparc/kernel/pci.c and
> arch/microblaze/pci/pci-common.c (clone of PPC). Some of these duplicate
> functionality provided by drivers/of/address.c.

Hm I wanted to test but was blocked by this:

Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Making the raw patch look like this:

=09const u32 *ranges;
-=09int rlen;
-=09int pna =3D of_n_addr_cells(dev);
-=09int np =3D pna + 5;
 =09int memno =3D 0, isa_hole =3D -1;

I bet the other ARM guys can help you get the format right
somehow... can't you just use git send-email?

Yours,
Linus Walleij
