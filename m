Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58270 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbcF2SrP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2016 14:47:15 -0400
Subject: Re: [PATCH V2 1/4] ACPI,PCI,IRQ: factor in PCI possible
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
 <1467188859-28188-2-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0j1m4oGJfdOC8uerKc-3ksq6k2e9RdjEnk0sWmsq4RHRQ@mail.gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Timur Tabi <timur@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Jon Masters <jcm@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	eric.auger@redhat.com, Linux PCI <linux-pci@vger.kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, wim@djo.tudelft.nl,
	perex@perex.cz, tiwai@suse.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8a40e242-fca4-5681-e480-e29ec05354ac@codeaurora.org>
Date: Wed, 29 Jun 2016 14:47:02 -0400
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j1m4oGJfdOC8uerKc-3ksq6k2e9RdjEnk0sWmsq4RHRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/29/2016 9:13 AM, Rafael J. Wysocki wrote:
> On Wed, Jun 29, 2016 at 10:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
>> resource requirements") omitted the initially assigned POSSIBLE penalty
>> when the IRQ is active.
> 
> It would be good to say what can go wrong with that here.
> 

I can add more description. Here is a first attempt.

Incorrect calculation of penalty leads to ACPI code assigning the wrong
interrupt number to PCI INTx interrupts.

This would not be as bad as it sounds in theory. You would just cause the
interrupts to be shared and observe performance penalty.

However, some drivers like parallel port driver doesn't like interrupt
sharing as in this example and causes all other PCI drivers sharing the interrupt
to malfunction.

The issue has not been caught because the behavior is platform specific
and depends on the peripheral drivers sharing the IRQ. 

I can claim that this could be a BIOS bug. if interrupt 7 is not good for PCI,
it shouldn't have been listed in the possible PCI interrupts to begin with. 
Given this is an existing platform, I don't think we have the luxury to request
all BIOS to be updated. This bugfix is needed to support existing platforms.


Feel free to request more information if the above description is not clear.


>> The original code would assign the POSSIBLE value divided by the number
>> of possible IRQs during initialization.
>>
>> Later, if the IRQ is chosen as the active IRQ or if the IRQ is in use
>> by ISA; additional penalties get added.
> 
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
