Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35921 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932135Ab2FOPqm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jun 2012 11:46:42 -0400
Received: by lahd3 with SMTP id d3so2169407lah.19
        for <linux-pci@vger.kernel.org>; Fri, 15 Jun 2012 08:46:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVHBE7pvaC5aCk-7q_pU3mxSoo5JapQkjG80DcnW16ZxA@mail.gmail.com>
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
 <1338026043-3968-9-git-send-email-jiang.liu@huawei.com> <CAE9FiQVHBE7pvaC5aCk-7q_pU3mxSoo5JapQkjG80DcnW16ZxA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 15 Jun 2012 09:46:20 -0600
Message-ID: <CAErSpo5BtQ3dmn4t==ByG+Y=Q7w+wwZ7sw+LJwkSxQG8bKuUzg@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] PCI, x86: add MMCFG information on demand
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I wrote:

> But the code in the init path is ridiculously, embarrassingly complicated ...

On Fri, Jun 15, 2012 at 1:15 AM, Yinghai Lu <yinghai@kernel.org> wrote:

> here cache cfg too early.  should do that after
>
> pci_mmcfg_reject_broken().
>
> otherwise will use mcfg even try to reject that before.
...
> that really change the logic.
>
> looks like it will break mrst/sfi path.
>
> the scan from pci_legacy_init() for mrst/sfi will not have ext_pci_ops
> set for bus 0.

I rest my case.  The current init path is unmaintainable.

I'll wait for a v8 (or later) with fixes for the build issues
Fengguang found and Yinghai's ack.  It will make things somewhat
easier for me if you start with my topic/jiang-mmconfig-v7 branch.

Bjorn
