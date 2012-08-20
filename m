Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53277 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468Ab2HTOEy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2012 10:04:54 -0400
Received: by lbbgj3 with SMTP id gj3so3314216lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 07:04:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5031EA55.4030503@extricom.com>
References: <5031EA55.4030503@extricom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 Aug 2012 07:04:32 -0700
Message-ID: <CAErSpo4C4TOUf+DVwHY8agvP8s9q_c-F0nZY4OP1pbJedGY7Jg@mail.gmail.com>
Subject: Re: p4080DS board and myri10gi
To: leonid <leonid@extricom.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2012 at 1:42 AM, leonid <leonid@extricom.com> wrote:
> Hi
> This is my first mail in this group , so I hope this is the right place for
> it.
>
> I am testing myri10ge pci-e (10G ethernet card) on p4080 evaluation board.
> using kernel 2.6.34.6
> when I am trying to insert myri10ge kernel module, I getting :
> "myri10ge: Version 1.5.2-1.459
> myri10ge 0001:03:00.0: invalid sram_size -33B or board span 16777216B "
>
> it is looks like sram_size value is garbage read from the device .
>
> any idea ?
>
> reference:
> myri10ge - https://www.myricom.com
> p4080ds -
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=P4080DS

This list is primarily concerned with issues in the Linux PCI core,
not directly with drivers.

It looks like the device has a 16MB BAR and the driver ioremapped it
successfully.  After that, the PCI core is pretty much out of the way.

The driver has this email address at the top: <help@myri.com>; maybe
they'd have some ideas.

Bjorn
