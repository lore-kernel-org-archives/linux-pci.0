Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V4 3/3] Revert "ACPI, PCI, IRQ: separate ISA penalty
 calculation"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-4-git-send-email-okaya@codeaurora.org>
 <20161021023109.GD31044@localhost>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
 agross@codeaurora.org, Robert Moore <robert.moore@intel.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Lv Zheng <lv.zheng@intel.com>, linux-arm-msm@vger.kernel.org,
 wim@djo.tudelft.nl, devel@acpica.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8dcd59ac-815b-da71-a3f2-ba533c4182c9@codeaurora.org>
Date: Thu, 20 Oct 2016 19:58:57 -0700
MIME-Version: 1.0
In-Reply-To: <20161021023109.GD31044@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/20/2016 7:31 PM, Bjorn Helgaas wrote:
>> Let's try to simplify the code one more time to share code.
> I'm sort of OK with this, but it's not exactly a revert of the above
> (the commits you mention don't check "link->irq.initialized == 1".

I can split the initialized bit. If I remove it from this commit, it can
break the git bisect. That's why, I folded it into this review. I
briefly mentioned about it in the cover letter. It might not be quiet
clear.

> 
> Previously acpi_irq_penalty_init() looked at _PRS info ("possible"
> IRQs), but now we won't.  Maybe that's good; I dunno.  But it should
> be mentioned.

I'm directing all IRQs to  acpi_irq_pci_sharing_penalty function. 
acpi_irq_pci_sharing_penalty checks for the possible values here from
_PRS.

/*
 * penalize the IRQs PCI might use, but not as severely.
 */
for (i = 0; i < link->irq.possible_count; i++)
	if (link->irq.possible[i] == irq)
		penalty += PIRQ_PENALTY_PCI_POSSIBLE /
			link->irq.possible_count;

> 
> And I don't think it fixes a user-visible problem, so it doesn't need
> to be applied immediately.  I'm not sure this is worth doing by
> itself; maybe it should wait until we can do more cleanup and think
> about all these issues together?
> 

It does fix the PCI_USING penalty assignment. 

                if (link->irq.active && link->irq.active == irq)
                         penalty += PIRQ_PENALTY_PCI_USING;


If we drop this patch, then we need
[PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts

http://www.gossamer-threads.com/lists/linux/kernel/2547605

as somebody needs to increment the penalty with PCI_USING when IRQ is assigned
for a given ISA IRQ.

We might as well take [PATCH V4 1/3], [PATCH V4 2/3] and [PATCH V3 1/3]
for this regression.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
