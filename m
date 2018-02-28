Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:55363 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeB1Bml (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 20:42:41 -0500
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix possible NULL pointer dereference for
 of_pci_bus_find_domain_nr
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1519526762-136838-1-git-send-email-shawn.lin@rock-chips.com>
 <20180227174957.GA12756@e107981-ln.cambridge.arm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <9fde4c77-cb07-a520-0114-683d331beeb7@rock-chips.com>
Date: Wed, 28 Feb 2018 09:42:39 +0800
MIME-Version: 1.0
In-Reply-To: <20180227174957.GA12756@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Lorenzo,

On 2018/2/28 1:49, Lorenzo Pieralisi wrote:
> On Sun, Feb 25, 2018 at 10:46:02AM +0800, Shawn Lin wrote:
> I really need to get rid of this function in its current form. In the
> interim, I think that printing NULL as faulting node gives no
> information whatsoever so this patch should be updated either by
> avoiding to print or better by demoting the dev_err() to a pr_err(),
> whatever works better for Bjorn.
> 

Ok, that sounds reasonable to me, so which ways is preferred, Bjorn?
