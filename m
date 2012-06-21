Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54075 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760135Ab2FUUGW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 16:06:22 -0400
Received: by bkcji2 with SMTP id ji2so977564bkc.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 13:06:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
References: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 21 Jun 2012 14:06:01 -0600
Message-ID: <CAErSpo5ABBo787gr+FqfvAhU=qQ9a5zgQyg=+HTr5dkigB3-XA@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2012 at 3:36 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
> This patchset enhance pci_root driver to update MMCFG information when
> hot-plugging PCI root bridges. It applies to
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/next

Yinghai, I'm hoping you will review these.  I'd like to get them into
-next soon and you're the main person paying attention to them :)  If
you can't, let me know and I'll give it a go myself.

Bjorn
