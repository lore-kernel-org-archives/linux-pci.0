Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36716 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbcDNUcE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Apr 2016 16:32:04 -0400
MIME-Version: 1.0
In-Reply-To: <20160414221818.4726e6c4@free-electrons.com>
References: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1460648177-31473-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160414174046.GA25285@rob-hp-laptop> <20160414221818.4726e6c4@free-electrons.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 14 Apr 2016 15:31:39 -0500
Message-ID: <CAL_JsqKJmbTqJcqJpmnZybby2kwo4hZL2_ghfOp63RCex2RoqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: add DT binding for Marvell
 Armada 7K/8K PCIe controller
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Yehuda Yitschak <yehuday@marvell.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 14, 2016 at 3:18 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Thu, 14 Apr 2016 12:40:46 -0500, Rob Herring wrote:
>
>> I already acked the last version, did something change?
>
> From the cover letter:
>
> """
> Changes since v1:
>
>  - Change the DT binding to take only one clock, since in fact all
>    PCIe lane clocks are child of the PCIe main clock, so there is no
>    need for the PCIe controllers to take a reference to both.

Found it after I replied...

> [...]
>
> Rob: due to the change to the DT binding (even though minimal), I have
> not kept your Acked-by. So if it still stands despite the DT binding
> change, could you send it again? Thanks!
> """

I did, here:

>> Acked-by: Rob Herring <rob@kernel.org>
>
> Thanks!
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
