Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40145 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbeDPLfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2018 07:35:15 -0400
Received: by mail-ot0-f193.google.com with SMTP id h8-v6so5875971otj.7
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2018 04:35:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522747141-8299-1-git-send-email-loic.poulain@linaro.org>
References: <1522747141-8299-1-git-send-email-loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Mon, 16 Apr 2018 13:34:34 +0200
Message-ID: <CAMZdPi-jsf0_oYvdUtobr+pJyaWomFv7MWcZRr_P7xBfi_8-rw@mail.gmail.com>
Subject: Re: [PATCH] PCI: kirin: Fix reset gpio name
To: songxiaowei@hisilicon.com, wangbinghui@hisilicon.com
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        lorenzo.pieralisi@arm.com, Loic Poulain <loic.poulain@linaro.org>,
        Guodong Xu <guodong.xu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Xiaowei,

On 3 April 2018 at 11:19, Loic Poulain <loic.poulain@linaro.org> wrote:
> As documented in the device-tree bindings (pci/kirin-pcie.txt) and
> defined in existing device-tree (hi3660.dtsi), the reset gpio name
> is 'reset-gpios'. However, driver looks for a 'reset-gpio' resource
> which makes the driver probe fail. Fix this.
>
> Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>


Are you still maintaining this driver ? Binghui's email seems to be invalid now.

Regards,
Loic
