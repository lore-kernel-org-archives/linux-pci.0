Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:56966 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbaDXXhV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 19:37:21 -0400
Received: by mail-vc0-f177.google.com with SMTP id if17so3824966vcb.36
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2014 16:37:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140424232431.GO29593@google.com>
References: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
	<1395960398-4238-4-git-send-email-robherring2@gmail.com>
	<20140424232431.GO29593@google.com>
Date: Thu, 24 Apr 2014 18:37:20 -0500
Message-ID: <CAL_JsqLsDge54k5v_R9rvaGTrPu2qhC5shgg3dNAqV3re+ZPxQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] pci: add DT based ARM Versatile PCI host driver
From: Rob Herring <robherring2@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 24, 2014 at 6:24 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Mar 27, 2014 at 05:46:38PM -0500, Rob Herring wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> This converts the Versatile PCI host code to a platform driver using
>> of_create_pci_host_bridge for parsing DT and setup.
>>
>> I think more of this setup could be done by the core code. There are
>> accesses to the host's config space (accesses using local_pci_cfg_base)
>> which seem like they could be done by the core code or using standard
>> config space accessors. The problem is bridge->bus->self is needed, but
>> it does not get setup. I'm not exactly sure how that should work.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> ...

>> +     bridge = of_create_pci_host_bridge(&pdev->dev, &pci_versatile_ops, &sys);
>
> Are we still relying on the PCI core to default to a bus number range of
> 00-ff?  Can we not do that?

No, that comes from DT.

Rob
