Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33956 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbbJIEOO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 00:14:14 -0400
Received: by vkat63 with SMTP id t63so44369438vka.1
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2015 21:14:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKAYmMKumZTG9e_PzBtW1Jbo+0EvHVtY_XyFiZ=jnBVstkA-dw@mail.gmail.com>
References: <CAKAYmMKumZTG9e_PzBtW1Jbo+0EvHVtY_XyFiZ=jnBVstkA-dw@mail.gmail.com>
Date: Thu, 8 Oct 2015 21:14:13 -0700
Message-ID: <CAE9FiQX0rsS+Z9n8zn6-wEwZTf1J4LHXKfsApjNLwWmiHO_Gdg@mail.gmail.com>
Subject: Re: what code generates this message?
From: Yinghai Lu <yinghai@kernel.org>
To: Chuck Tuffli <ctuffli@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 8, 2015 at 4:30 PM, Chuck Tuffli <ctuffli@gmail.com> wrote:
> As part of trying to understand a hardware issue, I'm trying to track
> down the kernel code which prints:
>
> [ 1077.119096] pcieport 0000:00:02.0: PCI bridge to [bus 02-02]
> [ 1077.119098] pcieport 0000:00:02.0:   bridge window [io  disabled]
> [ 1077.119101] pcieport 0000:00:02.0:   bridge window [mem disabled]
> [ 1077.119104] pcieport 0000:00:02.0:   bridge window [mem pref disabled]
>
> to the system log / dmesg. Grep'ing the kernel source for strings such
> as "PCI bridge to" or "bridge window" hasn't turned up any candidates.
> Can someone point me in the right direction? TIA.
>

should be pci_setup_bridge() or pci_read_bridge_bases()

        Yinghai
