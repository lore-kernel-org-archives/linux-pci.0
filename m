Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60069 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab2GIRFg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jul 2012 13:05:36 -0400
Received: by lbbgm6 with SMTP id gm6so20429156lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 09 Jul 2012 10:05:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FFAACF8.8040801@huawei.com>
References: <1338795894-6292-1-git-send-email-jiang.liu@huawei.com>
 <CAErSpo7NiCsuM+UxveZbYxNsCiStMH5SLZ8EdFzJ7EduB306OQ@mail.gmail.com>
 <CAErSpo70NtEJFaQmDtdTLkSB3fQRNy78juAQO-KbXeceZkunkw@mail.gmail.com>
 <4FF34CEF.3090400@redhat.com> <CAErSpo7=BzPX87qgKS_xkJg4o8BGDan-o7D9NqRiqKvH0kLjfQ@mail.gmail.com>
 <4FFAACF8.8040801@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Jul 2012 11:05:14 -0600
Message-ID: <CAErSpo5dV+ZPRmOBmdmTf1hEPXvqtXyTyNj4m2nDFEkKi5NmGQ@mail.gmail.com>
Subject: Re: [Resend with Ack][PATCH v1] PCI: allow acpiphp to handle PCIe
 ports without native PCIe hotplug capability
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Don Dutile <ddutile@redhat.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 9, 2012 at 4:05 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
> Hi Bjorn and Yinghai,
>         What's the policy to export a symbol by EXPORT_SYMBOL()
> or EXPORT_SYMBOL_GPL()? I know the legal difference, but don't
> know when I should mark a symbol as GPL.

>From Documentation/DocBook/kernel-hacking.tmpl,

    EXPORT_SYMBOL_GPL implies that the function is considered
    an internal implementation issue, and not really an interface.

So I use EXPORT_SYMBOL_GPL unless I'm willing to support the symbol as
an interface indefinitely.

Bjorn
