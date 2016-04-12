Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2 1/3] acpi,pci,irq: reduce resource requirements
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1460165192-4526-1-git-send-email-okaya@codeaurora.org>
 <1460165192-4526-2-git-send-email-okaya@codeaurora.org>
 <20160412051942.GE11361@localhost>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <570D2170.303@codeaurora.org>
Date: Tue, 12 Apr 2016 12:25:20 -0400
MIME-Version: 1.0
In-Reply-To: <20160412051942.GE11361@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/12/2016 1:19 AM, Bjorn Helgaas wrote:
> Hi Sinan,
> 
> I was hoping we could *simplify* this, but I think it's just getting
> even more complicated (it's a net addition of 100 lines), which is due
> to feature creep that I'm afraid is my fault.
> 
> IIRC, the main thing you need is to get rid of some early memory
> allocation.
> 
> I don't think all the trigger mode/level checking is worth it.  The
> current code doesn't do it, and it's not fixing a problem for you.
> It's conceivable that it could even make us trip over a new problem,
> e.g., some broken BIOS that we currently tolerate.
> 
> I think you could make this a little easier to review if you split
> things like the acpi_irq_penalty[] -> acpi_isa_irq_penalty[] rename
> into their own patches.  Little patches like that are trivial to
> review because a simple rename is pretty safe, and then the patches
> that actually *do* interesting things are smaller and easier to
> review, too.

OK. I honestly didn't like adding this check either. I'll work on a new
set and post with your additional comments in this patch.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
