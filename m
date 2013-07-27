Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:51068 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab3G0QKQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 27 Jul 2013 12:10:16 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so9692284oah.24
        for <linux-pci@vger.kernel.org>; Sat, 27 Jul 2013 09:10:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQX7g_L=u_EGGUgbHZ4z_u1feu47UeuvDkaK7eXChyHGGg@mail.gmail.com>
References: <51F23D0F.7090909@oracle.com> <20130726173956.GA14078@google.com> <CAE9FiQX7g_L=u_EGGUgbHZ4z_u1feu47UeuvDkaK7eXChyHGGg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 27 Jul 2013 10:09:54 -0600
Message-ID: <CAErSpo6ohVm=YfxY_Oci1byjPhr3t0hZu38HGRRfN+92eD1NJg@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI: MMCONFIG: cleanup and add address warning to pci_mmconfig_insert
To: Yinghai Lu <yinghai@kernel.org>
Cc: ethan zhao <ethan.zhao@oracle.com>,
	"jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ethan Zhao <ethan.kernel@gmail.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 27, 2013 at 8:27 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Jul 26, 2013 at 10:39 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>>     [bhelgaas: changelog, drop printk]
>>     Signed-off-by: ethan.zhao <ethan.zhao@oracle.com>
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>     Acked-by: Yinghai Lu <yinghai@kerne.org>
>
> looks like I had typo in ack. please update to
>
> Acked-by: Yinghai Lu <yinghai@kernel.org>

Done, thanks, sorry I didn't notice that :)
