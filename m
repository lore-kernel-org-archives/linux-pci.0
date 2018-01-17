Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754061AbeAQQqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jan 2018 11:46:54 -0500
Subject: Re: [PATCH v5 3/4] PCI/DPC: Unify and plumb error handling into DPC
To: Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Timur Tabi <timur@codeaurora.org>
References: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
 <1516185438-31556-4-git-send-email-poza@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <733abfcb-5b31-7394-ab62-19a0888d71c2@codeaurora.org>
Date: Wed, 17 Jan 2018 11:46:50 -0500
MIME-Version: 1.0
In-Reply-To: <1516185438-31556-4-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/17/2018 5:37 AM, Oza Pawandeep wrote:
> +++ b/include/linux/dpc.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _DPC_H_
> +#define _DPC_H_
> +
> +#define DPC_FATAL		4
> +
> +#endif //_DPC_H_
> +

can you keep this in drivers/pci.h and get rid of this file?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
