Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:41529 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933518AbeEWUjn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 16:39:43 -0400
Received: by mail-vk0-f52.google.com with SMTP id 131-v6so13975312vkf.8
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2018 13:39:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <553308ee-9c6f-2e1e-1ce8-03b739d1acb0@deltatee.com>
References: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
 <1527106686-18852-2-git-send-email-dmeyer@gigaio.com> <553308ee-9c6f-2e1e-1ce8-03b739d1acb0@deltatee.com>
From: Doug Meyer <dmeyer@gigaio.com>
Date: Wed, 23 May 2018 13:39:42 -0700
Message-ID: <CA+GK6ekttigey5o3nJzqi_LGg+n_kPWHJF21+pQDOgLXp4_xhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] NTB: Migrate PCI Constants to Cannonical PCI Header
To: Logan Gunthorpe <logang@deltatee.com>
Cc: kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-ntb <linux-ntb@googlegroups.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Logan,

Thank you for the comment. My gmail filters got me and I never saw
Bjorn's comments on pci_ids.h. I'll start work on v3 when I get
another window of time at work.

Blessings,
Doug


On Wed, May 23, 2018 at 1:26 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 23/05/18 02:18 PM, dmeyer@gigaio.com wrote:
>> +#define PCI_DEVICE_ID_MICROSEMI_PFX24XG3     0x8531
>
> I think Bjorn asked not to add the device IDs to the pci_ids.h and to
> just use the raw IDs in quirks.h. switchtec.c already uses the raw values.
>
> Besides that, it looks good to me.
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/553308ee-9c6f-2e1e-1ce8-03b739d1acb0%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
