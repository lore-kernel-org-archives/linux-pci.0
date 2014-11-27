Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:64429 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaK0Gq1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Nov 2014 01:46:27 -0500
Received: by mail-la0-f50.google.com with SMTP id pn19so2950075lab.9
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2014 22:46:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5L5bX+9PfZCFHAYmyAS9+kg9CpdQWnAy7WZLCNBm+RYSA@mail.gmail.com>
References: <CAHH3p5L5bX+9PfZCFHAYmyAS9+kg9CpdQWnAy7WZLCNBm+RYSA@mail.gmail.com>
Date: Thu, 27 Nov 2014 12:16:26 +0530
Message-ID: <CA+mB=1+5wfUDTLUWPNfZJTrqC17pq+TYOeACz2gnAvO6cghdwA@mail.gmail.com>
Subject: Re: PCIE card link up w/ or w/o device connected
From: Srikanth Thokala <sriku.linux@gmail.com>
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shiv Prakash,

On Wed, Nov 26, 2014 at 8:27 PM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Hi All,
>
> Is anybody aware of any pcie card which gets detected by root port i.e
> link is up only when any device is connected to card? For example:
> PCIE USB3 card link is up only when a usb3 device is connected to it.
>
> Is it possible at least? Or card link will always be up whether any
> device is connected to it or not?

Yes. As an example, Xilinx, Tegra root ports are able to detect link status.

- Srikanth

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
