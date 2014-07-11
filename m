Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:49709 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbaGKJH5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 05:07:57 -0400
Received: by mail-vc0-f178.google.com with SMTP id ij19so1454625vcb.23
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2014 02:07:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
	<d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
	<53BE926A.2070005@ti.com>
	<CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
Date: Fri, 11 Jul 2014 14:37:56 +0530
Message-ID: <CAOh2x=muti0t8akw=Kbw22seOCP4=CsUrCUaNzmae74+JH3Q+g@mail.gmail.com>
Subject: Re: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	spear-devel <spear-devel@list.st.com>,
	Mark Nicholson <mark@nicholnet.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"olof@lixom.net" <olof@lixom.net>, Arnd Bergmann <arnd@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 10, 2014 at 7:00 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>>> +#ifdef CONFIG_PM_SLEEP
>>> +static int spear1340_miphy_suspend(struct device *dev)
>>> +{
>>> +     struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);
>>> +     int ret = 0;
>>> +
>>> +     if (priv->mode == SATA)
>>> +             ret = spear1340_miphy_sata_exit(priv);
>>
>> Shouldn't this be spear1340_miphy_init()?
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int spear1340_miphy_resume(struct device *dev)
>>> +{
>>> +     struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);
>>> +     int ret = 0;
>>> +
>>> +     if (priv->mode == SATA)
>>> +             ret = spear1340_miphy_sata_init(priv);
>>
>> And here spear1340_miphy_exit()? Why only for sata phys?

Kishon,

I had a chat with Pratyush and this is what we came to:

init and exit are rightly placed I believe. We need to initialize from
resume and exit from suspend. That's fine right? Also this was already
part of: arch/arm/mach-spear/spear1340.c which is removed with
this set.

Regarding sata and pcie, pcie suspend isn't yet implemented and
tested. So only sata :)

For delays, need to wait for mohit. Was on leave today.
