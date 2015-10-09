Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5617E75F.2090907@caviumnetworks.com>
Date: Fri, 9 Oct 2015 09:12:15 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: David Daney <ddaney.cavm@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v5 1/4] Docs: dt: Add PCI MSI map bindings
References: <1444342250-6196-1-git-send-email-ddaney.cavm@gmail.com> <1444342250-6196-2-git-send-email-ddaney.cavm@gmail.com> <CAL_JsqK1kB30h=zse1LcaBisjYEGSBhD4FutvtqbUxpSU+2NjA@mail.gmail.com>
In-Reply-To: <CAL_JsqK1kB30h=zse1LcaBisjYEGSBhD4FutvtqbUxpSU+2NjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/09/2015 06:20 AM, Rob Herring wrote:
> On Thu, Oct 8, 2015 at 5:10 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>> From: Mark Rutland <mark.rutland@arm.com>
>>
>> Currently msi-parent is used by a few bindings to describe the
>> relationship between a PCI root complex and a single MSI controller, but
>> this property does not have a generic binding document.
>>
>> Additionally, msi-parent is insufficient to describe more complex
>> relationships between MSI controllers and devices under a root complex,
>> where devices may be able to target multiple MSI controllers, or where
>> MSI controllers use (non-probeable) sideband information to distinguish
>> devices.
>>
>> This patch adds a generic binding for mapping PCI devices to MSI
>> controllers. This document covers msi-parent, and a new msi-map property
>> (specific to PCI*) which may be used to map devices (identified by their
>> Requester ID) to sideband data for each MSI controller that they may
>> target.
>>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>
> I acked v3. Please add it so I can stop paying attention.
>

My apologies for missing that.

The Acked-by is now in my local tree.  Can the MSI maintainer take it as 
is and add your Acked-by?  If not, I can resend with this added.

Thanks for taking the time to review it,
David Daney


