Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35700 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbcGVVRl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2016 17:17:41 -0400
Received: by mail-vk0-f50.google.com with SMTP id w127so174022502vkh.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2016 14:17:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH=XD5-6QXxA42ukxJ40sOzGXqScS7u3QZAwCaCYT2r3pJxdCA@mail.gmail.com>
References: <CAH=XD5-6QXxA42ukxJ40sOzGXqScS7u3QZAwCaCYT2r3pJxdCA@mail.gmail.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 22 Jul 2016 14:17:39 -0700
Message-ID: <CAE9FiQXQNZPiWzL=hMsnQjkR7HSfbOxptFeLXWoEj30ucLSBMA@mail.gmail.com>
Subject: Re: No bus number available for hot-added bridge
To: Kallol Biswas <kallol@nucleodyne.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 15, 2016 at 1:33 PM, Kallol Biswas <kallol@nucleodyne.com> wrote:
> Hi,
>    I have been trying to hot-add a PCIe bridge and getting the
> following message in dmesg:
>
> No bus number available for hot-added bridge 0000:06:00.
>
> The kernel is 4.4. Do we have any patch for this?  I tried Yinghai's
> for-pci-busn-alloc patch. Did not work. Not sure I picked up the right
> changes.
>
> Any input...
>
> [  794.085909] pci 0000:06:00.0: [10b5:9797] type 01 class 0x060400
> [  794.086232] pci 0000:06:00.0: Max Payload Size set to 256 (was 128, max 512)
> [  794.086563] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
> [  794.086884] iommu: Adding device 0000:06:00.0 to group 47
> [  794.093797] No bus number available for hot-added bridge 0000:06:00.0


Can you please send out the whole boot log with
CONFIG_PCI_DEBUG=y ?

also output for lspci -tv and lspci -vvxxx.

Thanks

Yinghai
