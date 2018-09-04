Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbeIDRtv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 13:49:51 -0400
Date: Tue, 4 Sep 2018 08:24:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, x86@kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Drop node-local allocation during host controller
 initialisation
Message-ID: <20180904132442.GB107892@bhelgaas-glaptop.roam.corp.google.com>
References: <20180828150513.32458-1-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180828150513.32458-1-punit.agrawal@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 28, 2018 at 04:05:11PM +0100, Punit Agrawal wrote:
> Hi Bjorn,
> 
> As discussed before[0], here are a couple of patches to drop
> node-local allocations during host contoller initialisation. This set
> covers both arm64 and x86.
> 
> I'm posting early to give the patches time on the list as well in next
> in case there are issues we've missed.
> 
> The patches are based on v4.19-rc1 and has been boot tested on arm64
> and compile tested on x86.
> 
> Thanks,
> Punit
> 
> [0] https://www.spinics.net/lists/arm-kernel/msg669746.html
> 
> Punit Agrawal (2):
>   arm64: PCI: Remove node-local allocations when initialising host
>     controller
>   x86/PCI: Remove node-local allocation when initialising host
>     controller
> 
>  arch/arm64/kernel/pci.c | 5 ++---
>  arch/x86/pci/acpi.c     | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)

Applied with Will's ack on the arm64 patch to pci/enumeration for v4.20,
thanks!
