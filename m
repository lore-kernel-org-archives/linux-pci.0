Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:62022 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbaGNFpQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jul 2014 01:45:16 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so3643434obc.7
        for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2014 22:45:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1404976058.git.viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
Date: Mon, 14 Jul 2014 11:15:15 +0530
Message-ID: <CAKohpomvafkZcQiqC4+FXCH8cj5PnArd3wDzvUJMPU-dgWcygA@mail.gmail.com>
Subject: Re: [PATCH V9 0/7] ARM: SPEAr13xx: Add PCIe support
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@linaro.org>, "olof@lixom.net" <olof@lixom.net>,
	Kishon <kishon@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	spear-devel <spear-devel@list.st.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Nicholson <mark@nicholnet.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10 July 2014 12:56, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This adds PCIe support for ARM based ST Microelectronics SPEAr13xx SoCs.
>
> V8 was here: https://lkml.org/lkml/2014/4/15/260 and just before being pulled by
> Olof this happened: https://lkml.org/lkml/2014/7/9/641.
>
> An detailed look at the patches make it clear why Olof was unhappy.
> Patches weren't in right order, groups, etc..
>
> So, this is an attempt to fix all those issues. Pushed here:
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git spear/pcie-support-v9

It may not be worth enough to send V10 as there aren't many updates.
I have provided proper diff's in response to the comments I got.

V10 is here:
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git
spear/pcie-support-v10

Let me know if something is still missing before I send a pull request tomorrow.

--
Viresh
