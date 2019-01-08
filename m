Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75034C43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 16:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425DF21019
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 16:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546963624;
	bh=WXcE22ZPmi0Q9lnIYuh8ycXYppaxe7mke/zDxMMwRkM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-ID:From;
	b=fDV5NJuNTevfi7HQ4N9hwGKfvk9WNhBidGRBmRYEBLUPKmwEcku6q9KWtzwb2F9m7
	 UJAnKoKceOGwu7AJ0fp/ymbLRwusM0ogEhtJzU/+JK+TWSHAQNBsJ6vuXd/ESZIxFA
	 +LHdFB/YLu0WaJBQA1INCJPoXArLkmDhy1NMuJ/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfAHQHD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbfAHQHD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 11:07:03 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154CC214C6;
        Tue,  8 Jan 2019 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546963622;
        bh=WXcE22ZPmi0Q9lnIYuh8ycXYppaxe7mke/zDxMMwRkM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=04pe4voBK+s/3po4W2PzB2Q49eV+/fgPiu9xVWO+gZznKJOFyNFu9oZWSb+yByOGa
         V47Z27/sW0OrVnySt8gOWkNIKeq+bhbFGmAcXP6NsSAcJ2uZQzLV3WCTF47Yu/zLiF
         O4C70bx/QlA9Kr98pzxZY2mOmTl06cNS6avmZM1s=
Received: by mail-oi1-f179.google.com with SMTP id m6so3696276oig.11;
        Tue, 08 Jan 2019 08:07:02 -0800 (PST)
X-Gm-Message-State: AJcUukcHmcehGL9ICSKzcxUm+VF/I5QyXkOjqFnw9aqfmcTwbKRyubS9
        +lQpK+dTlbfbHIp4aflmxdHHZJCu4IP1ZEDhcqo=
X-Google-Smtp-Source: ALg8bN7o2ijn07aIe3azvMyGFtNz1M7Fb1aMsJPyAVa3LHZTqfqhgcFStE4SvzKFwOn4tYuXRFhimwojuQ+d5ru5xSM=
X-Received: by 2002:aca:c312:: with SMTP id t18mr1583284oif.92.1546963621320;
 Tue, 08 Jan 2019 08:07:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:2755:0:0:0:0:0 with HTTP; Tue, 8 Jan 2019 08:07:00 -0800 (PST)
In-Reply-To: <9af7993d-9d61-6488-3c97-a4126ffed07c@molgen.mpg.de>
References: <3a1c95bb-9986-663d-09a1-8c7e84d0a7a7@molgen.mpg.de>
 <6ba074cd-bd1b-3844-8a3b-b0cfb34e24bc@linux.intel.com> <9af7993d-9d61-6488-3c97-a4126ffed07c@molgen.mpg.de>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Tue, 8 Jan 2019 11:07:00 -0500
X-Gmail-Original-Message-ID: <CAK9iUCMNC2SdEwmQjqmzKD5d3ats9ZcW4wqbi6jHb6U=aExu4w@mail.gmail.com>
Message-ID: <CAK9iUCMNC2SdEwmQjqmzKD5d3ats9ZcW4wqbi6jHb6U=aExu4w@mail.gmail.com>
Subject: Re: [PATCH] drm: Require PCI for selecting VGA_ARB.
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/8/19, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> Dear Maarten,
>
>
> Thank you very much for the quick response.
>
> On 01/08/19 16:37, Maarten Lankhorst wrote:
>> Op 08-01-2019 om 16:07 schreef Paul Menzel:
>
>>> Building Linux 5.0-rc1 fails with the errors below. Please find the
>>> configuration file attached.
>>>
>>> ```
>>> $ make -j120
>>> [=E2=80=A6]
>>> drivers/gpu/vga/vgaarb.c: In function =E2=80=98__vga_tryget=E2=80=99:
>>> drivers/gpu/vga/vgaarb.c:286:14: error: =E2=80=98PCI_VGA_STATE_CHANGE_D=
ECODES=E2=80=99
>>> undeclared (first use in this function); did you mean
>>> =E2=80=98PCI_SUBTRACTIVE_DECODE=E2=80=99?
>>>      flags |=3D PCI_VGA_STATE_CHANGE_DECODES;
>>>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>               PCI_SUBTRACTIVE_DECODE
>>> drivers/gpu/vga/vgaarb.c:286:14: note: each undeclared identifier is
>>> reported only once for each function it appears in
>>>   CC [M]  net/netfilter/xt_realm.o
>>>   CC      drivers/hid/hid-cherry.o
>>> drivers/gpu/vga/vga_switcheroo.c: In function
>>> =E2=80=98vga_switcheroo_runtime_suspend=E2=80=99:
>>> drivers/gpu/vga/vga_switcheroo.c:1053:2: error: implicit declaration of
>>> function =E2=80=98pci_bus_set_current_state=E2=80=99; did you mean =E2=
=80=98__set_current_state=E2=80=99?
>>> [-Werror=3Dimplicit-function-declaration]
>>>   pci_bus_set_current_state(pdev->bus, PCI_D3cold);
>>>   ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>   __set_current_state
>>> drivers/gpu/vga/vgaarb.c:291:13: error: =E2=80=98PCI_VGA_STATE_CHANGE_B=
RIDGE=E2=80=99
>>> undeclared (first use in this function); did you mean
>>> =E2=80=98PCI_VGA_STATE_CHANGE_DECODES=E2=80=99?
>>>     flags |=3D PCI_VGA_STATE_CHANGE_BRIDGE;
>>>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>              PCI_VGA_STATE_CHANGE_DECODES
>>>   CC      fs/reiserfs/dir.o
>>>   LD [M]  net/tipc/tipc.o
>>> drivers/gpu/vga/vga_switcheroo.c: In function
>>> =E2=80=98vga_switcheroo_runtime_resume=E2=80=99:
>>> drivers/gpu/vga/vga_switcheroo.c:1067:2: error: implicit declaration of
>>> function =E2=80=98pci_wakeup_bus=E2=80=99; did you mean =E2=80=98__wake=
_up_bit=E2=80=99?
>>> [-Werror=3Dimplicit-function-declaration]
>>>   pci_wakeup_bus(pdev->bus);
>>>   ^~~~~~~~~~~~~~
>>>   __wake_up_bit
>>> drivers/gpu/vga/vgaarb.c:293:3: error: implicit declaration of function
>>> =E2=80=98pci_set_vga_state=E2=80=99; did you mean =E2=80=98pci_set_powe=
r_state=E2=80=99?
>>> [-Werror=3Dimplicit-function-declaration]
>>>    pci_set_vga_state(conflict->pdev, false, pci_bits, flags);
>>>    ^~~~~~~~~~~~~~~~~
>>>    pci_set_power_state
>>>   CC      fs/read_write.o
>>>   CC      drivers/hid/hid-chicony.o
>>>   CC      drivers/hid/hid-cypress.o
>>> drivers/gpu/vga/vgaarb.c: In function =E2=80=98vga_arb_device_init=E2=
=80=99:
>>> drivers/gpu/vga/vgaarb.c:1495:25: error: =E2=80=98pci_bus_type=E2=80=99=
 undeclared (first
>>> use in this function); did you mean =E2=80=98pci_pcie_type=E2=80=99?
>>>   bus_register_notifier(&pci_bus_type, &pci_notifier);
>>>                          ^~~~~~~~~~~~
>>>                          pci_pcie_type
>>> cc1: some warnings being treated as errors
>>> make[3]: *** [scripts/Makefile.build:277: drivers/gpu/vga/vgaarb.o] Err=
or
>>> 1
>>> make[3]: *** Waiting for unfinished jobs....
>>> [=E2=80=A6]
>>> ```
>
>> WARNING: unmet direct dependencies detected for VGA_ARB
>>   Depends on [n]: HAS_IOMEM [=3Dy] && PCI [=3Dn] && !S390
>>   Selected by [y]:
>>   - VGA_SWITCHEROO [=3Dy] && HAS_IOMEM [=3Dy] && X86 [=3Dy] && ACPI [=3D=
y]
>>
>> So I guess you need to enable PCI, probably not a common config you're
>> using. :)
>>
>> Especially since you selected EXPERT.
>
> We have the attached defconfig, which is then integrated using
> `make olddefconfig`.
>
>> Oh well, apply this with git am --scissors?
>> -----8<----
>> When configuring the kernel without PCI we can still enable VGA
>> switcheroo,
>> which is not possible because VGA_ARB cannot be selected.
>>
>> Remove this by depending on PCI for !S390.
>>
>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> ---
>> diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
>> index b677e5d524e6..ef5671475870 100644
>> --- a/drivers/gpu/vga/Kconfig
>> +++ b/drivers/gpu/vga/Kconfig
>> @@ -21,6 +21,7 @@ config VGA_SWITCHEROO
>>  	bool "Laptop Hybrid Graphics - GPU switching support"
>>  	depends on X86
>>  	depends on ACPI
>> +	depends on (PCI && !S390) # For VGA_ARB
>>  	select VGA_ARB
>>  	help
>>  	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer
>
> Is this an effect of commit eb01d42a (PCI: consolidate PCI config entry i=
n
> drivers/pci) as the `default y` is missing now?
>

See this :

https://patchwork.kernel.org/patch/10749209/

This change is about to go in.

>
> Kind regards,
>
> Paul
>
