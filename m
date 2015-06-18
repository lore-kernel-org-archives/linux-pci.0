Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150618165954.GE7710@google.com>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-11-git-send-email-robh@kernel.org> <20150618165954.GE7710@google.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 18 Jun 2015 15:08:34 -0500
Message-ID: <CAL_Jsq+5820W8N1Pbmv8JXzz7mH_H89HhtjXK_FAYbWAwBd8Ng@mail.gmail.com>
Subject: Re: [PATCH 10/15] PCI: kill off set_irq_flags usage
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm@kernel.org" <arm@kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	linux-omap <linux-omap@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	SH-Linux <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 11:59 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Jun 09, 2015 at 01:26:36PM -0500, Rob Herring wrote:
>> set_irq_flags is ARM specific with custom flags which have genirq
>> equivalents. Convert drivers to use the genirq interfaces directly, so we
>> can kill off set_irq_flags. The translation of flags is as follows:
>>
>> IRQF_VALID -> !IRQ_NOREQUEST
>> IRQF_PROBE -> !IRQ_NOPROBE
>> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>>
>> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
>> and setting IRQ_NOREQUEST already, so there is no need to do this in
>> .map() functions and we can simply remove the set_irq_flags calls. Some
>> users also set IRQ_NOPROBE and this has been maintained although it is not
>> clear that is really needed. There appears to be a great deal of blind
>> copy and paste of this code.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Murali Karicheri <m-karicheri2@ti.com>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> Cc: Pratyush Anand <pratyush.anand@gmail.com>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
>> Cc: linux-omap@vger.kernel.org
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-tegra@vger.kernel.org
>> Cc: linux-sh@vger.kernel.org
>
> This is the only part of the series on linux-pci, so I assume this will be
> merged by somebody else along with the rest.

I copied you on the intro, but all the lists and all the maintainers
was too long to cc. Being late in the cycle I didn't really intend for
this to be for 4.2, but you can pick up this patch if you want to as
it doesn't have any dependencies. If you don't, then I will submit the
whole series for 4.3.

> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks.

Rob
