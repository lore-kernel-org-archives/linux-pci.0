Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:32912 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEKRsl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2016 13:48:41 -0400
Received: by mail-vk0-f42.google.com with SMTP id o133so66876753vka.0
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2016 10:48:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH=XD5_QVjhSezg-AwO0UrEEwraX2ingWmMbJG0iewyhqbT39Q@mail.gmail.com>
References: <CAH=XD5_QVjhSezg-AwO0UrEEwraX2ingWmMbJG0iewyhqbT39Q@mail.gmail.com>
Date: Wed, 11 May 2016 13:48:40 -0400
Message-ID: <CAPoiz9xd3bKeCvk3qTbWWmvTYdD6xHLWhbnWaprQfKDujwc9BQ@mail.gmail.com>
Subject: Re: Intel NTB and a switch in between
From: Jon Mason <jdmason@kudzu.us>
To: Kallol Biswas <kallol@nucleodyne.com>
Cc: linux-ntb@googlegroups.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 9, 2016 at 6:25 PM, Kallol Biswas <kallol@nucleodyne.com> wrote:
> We have a requirement to setup intel processor NTB.
>
> We understand that NTB-NTB back to back connection works, but
> what if we put a transparent bridge (PCIe Switch) in between two NTBs?

You should consider looking at NTB-RP mode.

Thanks,
Jon

>
>
> Kallol
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/CAH%3DXD5_QVjhSezg-AwO0UrEEwraX2ingWmMbJG0iewyhqbT39Q%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
