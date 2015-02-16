Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 16 Feb 2015 08:55:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, --cclinux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86:pci: Change  sta2x11_dma_ops stucture to use
 switolb_dma_supported as it's dma_supported function in sta2x11-fixup.c
Message-ID: <20150216075506.GA25780@gmail.com>
References: <1424030062-8668-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424030062-8668-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Nicholas Krause <xerofoify@gmail.com> wrote:

> This changes the structure sta2x11_dma_ops stucture to 
> use switolb_dma_supported as it's function for 
> dma_supported hardware verus setting this value to NULL 
> as this should be set correctly for when dma_supported 
> function needs to be called for this hardware. Otherwise 
> this will cause a bug that will crash a operation needing 
> to access this function if an intended hardware operation 
> needs to call it but the kernel has the function pointer 
> for this structure set to NULL incorrectly.

This is a pretty vague description - what specific hardware 
is affected and how is the bug triggered?

Thanks,

	Ingo
