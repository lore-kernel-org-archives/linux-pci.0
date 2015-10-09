Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33237 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbbJISBL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 14:01:11 -0400
MIME-Version: 1.0
In-Reply-To: <5617E75F.2090907@caviumnetworks.com>
References: <1444342250-6196-1-git-send-email-ddaney.cavm@gmail.com>
 <1444342250-6196-2-git-send-email-ddaney.cavm@gmail.com> <CAL_JsqK1kB30h=zse1LcaBisjYEGSBhD4FutvtqbUxpSU+2NjA@mail.gmail.com>
 <5617E75F.2090907@caviumnetworks.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Oct 2015 13:00:51 -0500
Message-ID: <CAL_Jsq+Jk_HoQ_vGWbEak2HNAXYG4J=LBVWk7_LoRBzG2_pkqQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] Docs: dt: Add PCI MSI map bindings
To: David Daney <ddaney@caviumnetworks.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Daney <ddaney.cavm@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Frank Rowand <frowand.list@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 9, 2015 at 11:12 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 10/09/2015 06:20 AM, Rob Herring wrote:
>>
>> On Thu, Oct 8, 2015 at 5:10 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>>>
>>> From: Mark Rutland <mark.rutland@arm.com>
>>>
>>> Currently msi-parent is used by a few bindings to describe the
>>> relationship between a PCI root complex and a single MSI controller, but
>>> this property does not have a generic binding document.
>>>
>>> Additionally, msi-parent is insufficient to describe more complex
>>> relationships between MSI controllers and devices under a root complex,
>>> where devices may be able to target multiple MSI controllers, or where
>>> MSI controllers use (non-probeable) sideband information to distinguish
>>> devices.
>>>
>>> This patch adds a generic binding for mapping PCI devices to MSI
>>> controllers. This document covers msi-parent, and a new msi-map property
>>> (specific to PCI*) which may be used to map devices (identified by their
>>> Requester ID) to sideband data for each MSI controller that they may
>>> target.
>>>
>>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>
>>
>> I acked v3. Please add it so I can stop paying attention.
>>
>
> My apologies for missing that.
>
> The Acked-by is now in my local tree.  Can the MSI maintainer take it as is
> and add your Acked-by?  If not, I can resend with this added.

Usually they should pick up acks on the current version, but not
previous versions. Given the discussion here though, that should be
enough. IOW, don't resend stuff just to add acks.

Rob
