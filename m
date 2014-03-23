Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:58604 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbaCWKNV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 23 Mar 2014 06:13:21 -0400
MIME-Version: 1.0
In-Reply-To: <532C5ADE.4030708@cogentembedded.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
	<1395397968-6242-7-git-send-email-phil.edworthy@renesas.com>
	<532C5ADE.4030708@cogentembedded.com>
Date: Sun, 23 Mar 2014 11:13:20 +0100
Message-ID: <CAMuHMdVMCeZwX_67ktCYcYLe_P3+X5EeRbUDT3ZJjcgvU=Hwqg@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 21, 2014 at 4:29 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> +
>> +       pcie: pcie@fe000000 {
>> +               compatible = "renesas,r8a7790-pcie";
>
>    The convention adopted on this list is to put the "pcie" first, and SoC
> name the last.

Except for clock bindings ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
