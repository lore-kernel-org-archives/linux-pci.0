Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46990 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab2IYTyA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 15:54:00 -0400
Received: by bkcjk13 with SMTP id jk13so1483909bkc.19
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2012 12:53:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7NaaXpsJsVs0aV-d1aZ6OAUypgsapKdh3azBV_pBqoWA@mail.gmail.com>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5Arj=rh4mZJk3tEsaWKBFqxK6tAu1N5SKn2Cq=vTj+bw@mail.gmail.com>
	<CAE9FiQUu++bPNree995uY3bGURxJ6hSi8m77ah_8KK6S2aMUaQ@mail.gmail.com>
	<CAErSpo6NOhTV0HX1dw5-mRkUtfO7XH_iCGVwiddBPpQvPZL=7g@mail.gmail.com>
	<CAE9FiQUdE90YygSZY3tnSZ5+V2SxDfqc5CPcX5scSF8OFVC3cw@mail.gmail.com>
	<CAErSpo44AyBF_rNjYotwpH-LVqZhSY-Nk_XAA+Gbni2maS2WzQ@mail.gmail.com>
	<CAE9FiQUTigHgGDfSy6bTohzYauhBykMxdf4Xg5ZegWjBEqkfPA@mail.gmail.com>
	<CAErSpo7NaaXpsJsVs0aV-d1aZ6OAUypgsapKdh3azBV_pBqoWA@mail.gmail.com>
Date: Tue, 25 Sep 2012 12:53:58 -0700
Message-ID: <CAE9FiQVi3ONMSSFx_CyZo05VDtJSf4ma0aUjdWkzGGQJGH_7cA@mail.gmail.com>
Subject: Re: [PATCH 00/29] PCI: use pci host bridge to loop pci root bus
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 25, 2012 at 12:45 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> Sure, it might be *safe*.  But it's not *sufficient*.  If you use
> for_each_pci_host_bridge(), you also need to do something else to deal
> with hot-added host bridges.  It's hard to make sure that every caller
> does both parts correctly:
>
>   1) for_each_pci_host_bridge() for things we've already seen and
>   2) some sort of notifier for hot-added bridges

yes.

>
> That's why I'd prefer a single interface.

that will have draw backs too:
1. too much changes to the code of current caller.
2. have to checking system_state back and forth.
3. some variable function call may only need for _init path could not be freed.
    or add annoying _ref_ok etc.

-Yinghai
