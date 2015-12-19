Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:52287 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932252AbbLSL7u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 19 Dec 2015 06:59:50 -0500
From: Matthew Minter <matt@masarand.com>
To: Christopher Covington <cov@codeaurora.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com, tn@semihalf.com
Subject: Re: [PATCH V4] Delay allocation of PCI device IRQs from boot time until bus scan time to fix PCI hotplugging
Date: Sat, 19 Dec 2015 11:50:13 +0000
Message-ID: <1805407.y7ysQr2Hbr@shredder>
In-Reply-To: <56748094.2040405@codeaurora.org>
References: <1445576642-29624-1-git-send-email-matt@masarand.com> <20151207173251.GK7994@localhost> <56748094.2040405@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Christopher, Bjorn,

Apologies for leaving these issues in. I don’t currently have resources to 
easily test compiling, yet alone running on most architectures.

I did not receive the buildbot warnings but have now had a look at them on the 
web archive since my attention was brought to them.

Attempting to remove constness from the pointer to map_irq functions was 
tricky as I was nervous to blindly change a bunch of functions for hardware I 
cannot easily compile for and cannot test on as it is hard for me to be 100% 
sure I have not broken behaviour without trying the code even if visually the 
changes look fine. I did not understand all the arch specific code well enough 
to verify for sure what behaviour was ok to change so ended up making the 
minimum changes to functionality of arch code possible.

I expect the ideal thing to do is to fix all of those pointers to be non const 
even where the buildbot did not give warnings as removing constness as far as 
I know should never break anything that isn't already broken but leaving it in 
incorrectly could cause hard to find issues. If it later becomes clear that it 
should be there it can always be re-added in another patch-set.

However a second opinion on this would be greatly appreciated as I dont know 
if some architecture code has non obvious restrictions here.

Also please note I will not have much time to spend developing and working on 
this over the next couple of weeks due to Christmas related events but will 
try and keep up to date on emails. But thanks everyone so far for the 
feedback.

Many thanks,
Matthew Minter
