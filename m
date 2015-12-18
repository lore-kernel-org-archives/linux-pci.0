Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34406 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbbLRVyb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2015 16:54:31 -0500
Message-ID: <56748094.2040405@codeaurora.org>
Date: Fri, 18 Dec 2015 16:54:28 -0500
From: Christopher Covington <cov@codeaurora.org>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>,
	Matthew Minter <matt@masarand.com>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com, tn@semihalf.com
Subject: Re: [PATCH V4] Delay allocation of PCI device IRQs from boot
 time until bus scan time to fix PCI hotplugging
References: <1445576642-29624-1-git-send-email-matt@masarand.com> <20151207173251.GK7994@localhost>
In-Reply-To: <20151207173251.GK7994@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Matthew,

On 12/07/2015 12:32 PM, Bjorn Helgaas wrote:
> On Fri, Oct 23, 2015 at 06:03:33AM +0100, Matthew Minter wrote:
>> Hi again everyone, this is the extremely long awaited version 4 of this patchset.
>>
>> It has been rebased to the head of the lastest mainline kernel as of a few days
>> ago as well as a huge number of small restructures have been included.
> 
> Hi Matthew,
> 
> Thanks a lot for updating this.  I noticed a few kbuild warnings; did you
> get those, too?  I can forward them to you if you didn't.

The compiler warnings are due to various map_irq functions still using
"const pci_dev *dev". I'm not familiar with this code, but based on a
brief build test of a change to tile, it seems like 04/29, PCI: Remove
const from the pci_dev struct passed to pci_fixup_irqs, needs to be
mirrored in some or all architecture directories. What I'm wondering is
whether just those warnings identified by the kbuild test robot should
be fixed, all of them (see bash snippet below), or something in between?

for f in $(git grep -l 'map_irq(const'); do
  sed -i 's/map_irq(const /map_irq(/' $f
done

Thanks,
Christopher Covington

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
