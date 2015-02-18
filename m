Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:39284 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbbBRRL4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Feb 2015 12:11:56 -0500
Date: Wed, 18 Feb 2015 18:11:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] x86:pci: Change  sta2x11_dma_ops stucture to use
 switolb_dma_supported as it's dma_supported function in sta2x11-fixup.c
Message-ID: <20150218171151.GA29241@gmail.com>
References: <1424132571-32018-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424132571-32018-1-git-send-email-xerofoify@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Nicholas Krause <xerofoify@gmail.com> wrote:

> This changes the structure sta2x11_dma_ops stucture to use switolb_dma_supported
> as it's function for dma_supported hardware verus setting this value to NULL as
> this should be set correctly for when dma_supported function needs to be called
> for this hardware. Otherwise this will cause a bug that will crash a operation
> needing to access this function if an intended hardware operation needs to call
> it but the kernel has the function pointer for this structure set to NULL
> incorrectly.

Hm, I have asked a question for the v1 patch already:

  https://lkml.org/lkml/2015/2/16/30

is there an answer to my question?

Thanks,

	Ingo
