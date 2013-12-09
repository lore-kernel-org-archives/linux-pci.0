Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57758 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766Ab3LIRRM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 12:17:12 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so6594746iec.33
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 09:17:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52A3DE0B.7020809@servergy.com>
References: <52A26913.6030604@servergy.com> <52A3DE0B.7020809@servergy.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Dec 2013 10:11:29 -0700
Message-ID: <CAErSpo7h7JjCtef6FMkd=T9hAGSMyfATAiEGUCx6EoGU_UALcQ@mail.gmail.com>
Subject: Re: Question: 2 PCIE controllers
To: Ruchika <ruchika.k@servergy.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Sat, Dec 7, 2013 at 7:48 PM, Ruchika <ruchika.k@servergy.com> wrote:
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

Linux is not very good at reconfiguring bridges, as you've discovered.
 If the firmware or boot loader leaves things correctly configured,
Linux usually won't mess it up, but we may not be able to configure
things from scratch.  That's why Yinghai suggested having uboot set
things up beforehand.  That's not a very satisfactory answer, but it
is probably the easiest short-term solution.

In the longer term, it'd be nice if somebody would fix Linux to handle
this correctly, and one way to help that along would be to file a bug
at http://bugzilla.kernel.org in the drivers/PCI category, and attach
a complete dmesg log showing the problem.  If you can include a log or
other info about how uboot enumerates everything, that would also
help.

Bjorn
