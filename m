Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51201 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab2HJQcV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Aug 2012 12:32:21 -0400
Received: by vcbfk26 with SMTP id fk26so1738461vcb.19
        for <linux-pci@vger.kernel.org>; Fri, 10 Aug 2012 09:32:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1344589722-8772-1-git-send-email-guohanjun@huawei.com>
References: <1344589722-8772-1-git-send-email-guohanjun@huawei.com>
Date: Fri, 10 Aug 2012 09:32:19 -0700
Message-ID: <CAE9FiQX1Zq+FwdqX6D805pryiHS9je6cMFLyZSPhJBmEt41rSQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Fusion MPT: disable pci device when mpt map resoures failed
From: Yinghai Lu <yinghai@kernel.org>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Eric Moore <Eric.Moore@lsi.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 10, 2012 at 2:08 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
> when probe a pci device, first we enable it, and disable it when
> some error happened in the following process, because the power
> state of the device is set to D0, and if MSI is disabled,
> we will allocate irq and register gsi for this device in the enable process.
>
> In function mpt_mapresources(MPT_ADAPTER *ioc), it forgot disable the
> pci device when error happened, the irq and gsi will never be released.
> this patch will fix it.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
>  drivers/message/fusion/mptbase.c |   18 +++++++++++-------
>  1 files changed, 11 insertions(+), 7 deletions(-)

You may need to send to LSI and scsi list.

You need to use ./scripts/get_maintainer.pl to find out right CC list.

Thanks

Yinghai
