Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42026 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbbLCRs7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Dec 2015 12:48:59 -0500
Date: Thu, 3 Dec 2015 11:48:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Christopher Covington <cov@codeaurora.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, timur@codeaurora.org, jcm@redhat.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: enable SERR# forwarding and role-based error
 reporting
Message-ID: <20151203174853.GC17565@localhost>
References: <1445894704-28277-1-git-send-email-okaya@codeaurora.org>
 <20151201185157.GE9306@localhost>
 <565DF34C.6030606@codeaurora.org>
 <565DFE50.5030708@codeaurora.org>
 <20151201230710.GA32381@localhost>
 <565E76E9.1020307@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <565E76E9.1020307@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 01, 2015 at 11:43:21PM -0500, Sinan Kaya wrote:
> On 12/1/2015 6:07 PM, Bjorn Helgaas wrote:
> > On Tue, Dec 01, 2015 at 03:08:48PM -0500, Sinan Kaya wrote:

> >> For instance, what happens after hotplug insertion. Will anybody set
> >> these bits? We need some kernel support for some PCIe features to
> >> reconfigure the hardware.
> > 
> > ACPI systems that support hotplug may supply _HPP or _HPX methods.  If
> > _HPP or _HPX indicates that SERR# forwarding should be enabled, Linux
> > does enable it for hot-added devices (and I think we now do it for all
> > devices at boot, too).  That would explain how this could work on ACPI
> > systems today.
> 
> Are we sure about this? The name of the field in HPP is "Enable SERR".
> Will this also enable SERR# forwarding?

I *think* so.  In program_hpp_type0(), if hpp->enable_serr is set, we
turn on PCI_COMMAND_SERR.  For bridges, we also turn on
PCI_BRIDGE_CTL_SERR, which enables SERR# forwarding.  Of course, I
don't have a machine I'm testing this on; I'm just reading the code.

> I do have _HPP in ACPI with SERR enabled but I do not have HPX. I rely
> on the hardware defaults for which errors to be enabled and masked etc.
> So, I don't need HPX.

Huh.  If you have _HPP with "Enable SERR" set, I wonder why the
pci_configure_device() path isn't turning on PCI_COMMAND_SERR and
PCI_BRIDGE_CTL_SERR for you.  Can you instrument that path and see
what's going on?  I reworked that recently, and my *intent* was that
we apply _HPP & _HPX settings to every device we enumerate, not just
hot-added ones.  If that isn't happening, I'd like to know about it.

Bjorn
