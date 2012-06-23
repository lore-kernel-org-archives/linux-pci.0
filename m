Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38380 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650Ab2FWVgC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jun 2012 17:36:02 -0400
Received: by lbbgm6 with SMTP id gm6so5023207lbb.19
        for <linux-pci@vger.kernel.org>; Sat, 23 Jun 2012 14:36:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FE4AB2F.8090402@wwwdotorg.org>
References: <4FD85127.8050301@firmworks.com> <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de>
 <4FDA2DDA.1030704@wwwdotorg.org> <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
 <4FDA40A0.4030206@wwwdotorg.org> <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com> <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com>
 <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de>
 <4FE4A4B3.9010200@wwwdotorg.org> <4FE4AB2F.8090402@wwwdotorg.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 23 Jun 2012 15:35:40 -0600
Message-ID: <CAErSpo4UNaRea6F2xtZv++P3deS9h9rZdHeVRyaX_hFm7Gbxfg@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Mitch Bradley <wmb@firmworks.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 22, 2012 at 11:28 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/22/2012 11:00 AM, Stephen Warren wrote:
>> On 06/22/2012 05:00 AM, Thierry Reding wrote:
>> ...
>>> Stephen: can you try to find out whether the Tegra PCIe controller
>>> indeed implements ECAM, or if this scheme is actually just a
>>> proprietary variant?
>>
>> Sure. I have added this request to the bug I filed requesting more
>> complete PCIe host documentation.
>
> I've received unofficial confirmation that we do indeed implement a
> non-standard/non-ECAM mapping, and what's in our driver matches our HW.

Interesting.  A generic ECAM/MMCONFIG solution might still be worth
thinking about.  We could easily have a hook to encapsulate the
address mapping function, while still sharing the resource management
(request_region(), etc).  Not any kind of requirement for the current
patch series, of course, just possible future work.

Bjorn
