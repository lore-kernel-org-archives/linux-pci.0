Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52436 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967679AbeEYSgP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 May 2018 14:36:15 -0400
Subject: Re: [PATCH v4 6/6] PCI: rcar: Shut the PHY down in failpath
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
 <20180524143624.26718-7-marek.vasut+renesas@gmail.com>
 <CAMuHMdV7Tg3pnxZ7jNhWziwQMXSEt2SihtbM_9RQbqQJc=o2Nw@mail.gmail.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <7eb5034e-c116-bf06-0db6-2c709a7bc54d@gmail.com>
Date: Fri, 25 May 2018 20:34:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV7Tg3pnxZ7jNhWziwQMXSEt2SihtbM_9RQbqQJc=o2Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/25/2018 12:09 PM, Geert Uytterhoeven wrote:
> On Thu, May 24, 2018 at 4:36 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> If anything fails past phy_init_fn() and the system is a Gen3 with
>> a PHY, the PHY will be left on and inited. This is caused by the
>> phy_init_fn, which is in fact a pointer to rcar_pcie_phy_init_gen3()
>> function, which starts the PHY, yet has no counterpart in the failpath.
>> Add that counterpart.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Note that there's another unhandled failure mode: rcar_pcie_phy_init_gen3()
> doesn't call phy_exit() if phy_power_on() fails.

Should be fixed by subsequent patch, thanks.

-- 
Best regards,
Marek Vasut
