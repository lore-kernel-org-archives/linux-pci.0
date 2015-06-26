Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo7rE8yAS--L+aQmN-DqfL6uGxFBxD2WOPowoBsrvOZ7eg@mail.gmail.com>
References: <1435280756-24455-1-git-send-email-dhdang@apm.com> <CAErSpo7rE8yAS--L+aQmN-DqfL6uGxFBxD2WOPowoBsrvOZ7eg@mail.gmail.com>
From: Duc Dang <dhdang@apm.com>
Date: Fri, 26 Jun 2015 10:26:48 -0700
Message-ID: <CADaLNDmUiZwQfyk_XE9tr03jsM_fW+aXk3b3krAFuqsfNvkLYA@mail.gmail.com>
Subject: Re: [PATCH 1/1] pci: xgene: Enable huge outbound bar support
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>, patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 26, 2015 at 7:26 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Hi Duc,
>
> On Thu, Jun 25, 2015 at 8:05 PM, Duc Dang <dhdang@apm.com> wrote:
>> X-Gene PCIe controllers support huge outbound BARs (with size upto
>> 64GB). This patch configures additional 1 outbound BAR for X-Gene
>> PCIe controllers with size larger than 4GB. This is required to
>> support devices that request huge outbound memory (nVidia K40 as an
>> example)
>
> The PCI specs don't use the "outbound BAR" terminology.  I assume this
> is what we normally call "windows" or "apertures" for MMIO access by
> the CPU?  (The specs rarely use those terms either, but they're
> commonly used in Linux, and the PCIe spec does mention them a couple
> times.)

Yes, Bjorn. The "outbound BAR" that I mentioned is the MMIO window. I
will change these terms in next patch.

>
> By "request huge outbound memory," I assume you simply mean the device
> has a huge BAR, right?
Yes, I meant "the device has a huge BAR". I will change the
description for this in next patch as well

>
> Bjorn

Regards,
Duc Dang.
