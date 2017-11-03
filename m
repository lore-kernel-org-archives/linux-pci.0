Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.182]:63939 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933753AbdKCRN1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2017 13:13:27 -0400
Received: from 1eAfX3-000ArO-To by out6c.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1eAfX3-000As5-Uj
        for linux-pci@vger.kernel.org; Fri, 03 Nov 2017 10:13:25 -0700
Received: from [156.67.243.126] (helo=AcuExch.aculab.com)
        by out6c.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1eAfX3-000ArO-To
        for linux-pci@vger.kernel.org; Fri, 03 Nov 2017 10:13:25 -0700
From: David Laight <David.Laight@ACULAB.COM>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Should pci_iomap_range() really truncate requests?
Date: Fri, 3 Nov 2017 17:13:45 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00AEF3F@AcuExch.aculab.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_iomap_range() (in lib/pci_iomap.c) will truncate a mapping
request to the end of the BAR.

So if a driver tries to map 8k but the BAR is only 4k only 4k
is mapped.
The driver isn't told and is likely to try to access the entire
8k of the original request.
At best this gives a fault on the access, worse the virtual
address might reference some other memory/device.

ISTM that NULL ought to be returned.
Failing that at least a message saying the request has been truncated.

It isn't even necessarily obvious that treating 0 as 'all the BAR'
is in any way safe.

If pcio_iomap_range() didn't truncate the request, there would be
a message from (somewhere inside) ioremap() that the request crossed
a BAR boundary. The map is, however, actioned 'correctly'.

(Discovered while trying to map a BAR double its length in order to
send a PCIe endpoint a TLP that was outside the actual BAR in order
to generate an AER report.)

I could cook up a patch to at generate a warning message.

	David
