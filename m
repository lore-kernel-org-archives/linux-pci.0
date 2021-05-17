Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8078C43460
	for <linux-pci@archiver.kernel.org>; Mon, 17 May 2021 07:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC22611ED
	for <linux-pci@archiver.kernel.org>; Mon, 17 May 2021 07:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhEQHlG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 May 2021 03:41:06 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:37723 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhEQHlG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 03:41:06 -0400
Received: by mail-ua1-f42.google.com with SMTP id p17so260531uaw.4;
        Mon, 17 May 2021 00:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4yBJ8X5FzXC0L+P0xFONg6tye0r9DGB5bUdiN73N88=;
        b=QpltYpQfcMW0upSY6hShSeAPsh9ocxY2CnOV3173HH3DU5CRkAZS5tSBTIszUppPPg
         tDD/OPDjVQuxLO9dpCBXHBrPAHAElvk5g7Jv5Kn8r4mVssUiycFncxfmarGlU6jDc+cm
         2cAYa3+IlSd/Q3vr7zYgVi7T6mpozo6YlI3Mch9LPNqXSAkI8x58rQti8LuAiy0OCjM8
         9PC6Gj3GLi8Oflste6zp9SykFVK20BOlExtYer4hUw2akv5yQzf37D5Ri+Wv55tb0rP2
         vXgIZYti9pldWoyloqXx3gHKJVTrUKS26Y1KT8iuj49EwHZHszI2xIr19n0nn89WluaN
         mSag==
X-Gm-Message-State: AOAM532Vp3owcHKMcZTKXupCS1DKb3D5qoJz8LxT5cn5e8Dc3lvqnaU0
        WLa5w4ekqsYF5mZr87oENSjti1dsInzmmZusjtU=
X-Google-Smtp-Source: ABdhPJwPWi5U2BrEuaNLB5vm/oEutLU4an+1Qd5zBejcB2eglX6gcgSRgw0P58su8+n1DikhgFemngdH4qoOCgsBPBQ=
X-Received: by 2002:ab0:2a8b:: with SMTP id h11mr28582202uar.4.1621237185486;
 Mon, 17 May 2021 00:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210514200549.431275-1-marek.vasut@gmail.com>
In-Reply-To: <20210514200549.431275-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 May 2021 09:39:33 +0200
Message-ID: <CAMuHMdXPjDav1_isZsufYFRvPj-JJA2yz2UQxXbqvCPzUzK3-g@mail.gmail.com>
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 14, 2021 at 10:06 PM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> The R-Car PCIe controller is capable of handling L0s/L1 link states.
> While the controller can enter and exit L0s link state, and exit L1
> link state, without any additional action from the driver, to enter
> L1 link state, the driver must complete the link state transition by
> issuing additional commands to the controller.
>
> The problem is, this transition is not atomic. The controller sets
> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> the PCIe card, but then the controller enters some sort of inbetween
> state. The driver must detect this condition and complete the link
> state transition, by setting L1IATN bit in PMCTLR and waiting for
> the link state transition to complete.
>
> If a PCIe access happens inside this window, where the controller
> is between L0 and L1 link states, the access generates a fault and
> the ARM 'imprecise external abort' handler is invoked.
>
> Just like other PCI controller drivers, here we hook the fault handler,
> perform the fixup to help the controller enter L1 link state, and then
> restart the instruction which triggered the fault. Since the controller
> is in L1 link state now, the link can exit from L1 link state to L0 and
> successfully complete the access.
>
> While it was suggested to disable L1 link state support completely on
> the controller level, this would not prevent the L1 link state entry
> initiated by the link partner. This happens e.g. in case a PCIe card
> enters D3Hot state, which could be initiated from pci_set_power_state()
> if the card indicates D3Hot support, which in turn means link must enter
> L1 state. So instead, fix up the L1 link state after all.
>
> Note that this fixup is applicable only to Aarch32 R-Car controllers,
> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
> V2: - Update commit message, add link to TFA repository commit
>     - Handle the LPAE case as in ARM fault.c and fsr-{2,3}level.c
>     - Cache clock and check whether they are enabled before register
>       access
> V3: - Fix commit message according to spellchecker
>     - Use of_find_matching_node() to apply hook only on Gen1 and Gen2 RCar
>       (in case the kernel is multiplatform)
> V4: - Mark rcar_pcie_abort_handler_of_match with __initconst
> V5: - Add mutex around rcar_pcie_aarch32_abort_handler()

[from my v5 comments] spinlock (used as a mutex ;-)

>     - Update commit message again to point out issues with L1/D3Hot states
> V6: - Return 1 only if condition cannot be fixed

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
