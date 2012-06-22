Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36368 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229Ab2FVRNm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 13:13:42 -0400
Received: by lbbgm6 with SMTP id gm6so3848973lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2012 10:13:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201206221653.31817.arnd@arndb.de>
References: <4FDA2DDA.1030704@wwwdotorg.org> <201206221303.21985.arnd@arndb.de>
 <CAErSpo56=S2oQ0usYfH28T0178SQUBD=5jqmcKWCT6M5WUQF6g@mail.gmail.com> <201206221653.31817.arnd@arndb.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 22 Jun 2012 11:13:19 -0600
Message-ID: <CAErSpo5dj99iHW0WNEABPR1OO2yS=BwNezOivu6_7Go8sKyjsQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Mitch Bradley <wmb@firmworks.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 22, 2012 at 10:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 22 June 2012, Bjorn Helgaas wrote:
>> The requirement (if there is one) isn't anything related to PC-ness.
>> I just don't understand how things can actually work if two host
>> bridges both claim the same bus number.  If we do a config read to
>> that bus, both bridges should claim it and turn it into config cycles
>> on their respective root buses, and we should get two responses.  I
>> would expect the second response to cause an "unexpected response"
>> machine check or similar.
>
> But each PCI domain has its own config space, so if you do a config
> read for one bus, it's always relative to the domain.

Oh, I see!  I totally missed the fact that each host bridge was in its
own domain.  If each has its own domain, then the bus number aperture
can certainly be [bus 00-ff] and there's no problem.
