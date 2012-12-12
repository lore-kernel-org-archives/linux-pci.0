Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48542 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab2LLKtf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2012 05:49:35 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so456008pbc.19
        for <linux-pci@vger.kernel.org>; Wed, 12 Dec 2012 02:49:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50C85E7D.5080006@monstr.eu>
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com> <20121210214127.D51773E0796@localhost>
 <50C85E7D.5080006@monstr.eu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 12 Dec 2012 10:49:14 +0000
Message-ID: <CACxGe6udeSbEfibC53v0wu8vFRE6K3Fd_P6EX-3JS9F2M=wUeA@mail.gmail.com>
Subject: Re: pci and pcie device-tree binding - range No cells
To: Michal Simek <monstr@monstr.eu>
Cc: Rob Herring <robherring2@gmail.com>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linux-pci@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thierry Reding <thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 12, 2012 at 10:37 AM, Michal Simek <monstr@monstr.eu> wrote:
> On 12/10/2012 10:41 PM, Grant Likely wrote:
>> drivers/pci/pci-of.c would be good. I'd also accept drivers/of/pci.c
>> which might actually be a good idea in the short term so that it gets
>> appropriate supervision while being generalized before being moved into
>> the pci directory.
>
> Ben: Are you willing to move that ppc code to this location?
> It is probably not good idea that I should do it when I even don't have
> hardware available for testing (Asking someone else).

You're a clever guy, you are more than capable of crafting the patch,
even if you can't test on hardware. :-)

I refactored most of the OF support code without having access to most
of the affected hardware. Once I got the changes out there for review
I also asked for spot testing before getting it into linux-next for
even more testing.

g.
