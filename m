Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191CEC10F0B
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 05:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA26D2147A
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 05:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgMmwlwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfDCFxu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:53:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53885 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbfDCFxu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 01:53:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so5927247wmj.3;
        Tue, 02 Apr 2019 22:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nJafKJJdkD6NRtC2dXcM2SENn9S/hvKoQrJFAbbXKXU=;
        b=DgMmwlwOrMzj6C4iOkqsOHiHdL+OLP0oF7EXuINMfWeBuUDYqh39HZCp/FVaJvn4gM
         0kEKyr9tQafV/gCNl7XfZcffHrVPooebXP5bK8lLIQqoSr7p2kInWYhKY/+oj4g/N3BD
         9CIvRrh8h120czO7gPw3iLMSd0ifczWoPneXCw51/Ihgn844FgGfdI01Yv08mJwvKyQa
         4+bWa6kgs9jf09wSOjOiDjBqE8IrS1TamM1KtTwmXpLNnQDRTzB9yRcS0rgpsHeZkNcY
         GutprCwBv59NnPndQl2+Q0auj5agXgiHoLReXsFy0aL/XxK8V56xO/6oswkfKfGoGq7O
         xROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJafKJJdkD6NRtC2dXcM2SENn9S/hvKoQrJFAbbXKXU=;
        b=EzGChcruR9iEVwqmVDu5KQnzPKx/qER9uXUYfGQYjZ2CtLTr7si9s8lFFu7WXVkIYs
         vZNiZiHxz6oVG6z6gj2l8sX112SQU37uA4R3spNMZdpPusd7LY+cfUzhKMFDQQSCTkY9
         6S8/T5MZs2HbyEVAleqZxCEDNI33ICjbhvo2XEhPyO1KtIv2Yu0uA+hwSyLkR/LiRnCo
         UQR/GmLvzYTS3CACzTj526FXA4isdzhfw6KWWSCX/58IPc9rdrS5NZr0M9JhQwKZpl0O
         WuHEXhxJQ7eG6WYvaOtuLI+CM85DfDEfX2HNOvsoiMM+iLgdRGo0XCDKMbNrtjlJZzAc
         PF+Q==
X-Gm-Message-State: APjAAAWmGKsT+dSqcNXgGC7PdSolajJXGUZHqF3WfDegtasZojzMv5A4
        WjeLDqGscaEf0a0QaafuvF0=
X-Google-Smtp-Source: APXvYqwlgKpBI8YQXoI17abBsP8FCrVhlDSplTbFiIEH2NAZGkI/baGMur4MIUdZxV4NmDMOYR+p3g==
X-Received: by 2002:a1c:14:: with SMTP id 20mr596744wma.66.1554270827469;
        Tue, 02 Apr 2019 22:53:47 -0700 (PDT)
Received: from ?IPv6:2003:ea:8be1:dd00:a1d8:cecd:ef87:100d? (p200300EA8BE1DD00A1D8CECDEF87100D.dip0.t-ipconnect.de. [2003:ea:8be1:dd00:a1d8:cecd:ef87:100d])
        by smtp.googlemail.com with ESMTPSA id o20sm13922670wmh.21.2019.04.02.22.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 22:53:46 -0700 (PDT)
Subject: Re: [PATCH net] r8169: switch off ASPM by default and add sysfs
 attribute to control ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
References: <275eb60f-8cfe-9ff6-97bc-39d9ef280d36@gmail.com>
 <0640ba80-519f-ab76-a86d-e42833df46fb@gmail.com>
 <4f0e0f6c-20b7-73f8-e524-9798dfbac6d9@gmail.com>
 <20190402215752.GG141706@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <436d3d44-27ab-2d4b-988e-8411b8ea3759@gmail.com>
Date:   Wed, 3 Apr 2019 07:53:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402215752.GG141706@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02.04.2019 23:57, Bjorn Helgaas wrote:
> [+cc Rajat]
> 
> On Tue, Apr 02, 2019 at 10:41:20PM +0200, Heiner Kallweit wrote:
>> On 02.04.2019 22:16, Florian Fainelli wrote:
>>> On 4/2/19 12:55 PM, Heiner Kallweit wrote:
>>>> There are numerous reports about different problems caused by ASPM
>>>> incompatibilities between certain network chip versions and board
>>>> chipsets. On the other hand on (especially mobile) systems where ASPM
>>>> works properly it can significantly contribute to power-saving and
>>>> increased battery runtime.
>>>> One problem so far to make ASPM configurable was to find an acceptable
>>>> way of configuration (e.g. module parameters are discouraged for that
>>>> purpose).
>>>>
>>>> As a new attempt let's switch off ASPM per default and make it
>>>> configurable by a sysfs attribute. The attribute is documented in
>>>> new file Documentation/networking/device_drivers/realtek/r8169.txt.
> 
> Both module parameters and sysfs attributes are a poor user
> experience.  It's very difficult for users to figure out that
> a tweak is needed.
> 
>>> I am not sure this is where it should be solved, there is
>>> definitively a device specific aspect to properly supporting the
>>> enabling of ASPM L0s, L1s etc, but the actual sysfs knobs should
>>> belong to the pci_device itself, since this is something that
>>> likely other drivers would want to be able to expose. You would
>>> probably want to work with the PCI maintainers to come up with a
>>> standard solution that applies beyond just r8169 since presumably
>>> there must be a gazillion of devices with the same issues.
> 
> The Linux PCI core support for ASPM is poor.  Without more details,
> it's impossible to tell whether these issues are hardware or firmware
> defects on the device itself, or something that Linux is doing wrong.
> There are several known defects, especially related to L1 substates
> and hotplug.
> 
The vendor refuses to release datasheets or errata. Only certain
combinations of board chipsets (and maybe BIOS versions) and network
chip versions (from the ~ 50 supported by the driver) seem to be
affected. One typical symptom is missed RX packets, maybe the RX FIFO
isn't big enough to buffer all packets until PCIe has woken up.
The Windows vendor driver uses a hack, they dynamically disable ASPM
under load.

> We already have the "pcie_aspm=off" kernel parameter.  That's
> system-wide, but maybe that's sufficient for debugging?
> 
For a lot of affected users it helped to set pcie_aspm.policy=performance.

> If we can determine that a device is broken, quirks along the lines of
> quirk_disable_aspm_l0s() are one possibility.
> 
>> Here this attribute only controls whether the device actively enters
>> ASPM states. I doesn't change anything on the other side of the
>> link.
>>
>> Maybe it would be an option to add an attribute on device level in
>> the PCI core that reflects "ASPM allowed", or even in more detail
>> which ASPM states / sub-states are acceptable. Certain support for
>> disabling ASPM states is provided by pci_disable_link_state().  Not
>> sure whether the device would have to be notified by the core that
>> certain states have been disabled. Maybe not because this is auto-
>> negotiated between the PCIe link partners.
> 
> Drivers should not be involved in ASPM except to the extent that
> there are hardware/firmware defects that mean some ASPM states should
> be disabled even though the device advertises support for them.
> 
> Some ASPM configuration requires knowledge of latencies along the
> entire path to the root complex, so it involves more than just the
> device, and it really should be done by the PCI core before the driver
> is attached.
> 
>> Based on the usage of pci_disable_link_state() not that many devices
>> seem to be effected. One good example may be Intel e1000e
>> (__e1000e_disable_aspm()).
>>
>>>>
>>>> Fixes: a99790bf5c7f ("r8169: Reinstate ASPM Support")
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  .../device_drivers/realtek/r8169.txt          | 19 +++++
>>>>  drivers/net/ethernet/realtek/r8169.c          | 75 +++++++++++++++++--
>>>>  2 files changed, 86 insertions(+), 8 deletions(-)
>>>>  create mode 100644 Documentation/networking/device_drivers/realtek/r8169.txt
>>>>
>>>> diff --git a/Documentation/networking/device_drivers/realtek/r8169.txt b/Documentation/networking/device_drivers/realtek/r8169.txt
>>>> new file mode 100644
>>>> index 000000000..669995d0c
>>>> --- /dev/null
>>>> +++ b/Documentation/networking/device_drivers/realtek/r8169.txt
>>>> @@ -0,0 +1,19 @@
>>>> +Written by Heiner Kallweit <hkallweit1@gmail.com>
>>>> +
>>>> +Version 04/02/2019
>>>> +
>>>> +Driver-specific sysfs attributes
>>>> +================================
>>>> +
>>>> +rtl_aspm (bool)
>>>> +---------------
>>>> +
>>>> +Certain combinations of network chip versions and board chipsets result in
>>>> +increased packet latency, PCIe errors, or significantly reduced network
>>>> +performance. Therefore ASPM is off by default. On the other hand ASPM can
>>>> +significantly contribute to power-saving and thus increased battery
>>>> +runtime on notebooks. Therefore this sysfs attribute allows to switch on
>>>> +ASPM on systems where ASPM works properly. The attribute accepts any form
>>>> +of bool value, e.g. 1/y/on. See also kerneldoc of kstrtobool().
>>>> +Note that the attribute is accessible only if interface is up.
>>>> +Else network chip and PCIe link may be powered-down and not reachable.
>>>> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
>>>> index 19efa88f3..e2de94dc3 100644
>>>> --- a/drivers/net/ethernet/realtek/r8169.c
>>>> +++ b/drivers/net/ethernet/realtek/r8169.c
>>>> @@ -678,6 +678,8 @@ struct rtl8169_private {
>>>>  		struct work_struct work;
>>>>  	} wk;
>>>>  
>>>> +	unsigned aspm_supported:1;
>>>> +	unsigned aspm_enabled:1;
>>>>  	unsigned irq_enabled:1;
>>>>  	unsigned supports_gmii:1;
>>>>  	dma_addr_t counters_phys_addr;
>>>> @@ -5091,7 +5093,7 @@ static void rtl_hw_start_8168e_2(struct rtl8169_private *tp)
>>>>  	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
>>>>  	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~Spi_en);
>>>>  
>>>> -	rtl_hw_aspm_clkreq_enable(tp, true);
>>>> +	tp->aspm_supported = 1;
>>>>  }
>>>>  
>>>>  static void rtl_hw_start_8168f(struct rtl8169_private *tp)
>>>> @@ -5205,7 +5207,7 @@ static void rtl_hw_start_8168g_1(struct rtl8169_private *tp)
>>>>  	/* disable aspm and clock request before access ephy */
>>>>  	rtl_hw_aspm_clkreq_enable(tp, false);
>>>>  	rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
>>>> -	rtl_hw_aspm_clkreq_enable(tp, true);
>>>> +	tp->aspm_supported = 1;
>>>>  }
>>>>  
>>>>  static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
>>>> @@ -5240,7 +5242,7 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>>>  	/* disable aspm and clock request before access ephy */
>>>>  	rtl_hw_aspm_clkreq_enable(tp, false);
>>>>  	rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
>>>> -	rtl_hw_aspm_clkreq_enable(tp, true);
>>>> +	tp->aspm_supported = 1;
>>>>  }
>>>>  
>>>>  static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>>>> @@ -5337,7 +5339,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>>>>  	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
>>>>  	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
>>>>  
>>>> -	rtl_hw_aspm_clkreq_enable(tp, true);
>>>> +	tp->aspm_supported = 1;
>>>>  }
>>>>  
>>>>  static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
>>>> @@ -5394,7 +5396,7 @@ static void rtl_hw_start_8168ep_1(struct rtl8169_private *tp)
>>>>  
>>>>  	rtl_hw_start_8168ep(tp);
>>>>  
>>>> -	rtl_hw_aspm_clkreq_enable(tp, true);
>>>> +	tp->aspm_supported = 1;
>>>>  }
>>>>  
>>>>  static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
>>>> @@ -5414,7 +5416,7 @@ static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
>>>>  	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
>>>>  	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
>>>>  
>>>> -	rtl_hw_aspm_clkreq_enable(tp, true);
>>>> +	tp->aspm_supported = 1;
>>>>  }
>>>>  
>>>>  static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
>>>> @@ -5449,7 +5451,7 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
>>>>  	data |= 0x0080;
>>>>  	r8168_mac_ocp_write(tp, 0xe860, data);
>>>>  
>>>> -	rtl_hw_aspm_clkreq_enable(tp, true);
>>>> +	tp->aspm_supported = 1;
>>>>  }
>>>>  
>>>>  static void rtl_hw_start_8168(struct rtl8169_private *tp)
>>>> @@ -5696,7 +5698,7 @@ static void rtl_hw_start_8106(struct rtl8169_private *tp)
>>>>  	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
>>>>  
>>>>  	rtl_pcie_state_l2l3_disable(tp);
>>>> -	rtl_hw_aspm_clkreq_enable(tp, true);
>>>> +	tp->aspm_supported = 1;
>>>>  }
>>>>  
>>>>  static void rtl_hw_start_8101(struct rtl8169_private *tp)
>>>> @@ -7097,6 +7099,49 @@ static const struct rtl_cfg_info {
>>>>  	}
>>>>  };
>>>>  
>>>> +static ssize_t rtl_aspm_show(struct device *dev, struct device_attribute *attr,
>>>> +			     char *buf)
>>>> +{
>>>> +	struct net_device *ndev = dev_get_drvdata(dev);
>>>> +	struct rtl8169_private *tp = netdev_priv(ndev);
>>>> +
>>>> +	return snprintf(buf, PAGE_SIZE, "%d\n", tp->aspm_enabled);
>>>> +}
>>>> +
>>>> +static ssize_t rtl_aspm_store(struct device *dev, struct device_attribute *attr,
>>>> +			      const char *buf, size_t size)
>>>> +{
>>>> +	struct net_device *ndev = dev_get_drvdata(dev);
>>>> +	struct rtl8169_private *tp = netdev_priv(ndev);
>>>> +	bool aspm;
>>>> +
>>>> +	if (!tp->aspm_supported)
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	if (strtobool(buf, &aspm) < 0)
>>>> +		return -EINVAL;
>>>> +
>>>> +	pm_runtime_get_noresume(dev);
>>>> +
>>>> +	if (!pm_runtime_active(dev)) {
>>>> +		size = -ENETDOWN;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	rtl_lock_work(tp);
>>>> +	rtl_unlock_config_regs(tp);
>>>> +	rtl_hw_aspm_clkreq_enable(tp, aspm);
>>>> +	tp->aspm_enabled = aspm ? 1 : 0;
>>>> +	rtl_lock_config_regs(tp);
>>>> +	rtl_unlock_work(tp);
>>>> +out:
>>>> +	pm_runtime_put_noidle(dev);
>>>> +
>>>> +	return size;
>>>> +}
>>>> +
>>>> +static DEVICE_ATTR_RW(rtl_aspm);
>>>> +
>>>>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>>>>  {
>>>>  	unsigned int flags;
>>>> @@ -7325,6 +7370,11 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
>>>>  	return rc;
>>>>  }
>>>>  
>>>> +static void rtl_remove_sysfs_aspm_file(void *data)
>>>> +{
>>>> +	device_remove_file(data, &dev_attr_rtl_aspm);
>>>> +}
>>>> +
>>>>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>>  {
>>>>  	const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
>>>> @@ -7498,6 +7548,15 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>>  
>>>>  	pci_set_drvdata(pdev, dev);
>>>>  
>>>> +	rc = device_create_file(&pdev->dev, &dev_attr_rtl_aspm);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	rc = devm_add_action_or_reset(&pdev->dev, rtl_remove_sysfs_aspm_file,
>>>> +				      &pdev->dev);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>>  	rc = r8169_mdio_register(tp);
>>>>  	if (rc)
>>>>  		return rc;
>>>>
>>>
>>>
>>
> 

