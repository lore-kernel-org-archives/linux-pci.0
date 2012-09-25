Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53910 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab2IYTpy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 15:45:54 -0400
Received: by ieak13 with SMTP id k13so14898402iea.19
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2012 12:45:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUTigHgGDfSy6bTohzYauhBykMxdf4Xg5ZegWjBEqkfPA@mail.gmail.com>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
 <CAErSpo5Arj=rh4mZJk3tEsaWKBFqxK6tAu1N5SKn2Cq=vTj+bw@mail.gmail.com>
 <CAE9FiQUu++bPNree995uY3bGURxJ6hSi8m77ah_8KK6S2aMUaQ@mail.gmail.com>
 <CAErSpo6NOhTV0HX1dw5-mRkUtfO7XH_iCGVwiddBPpQvPZL=7g@mail.gmail.com>
 <CAE9FiQUdE90YygSZY3tnSZ5+V2SxDfqc5CPcX5scSF8OFVC3cw@mail.gmail.com>
 <CAErSpo44AyBF_rNjYotwpH-LVqZhSY-Nk_XAA+Gbni2maS2WzQ@mail.gmail.com> <CAE9FiQUTigHgGDfSy6bTohzYauhBykMxdf4Xg5ZegWjBEqkfPA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Sep 2012 13:45:33 -0600
Message-ID: <CAErSpo7NaaXpsJsVs0aV-d1aZ6OAUypgsapKdh3azBV_pBqoWA@mail.gmail.com>
Subject: Re: [PATCH 00/29] PCI: use pci host bridge to loop pci root bus
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 25, 2012 at 1:17 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Sep 25, 2012 at 11:19 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Sep 25, 2012 at 12:06 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
>>> that is for initial booting path.
>>>
>>> for hot add/remove notifier add need to be done case by case.
>>
>> Can initial boot be done the same as hot-add?  If we add interfaces
>> like for_each_pci_host_bridge(), people will just copy that for use at
>> run-time.  So it would be better to have the same interfaces for use
>> at boot-time and at hot add-time.
>
> still need to check them case by case. some function may be too early
> to be called in work_fn in notifier. that need to find out when to get
> that bus notifier get
> register.
>
> I have one draft patch that will delay bridge enabling to BUS_ADD for
> pci bridge...
> that will need to get that register rather later otherwise that bridge
> can not be enabled because resources are not reserved/allocated for
> initial booting path.
> please refer to the attached patch. you should notice that fs_initcall
> is used for registration until boot path already have that pci bridges
> before.
>
> +static struct notifier_block pci_hp_nb = {
> +       .notifier_call = &pci_hp_notifier,
> +};
> +
> +static int __init pci_hp_init(void)
> +{
> +       return bus_register_notifier(&pci_bus_type, &pci_hp_nb);
> +}
> +
> +fs_initcall(pci_hp_init);
>
> Also using that for_each_pci_host_bridge in run-time is still safe.

Sure, it might be *safe*.  But it's not *sufficient*.  If you use
for_each_pci_host_bridge(), you also need to do something else to deal
with hot-added host bridges.  It's hard to make sure that every caller
does both parts correctly:

  1) for_each_pci_host_bridge() for things we've already seen and
  2) some sort of notifier for hot-added bridges

That's why I'd prefer a single interface.
