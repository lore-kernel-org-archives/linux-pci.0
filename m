Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDED6C10F0B
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 21:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A389E20645
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 21:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bv7SwzrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfDBVJF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:09:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43596 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBVJE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 17:09:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so12873063lja.10
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2019 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqIBIsg8EF8LeRhAgwCIGgBdYWDKxI0Jzpe75CI0AYA=;
        b=bv7SwzrCIj8c3GXl4AmdSPV7AbnlaLoLL7hO5R8LvFfCgR5xLAdnxpbcqFbyjxf5Z6
         MNEgauAoIEcPfqWo1tF3T89eakErxUhWDuUodG18mkFJBxbyf/lqfyawZUo+eL8Vxn3z
         +LbqWDg+WsqiT902ZwZQ2KnFU1t6PRmAiPPTNLbTCjMh6HqNpB65dk01LLpMIMMCTKzx
         sBo+ovz/eOSJsfoJm90XTtmUo1Lg3V9uS2dKJWY1ZkN8388CNfHqvji6OC7JPffxuoc3
         iwTBwWmKdkK9Vt10c4D4N0RhsWVNF9RO9TVUluBw7lWIizotP2MJI+L2wPXy1svETr/c
         Ts1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqIBIsg8EF8LeRhAgwCIGgBdYWDKxI0Jzpe75CI0AYA=;
        b=rjIgO+SGW21xYu8nt3ScBEK4v9Buz/Bn0i6Dgs74agr7igJUmeER89WqNQPuyRAN4r
         mcjtKHSf6e3lYZE0CS/tSjpi+t++qt8zGqhmwkvre5WumhRJ1IzJ3NLQY1ogkVEIG5Wr
         1w+wmgiem3mYLN/Q+TKNJk86rBA6nRbWOBv1KNr/5STy7MtDgzXXWvQtLspJ24/uoY2j
         s+R+rX1txW2vIBeEkoAVVxcooctnPdhz+ooNisJHoRhVVKv6pwKivYR7vHstDTMhkS77
         gtG5+UYx0CbuO3YN74/Qg8iQbMcscluuVIaEQ3QwPQYsNYAh+IFY+cOGHc+7aiir0ils
         DXlA==
X-Gm-Message-State: APjAAAXF6ELFt8YNeFQb8+J8GjY3aF/Li/2yX0AiPX/4w+BaFa79uwXL
        p5CNZL9ilwNsupHlEcWWxItXKsHEfc/iegw+aNLTGA==
X-Google-Smtp-Source: APXvYqyu9kw4arEFlICyg4mQG5VWBM2YEVAGOO+xxWqzqOJqiySZgaTD/d38jQXRPEl0GfJZt2zi8oxd/Gb1eOVt1mk=
X-Received: by 2002:a2e:99d2:: with SMTP id l18mr31114891ljj.27.1554239340871;
 Tue, 02 Apr 2019 14:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <275eb60f-8cfe-9ff6-97bc-39d9ef280d36@gmail.com>
 <0640ba80-519f-ab76-a86d-e42833df46fb@gmail.com> <4f0e0f6c-20b7-73f8-e524-9798dfbac6d9@gmail.com>
In-Reply-To: <4f0e0f6c-20b7-73f8-e524-9798dfbac6d9@gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 2 Apr 2019 14:08:22 -0700
Message-ID: <CACK8Z6HPp1tL2g+CRca4d85zCSeifOVZCC1ZjL86iEHUBUw7-Q@mail.gmail.com>
Subject: Re: [PATCH net] r8169: switch off ASPM by default and add sysfs
 attribute to control ASPM
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 2, 2019 at 1:41 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 02.04.2019 22:16, Florian Fainelli wrote:
> > On 4/2/19 12:55 PM, Heiner Kallweit wrote:
> >> There are numerous reports about different problems caused by ASPM
> >> incompatibilities between certain network chip versions and board
> >> chipsets. On the other hand on (especially mobile) systems where ASPM
> >> works properly it can significantly contribute to power-saving and
> >> increased battery runtime.
> >> One problem so far to make ASPM configurable was to find an acceptable
> >> way of configuration (e.g. module parameters are discouraged for that
> >> purpose).
> >>
> >> As a new attempt let's switch off ASPM per default and make it
> >> configurable by a sysfs attribute. The attribute is documented in
> >> new file Documentation/networking/device_drivers/realtek/r8169.txt.
> >
> > I am not sure this is where it should be solved, there is definitively a
> > device specific aspect to properly supporting the enabling of ASPM L0s,
> > L1s etc, but the actual sysfs knobs should belong to the pci_device
> > itself, since this is something that likely other drivers would want to
> > be able to expose. You would probably want to work with the PCI
> > maintainers to come up with a standard solution that applies beyond just
> > r8169 since presumably there must be a gazillion of devices with the
> > same issues.
> >
> Interesting point, so let me add Bjorn and linux-pci.
>
> Here this attribute only controls whether the device actively enters
> ASPM states. I doesn't change anything on the other side of the link.
>
> Maybe it would be an option to add an attribute on device level in the
> PCI core that reflects "ASPM allowed", or even in more detail which
> ASPM states / sub-states are acceptable.

CONFIG_PCIEASPM_DEBUG creates a link_state attribute on a per device
basis, that could help achieve this to some extent. It does not
indicate "what is allowed" but lets userspace control the ASPM to
switch to certain states.

Thanks,

Rajat

> Certain support for disabling
> ASPM states is provided by pci_disable_link_state().
> Not sure whether the device would have to be notified by the core that
> certain states have been disabled. Maybe not because this is auto-
> negotiated between the PCIe link partners.
>
> Based on the usage of pci_disable_link_state() not that many devices
> seem to be effected. One good example may be Intel e1000e
> (__e1000e_disable_aspm()).
>
> >>
> >> Fixes: a99790bf5c7f ("r8169: Reinstate ASPM Support")
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  .../device_drivers/realtek/r8169.txt          | 19 +++++
> >>  drivers/net/ethernet/realtek/r8169.c          | 75 +++++++++++++++++--
> >>  2 files changed, 86 insertions(+), 8 deletions(-)
> >>  create mode 100644 Documentation/networking/device_drivers/realtek/r8169.txt
> >>
> >> diff --git a/Documentation/networking/device_drivers/realtek/r8169.txt b/Documentation/networking/device_drivers/realtek/r8169.txt
> >> new file mode 100644
> >> index 000000000..669995d0c
> >> --- /dev/null
> >> +++ b/Documentation/networking/device_drivers/realtek/r8169.txt
> >> @@ -0,0 +1,19 @@
> >> +Written by Heiner Kallweit <hkallweit1@gmail.com>
> >> +
> >> +Version 04/02/2019
> >> +
> >> +Driver-specific sysfs attributes
> >> +================================
> >> +
> >> +rtl_aspm (bool)
> >> +---------------
> >> +
> >> +Certain combinations of network chip versions and board chipsets result in
> >> +increased packet latency, PCIe errors, or significantly reduced network
> >> +performance. Therefore ASPM is off by default. On the other hand ASPM can
> >> +significantly contribute to power-saving and thus increased battery
> >> +runtime on notebooks. Therefore this sysfs attribute allows to switch on
> >> +ASPM on systems where ASPM works properly. The attribute accepts any form
> >> +of bool value, e.g. 1/y/on. See also kerneldoc of kstrtobool().
> >> +Note that the attribute is accessible only if interface is up.
> >> +Else network chip and PCIe link may be powered-down and not reachable.
> >> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> >> index 19efa88f3..e2de94dc3 100644
> >> --- a/drivers/net/ethernet/realtek/r8169.c
> >> +++ b/drivers/net/ethernet/realtek/r8169.c
> >> @@ -678,6 +678,8 @@ struct rtl8169_private {
> >>              struct work_struct work;
> >>      } wk;
> >>
> >> +    unsigned aspm_supported:1;
> >> +    unsigned aspm_enabled:1;
> >>      unsigned irq_enabled:1;
> >>      unsigned supports_gmii:1;
> >>      dma_addr_t counters_phys_addr;
> >> @@ -5091,7 +5093,7 @@ static void rtl_hw_start_8168e_2(struct rtl8169_private *tp)
> >>      RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
> >>      RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~Spi_en);
> >>
> >> -    rtl_hw_aspm_clkreq_enable(tp, true);
> >> +    tp->aspm_supported = 1;
> >>  }
> >>
> >>  static void rtl_hw_start_8168f(struct rtl8169_private *tp)
> >> @@ -5205,7 +5207,7 @@ static void rtl_hw_start_8168g_1(struct rtl8169_private *tp)
> >>      /* disable aspm and clock request before access ephy */
> >>      rtl_hw_aspm_clkreq_enable(tp, false);
> >>      rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
> >> -    rtl_hw_aspm_clkreq_enable(tp, true);
> >> +    tp->aspm_supported = 1;
> >>  }
> >>
> >>  static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
> >> @@ -5240,7 +5242,7 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
> >>      /* disable aspm and clock request before access ephy */
> >>      rtl_hw_aspm_clkreq_enable(tp, false);
> >>      rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
> >> -    rtl_hw_aspm_clkreq_enable(tp, true);
> >> +    tp->aspm_supported = 1;
> >>  }
> >>
> >>  static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
> >> @@ -5337,7 +5339,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
> >>      r8168_mac_ocp_write(tp, 0xc094, 0x0000);
> >>      r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
> >>
> >> -    rtl_hw_aspm_clkreq_enable(tp, true);
> >> +    tp->aspm_supported = 1;
> >>  }
> >>
> >>  static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
> >> @@ -5394,7 +5396,7 @@ static void rtl_hw_start_8168ep_1(struct rtl8169_private *tp)
> >>
> >>      rtl_hw_start_8168ep(tp);
> >>
> >> -    rtl_hw_aspm_clkreq_enable(tp, true);
> >> +    tp->aspm_supported = 1;
> >>  }
> >>
> >>  static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
> >> @@ -5414,7 +5416,7 @@ static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
> >>      RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
> >>      RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
> >>
> >> -    rtl_hw_aspm_clkreq_enable(tp, true);
> >> +    tp->aspm_supported = 1;
> >>  }
> >>
> >>  static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
> >> @@ -5449,7 +5451,7 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
> >>      data |= 0x0080;
> >>      r8168_mac_ocp_write(tp, 0xe860, data);
> >>
> >> -    rtl_hw_aspm_clkreq_enable(tp, true);
> >> +    tp->aspm_supported = 1;
> >>  }
> >>
> >>  static void rtl_hw_start_8168(struct rtl8169_private *tp)
> >> @@ -5696,7 +5698,7 @@ static void rtl_hw_start_8106(struct rtl8169_private *tp)
> >>      RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
> >>
> >>      rtl_pcie_state_l2l3_disable(tp);
> >> -    rtl_hw_aspm_clkreq_enable(tp, true);
> >> +    tp->aspm_supported = 1;
> >>  }
> >>
> >>  static void rtl_hw_start_8101(struct rtl8169_private *tp)
> >> @@ -7097,6 +7099,49 @@ static const struct rtl_cfg_info {
> >>      }
> >>  };
> >>
> >> +static ssize_t rtl_aspm_show(struct device *dev, struct device_attribute *attr,
> >> +                         char *buf)
> >> +{
> >> +    struct net_device *ndev = dev_get_drvdata(dev);
> >> +    struct rtl8169_private *tp = netdev_priv(ndev);
> >> +
> >> +    return snprintf(buf, PAGE_SIZE, "%d\n", tp->aspm_enabled);
> >> +}
> >> +
> >> +static ssize_t rtl_aspm_store(struct device *dev, struct device_attribute *attr,
> >> +                          const char *buf, size_t size)
> >> +{
> >> +    struct net_device *ndev = dev_get_drvdata(dev);
> >> +    struct rtl8169_private *tp = netdev_priv(ndev);
> >> +    bool aspm;
> >> +
> >> +    if (!tp->aspm_supported)
> >> +            return -EOPNOTSUPP;
> >> +
> >> +    if (strtobool(buf, &aspm) < 0)
> >> +            return -EINVAL;
> >> +
> >> +    pm_runtime_get_noresume(dev);
> >> +
> >> +    if (!pm_runtime_active(dev)) {
> >> +            size = -ENETDOWN;
> >> +            goto out;
> >> +    }
> >> +
> >> +    rtl_lock_work(tp);
> >> +    rtl_unlock_config_regs(tp);
> >> +    rtl_hw_aspm_clkreq_enable(tp, aspm);
> >> +    tp->aspm_enabled = aspm ? 1 : 0;
> >> +    rtl_lock_config_regs(tp);
> >> +    rtl_unlock_work(tp);
> >> +out:
> >> +    pm_runtime_put_noidle(dev);
> >> +
> >> +    return size;
> >> +}
> >> +
> >> +static DEVICE_ATTR_RW(rtl_aspm);
> >> +
> >>  static int rtl_alloc_irq(struct rtl8169_private *tp)
> >>  {
> >>      unsigned int flags;
> >> @@ -7325,6 +7370,11 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
> >>      return rc;
> >>  }
> >>
> >> +static void rtl_remove_sysfs_aspm_file(void *data)
> >> +{
> >> +    device_remove_file(data, &dev_attr_rtl_aspm);
> >> +}
> >> +
> >>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >>  {
> >>      const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
> >> @@ -7498,6 +7548,15 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >>
> >>      pci_set_drvdata(pdev, dev);
> >>
> >> +    rc = device_create_file(&pdev->dev, &dev_attr_rtl_aspm);
> >> +    if (rc)
> >> +            return rc;
> >> +
> >> +    rc = devm_add_action_or_reset(&pdev->dev, rtl_remove_sysfs_aspm_file,
> >> +                                  &pdev->dev);
> >> +    if (rc)
> >> +            return rc;
> >> +
> >>      rc = r8169_mdio_register(tp);
> >>      if (rc)
> >>              return rc;
> >>
> >
> >
>
