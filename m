Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36542 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbeH3M5N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Aug 2018 08:57:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id j192-v6so1170835wmj.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Aug 2018 01:56:07 -0700 (PDT)
Message-ID: <2558005d0cad11feb9d6775b2ed237351098fa06.camel@baylibre.com>
Subject: Re: [PATCH v2 2/2] PCI: meson: add the Amlogic Meson PCIe phy driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Hanjie Lin <hanjie.lin@amlogic.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-pci@vger.kernel.org, Yixun Lan <yixun.lan@amlogic.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date: Thu, 30 Aug 2018 10:56:05 +0200
In-Reply-To: <b8deb2ef-5e73-b508-616e-b0303a0adc78@amlogic.com>
References: <1535096006-152091-1-git-send-email-hanjie.lin@amlogic.com>
         <1535096006-152091-3-git-send-email-hanjie.lin@amlogic.com>
         <c21a2e25c934d19f913f625542f505cf45754f23.camel@baylibre.com>
         <b8deb2ef-5e73-b508-616e-b0303a0adc78@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-08-30 at 16:02 +0800, Hanjie Lin wrote:
> > I thought you said there was only phy on this platform.
> > If that's the case, what is this reset shared with ?
> 
> Amlogic axg soc includes two pcie controllers and they share the same pcie phy.
> Because of two pcie controllers, meson_pcie_phy_probe() will be called two times.
> So, the phy reset must be shared.

You are abusing the API then.
The phy should have exclusive control of its *own* reset line, not other device
should claim this reset. 
I should then manage the fact that it may have more than one consumer.
