Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from re04.intra2net.com ([82.165.46.26]:34908 "EHLO
	re04.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755633Ab2DYPr0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Apr 2012 11:47:26 -0400
From: Thomas Jarosch <thomas.jarosch@intra2net.com>
To: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Add quirk for still enabled interrupts on Intel Sandy Bridge GPUs
Date: Wed, 25 Apr 2012 17:22:14 +0200
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-kernel@vger.kernel.org, Drew Weaver <drew.weaver@thenap.com>,
	Charlie Suffin <charlie.suffin@stratus.com>
References: <4EDFD5BB.1050906@intra2net.com>
In-Reply-To: <4EDFD5BB.1050906@intra2net.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201204251722.14877.thomas.jarosch@intra2net.com>
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

Just a small heads up: Boards with the new Intel Ivy bridge chipset
are affected, too. Currently known to be affected is

    Intel Desktop Board DH77EB


Would be nice if Intel fixes the shared BIOS code...

Thanks to Drew Weaver for reporting the issue. I currently
don't have time to prepare another quirk.

Best regards
Thomas Jarosch
