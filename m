Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53195 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab2FOQzM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jun 2012 12:55:12 -0400
Received: by pbbrp8 with SMTP id rp8so5518160pbb.19
        for <linux-pci@vger.kernel.org>; Fri, 15 Jun 2012 09:55:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5BtQ3dmn4t==ByG+Y=Q7w+wwZ7sw+LJwkSxQG8bKuUzg@mail.gmail.com>
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
	<1338026043-3968-9-git-send-email-jiang.liu@huawei.com>
	<CAE9FiQVHBE7pvaC5aCk-7q_pU3mxSoo5JapQkjG80DcnW16ZxA@mail.gmail.com>
	<CAErSpo5BtQ3dmn4t==ByG+Y=Q7w+wwZ7sw+LJwkSxQG8bKuUzg@mail.gmail.com>
Date: Fri, 15 Jun 2012 09:55:11 -0700
Message-ID: <CAE9FiQUOtdB3PMgmX8aSRYrinhJGWoUBZGii1aowDBLKTH_LJQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] PCI, x86: add MMCFG information on demand
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
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

On Fri, Jun 15, 2012 at 8:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> But the code in the init path is ridiculously, embarrassingly complicated ...
>
> I rest my case.  The current init path is unmaintainable.
>
> I'll wait for a v8 (or later) with fixes for the build issues
> Fengguang found and Yinghai's ack.  It will make things somewhat
> easier for me if you start with my topic/jiang-mmconfig-v7 branch.

yes. probe/free then install is not good.

should make __pci_mmcfg_init() to cache needed stuff for all path, and
then consume stored
entry just before scan root bus.

Thanks

Yinghai
