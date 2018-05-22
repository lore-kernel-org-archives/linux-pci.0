Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38874 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbeEVIKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 04:10:05 -0400
MIME-Version: 1.0
In-Reply-To: <20180521220514.30256-1-marek.vasut+renesas@gmail.com>
References: <20180521220514.30256-1-marek.vasut+renesas@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 22 May 2018 10:10:04 +0200
Message-ID: <CAK8P3a1PZ_MfgEcvWdUbN-eCcs5Xo38LQ54imLc4kNtSKO9Txw@mail.gmail.com>
Subject: Re: [PATCH][RFC] PCI: rcar: Add bus notifier so we can limit the DMA range
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 12:05 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>
> The PCIe DMA controller on RCar Gen2 and earlier is on 32bit bus,
> so limit the DMA range to 32bit.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> ---
> NOTE: I'm aware of https://patchwork.kernel.org/patch/9495895/ , but the
>       discussion seems to have gone way off, so I'm sending this as a
>       RFC. Any feedback on how to do this limiting properly would be nice.

Doing it in the driver is clearly not appropriate, we must do this in
common code. If I remember correctly, it's specifically ARM64 that is
broken here, it incorrectly allows setting a DMA mask to 64 bit
when that is not available.

      Arnd
