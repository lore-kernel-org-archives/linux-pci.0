Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from re04.intra2net.com ([82.165.46.26]:51127 "EHLO
	re04.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab2AJKpz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2012 05:45:55 -0500
From: Thomas Jarosch <thomas.jarosch@intra2net.com>
To: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Add quirk for still enabled interrupts on Intel Sandy Bridge GPUs
Date: Tue, 10 Jan 2012 11:45:52 +0100
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-kernel@vger.kernel.org,
	Charlie Suffin <charlie.suffin@stratus.com>, stable@kernel.org
References: <4EDFD5BB.1050906@intra2net.com>
In-Reply-To: <4EDFD5BB.1050906@intra2net.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201201101145.52640.thomas.jarosch@intra2net.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, 7. December 2011 22:08:11 Thomas Jarosch wrote:
> Some BIOS implementations leave the Intel GPU interrupts enabled,
> even though no one is handling them (f.e. i915 driver is never loaded).
> Additionally the interrupt destination is not set up properly
> and the interrupt ends up -somewhere-.
> 
> These spurious interrupts are "sticky" and the kernel disables
> the (shared) interrupt line after 100.000+ generated interrupts.
> 
> Fix it by disabling the still enabled interrupts.
> This resolves crashes often seen on monitor unplug.

Happy new year 2012!

Any news on the status of this patch?

Cheers,
Thomas
