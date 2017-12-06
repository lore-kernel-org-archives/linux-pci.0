Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbdLFUvh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Dec 2017 15:51:37 -0500
Date: Wed, 6 Dec 2017 14:51:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Fixes for 64bit window handling on AMD CPUs
Message-ID: <20171206205133.GM23510@bhelgaas-glaptop.roam.corp.google.com>
References: <20171129141229.6107-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171129141229.6107-1-christian.koenig@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 29, 2017 at 03:12:26PM +0100, Christian König wrote:
> Hi Bjorn,
> 
> please include the following three patches in your next fix pull request for -rc2.
> 
> They just restrict the fixup of the 64bit window on AMD CPU to avoid problems with Xen and multi socket systems.

Applied the first two to for-linus for v4.15, thanks!

I'll apply the third as soon as we get the changelog clarified.
