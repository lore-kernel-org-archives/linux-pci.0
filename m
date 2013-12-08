Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:39510 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab3LHDki (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Dec 2013 22:40:38 -0500
Received: by mail-ig0-f177.google.com with SMTP id uy17so483633igb.4
        for <linux-pci@vger.kernel.org>; Sat, 07 Dec 2013 19:40:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52A3DE0B.7020809@servergy.com>
References: <52A26913.6030604@servergy.com>
	<52A3DE0B.7020809@servergy.com>
Date: Sat, 7 Dec 2013 19:40:38 -0800
Message-ID: <CAE9FiQXARiFtrD6Eh3QKtnaEr1ZXKL7zTiMdcQgnm30Ch5Gosg@mail.gmail.com>
Subject: Re: Question: 2 PCIE controllers
From: Yinghai Lu <yinghai@kernel.org>
To: Ruchika <ruchika.k@servergy.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 7, 2013 at 6:48 PM, Ruchika <ruchika.k@servergy.com> wrote:
>
> Hi,
> I am working with an Soc with 3 PCIE controllers.
> I need to have 2 configured.
>
> In uboot I have no problems scanning and discovering what is connected
> to both bridges PCIE1 and PCIE2
>
> For both uboot sets up the Primary, secondary and Subordinate bus
> numbers to 0,1,1 respectively.
>
> When linux boots up and probes the controllers, PCIE1 is probed and the
> bridge scanned properly but PCIE2 is probed at the bridge but not
> attempted a scan.
> I see this message
> "pci 0001:02:00.0: bridge configuration invalid ([bus 01-01]), reconfiguring
> "
>
> I updated uboot to set the secondary and subordinate numbers to 2 (left
> the primary number to 0) and a subsequent kernel boot scanned the bus
> for PCIE2 successfully.
> I found these numbers to be very critical since the device tree blob
> (bus-range) for pci is also based off these.
>
> I'd like to get a good fix and get better understanding of the problem.
> If there are any pointers someone could provide it would be awesome.

So keep bus range correct from uboot before hand it to kernel.

Thanks

Yinghai
