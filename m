Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:55404 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965906Ab3DRPCA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Apr 2013 11:02:00 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so2864277oag.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2013 08:01:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAh6nkmbKR3HTqm5ommevsBwhL_u0N8Rk7Wsms_LfP=nBgKNew@mail.gmail.com>
References: <CAAh6nkmbKR3HTqm5ommevsBwhL_u0N8Rk7Wsms_LfP=nBgKNew@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 18 Apr 2013 09:01:39 -0600
Message-ID: <CAErSpo6uu-=j7Ro_HuXT6t6E-cQRx+=SfeASfeKNDt-+7WE2UA@mail.gmail.com>
Subject: Re: About dynamically loading the acpiphp.ko
To: Gavin Guo <tuffkidtt@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	t-kochi@bq.jp.nec.com, Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jiang, -cc willy@hp.com (defunct address), -cc t-kochi (I assume
also defunct)]

On Wed, Apr 17, 2013 at 9:27 PM, Gavin Guo <tuffkidtt@gmail.com> wrote:
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

Please test linux-next (20130417 or later) with
CONFIG_HOTPLUG_PCI_ACPI=y and see if that works as you expect.  That
contains Jiang's patch (that you mentioned in a your subsequent email)
which removes the option of building acpiphp as a module.

If that doesn't work, please let us know, along with more details,
such as a complete dmesg log.  There are still known issues with
acpiphp, e.g., https://bugzilla.kernel.org/show_bug.cgi?id=54981, that
you might be seeing.

Bjorn
