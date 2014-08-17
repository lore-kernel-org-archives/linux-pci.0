Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38341 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbaHQC7K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Aug 2014 22:59:10 -0400
Received: by mail-ig0-f180.google.com with SMTP id l13so4997298iga.1
        for <linux-pci@vger.kernel.org>; Sat, 16 Aug 2014 19:59:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHM4w1nMxwfk9Vv37FO6Aa4-Zbb0tgCposakVzUm66B2BZobRQ@mail.gmail.com>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
	<1406137961-14684-4-git-send-email-l.stach@pengutronix.de>
	<CAHM4w1nMxwfk9Vv37FO6Aa4-Zbb0tgCposakVzUm66B2BZobRQ@mail.gmail.com>
Date: Sat, 16 Aug 2014 19:59:09 -0700
Message-ID: <CAE9FiQWe-NzAxGuYDsTBRgA=bDH5y5n5AL5awnw6s-1MwcwhAg@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: designware: remove pci_assign_unassigned_resources
 call
From: Yinghai Lu <yinghai@kernel.org>
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	kernel@pengutronix.de, Pratyush ANAND <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 16, 2014 at 6:13 AM, Pratyush Anand
<pratyush.anand@gmail.com> wrote:
> On Wed, Jul 23, 2014 at 11:22 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
>
> I am not sure here. IIRC, then calling  pci_assign_unassigned_resources after
> pci_common_init_dev was needed to handle few PCIe cards with EP behind
> bridge.
>
> I do not have good understanding of pci resource allocation code.
> @Yinghai: Can you please help(rather teach) with the description of
> different resource allocator
> available in setup-bus.c. Can try reading code, but if a documentation
> exists, that would
> be helpful.

pci_assign_unassigned_resources() should try several times to make sure
assign resource to PCI bars that are not assigned by BIOS or not valid value
from BIOS.
so it will honor the setting from BIOS.

in your arm case, pci_common_init_dev() is doing sizing and assign.
so you should not need that pci_assign_unassigned_resources() anymore.

Or your setup have PCI_PROBE_ONLY ?

Yinghai
