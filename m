Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:36132 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965179Ab3DRD1S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2013 23:27:18 -0400
Received: by mail-oa0-f47.google.com with SMTP id n9so2295820oag.20
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2013 20:27:18 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Apr 2013 11:27:17 +0800
Message-ID: <CAAh6nkmbKR3HTqm5ommevsBwhL_u0N8Rk7Wsms_LfP=nBgKNew@mail.gmail.com>
Subject: About dynamically loading the acpiphp.ko
From: Gavin Guo <tuffkidtt@gmail.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	gregkh@linuxfoundation.org, t-kochi@bq.jp.nec.com, willy@hp.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

I've a Dell platform which has PCI-to-USB card and would like to let
the module be dynamically insmoded when hotplugging this card.
Firstly, I've submitted a patch, which added acpiphp to the
/etc/modules, to the init-module-tools package in the Debian system,
but maintainer rejected to accept the patch and said it would be done
in the kernel side to enable the automatically loading. Then, I've
tried to read the code about acpiphp under drivers/pci/hotplug/* and
found that acpiphp_ibm.c seems providing a hook to build the
dependency with acpiphp.ko, providing a way to construct a empty
ibm_handle_events-liked callback function, named dell_handle_events,
for acpi_install_notify_handler and the acpiphp_dell.ko could be
insmoded by udev through the MODULE_ALIAS("dmi*...") which describe
the dell platform information. However, writing a code with fake empty
function just to enable the hotplugging PCI is silly in my opinion, I
would be appreciated if anyone could provide a method to enable the
hotplugging automatically.

Thanks,
Gavin Guo
