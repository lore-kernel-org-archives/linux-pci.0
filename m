Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:38662 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab2HAQHb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2012 12:07:31 -0400
Message-ID: <5019543F.3080601@wwwdotorg.org>
Date: Wed, 01 Aug 2012 10:07:27 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Rob Herring <robherring2@gmail.com>, linux-tegra@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Colin Cross <ccross@android.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 09/10] of: Add of_pci_parse_ranges()
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de> <1343332512-28762-10-git-send-email-thierry.reding@avionic-design.de> <50183B03.2090809@gmail.com> <20120801065437.GB26791@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20120801065437.GB26791@avionic-0098.adnet.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/01/2012 12:54 AM, Thierry Reding wrote:
> On Tue, Jul 31, 2012 at 03:07:31PM -0500, Rob Herring wrote:
>> On 07/26/2012 02:55 PM, Thierry Reding wrote:
>>> This new function parses the ranges property of PCI device
>>> nodes into an array of struct resource elements. It is useful
>>> in multiple-port PCI host controller drivers to collect
>>> information about the ranges that it needs to forward to the
>>> respective ports.
>> 
>> It seems to me that some of the DT PCI code in
>> arch/powerpc/kernel/pci* like pci_process_bridge_OF_ranges()
>> should apply for ARM as well.
>> 
>> Each arch defining their own pci controller structs complicates
>> this, but I would think at least the DT parsing can be common.
> 
> Yes, there's quite a lot of room for refactoring. When I first
> started work on this there had been some discussion about whether
> it would make sense to move PCI controller drivers into a common
> location to make it easier to refactor but the consensus at the
> time was that this should not be done.

In the long term, if we end up with a separate arch/aarch64/, I think
we'll have to move the PCIe (and any other) drivers to a common
location. Still, I imagine there is plenty of time until that's mandatory.
