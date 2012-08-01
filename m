Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60443 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2HARCX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2012 13:02:23 -0400
Message-ID: <5019611A.2060804@wwwdotorg.org>
Date: Wed, 01 Aug 2012 11:02:18 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de> <50180547.9040603@wwwdotorg.org> <20120801063545.GA26791@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20120801063545.GA26791@avionic-0098.adnet.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/01/2012 12:35 AM, Thierry Reding wrote:
> On Tue, Jul 31, 2012 at 10:18:15AM -0600, Stephen Warren wrote:
>> On 07/26/2012 01:55 PM, Thierry Reding wrote:
>>> This patch series adds support for device tree based probing of
>>> the PCIe controller found on Tegra SoCs.
>> 
>> Thierry,
>> 
>> I think one thing that would help here would be to split up this
>> series into one per subsystem, and to get all the dependencies
>> merged by the respective maintainers. Preferably, each subsystem
>> would export a stable branch (perhaps consisting of just these
>> patches) that I can then merge into the Tegra tree and use as a
>> basis for the PCIe driver itself. Hopefully this approach will
>> get more traction on all the non-Tegra changes. Does that sound
>> like a good plan?
> 
> I don't understand. The series is already split up into
> per-subsystem patches. I just didn't want to post them separately
> so everybody on Cc would be able to see the big picture and the
> reason why the patch was required.

There are separate patches that touch the different subsystems, but
they're all scattered throughout the one series, rather than having e.g.:

* a series for the PCI tree
* a series for the ARM core tree
* a series for the OF/DT tree
* a series for the Tegra tree, which indicates it depends on all of those.

I'm wondering if the reason you haven't seen much discussion/Acks from
the maintainers of the non-Tegra trees is because this is a big scary
series that touches a lot of stuff, and it's not necessarily clear for
people unfamiliar with it why they're being CCd on it.
