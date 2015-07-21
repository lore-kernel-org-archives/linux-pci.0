Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:35108 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933098AbbGUVEg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2015 17:04:36 -0400
Subject: Re: [PATCH v3 1/4] PCI: iproc: enable arm64 support for iProc PCIe
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1437021563-29139-1-git-send-email-rjui@broadcom.com>
 <1437021563-29139-2-git-send-email-rjui@broadcom.com>
 <20150721203018.GH21967@google.com> <55AEB094.1090601@broadcom.com>
CC: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <55AEB3E1.6010405@broadcom.com>
Date: Tue, 21 Jul 2015 14:04:33 -0700
MIME-Version: 1.0
In-Reply-To: <55AEB094.1090601@broadcom.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 7/21/2015 1:50 PM, Ray Jui wrote:
> 
> 
> On 7/21/2015 1:30 PM, Bjorn Helgaas wrote:
>> On Wed, Jul 15, 2015 at 09:39:20PM -0700, Ray Jui wrote:

>> I see that your v1 patch added #ifdef CONFIG_ARM around sysdata at its
>> original location below, and you mentioned that you took Arnd's advice to
>> move sysdata to the beginning of the structure, but I don't see Arnd's
>> email on the list.
>>
> 
> Sorry maybe you need to elaborate here. Am I supposed to add Arnd's name
> in the commit message? Other than that, Arnd is on this email thread.
> 

For your previous question: when Arnd replied, he only replied to me but
did not reply to all, that's why you cannot find his email....

Ray
