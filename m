Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk1-f173.google.com ([209.85.222.173]:45354 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeIEKza (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Sep 2018 06:55:30 -0400
Received: by mail-qk1-f173.google.com with SMTP id z125-v6so4139436qkb.12
        for <linux-pci@vger.kernel.org>; Tue, 04 Sep 2018 23:26:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180828095722.GA8820@al>
References: <CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com>
 <20180824154212.GB8601@al> <CAD8Lp45D6=pqsgr_tXS08pE0dbG1XhcwnDB3mGZQ=P3ETxywzw@mail.gmail.com>
 <20180828095722.GA8820@al>
From: Daniel Drake <drake@endlessm.com>
Date: Wed, 5 Sep 2018 14:26:51 +0800
Message-ID: <CAD8Lp461TW7KvSv2N-k=_vkg54F-AYixHr+uAsCo+Gh=0zEPNQ@mail.gmail.com>
Subject: Re: [Nouveau] Rewriting Intel PCI bridge prefetch base address bits
 solves nvidia graphics issues
To: Peter Wu <peter@lekensteyn.nl>
Cc: linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 28, 2018 at 5:57 PM, Peter Wu <peter@lekensteyn.nl> wrote:
> Only non-bridge devices can be passed to a guest, but perhaps logging
> access to the emulated bridge is already sufficient. The Prefetchable
> Base Upper 32 Bits register is at offset 0x28.
>
> In a trace where the Nvidia device is disabled/enabled via Device
> Manager, I see writes on the enable path:
>
>     2571@1535108904.593107:rp_write_config (ioh3420, @0x28, 0x0, len=0x4)

Did you do anything special to get an emulated bridge included in this setup?

Folllowing the instructions at
https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF I can
successfully pass through devices to windows running under
virt-manager. In the nvidia GPU case I haven't got passed the driver
installation failure, but I can pass through other devices OK and
install their drivers.

However I do not end up with any PCI-to-PCI bridges in this setup. The
passed through device sits at address 00:08.0, parent is the PCI host
bridge 00:00.0.

(I'm trying to spy if Windows appears to restore or reset the PCI
bridge prefetch registers upon resume)

Thanks
Daniel
