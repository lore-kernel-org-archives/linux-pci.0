Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:49173 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbaHQGUM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 17 Aug 2014 02:20:12 -0400
Received: by mail-qg0-f43.google.com with SMTP id a108so3611618qge.30
        for <linux-pci@vger.kernel.org>; Sat, 16 Aug 2014 23:20:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWe-NzAxGuYDsTBRgA=bDH5y5n5AL5awnw6s-1MwcwhAg@mail.gmail.com>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
	<1406137961-14684-4-git-send-email-l.stach@pengutronix.de>
	<CAHM4w1nMxwfk9Vv37FO6Aa4-Zbb0tgCposakVzUm66B2BZobRQ@mail.gmail.com>
	<CAE9FiQWe-NzAxGuYDsTBRgA=bDH5y5n5AL5awnw6s-1MwcwhAg@mail.gmail.com>
Date: Sun, 17 Aug 2014 11:50:11 +0530
Message-ID: <CAHM4w1kiWy407FARWyYz_1GJUbFh9jnGP+oMuWZUCfdWtdHX_Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: designware: remove pci_assign_unassigned_resources
 call
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	kernel@pengutronix.de, Pratyush ANAND <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 17, 2014 at 8:29 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Sat, Aug 16, 2014 at 6:13 AM, Pratyush Anand
> <pratyush.anand@gmail.com> wrote:
>> On Wed, Jul 23, 2014 at 11:22 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
>>
>> I am not sure here. IIRC, then calling  pci_assign_unassigned_resources after
>> pci_common_init_dev was needed to handle few PCIe cards with EP behind
>> bridge.
>>
>> I do not have good understanding of pci resource allocation code.
>> @Yinghai: Can you please help(rather teach) with the description of
>> different resource allocator
>> available in setup-bus.c. Can try reading code, but if a documentation
>> exists, that would
>> be helpful.
>
> pci_assign_unassigned_resources() should try several times to make sure
> assign resource to PCI bars that are not assigned by BIOS or not valid value
> from BIOS.
> so it will honor the setting from BIOS.
>
> in your arm case, pci_common_init_dev() is doing sizing and assign.
> so you should not need that pci_assign_unassigned_resources() anymore.
>
> Or your setup have PCI_PROBE_ONLY ?

Thanks for the clarification.

I think none of the designware based platform boots with *firmware*, so none of
the setup should have PCI_PROBE_ONLY. Then patch seems fine.

~Pratyush

>
> Yinghai
