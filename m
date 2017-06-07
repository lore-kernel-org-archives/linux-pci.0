Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:7759 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdFGIzK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2017 04:55:10 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>
Subject: RE: [Question] eDPC and DPC settings in BIOS or Kernel?
Date: Wed, 7 Jun 2017 08:54:57 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40A92D32@FRAEML521-MBX.china.huawei.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E40A3657B@FRAEML521-MBX.china.huawei.com>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40A3657B@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello

Any feedback on this?

Thanks
Gab

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Gabriele Paoloni
> Sent: 18 May 2017 11:02
> To: Keith Busch
> Cc: linux-pci@vger.kernel.org; Linuxarm; liudongdong (C)
> Subject: [Question] eDPC and DPC settings in BIOS or Kernel?
> 
> Hi Keith and all
> 
> We are currently working on extending the current DPC driver
> In Linux with eDPC features.
> 
> While working on it we are wondering on whether "RP PIO Mask Register"
> and "RP PIO Severity Register" should be set in BIOS or Kernel.
> 
> If we look at the current DPC driver we see that DPC is enabled in
> kernel and "DPC Trigger Enable" is set to 10b where instead the PCIe
> specs says that "DPC is disabled by default".
> 
> Consistently for "RP PIO Severity Register" and "RP PIO Mask Register"
> we see that their bits defaults to 0b and 1b respectively (i.e. by
> defaults all RP PIO events are masked and treated as Advisory Non-
> Fatal).
> 
> So we have some questions:
> 1) Why the current "DPC Trigger Enable" is enabled in Kernel rather
> than
>    BIOS? (enabling it in BIOS seems more scalable to fit different
> systems'
>    scenarios)
> 
> 2) Do you have any advice on where to enable and unmask RP PIO events?
> 
> Many thanks
> Gab
