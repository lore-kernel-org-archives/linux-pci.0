Return-Path: <SRS0=dHkj=IX=gmail.com=hkallweit1@kernel.org>
Return-Path: <SRS0=dHkj=IX=gmail.com=hkallweit1@kernel.org>
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
To: Bjorn Helgaas <helgaas@kernel.org>, Ryankao <ryankao@realtek.com>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>,
 "jrg.otte@gmail.com" <jrg.otte@gmail.com>, David Miller
 <davem@davemloft.net>, Hayes Wang <hayeswang@realtek.com>,
 "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>,
 Linux Netdev List <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Hau <hau@realtek.com>, linux-pci@vger.kernel.org
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
 <9D9E2AF1-CD59-425B-85E9-DB89D620CA67@canonical.com>
 <B01FA80E1422A647BEB597328C544223D30B8F90@RTITMBSV05.realtek.com.tw>
 <20180605172805.GD30381@bhelgaas-glaptop.roam.corp.google.com>
 <20180605191142.GA214338@bhelgaas-glaptop.roam.corp.google.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <6c6b579a-5be4-ccc0-f64c-9998e51145f5@gmail.com>
Date: Tue, 5 Jun 2018 21:17:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180605191142.GA214338@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 05.06.2018 21:11, Bjorn Helgaas wrote:
> [+cc linux-pci]
> 
> On Tue, Jun 05, 2018 at 12:28:05PM -0500, Bjorn Helgaas wrote:
>> On Tue, Jun 05, 2018 at 06:34:09AM +0000, Ryankao wrote:
>>> Add realtek folk Hau
>>>
>>> -----Original Message-----
>>> From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com] 
>>> Sent: Tuesday, June 05, 2018 1:02 PM
>>> To: jrg.otte@gmail.com
>>> Cc: David Miller <davem@davemloft.net>; Hayes Wang <hayeswang@realtek.com>; hkallweit1@gmail.com; romieu@fr.zoreil.com; Linux Netdev List <netdev@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Ryankao <ryankao@realtek.com>
>>> Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
>>>
>>> Hi Jörg Otte,
>>>
>>> Can you give this patch a try?
>>>
>>> Since you are the only one that reported ALDPS/ASPM regression,
>>>
>>> And I think this patch should solve the issue you had [1].
>>>
>>> Hopefully we don't need to go down the rabbit hole of blacklist/whitelist...
>>>
>>> Kai-Heng
>>>
>>> [1] https://lkml.org/lkml/2013/1/5/36
>>
>> I have no idea what ALDPS is.  It's not mentioned in the PCIe spec, so
>> presumably it's some Realtek-specific thing.  ASPM is a generic PCIe
>> thing.  Changes to these two things should be in separate patches so
>> they don't get tangled up.
>>
ALDPS = Advanced Link Down Power Saving
And yes, it's a Realtek feature.

>>>> On Jun 5, 2018, at 12:58 PM, Kai-Heng Feng 
>>>> <kai.heng.feng@canonical.com>
>>>> wrote:
>>>>
>>>> This patch reinstate ALDPS and ASPM support on r8169.
>>>>
>>>> On some Intel platforms, ASPM support on r8169 is the key factor to 
>>>> let Package C-State achieve PC8. Without ASPM support, the deepest 
>>>> Package C-State can hit is PC3. PC8 can save additional ~3W in 
>>>> comparison with PC3.
>>>>
>>>> This patch is from Realtek.
>>>>
>>>> Fixes: e0c075577965 ("r8169: enable ALDPS for power saving")
>>>> Fixes: d64ec841517a ("r8169: enable internal ASPM and clock request
>>>> settings")
>>
>>>> +3507,15 @@ static void rtl8168e_1_hw_phy_config(struct 
>>>> rtl8169_private *tp)
>>>>  	rtl_writephy(tp, 0x0d, 0x4007);
>>>>  	rtl_writephy(tp, 0x0e, 0x0000);
>>>>  	rtl_writephy(tp, 0x0d, 0x0000);
>>>> +
>>>> +	/* Check ALDPS bit, disable it if enabled */
>>>> +	rtl_writephy(tp, 0x1f, 0x0000);
>>>> +	if (enable_aldps)
>>>> +		rtl_w0w1_phy(tp, 0x15, 0x1000, 0x0000);
>>>> +	else if (rtl_readphy(tp, 0x15) & 0x1000)
>>>> +		rtl_w0w1_phy(tp, 0x15, 0x0000, 0x1000);
>>
>> There's a lot of repetition of this code with minor variations.  You
>> could probably factor it out and make it more concise and more
>> readable.
>>
>>>> +static void rtl8169_check_link_status(struct net_device *dev,
>>>> +				      struct rtl8169_private *tp) {
>>>> +	struct device *d = tp_to_dev(tp);
>>>> +
>>>> +	if (tp->link_ok(tp)) {
>>>> +		rtl_link_chg_patch(tp);
>>>> +		/* This is to cancel a scheduled suspend if there's one. */
>>>> +		if (pm_request_resume(d))
>>>> +			_rtl_reset_work(tp);
>>>> +		netif_carrier_on(dev);
>>>> +		if (net_ratelimit())
>>>> +			netif_info(tp, ifup, dev, "link up\n");
>>>> +	} else {
>>>> +		netif_carrier_off(dev);
>>>> +		netif_info(tp, ifdown, dev, "link down\n");
>>>> +		pm_runtime_idle(d);
>>>> +	}
>>>> +}
>>
>> This function apparently just got moved around without changing
>> anything.  That's fine, but the move should be in a separate patch to
>> make the real changes easier to review.
>>
>>>> @@ -7649,8 +7757,12 @@ static int rtl_init_one(struct pci_dev *pdev, 
>>>> const struct pci_device_id *ent)
>>>>
>>>>  	/* disable ASPM completely as that cause random device stop working
>>>>  	 * problems as well as full system hangs for some PCIe devices users */
>>>> -	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |
>>>> -				     PCIE_LINK_STATE_CLKPM);
>>>> +	if (!enable_aspm) {
>>>> +		pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
>>>> +					     PCIE_LINK_STATE_L1 |
>>>> +					     PCIE_LINK_STATE_CLKPM);
>>>> +		netif_info(tp, probe, dev, "ASPM disabled\n");
>>>> +	}
>>
>> ASPM is a generic PCIe feature that should be configured by the PCI
>> core without any help from the device driver.
>>
>> If code in the driver is needed, that means either the PCI core is
>> doing it wrong and we should fix it there, or the device is broken and
>> the driver is working around the erratum.
>>
>> If this is an erratum, you should include details about exactly what's
>> broken and (ideally) a URL to the published erratum.  Otherwise this
>> is just unmaintainable black magic and likely to be broken by future
>> ASPM changes in the PCI core.
>>
>> ASPM configuration is done by the PCI core before drivers are bound to
>> the device.  If you need device-specific workarounds, they should
>> probably be in quirks so they're done before the core does that ASPM
>> configuration.
>>
>>>>  	/* enable device (incl. PCI PM wakeup and hotplug setup) */
>>>>  	rc = pcim_enable_device(pdev);
>>>> --
>>>> 2.17.0
>>>
>>> ------Please consider the environment before printing this e-mail.
> 
