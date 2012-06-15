Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46619 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab2FOHQJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jun 2012 03:16:09 -0400
Received: by pbbrp8 with SMTP id rp8so4895411pbb.19
        for <linux-pci@vger.kernel.org>; Fri, 15 Jun 2012 00:16:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4v_N8MhoCyQMi6vOOipw6Cg8wbMqP2q9FXT+gXjF88iw@mail.gmail.com>
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
	<CAErSpo4v_N8MhoCyQMi6vOOipw6Cg8wbMqP2q9FXT+gXjF88iw@mail.gmail.com>
Date: Fri, 15 Jun 2012 00:16:08 -0700
Message-ID: <CAE9FiQWTpy4iEfhTiPC4UgCu_+6L0yR6SSFCbvMtHp-Jv7_DFA@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 14, 2012 at 8:06 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I have to say I'm still ambivalent about this.  I really like the fact
> that we track MMCONFIG space on a per-host bridge basis.  But the code
> in the init path is ridiculously, embarrassingly complicated
> (obviously this is not your fault at all).  It took me a couple hours
> to trace through and figure out why my box emits the "motherboard
> resources" warnings when it didn't before.

[PATCH v7 08/10] PCI, x86: add MMCFG information on demand

still have some problem that need to be fixed.

Yinghai
