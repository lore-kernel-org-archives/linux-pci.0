Return-Path: <SRS0=90sa=CO=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=90sa=CO=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v2 4/4] PCI/AER: Dont do recovery when DPC is enabled
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dongdong Liu <liudongdong3@huawei.com>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
 <1510721808-27164-5-git-send-email-poza@codeaurora.org>
 <20171115211447.GA7266@bhelgaas-glaptop.roam.corp.google.com>
 <16e82fb4-dda8-3790-e831-675f9a6fd388@codeaurora.org>
 <20171116201745.GB7266@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <16b9ac67-042d-1010-0c8c-205b2fa40a7f@codeaurora.org>
Date: Thu, 16 Nov 2017 15:52:47 -0500
MIME-Version: 1.0
In-Reply-To: <20171116201745.GB7266@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

>>
>> Whether the AER driver reads ~0 or not really depends on timing. The
>> link may come up from the DPC driver by the time AER driver reaches
>> here as an example.
>>
>> Bad things do happen. We have seen this with e1000e driver.
> 
> I don't doubt that bad things happen.  I'm just trying to understand
> exactly *what* bad things happen and how, so we can fix them cleanly.
> 

This was random crashes in the e1000e drivers accompanied with stack
traces coming from WARN and msi allocation routines.

> I don't know exactly what you mean by "DPC stops the drivers
> immediately".  Since the DPC hardware disables the Link, I *think*
> you probably mean that driver accesses to the device start failing
> (whether the driver notices this is a whole different question).

Sorry for not being clear.

I was talking about the pci_stop_and_remove_bus_device() call in DPC's
interrupt_event_handler() function as the "stop command".

> 
> When the DPC hardware disables the Link, it causes a hot reset for
> downstream components.  The DPC interrupt_event_handler() doesn't do
> much except remove the device (which detaches the driver) and clear
> the DPC Trigger Status bit (which allows hardware to try to retrain
> the Link).
> 

That's true.

> So the "stop" and "recover" commands you mention must be related to
> AER.  

I was talking about pci_stop_and_remove_bus_device() vs. error_detected()
as "stop" and "recover"

> I guess these would be some of the driver callbacks
> (error_detected(), mmio_enabled(), slot_reset(), reset_prepare(),
> reset_done(), resume())?
> 
> In any case, I agree that it probably doesn't make sense to call any
> of these callbacks if the DPC driver has already detached the driver
> and re-attached it.  The device state is gone because of the hot reset
> and the driver state is gone because of the detach/re-attach.
> 
> However, I'm not so sure about the period *before* the DPC driver
> detaches the driver.  The description of error_detected() says it
> cannot assume the device is accessible, so I think there might be an
> argument that AER *should* call this for DPC events so the driver has
> a chance to clean up before being unceremoniously detached.

Makes sense. Let us work on this.

> 
> I suspect this all probably requires tighter integration between DPC
> and AER, and I'm totally fine with that.  I think the current
> separation as separate "drivers" is pretty artificial anyway.

Got it. We will try to plumb DPC error handling into AER driver's error
handling mechanism.

Another question:

What do you think about the rescan following link up? The only entity
that does rescan today is hotplug after DPC recovery. There could be
a platform with DPC support but no hotplug support. 

How should we handle it?

We can call rescan from DPC all the time.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
