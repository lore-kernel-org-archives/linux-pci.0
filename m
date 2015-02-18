Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 18 Feb 2015 19:06:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: nick <xerofoify@gmail.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, --cclinux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86:pci: Change  sta2x11_dma_ops stucture to use
 switolb_dma_supported as it's dma_supported function in sta2x11-fixup.c
Message-ID: <20150218180651.GB32019@gmail.com>
References: <1424030062-8668-1-git-send-email-xerofoify@gmail.com>
 <20150216075506.GA25780@gmail.com>
 <54E243F4.4040708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54E243F4.4040708@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* nick <xerofoify@gmail.com> wrote:

> 
> 
> On 2015-02-16 02:55 AM, Ingo Molnar wrote:
> > 
> > * Nicholas Krause <xerofoify@gmail.com> wrote:
> > 
> >> This changes the structure sta2x11_dma_ops stucture to 
> >> use switolb_dma_supported as it's function for 
> >> dma_supported hardware verus setting this value to NULL 
> >> as this should be set correctly for when dma_supported 
> >> function needs to be called for this hardware. Otherwise 
> >> this will cause a bug that will crash a operation needing 
> >> to access this function if an intended hardware operation 
> >> needs to call it but the kernel has the function pointer 
> >> for this structure set to NULL incorrectly.
> > 
> > This is a pretty vague description - what specific hardware 
> > is affected and how is the bug triggered?
> > 
> > Thanks,
> > 
> > 	Ingo
> > 
> Ingo,
>
> I am unaware of any hardware exactly that this effects. 
> However this should be fixed as a preventive feature in 
> order to avoid future bugs related to hardware that need 
> this function to be supported by the kernel. If you wish 
> I can rewrite the commit message stating this instead of 
> my earlier commit message.

Fair enough, and yes, adding that info would be nice - just 
appending your explanation would do the trick for me!

Thanks,

	Ingo
