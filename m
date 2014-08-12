Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:65496 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbaHLSo0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Aug 2014 14:44:26 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so7737847igc.0
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 11:44:24 -0700 (PDT)
Date: Tue, 12 Aug 2014 12:44:21 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Benoit Taine <benoit.taine@lip6.fr>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/1] Replace DEFINE_PCI_DEVICE_TABLE macro use
Message-ID: <20140812184421.GA5516@google.com>
References: <1407506163-8371-1-git-send-email-benoit.taine@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407506163-8371-1-git-send-email-benoit.taine@lip6.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 08, 2014 at 03:56:02PM +0200, Benoit Taine wrote:
> We should prefer `const struct pci_device_id` over
> `DEFINE_PCI_DEVICE_TABLE` to meet kernel coding style guidelines.
> This issue was reported by checkpatch.
> 
> A simplified version of the semantic patch that makes this change is as
> follows (http://coccinelle.lip6.fr/):
> 
> // <smpl>
> 
> @@
> identifier i;
> declarer name DEFINE_PCI_DEVICE_TABLE;
> initializer z;
> @@
> 
> - DEFINE_PCI_DEVICE_TABLE(i)
> + const struct pci_device_id i[]
> = z;
> 
> // </smpl>
> 
> I previously sent parts of this patch to check wether or not it was
> worth sending, and Bjorn answered:
> > Benoit, how about if you wait until about half-way through the merge
> > window after v3.16 releases, generate an up-to-date single patch, and
> > post that?  Then we can try to get it in before v3.17-rc1 to minimize
> > merge hassles.
> 
> So here it is, based on linux-next on 2014-08-07.

Applied to my for-linus branch for v3.17, thanks!

Bjorn
