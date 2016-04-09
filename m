Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53468 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbcDIB2r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2016 21:28:47 -0400
Subject: Re: [PATCH 1/4] acpi,pci,irq: reduce resource requirements
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1457484079-18202-1-git-send-email-okaya@codeaurora.org>
 <20160314185251.GA19703@localhost> <56E7211F.3070203@codeaurora.org>
 <20160314210147.GA11459@localhost> <56E73232.9030704@codeaurora.org>
 <20160315014843.GA16967@localhost> <56E7733B.4050308@codeaurora.org>
 <20160315023632.GA23940@localhost> <56E80F19.7010503@codeaurora.org>
 <56EEE925.7070202@codeaurora.org> <20160405232124.GH15353@localhost>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <57085ACA.2040108@codeaurora.org>
Date: Fri, 8 Apr 2016 21:28:42 -0400
MIME-Version: 1.0
In-Reply-To: <20160405232124.GH15353@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 4/5/2016 7:21 PM, Bjorn Helgaas wrote:
>> I know you want to validate that all PCI interrupts are level, it looks like the code
>> > is allowing other combinations.
> It's not that we need to validate that all PCI interrupts are level.  What
> we need is to make sure all users sharing an IRQ agree on the mode.
> 

I posted v2. Let me know if the implementation feels like what you are looking for.

Sinan

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
