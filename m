Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.182]:64358 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754085AbdJIPXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2017 11:23:44 -0400
Received: from 1e1ZjX-00023e-VO by out6a.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1e1ZjY-00025D-TI
        for linux-pci@vger.kernel.org; Mon, 09 Oct 2017 08:12:44 -0700
Received: from [156.67.243.126] (helo=AcuExch.aculab.com)
        by out6a.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1e1ZjX-00023e-VO
        for linux-pci@vger.kernel.org; Mon, 09 Oct 2017 08:12:43 -0700
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Subject: PCIe error reporting
Date: Mon, 9 Oct 2017 15:12:45 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD008D9F2@AcuExch.aculab.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm trying to determine how a PCIe card we are building handles (and
hopefully recovers from) PCIe link errors.
However I'm not at all sure what I should expect the x86 Linux host to do.

The card has an Altera FPGA and I can monitor things like changes to
it's LTSSM state engine, but not quite the full operation of the PCIe logic.

I've enabled AER and lspci seems to decode most of the bits but
it looks as though something needs to detect error bits being set
log the error and then clear them.

I did a rather brutal test - shorted the TX lines after the caps.
The card's PCIe logic issued a reset to the internal logic before
bringing the PCIe link back up.
I could then read config space - but the BARs were all zero
(I think lspci reported the old values, but the -x data showed zeros).
Nothing seemed to indicate the Linux thought anything was wrong.
Not surprisingly reads returned ~0u.

I should really try a much shorter error.

On that system (XEON E5-2600) dmesg contains (retyped):
  acpi: PNP0A08:00: _OSC: platform does not support [AER]

Another system is even more 'useless', it reports "AER handled
by the firmware".
If we take the PCIe link down (even after echo 1 >sys/devices/.../remove)
something generates an NMI!

Is this all 'expected' behaviour?
Anything else I should/could be looking at?
Is there anything that will poll the AER bits for me?

	David
