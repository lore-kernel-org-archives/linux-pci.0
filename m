Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:64146 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbaCMWZv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Mar 2014 18:25:51 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so1443409wes.36
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2014 15:25:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140313182554.GA15990@obsidianresearch.com>
References: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
	<1394732405-2260-2-git-send-email-tharvey@gateworks.com>
	<5321EE81.1030207@wwwdotorg.org>
	<20140313182554.GA15990@obsidianresearch.com>
Date: Thu, 13 Mar 2014 15:25:50 -0700
Message-ID: <CAJ+vNU2YYbsH8iOWJ_B-vcHdfWYW1oFsWY_=YEd-ojJASOZgtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: DT: fix gic interrupt controller documentation
From: Tim Harvey <tharvey@gateworks.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>,
	linux-tegra <linux-tegra@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 13, 2014 at 11:25 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Thu, Mar 13, 2014 at 11:44:33AM -0600, Stephen Warren wrote:
>> On 03/13/2014 11:40 AM, Tim Harvey wrote:
>> > When using interrupt-maps, the size of a map entry is #address-cells +
>> >  #interrupt-cells for the parent interrupt controller.  For the ARM GIC
>> > address-cells should be 0 as this is not used.
>> >
>> > This patch fixes the example by correctly specifying #address-cells = 0.
>>
>> If the #address-cells property is required (well, or even optional...)
>> in the node, shouldn't it be included in the list of required/optional
>> properties above, and not solely included in the example?
>
> AFAIK, #address-cells = 0 is the same as not including a
> #address-cells at all.
>
> Omitting entirely is what other interrupt-controller bindings are
> doing, so I'd just drop mention of #address-cells completely.
>
> Jason

Jason / Stephen,

Yes, it does indeed default to 0 if not specified.  For arm-gic it
would appear #address-cells must be 0, so should we remove all places
its set explicitly to 0 in dts as wel as the example in
Documentation/devicetree/bindings?

Looking through arch/arm/boot/dts I'm seeing other dts configs using
'arm,cortex-a9-gic' which I'm guessing are equally as wrong as the
imx6 situation:
 - arch/arm/boot/dts/highbank.dts
 - arch/arm/boot/dts/sh73a0.dtsi

I'm also seeing a number of places where its set explicitly to 0:
 - Documentation/devicetree/bindings/arm/gic.txt
 - Documentation/devicetree/bindings/arm/vexpress.txt
 - arch/arm/boot/dts/bcm11351.dtsi
 - arch/arm/boot/dts/hi3620.dtsi
 - arch/arm/boot/dts/imx6qdl.dtsi
 - arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts

If I extend this search to the other compatible gic interrupt
controllers implemented in drivers/irqchip/irq-gic.c
(arm,cortex-a15-gic, qcom,msm-8660-qgic, qcom,msm-qgic2) I find even
more examples where #address-cells is set explicitly to 0 or to 1 (and
I would believe a value of 1 is invalid, just as it is in my case).

I'm happy to broaden my patch, but I certainly want to make sure I'm
doing the right thing with it, as I don't have the ability to test all
the other devicetree configs and am by no means a devicetree expert.

Recommendations?

Tim
