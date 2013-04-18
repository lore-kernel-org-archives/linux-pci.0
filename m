Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:38195 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965679Ab3DRGed (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Apr 2013 02:34:33 -0400
Received: by mail-oa0-f52.google.com with SMTP id k18so2370992oag.25
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2013 23:34:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAh6nkmbKR3HTqm5ommevsBwhL_u0N8Rk7Wsms_LfP=nBgKNew@mail.gmail.com>
References: <CAAh6nkmbKR3HTqm5ommevsBwhL_u0N8Rk7Wsms_LfP=nBgKNew@mail.gmail.com>
Date: Thu, 18 Apr 2013 14:34:32 +0800
Message-ID: <CAAh6nk=u7yK_0_EsRq_EpGKUKGahdtHXrNXc4gbroaj3=naDcQ@mail.gmail.com>
Subject: Re: About dynamically loading the acpiphp.ko
From: Gavin Guo <tuffkidtt@gmail.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2013/4/18 Gavin Guo <tuffkidtt@gmail.com>:
> Hi All,
>
> I've a Dell platform which has PCI-to-USB card and would like to let
> the module be dynamically insmoded when hotplugging this card.
> Firstly, I've submitted a patch, which added acpiphp to the
> /etc/modules, to the init-module-tools package in the Debian system,
> but maintainer rejected to accept the patch and said it would be done
> in the kernel side to enable the automatically loading. Then, I've
> tried to read the code about acpiphp under drivers/pci/hotplug/* and
> found that acpiphp_ibm.c seems providing a hook to build the
> dependency with acpiphp.ko, providing a way to construct a empty
> ibm_handle_events-liked callback function, named dell_handle_events,
> for acpi_install_notify_handler and the acpiphp_dell.ko could be
> insmoded by udev through the MODULE_ALIAS("dmi*...") which describe
> the dell platform information. However, writing a code with fake empty
> function just to enable the hotplugging PCI is silly in my opinion, I
> would be appreciated if anyone could provide a method to enable the
> hotplugging automatically.
>
> Thanks,
> Gavin Guo

Hi all,

I found that jiang.liu@huawei.com has committed a patch and was
already in the Bjorn Helgaas's git tree. That means the only way to
use the hot-plugging in the future is just to build in the function.

Thanks
Gavin Guo
