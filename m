Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60304 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653Ab2FVRdo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 13:33:44 -0400
Received: by pbbrp8 with SMTP id rp8so3830161pbb.19
        for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2012 10:33:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340348122-29021-14-git-send-email-jiang.liu@huawei.com>
References: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
	<1340348122-29021-14-git-send-email-jiang.liu@huawei.com>
Date: Fri, 22 Jun 2012 10:33:43 -0700
Message-ID: <CAE9FiQUvksHYHVaZUn1Je7MiLibB=mkpXZ0mxyuqrWAq6Wr_bg@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] x86/PCI: use pr_level() to replace printk(KERN_LEVEL)
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2012 at 11:55 PM, Jiang Liu <liuj97@gmail.com> wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
>
> Script checkpatch.pl recommends to replace printk(KERN_LVL) with pr_lvl(),
> so do it.
>
> Signed-off-by: Jiang Liu <liuj97@gmail.com>

for 1-13

Reviewed-by: Yinghai Lu <yinghai@kernel.org>

Thanks

Yinghai
