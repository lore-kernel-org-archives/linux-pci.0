Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB1C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 13:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF84208E7
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 13:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LmCipauO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF84208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeLGNLT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:11:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35213 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeLGNLS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 08:11:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so2998612lfc.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Dec 2018 05:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EFj9X/innvkpACYNCTtZcY37pslKCk2J0+kVrFHIYOI=;
        b=LmCipauOb1yLA1CNjfxYn4Q7iy7tl70uGlFvAgMt74FNEpfLA2CjVMLuKDLmyxf9P9
         vaVmbpOIrI+S6dfKTq9sX/snFic79x2CqMlbxsMCJI1hHSf+subIIkVQuOXv2+B+LXjn
         xa+GDgGu0JMtiGoaSGSsjQTHibBTehXtos3U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EFj9X/innvkpACYNCTtZcY37pslKCk2J0+kVrFHIYOI=;
        b=M4E7fuhdO0ZEsxSDkEqnXKATLpHnaFq5WQHxxC/b5c6q9lcTahRIP5QVsz+TSMY9s8
         5D/Cp7Yld8PmcbtAh4R6O6kaNJLAWZp6WkpyPx2FcpvYNslHfaMLtzoQ9SoJl5avay8I
         7hULkQlcprfD1xgpaq7WMn+vdRNlpSG8qPNz0Yc8uoaqlnN3jVde0yq9ub1hX7QOnC9x
         YDfJ5YWJvWcWS+P0yH+1vs2qIi4b+VamIEeQ4ANtBbhd2SzzqBstmojm4mRC7uXlUbNZ
         E7PUJy/XuWMXwl5z7njNbbQu0V+cCk9smFeHqIm8CD3uOjZoLil0kkgO/+b4uTddMOJH
         hMGw==
X-Gm-Message-State: AA+aEWaxc6104TXgB3BIh0833cvLKMcnaqveCoQTXX8a2mUWr5SnjgRX
        9UiAYTMq1NYAJ7aHbQsq4oIuow==
X-Google-Smtp-Source: AFSGD/WYjfEugWJ/CiebXU8yXokboCL047BVIH5KUpU6vVPMwFkDZfarIwmrnaQbyupeZioH9F/HOg==
X-Received: by 2002:a19:8f45:: with SMTP id r66mr1413285lfd.9.1544188276612;
        Fri, 07 Dec 2018 05:11:16 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id i143sm604609lfg.74.2018.12.07.05.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 05:11:15 -0800 (PST)
Date:   Fri, 7 Dec 2018 14:11:13 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
Message-ID: <20181207131113.GA427@centauri.lan>
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
 <1544092136.3709.57.camel@pengutronix.de>
 <CAHQ1cqFeJtxnpfzqWVQ3T9Sv=gfw+cvZZw-uKnZV7pxJg_S+EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqFeJtxnpfzqWVQ3T9Sv=gfw+cvZZw-uKnZV7pxJg_S+EA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 06, 2018 at 08:55:13PM -0800, Andrey Smirnov wrote:
> On Thu, Dec 6, 2018 at 2:28 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> >
> > Am Mittwoch, den 05.12.2018, 23:45 -0800 schrieb Andrey Smirnov:
> > > Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
> > > produces a system where built-in PCIE bridge (16c3:abcd) isn't bound
> > > to pcieport driver. This, in turn, results in a PCIE bus that is
> > > capable of enumerating attached PCIE device, but lacks functional
> > > interrupt support.
> >
> > This is odd. AFAIK PCI port services are a totally optional thing and
> > them being absent should not lead to a non-functional PCI bus. So I
> > would really like to see some deeper analysis what is going on here.
> >
> 
> AFAICT, this is due to pcieport driver enabling MSI of the bridge
> device (16c3:abcd) via pcie_port_device_register() ->
> pcie_init_service_irqs() -> pcie_port_enable_irq_vec() -> etc.
> 
> I did an experiment on a i.MX8MQ/PCIE -> i210 setup I have: I disabled
> CONFIG_PCIEPORTBUS and hacked igb_main.c enough to make the i210
> driver believe it should fall back onto legacy interrupts. Even
> without pcieport present in the system, i210 worked as expected via
> legacy interrupts, which seems to collaborate my conjecture above.
> 
> Thanks,
> Andrey Smirnov

IIUC PCIEPORTBUS should not be needed for MSIs to work,
it is only needed if you want e.g. PME or AER.

The difference is that if PCIEPORTBUS is enabled, a MSI irq vector will be
allocated for the Root Complex itself, so that it can send an irq when
e.g. AER has detected an error.


If we disregard that MSI handling is currently broken on DWC PCIe:
https://marc.info/?l=linux-pci&m=154214986924244&w=2
It is very possible to have MSIs on dragonboard 820c, which also
uses the DWC PCIe controller, without having PCIEPORTBUS selected:

# zcat /proc/config.gz | grep -E "PCIE_QCOM|PCIEPORTBUS"
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIE_QCOM=y


# lspci -v -s 0000:00:00.0
0000:00:00.0 PCI bridge: Qualcomm Device 0104 (prog-if 00 [Normal decode])
	...
        Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit+

# lspci -v -s 0000:01:00.0
0000:01:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
	...
        Capabilities: [50] MSI: Enable+ Count=1/8 Maskable+ 64bit-


# cat /proc/interrupts | grep MSI
 70:       5620          0          0          0   PCI-MSI 524288 Edge      ath10k_pci

So perhaps this is a bug specific to imx6?


Kind regards,
Niklas
