Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752195AbdKHRXv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Nov 2017 12:23:51 -0500
Date: Wed, 8 Nov 2017 11:23:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: subrahmanya l <l.subrahmanya@mobiveil.co.in>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [Patch] PCIe: Add Mobiveil PCIe Host Bridge IP driver
Message-ID: <20171108172349.GC28427@bhelgaas-glaptop.roam.corp.google.com>
References: <CAFZiPx2mc6bjJkXbjOeKqwJhFSicu3fXYSMgL8ET-mnuEvB2rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFZiPx2mc6bjJkXbjOeKqwJhFSicu3fXYSMgL8ET-mnuEvB2rQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 08, 2017 at 09:42:29PM +0530, subrahmanya l wrote:
> This is the driver for Mobiveil  AXI PCIe Host Bridge Soft IP
> 
> -- 
> Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any 
> attachments, is for the sole use of the intended recipient(s) and may 
> contain proprietary confidential or privileged information or otherwise be 
> protected by law. Any unauthorized review, use, disclosure or distribution 
> is prohibited. If you are not the intended recipient, please notify the 
> sender and destroy all copies and the original message.

I can't do anything with email marked "confidential".

Also, please review these hints for posting patches:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst
https://lkml.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

Please include your patch inline (not as an attachment).  Patchwork
(https://patchwork.ozlabs.org/project/linux-pci/list/), the system I
use to track patches, doesn't pick up attachments, so they tend to get
lost.

Please look at the other drivers in drivers/pci/host/ and make yours
look as much as possible like them.  Same coding style, same
organization, same function naming scheme, etc.

Bjorn
