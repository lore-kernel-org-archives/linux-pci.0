Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:39436 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbaCNNGN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Mar 2014 09:06:13 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so2475367ier.41
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2014 06:06:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140313182554.GA15990@obsidianresearch.com>
References: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
 <1394732405-2260-2-git-send-email-tharvey@gateworks.com> <5321EE81.1030207@wwwdotorg.org>
 <20140313182554.GA15990@obsidianresearch.com>
From: Grant Likely <grant.likely@linaro.org>
Date: Fri, 14 Mar 2014 13:05:52 +0000
Message-ID: <CACxGe6sEjW+J1ZHq-qb=7yPWLEnfWkSxZvwHUVO3L9vL5rsm1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: DT: fix gic interrupt controller documentation
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Richard Zhu <r65037@freescale.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Jingoo Han <jg1.han@samsung.com>,
	linux-tegra <linux-tegra@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 13, 2014 at 6:25 PM, Jason Gunthorpe
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

Correct. Just drop it.

g.
