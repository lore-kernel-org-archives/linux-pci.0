Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35415 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbcEMHQs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 03:16:48 -0400
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJGpV-+JYyA1g0dw_nEduhmrMEouTH03kHtuCkGSOP57Q@mail.gmail.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
	<1446642770-4681-46-git-send-email-gwshan@linux.vnet.ibm.com>
	<CAL_JsqJGpV-+JYyA1g0dw_nEduhmrMEouTH03kHtuCkGSOP57Q@mail.gmail.com>
Date: Fri, 13 May 2016 09:16:47 +0200
Message-ID: <CAMuHMdUnsDhTS5-C6_SvrqGb6hVTBZOz00=HBGhtqAQbwYv6hg@mail.gmail.com>
Subject: Re: [PATCH v7 45/50] drivers/of: Avoid recursively calling unflatten_dt_node()
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rob Herring <robherring2@gmail.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Pantelis Antoniou <panto@antoniou-consulting.com>,
	Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 4, 2015 at 5:07 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Nov 4, 2015 at 7:12 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> In current implementation, unflatten_dt_node() is called recursively
>> to unflatten device nodes in FDT blob. It's stress to limited stack
>> capacity.
>
> Did you actually hit a problem?
>
> Now we have a max depth of 64. Seems like that should be plenty... Any
> idea how this compares to when we run out of stack space?

FWIW, on arm64:

drivers/of/fdt.c:443:1: warning: the frame size of 1136 bytes is
larger than 1024 bytes [-Wframe-larger-than=]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
