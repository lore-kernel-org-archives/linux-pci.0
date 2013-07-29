Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:47676 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155Ab3G2XOk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2013 19:14:40 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so1734415obc.38
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2013 16:14:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375134764.2104.1.camel@jtkirshe-mobl>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
	<1374937868-24437-2-git-send-email-yinghai@kernel.org>
	<CAErSpo7xk-NGp+4ZFo-jnVnQSEomY=7=CXDSbZPzrhdjZ4zVSA@mail.gmail.com>
	<51F6D161.1040106@redhat.com>
	<51F6D9A2.8020403@intel.com>
	<51F6DF35.40909@redhat.com>
	<1375134764.2104.1.camel@jtkirshe-mobl>
Date: Mon, 29 Jul 2013 16:14:39 -0700
Message-ID: <CAE9FiQWsaMuAPrx62rTGBokyV-O49NuX0tsaVzqKUcxuoEoPvA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: Stop sriov after stop PF if PF's driver skip that
From: Yinghai Lu <yinghai@kernel.org>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Don Dutile <ddutile@redhat.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Greg Rose <gregory.v.rose@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 29, 2013 at 2:52 PM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> Can I apply this patch as a standalone? or will I need the entire 3
> patch series?

would be better if you can test those three on top of pci/for-linus branch.
http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=for-linus
