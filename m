Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:60606 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab2GJSWK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 14:22:10 -0400
Received: by vcbf11 with SMTP id f11so210620vcb.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 11:22:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF15EE971A.73D0AED3-ONC1257A37.005D93BD-C1257A37.00601BF9@transmode.se>
References: <OF15EE971A.73D0AED3-ONC1257A37.005D93BD-C1257A37.00601BF9@transmode.se>
Date: Tue, 10 Jul 2012 11:22:09 -0700
Message-ID: <CAE9FiQV3-x64CbkPGVDNLzDkiuteQyvxpU56U_paVbyXavifmQ@mail.gmail.com>
Subject: Re: PICe hotplug problems
From: Yinghai Lu <yinghai@kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 10, 2012 at 10:29 AM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
>
> I got an PCIe device that is woken up by user space, clocks needs to configured in various ways before the
> device enables its PCIe interface.
>
> The device is connected to a built in root bridge on a P2010(mpc85xx) CPU.
> To enable HP in Linux we need to apply some minor hacks.

can you post lspci -vvxxx -s BB:DD:F of the two devices?

Yinghai
