Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43658 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab2FUSSI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 14:18:08 -0400
Received: by dady13 with SMTP id y13so1217643dad.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 11:18:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
References: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
Date: Thu, 21 Jun 2012 11:18:07 -0700
Message-ID: <CAE9FiQUn-NhgJkhHXFu4gMi=xzWz06hSVxUJunj25e8gH_xqBw@mail.gmail.com>
Subject: Re: [PATCH 0/4] acpi, pci: hostbridge hotplug support
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2012 at 2:34 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
>  This patchset adds basic code for host bridge hotplug.
>
>  I assume ACPI container device (ACPI0004) which carries
>  hostbridges will be hot-added or hot-removed. In that case
>  some codes are now missing for hostbridge hotplug.
>  This patchset mainly adds the following:
>   - remove hostbridge and devices under it
>   - resoruce-assign code for devices under hot-added hostbridge
>
>  The behavior when you don't try hostbridge hotplug should not change.
>
>  *[PATCH 1/4] acpi, pci: introduce list for acpi_pci_root drivers
>  *[PATCH 2/4] acpi, pci: introduce acpi_root_sem for list manipulation
>  *[PATCH 3/4] acpi, pci: add hostbridge removal function
>  *[PATCH 4/4] acpi, pci: add resoruce-assign code for devices under
>      hot-added hostbridge

Hi, did you check our pci root bus hot plug branch ?

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-root-bus-hotplug

It contain some similar patches from jiang and me.

Thanks

Yinghai
