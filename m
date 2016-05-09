Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60364 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbcEINfQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 May 2016 09:35:16 -0400
Date: Mon, 9 May 2016 08:35:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: PTM preliminary implementation
Message-ID: <20160509133512.GA3580@localhost>
References: <1461047358-4736-1-git-send-email-jonathan.yong@intel.com>
 <1461047358-4736-2-git-send-email-jonathan.yong@intel.com>
 <20160508023821.GA13531@localhost>
 <572FFFD8.30709@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <572FFFD8.30709@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 09, 2016 at 11:11:20AM +0800, Yong, Jonathan wrote:
> On 05/08/2016 10:38, Bjorn Helgaas wrote:
> >On Tue, Apr 19, 2016 at 06:29:18AM +0000, Yong, Jonathan wrote:
> >>Simplified Precision Time Measurement driver, activates PTM feature
> >>if a PCIe PTM requester (as per PCI Express 3.1 Base Specification
> >>section 7.32)is found, but not before checking if the rest of the
> >>PCI hierarchy can support it.
> >>
> >>The driver does not take part in facilitating PTM conversations,
> >>neither does it provide any useful services, it is only responsible
> >>for setting up the required configuration space bits.
> >>
> >>As of writing, there aren't any PTM capable devices on the market
> >>yet, but it is supported by the Intel Apollo Lake platform.
> >
> >Can you also add lspci support for the PTM capability?  That will help
> >debugging.
> >
> >Bjorn
> >
> 
> Do I also send it to this list? Or directly to Martin?

Send it to Martin and cc this list.
