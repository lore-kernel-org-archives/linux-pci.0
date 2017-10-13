Return-Path: <SRS0=ErCP=BM=rock-chips.com=jeffy.chen@kernel.org>
Return-Path: <SRS0=ErCP=BM=rock-chips.com=jeffy.chen@kernel.org>
Message-ID: <59E10709.4020300@rock-chips.com>
Date: Sat, 14 Oct 2017 02:33:45 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Bjorn Helgaas <helgaas@kernel.org>
CC: linux-kernel@vger.kernel.org, bhelgaas@google.com,
 Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
 briannorris@chromium.org, dianders@chromium.org,
 linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/3] PCI: rockchip: Add support for pcie wake irq
References: <20170911151029.25185-1-jeffy.chen@rock-chips.com> <20170911151029.25185-2-jeffy.chen@rock-chips.com> <20171013030441.GA25517@bhelgaas-glaptop.roam.corp.google.com> <2453698.N4jfPaHx71@aspire.rjw.lan>
In-Reply-To: <2453698.N4jfPaHx71@aspire.rjw.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On 10/13/2017 09:21 PM, Rafael J. Wysocki wrote:
>>
>>I'm a little skeptical about dev_pm_set_dedicated_wake_irq(), not
>>because I know anything at all about it, but because there are only
>>five callers in the whole tree, three of which are in UART code, and
>>none in anything resembling PCI code.
>>
>>Is Rockchip really that special, or are we going about this the wrong
>>way?

we used to put these codes in the wifi driver, but another wifi vendor 
suggests these should go into the pcie driver.

and as tony said, it could go into pcie common code :)
>>
>> > >+		if (err)
>> > >+			dev_err(dev, "failed to setup PCIe wakeup IRQ\n");
>> > >+	}
>> > >+
>> > >  	return 0;
>>
>>The above could be structured as:
>>
>>   irq = platform_get_irq_byname(pdev, "wakeup");
>>   if (irq < 0)
>>     return 0;
>>
>>   device_init_wakeup(dev, true);
>>   err = dev_pm_set_dedicated_wake_irq(dev, irq);
>>   if (err) {
>>     dev_pm_clear_wake_irq(dev);
>>     device_init_wakeup(dev, false);
>>   }
>>
there's no need to call dev_pm_clear_wake_irq when 
dev_pm_set_dedicated_wake_irq failed...and i agree the 
device_init_wakeup part, i'll add that in the next version(with brian's 
comment too)
>>   return 0;
>>
>>to unindent the mainline non-error code.
>>
>> > >  }
>> > >
>> > >@@ -1542,11 +1552,11 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>> > >
>> > >  	err = rockchip_pcie_parse_dt(rockchip);
>> > >  	if (err)
>> > >-		return err;
>> > >+		goto err_disable_wake;
>> > >
>> > >  	err = rockchip_pcie_enable_clocks(rockchip);
>> > >  	if (err)
>> > >-		return err;
>> > >+		goto err_disable_wake;
>> > >
>> > >  	err = rockchip_pcie_set_vpcie(rockchip);
>> > >  	if (err) {
>> > >@@ -1656,6 +1666,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>> > >  		regulator_disable(rockchip->vpcie0v9);
>> > >  err_set_vpcie:
>> > >  	rockchip_pcie_disable_clocks(rockchip);
>> > >+err_disable_wake:
>> > >+	dev_pm_clear_wake_irq(dev);
>> > >+	device_init_wakeup(dev, false);
>>
>>I think this error cleanup should be done in rockchip_pcie_setup_irq()
>>as shown above.  There's no real connection between
>>rockchip_pcie_probe() and the wake setup.

this error handling is like inline "rockchip_pcie_cleanup_irq()", and 
they are harmless to be called even if we don't have the wakeup irq :)
