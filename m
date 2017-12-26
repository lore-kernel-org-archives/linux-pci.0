Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.130]:39563 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdLZBHB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Dec 2017 20:07:01 -0500
Message-ID: <5A41A0A7.5070605@rock-chips.com>
Date: Tue, 26 Dec 2017 09:06:47 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        dianders@chromium.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com> <20171225114742.18920-5-jeffy.chen@rock-chips.com> <9593014.U0c2JQdoEZ@aspire.rjw.lan>
In-Reply-To: <9593014.U0c2JQdoEZ@aspire.rjw.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

Thanks for your reply :)

On 12/26/2017 08:11 AM, Rafael J. Wysocki wrote:
>> >+
>> >+	dn = pci_device_to_OF_node(ppdev);
>> >+	if (!dn)
>> >+		return 0;
>> >+
>> >+	irq = of_irq_get_byname(dn, "wakeup");
> Why is this a property of the bridge and not of the device itself?
That is suggested by Brian, because in that way, the wakeup pin would 
not "tied to what exact device is installed (or no device, if it's a slot)."

>
>> >+	if (irq == -EPROBE_DEFER)
> Braces here, please.
ok, will fix in the next version.

>
>> >+		return irq;
>> >+	/* Ignore other errors, since a missing wakeup is non-fatal. */
>> >+	else if (irq < 0) {
>> >+		dev_info(&pdev->dev, "cannot get wakeup interrupt: %d\n", irq);
>> >+		return 0;
>> >+	}
>> >+
>> >+	device_init_wakeup(&pdev->dev, true);
> Why do you call this before dev_pm_set_dedicated_wake_irq()?
hmmm, i thought so too, but it turns out the dedicated wake irq 
framework requires device_init_wakeup(dev, true) before attach the wake irq:

int device_wakeup_attach_irq(struct device *dev,
                              struct wake_irq *wakeirq)
{
         struct wakeup_source *ws;

         ws = dev->power.wakeup;
         if (!ws) {
                 dev_err(dev, "forgot to call device_init_wakeup?\n");
                 return -EINVAL;


>
>> >+
>> >+	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, irq);
>> >+	if (ret < 0) {
>> >+		dev_err(&pdev->dev, "failed to set wake IRQ: %d\n", ret);
>> >+		device_init_wakeup(&pdev->dev, false);
>> >+		return ret;
>> >+	}
>> >+
> It would be more straightforward to call device_init_wakeup() here.
>
>> >+	return 0;
>> >+}
>> >+EXPORT_SYMBOL_GPL(of_pci_setup_wake_irq);
>> >+
>> >+void of_pci_teardown_wake_irq(struct pci_dev *pdev)
>> >+{
>> >+	if (!pdev->dev.power.wakeirq)
>> >+		return;
>> >+
>> >+	dev_pm_clear_wake_irq(&pdev->dev);
>> >+	device_init_wakeup(&pdev->dev, false);
>> >+}
>> >+EXPORT_SYMBOL_GPL(of_pci_teardown_wake_irq);
>> >+
>> >  /**
>> >   * of_irq_parse_pci - Resolve the interrupt for a PCI device
>> >   * @pdev:       the device whose interrupt is to be resolved
> Thanks,
> Rafael
>
>
>
>
