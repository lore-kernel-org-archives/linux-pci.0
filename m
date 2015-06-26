Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1435280756-24455-1-git-send-email-dhdang@apm.com>
References: <1435280756-24455-1-git-send-email-dhdang@apm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 26 Jun 2015 09:26:21 -0500
Message-ID: <CAErSpo7rE8yAS--L+aQmN-DqfL6uGxFBxD2WOPowoBsrvOZ7eg@mail.gmail.com>
Subject: Re: [PATCH 1/1] pci: xgene: Enable huge outbound bar support
To: Duc Dang <dhdang@apm.com>
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

Hi Duc,

On Thu, Jun 25, 2015 at 8:05 PM, Duc Dang <dhdang@apm.com> wrote:
> X-Gene PCIe controllers support huge outbound BARs (with size upto
> 64GB). This patch configures additional 1 outbound BAR for X-Gene
> PCIe controllers with size larger than 4GB. This is required to
> support devices that request huge outbound memory (nVidia K40 as an
> example)

The PCI specs don't use the "outbound BAR" terminology.  I assume this
is what we normally call "windows" or "apertures" for MMIO access by
the CPU?  (The specs rarely use those terms either, but they're
commonly used in Linux, and the PCIe spec does mention them a couple
times.)

By "request huge outbound memory," I assume you simply mean the device
has a huge BAR, right?

Bjorn
