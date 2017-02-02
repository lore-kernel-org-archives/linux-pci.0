Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdBBPZv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Feb 2017 10:25:51 -0500
Date: Thu, 2 Feb 2017 09:25:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sameer Nanda <snanda@google.com>,
        Kirtika Ruchandani <kirtika@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Subject: Re: Can AER correctable errors make the device inaccessible?
Message-ID: <20170202152540.GA21267@bhelgaas-glaptop.roam.corp.google.com>
References: <CACK8Z6FTHQkYKfYUAiY8ty==9gxQAFUM4Fz0PsxpuLwvHS3Z8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACK8Z6FTHQkYKfYUAiY8ty==9gxQAFUM4Fz0PsxpuLwvHS3Z8w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rajat,

On Wed, Feb 01, 2017 at 04:22:49PM -0800, Rajat Jain wrote:
> Hello,
> 
> We have a few devices out in the field and we get occasional kernel
> crash reports where the PCI device driver often complains about not
> being able to access the device (PCIe mem mapped registers read
> returns all 0xFFs). Sometimes we do see a bunch of PCIe correctable
> AER errors () in the dmesg for those devices:
> 
> [   58.527092] pcieport 0000:00:1c.0: PCIe Bus Error:
> severity=Corrected, type=Data Link Layer, id=00e0(Transmitter ID)
> [   58.527104] pcieport 0000:00:1c.0:   device [8086:0f48] error
> status/mask=00001100/00002000
> [   58.527114] pcieport 0000:00:1c.0:    [ 8] RELAY_NUM Rollover
> [   58.527123] pcieport 0000:00:1c.0:    [12] Replay Timer Timeout
> 
>  and thus we suspect that the PCIe link health may not be very good
> causing this to happen. However, a lot of times, dmesg logs are not
> available or has rolled over, and hence leaving us no good way of
> identifying if the PCIe link has been seeing issues. I can't find any
> counters or statistics in sysfs or elsewhere that can tell me what
> kind of PCIE/AER errors were seen. My questions:
> 
> 1) I'm assuming that we might not be the first ones to have to feel
> the need of such counters. Essentially I'm looking for some counters
> that can give indication of PCIe errors (and possibly categorized by
> error type) on a per device / link basis. Does something exist
> already? Does it make sense to add some counters like that (I'd be
> happy to add)?
> 
> 2) We only see the above correctable errors, and no uncorrectable
> errors. Do they look that they may be noticable by the driver? I
> looked up in the PCIe spec, and it seems that these only mean that the
> PCIe may retry the packets and hence the PCIe transaction may take a
> little longer to execute, but the transaction should not fail. Hence
> the SW should not notice anything else other than the PCIe read taking
> slightly longer than usual. I see that RELAY_NUM rollover may cause a
> link to retrain, but in that case would the pending PCIe transaction
> fail? In short can the above errors result in making a device
> inaccessible to the driver?
> 
> My understanding so far is that these correctable errors should not
> have a role (other than introducing some delay), and it may be more of
> a device firmware issue (that may have landed in a bad state thus
> returning all FFs), and will be happy to get any more pointers.

There's an open issue with AER correctable errors:
https://bugzilla.kernel.org/show_bug.cgi?id=111601

No idea whether it's related to what you're seeing, but worth checking
it out.
