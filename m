Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46878 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752063Ab2EXXJs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 May 2012 19:09:48 -0400
Received: by lahd3 with SMTP id d3so237396lah.19
        for <linux-pci@vger.kernel.org>; Thu, 24 May 2012 16:09:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120524182601.GA7551@google.com>
References: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com> <20120524182601.GA7551@google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 24 May 2012 17:09:26 -0600
Message-ID: <CAErSpo45LiXkeA0sj2UWcJr7h9VREV2icnahxDGtrW4jndJMGg@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>, Jiang Liu <liuj97@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2012 at 12:26 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>    ACPI: bus type pci registered
> 1)  PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
>    PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
>    ...

> 1): Do we really need this early MCFG scan?  Conceptually it seems like we
> don't need to look at MCFG until we add a host bridge or do a blind probe.

I looked at mmconfig-shared.c again.  I had forgotten what a total
pile of crap it is.  I haven't seen so many special cases and
exceptions in a long time.

I think we probably *could* drop this early scan by converting the
pci_mmcfg_check_hostbridge() stuff into quirks (i.e., enumerate
devices without MMCONFIG and have quirks add MMCONFIG space when their
devices are found), but that would be major surgery that isn't
relevant to your project.  So just ignore my question about this.

Bjorn
