Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3on0097.outbound.protection.outlook.com ([157.55.234.97]:35860
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751038AbcD1Hze (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 03:55:34 -0400
Subject: Re: [PATCH] PCI: Refine broken INTx masking for Mellanox devices
To: Or Gerlitz <ogerlitz@mellanox.com>,
	Alex Williamson <alex.williamson@redhat.com>
References: <1461083616-30099-1-git-send-email-majd@mellanox.com>
 <20160419130435.7d681f6d@t450s.home>
 <7b67ed14-516d-aae9-2b72-6dae420caa65@mellanox.com>
 <cf7d745d-a43c-dcf7-e2e0-00afbbe26a72@mellanox.com>
 <20160425075535.6c297c26@ul30vt.home> <5720CFA1.6030200@mellanox.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Noa Osherovich <noaos@mellanox.com>
From: Majd Dibbiny <majd@mellanox.com>
Message-ID: <4d2a7922-2020-b208-0967-9e169db36c1c@mellanox.com>
Date: Thu, 28 Apr 2016 10:55:25 +0300
MIME-Version: 1.0
In-Reply-To: <5720CFA1.6030200@mellanox.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 4/27/2016 5:41 PM, Or Gerlitz wrote:
> On 4/25/2016 4:55 PM, Alex Williamson wrote:
>> My comment is trying to highlight the problem that users are not likely
>> to check for updated firmware for every device *before* installing a new
>> kernel, so there's a reasonable chance that a user will see this change
>> first as a regression in the kernel.  So documentation in the firmware
>> release notes is really only going to help very meticulous users.  For
>> everyone else it still looks like a kernel regression and a detailed
>> commit log is an after the fact aid to resolving the problem.  So, is
>> there some way we can detect the firmware from the quirk and make a
>> determination whether to enable broken intx, with a dmesg entry
>> indicating to update device firmware?  Thanks,
>
Yes, we can read the firmware version in the quirk. I'll prepare a new 
fix that determines whether to mark INTx masking as broken or not 
according to the firmware version.
> Yep, makes sense to me.
>
> If we can do that, lets go this way, Majd?
>
> Or.
