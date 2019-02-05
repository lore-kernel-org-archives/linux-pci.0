Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16638C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 04:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEF620818
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 04:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnYpX93N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfBEEAn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 23:00:43 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46831 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBEEAm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Feb 2019 23:00:42 -0500
Received: by mail-vs1-f67.google.com with SMTP id n10so1325918vso.13;
        Mon, 04 Feb 2019 20:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43dIX06aSxg30xPFfUM+JL7KRc6hvHiBYZ/aiMUqlIY=;
        b=HnYpX93NDhznmJdy1MUcG0rHQli53ydBIElOspc8xhjfFBP1Ygwldu+M0hy0mFt8KO
         8qB5SFGBXqDgS+V7aM2YMi4oKOPRQGxNJyZ4d/9mMv9rgvZqnnVgG+L1lhsrxcG69W5e
         x8wKHh79m2ZnX38vPZKmEzVHCgqWV36Pb3jtk54ksokjuSyHllj6mHCRwn+fyISC5YwW
         XiJwDlKLyL5okIQN+YpL4iK4mUuZCJ1gEMxWdpDJZ6RirpHBfPyMocPvP1jbawHralJL
         3sZV2JEm7Kb+q9SRYDBGPA+fM+n0YYiesdr2A7WTy3BWqItauvquVS4QGiA9tO4j5vJV
         hiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43dIX06aSxg30xPFfUM+JL7KRc6hvHiBYZ/aiMUqlIY=;
        b=k2WsH9GPHm4rXYxvC99QiHs7WlDjCj3ZgGAGaOaEjipdIeNV6CA7SCIiLwxiWmJ6Ur
         nv/aYdh0nNnWbwe2PZpXRto4Or07rDqcnqtTpr8G4mOJrjEX1f8iPNWi/v7TON6TMEsy
         EZvqRoCPVfwwz7QHiOsBXum3UlP8wUCyuoTZe4AlEHZ2D2fFKRD5Mg5awjLdIQG8+Uoa
         2OMEI8YiTIJTpXO8qd5MWyNfTUlSHEYq8ueABNqW8FTuZ5jEZoMeY/cCnNgdYhK9bUTN
         nhdenUzRyD8fGH3XdfOMAV+huOVMeXIducQzNPdKvpYfWOy2eyLpIT3dOkdINUkOn89x
         cD3w==
X-Gm-Message-State: AHQUAubSwWtRQB+ZZGetIWaQ/Tp2sg/EiRWjAeIpPcwdXAMd4nyUVAz5
        v8LaxmYapdo+eAfLEME8CMh8reGRwrIKMfYqvvAOLQ==
X-Google-Smtp-Source: AHgI3IbvC62mqA2O+uMEBcMhL+fRKRA4ud2n4/MpYHC2R6Ip5kG55k+WFc3giKmbuPVoZjZxNtXhp7GSe64BDGC6R+0=
X-Received: by 2002:a67:8e8a:: with SMTP id q132mr1122441vsd.210.1549339241211;
 Mon, 04 Feb 2019 20:00:41 -0800 (PST)
MIME-Version: 1.0
References: <1548249481-24645-1-git-send-email-sundeep.lkml@gmail.com>
In-Reply-To: <1548249481-24645-1-git-send-email-sundeep.lkml@gmail.com>
From:   sundeep subbaraya <sundeep.lkml@gmail.com>
Date:   Tue, 5 Feb 2019 09:30:29 +0530
Message-ID: <CALHRZuqoA+JknbJsqcYOzyBOy-NJSGG7h9H-ZV6Qpe7puEQAiw@mail.gmail.com>
Subject: Re: [v3 PATCH 1/2] PCI: read fixed bus numbers in EA for type 1 functions
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Stalley, Sean" <sean.stalley@intel.com>, sgoutham@marvell.com,
        Bjorn Helgaas <helgaas@kernel.org>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Any comments?

Thanks,
Sundeep

On Wed, Jan 23, 2019 at 6:48 PM <sundeep.lkml@gmail.com> wrote:
>
> From: Subbaraya Sundeep <sbhatta@marvell.com>
>
> As per the spec - ECN_Enhanced_Allocation_23_Oct_2014_Final
> and section 6.9.1.2, EA capability contains fixed secondary
> and subordinate bus numbers for type 1 functions.
> This patch adds support to read the fixed bus numbers
> from EA capability for bridge.
>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v3:
>   As per Bjorn's suggestion placed EA stuff in pci_ea_init and
>   captured bus numbers in pci_dev
> v2:
>   None just added Sean
>
>  drivers/pci/pci.c             | 10 ++++++++--
>  include/linux/pci.h           |  4 ++++
>  include/uapi/linux/pci_regs.h |  4 ++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c25acac..484b63e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2909,6 +2909,7 @@ void pci_ea_init(struct pci_dev *dev)
>         u8 num_ent;
>         int offset;
>         int i;
> +       u32 dw;
>
>         /* find PCI EA capability in list */
>         ea = pci_find_capability(dev, PCI_CAP_ID_EA);
> @@ -2922,9 +2923,14 @@ void pci_ea_init(struct pci_dev *dev)
>
>         offset = ea + PCI_EA_FIRST_ENT;
>
> -       /* Skip DWORD 2 for type 1 functions */
> -       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> +       /* Note fixed bus numbers for type 1 functions */
> +       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +               pci_read_config_dword(dev, offset, &dw);
> +               dev->fixed_sec_busnr = dw & PCI_EA_FIXED_SEC_BUS;
> +               dev->fixed_sub_busnr = (dw & PCI_EA_FIXED_SUB_BUS) >>
> +                                       PCI_EA_FIXED_SUB_SHIFT;
>                 offset += 4;
> +       }
>
>         /* parse each EA entry */
>         for (i = 0; i < num_ent; ++i)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f1d8c..3e9a3ae 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -459,6 +459,10 @@ struct pci_dev {
>         char            *driver_override; /* Driver name to force a match */
>
>         unsigned long   priv_flags;     /* Private flags for the PCI driver */
> +
> +       /* bus numbers from EA capability if this device is a bridge */
> +       u8 fixed_sec_busnr; /* Fixed Secondary Bus number */
> +       u8 fixed_sub_busnr; /* Fixed Subordinate Bus number */
>  };
>
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e1e9888..51e9ac0 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -372,6 +372,10 @@
>  #define PCI_EA_FIRST_ENT_BRIDGE        8       /* First EA Entry for Bridges */
>  #define  PCI_EA_ES             0x00000007 /* Entry Size */
>  #define  PCI_EA_BEI            0x000000f0 /* BAR Equivalent Indicator */
> +/* Fixed Secondary and Subordinate bus numbers in EA for Bridge */
> +#define   PCI_EA_FIXED_SEC_BUS         0xff
> +#define   PCI_EA_FIXED_SUB_BUS         0xff00
> +#define   PCI_EA_FIXED_SUB_SHIFT       8
>  /* 0-5 map to BARs 0-5 respectively */
>  #define   PCI_EA_BEI_BAR0              0
>  #define   PCI_EA_BEI_BAR5              5
> --
> 1.8.3.1
>
