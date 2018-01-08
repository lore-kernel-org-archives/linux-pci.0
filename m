Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35407 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756174AbeAHMxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jan 2018 07:53:30 -0500
Received: by mail-wr0-f193.google.com with SMTP id n9so764436wrg.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2018 04:53:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515398105-10329-2-git-send-email-poza@codeaurora.org>
References: <1515398105-10329-1-git-send-email-poza@codeaurora.org> <1515398105-10329-2-git-send-email-poza@codeaurora.org>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 8 Jan 2018 13:52:48 +0100
Message-ID: <CAOFm3uF30-Un-_aX97+yPDkqu5YLHKCAaNF-byBRhJQP-5io7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PCI/AER: factor out error reporting from AER
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Oza,

On Mon, Jan 8, 2018 at 8:55 AM, Oza Pawandeep <poza@codeaurora.org> wrote:
> This patch factors out error reporting callbacks, which are currently
> tightly coupled with AER.
> DPC should be able to call these callbacks when DPC trigger event occurs.
>
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

<snip>

> --- /dev/null
> +++ b/drivers/pci/pcie/pcie-err.c
> @@ -0,0 +1,335 @@
> +/*
> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> +
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

Do you mind using an SPDX tag there instead of this fine legalese?

-- 
Cordially
Philippe Ombredanne
