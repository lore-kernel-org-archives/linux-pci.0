Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33182 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbbD0SWa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2015 14:22:30 -0400
Received: by oica37 with SMTP id a37so96521840oic.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 11:22:30 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 27 Apr 2015 11:22:30 -0700
Message-ID: <CABLseQ7Vog4YgCwhrVhqmp-8h84f2qbTog=nPYKzc4ZE8pvHhw@mail.gmail.com>
Subject: Endpoint-to-Endpoint communication - Handshake Problem Enumeration
From: Barry Grussling <barry@grussling.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Everyone,

I am working on a device with a PLX PCIe switch and multiple
PCIe endpoints enumerated off an ARM RP.  I am playing with
endpoint-to-endpoint communications.  I have verified after
the PCIe bus is enumerated that I can send TLPs from
one endpoint to an enumerated BAR on another endpoint
and the TLP is directed to the other endpoint.  I have further
verified that the RP receivies nothing as desired.

The issue I am looking for some advice on is how to tell
each endpoint what all the other endpoints BAR address is.
For the sake of argument, lets say I have N modules and
each module needs to know the enumerated endpoint
address of the other N-1 modules Bar0 address.

The brute force/prototype method I have been testing is
scrape /proc/iomem after enumeration and write to each
card's registers via /dev/mem the address of all other
cards.  This works, but is not something I would put
on my resume.  I am now trying to "do it right".  This
scraping also assumes bus addresses and host addresses
are the same.  This seems to be true on my architecture.

My preliminary driver design has a common base layer
that each endpoint's driver registers with when it is probed.
After the BAR addresses are assigned the endpoint driver
tells the common base layer its assigned address and
the base layer writes that into registers in all the
other registered endpoints via their respective drivers.

Before I go off boldly and and completely re-invent the
wheel I was wondering if something like this had
been contemplated or created yet, perhaps via
callback hooks or some other PCIe framework
thingy I am not aware of.  Or is there another way
to achieve the same goal?

Anyone have any feedback?

Thanks for your time!

Barry
