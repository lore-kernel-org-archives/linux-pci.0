Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEF3C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 08:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F7720818
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 08:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfBVILF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:11:05 -0500
Received: from doppler.thel33t.co.uk ([185.153.207.61]:49486 "EHLO
        doppler.thel33t.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVILE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 03:11:04 -0500
Received: from doppler.thel33t.co.uk (localhost [127.0.0.1])
        by doppler.thel33t.co.uk (Postfix) with ESMTP id D7ACE20B94;
        Fri, 22 Feb 2019 08:11:01 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 08:11:01 +0000
From:   Leigh Brown <leigh@solinno.co.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?Q?Lu=C3=ADs_Mendes?= <luis.p.mendes@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common bridge
 emul code
In-Reply-To: <20190221232317.GB219879@google.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
 <20190221232317.GB219879@google.com>
Message-ID: <3ead4de3a0a5a0fe4aa5a76c92f01629@solinno.co.uk>
X-Sender: leigh@solinno.co.uk
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-02-21 23:23, Bjorn Helgaas wrote:
> On Wed, Feb 20, 2019 at 10:48:39AM +0100, Thomas Petazzoni wrote:
>> Hello,
>> 
>> This set of two patches aim at fixing some regression reported by two
>> users (Luis and Leigh), that were introduced by the conversion of the
>> pci-mvebu driver to the common PCI bridge emulation code shared
>> between pci-aardvark and pci-mvebu.
>> 
>> Due to this conversion, some registers of the PCI configuration that
>> used to be read-only are now read-write, making the Linux PCI core
>> believe that some features are implemented by the PCI bridge. Namely
>> in the case of pci-mvebu, the prefetchable memory base/limit registers
>> were read-only, while they are now read-write. Due to this, the Linux
>> PCI core now believes it can configure a prefetchable memory area, but
>> this is not supported by pci-mvebu, which does not have the logic to
>> create the appropriate MBUs windows.
>> 
>> This set of two commits allow PCI controller code to tell the PCI
>> bridge emulation logic about their capabilities. Because we envision
>> that other capabilities than prefetchable memory support might need to
>> be communicated from the PCI controller code to the PCI bridge
>> emulation code in the future, we introduce a "flags" argument, even if
>> for now only one flag is supported.
>> 
>> Lorenzo, let me know what you think about this approach. I am open to
>> suggestions if the proposed approach is not satisfying.
>> 
>> Both patches have been confirmed by Luis and Leigh to fix the
>> regression, but I'll let them give a formal Tested-by.
>> 
>> Best regards,
>> 
>> Thomas Petazzoni
>> 
>> Thomas Petazzoni (2):
>>   PCI: pci-bridge-emul: Create per-bridge copy of register behavior
>>   PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with flags
>> 
>>  drivers/pci/controller/pci-aardvark.c |  2 +-
>>  drivers/pci/controller/pci-mvebu.c    |  2 +-
>>  drivers/pci/pci-bridge-emul.c         | 86 
>> ++++++++++++++++++---------
>>  drivers/pci/pci-bridge-emul.h         | 13 +++-
>>  4 files changed, 73 insertions(+), 30 deletions(-)
> 
> Lorenzo, I assume you'll take both of these, so for both patches,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Maybe we should add a stable tag (v4.20+)?

That would be great, as it would get that kernel version working again.

Regards,

Leigh.
