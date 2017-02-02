Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f179.google.com ([209.85.213.179]:34655 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdBBAXb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2017 19:23:31 -0500
Received: by mail-yb0-f179.google.com with SMTP id j82so198202ybg.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Feb 2017 16:23:31 -0800 (PST)
MIME-Version: 1.0
From: Rajat Jain <rajatja@google.com>
Date: Wed, 1 Feb 2017 16:22:49 -0800
Message-ID: <CACK8Z6FTHQkYKfYUAiY8ty==9gxQAFUM4Fz0PsxpuLwvHS3Z8w@mail.gmail.com>
Subject: Can AER correctable errors make the device inaccessible?
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Sameer Nanda <snanda@google.com>,
        Kirtika Ruchandani <kirtika@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

We have a few devices out in the field and we get occasional kernel
crash reports where the PCI device driver often complains about not
being able to access the device (PCIe mem mapped registers read
returns all 0xFFs). Sometimes we do see a bunch of PCIe correctable
AER errors () in the dmesg for those devices:

[   58.527092] pcieport 0000:00:1c.0: PCIe Bus Error:
severity=Corrected, type=Data Link Layer, id=00e0(Transmitter ID)
[   58.527104] pcieport 0000:00:1c.0:   device [8086:0f48] error
status/mask=00001100/00002000
[   58.527114] pcieport 0000:00:1c.0:    [ 8] RELAY_NUM Rollover
[   58.527123] pcieport 0000:00:1c.0:    [12] Replay Timer Timeout

 and thus we suspect that the PCIe link health may not be very good
causing this to happen. However, a lot of times, dmesg logs are not
available or has rolled over, and hence leaving us no good way of
identifying if the PCIe link has been seeing issues. I can't find any
counters or statistics in sysfs or elsewhere that can tell me what
kind of PCIE/AER errors were seen. My questions:

1) I'm assuming that we might not be the first ones to have to feel
the need of such counters. Essentially I'm looking for some counters
that can give indication of PCIe errors (and possibly categorized by
error type) on a per device / link basis. Does something exist
already? Does it make sense to add some counters like that (I'd be
happy to add)?

2) We only see the above correctable errors, and no uncorrectable
errors. Do they look that they may be noticable by the driver? I
looked up in the PCIe spec, and it seems that these only mean that the
PCIe may retry the packets and hence the PCIe transaction may take a
little longer to execute, but the transaction should not fail. Hence
the SW should not notice anything else other than the PCIe read taking
slightly longer than usual. I see that RELAY_NUM rollover may cause a
link to retrain, but in that case would the pending PCIe transaction
fail? In short can the above errors result in making a device
inaccessible to the driver?

My understanding so far is that these correctable errors should not
have a role (other than introducing some delay), and it may be more of
a device firmware issue (that may have landed in a bad state thus
returning all FFs), and will be happy to get any more pointers.

Thanks,

Rajat
