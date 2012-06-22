Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:47299 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093Ab2FVR2U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 13:28:20 -0400
Message-ID: <4FE4AB2F.8090402@wwwdotorg.org>
Date: Fri, 22 Jun 2012 11:28:15 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
References: <4FD85127.8050301@firmworks.com> <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de> <4FDA2DDA.1030704@wwwdotorg.org> <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de> <4FDA40A0.4030206@wwwdotorg.org> <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de> <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de> <4FE0EFBB.6090206@firmworks.com> <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de> <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com> <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de> <4FE4A4B3.9010200@wwwdotorg.org>
In-Reply-To: <4FE4A4B3.9010200@wwwdotorg.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/22/2012 11:00 AM, Stephen Warren wrote:
> On 06/22/2012 05:00 AM, Thierry Reding wrote:
> ...
>> Stephen: can you try to find out whether the Tegra PCIe controller 
>> indeed implements ECAM, or if this scheme is actually just a
>> proprietary variant?
> 
> Sure. I have added this request to the bug I filed requesting more
> complete PCIe host documentation.

I've received unofficial confirmation that we do indeed implement a
non-standard/non-ECAM mapping, and what's in our driver matches our HW.
