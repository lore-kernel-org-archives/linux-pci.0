Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37919 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeAVMcD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jan 2018 07:32:03 -0500
Received: by mail-it0-f48.google.com with SMTP id w14so9532858itc.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2018 04:32:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180122115054.GA14714@lenoch>
References: <20180121211508.GB15151@lenoch> <201801221715.OdDnS1NF%fengguang.wu@intel.com>
 <20180122115054.GA14714@lenoch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 22 Jan 2018 13:32:02 +0100
Message-ID: <CACRpkdbJb+EWZHx++2fa2KHH6B-NHGMgQ=fhvzdYd8dQyWs6Xw@mail.gmail.com>
Subject: Re: [PATCH 1/5] devres: Move managed io function declarations into device.h
To: Ladislav Michl <ladis@linux-mips.org>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 22, 2018 at 12:50 PM, Ladislav Michl <ladis@linux-mips.org> wrote:

> Linus,
>
> after moving managed io function declarations into device.h, above error
> was triggered. Please consider folowing patch:
>
>>8--------------
>
> From: Ladislav Michl <ladis@linux-mips.org>
> Subject: [PATCH] include/pinctrl: Forward declare struct device
>
> pinctrl/devinfo.h is using forward declaration from pinctrl/consumer.h
> for configurations with CONFIG_PINCTRL defined, however nothing declares
> it in the opposite case. Fix this by adding a forward declaration.
>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Ah good catch.

Patch applied.

Yours,
Linus Walleij
