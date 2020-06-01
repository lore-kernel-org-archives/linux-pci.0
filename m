Return-Path: <SRS0=3fN0=7O=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F05C433E0
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jun 2020 15:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4022081A
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jun 2020 15:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgFAPXC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:23:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61898 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgFAPXC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 11:23:02 -0400
Received: from 89-64-84-138.dynamic.chello.pl (89.64.84.138) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 4ce2c91982a1814a; Mon, 1 Jun 2020 17:22:59 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] PCI/ASPM: Print correct ASPM status when _OSC failed
Date:   Mon, 01 Jun 2020 17:22:58 +0200
Message-ID: <1908398.Rfmu1g3mcC@kreacher>
In-Reply-To: <6f6aa87f-7c4d-61f6-f8c2-42ad05b5c845@kernel.org>
References: <1590655125-23949-1-git-send-email-yangyicong@hisilicon.com> <CAJZ5v0g9O5r7tpLMN7SJu+KZEeEcdeTKeQ=hEo5r+VJzc6g08Q@mail.gmail.com> <6f6aa87f-7c4d-61f6-f8c2-42ad05b5c845@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, June 1, 2020 5:14:45 PM CEST Sinan Kaya wrote:
> On 5/28/2020 7:42 AM, Rafael J. Wysocki wrote:
> >> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> >> index ac8ad6c..5140b26 100644
> >> --- a/drivers/acpi/pci_root.c
> >> +++ b/drivers/acpi/pci_root.c
> >> @@ -456,7 +456,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> >>
> >>                 dev_info(&device->dev, "_OSC failed (%s)%s\n",
> >>                          acpi_format_exception(status),
> >> -                        pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
> >> +                        pcie_aspm_support_enabled() ? "" : "; disabling ASPM");
> >>                 return;
> >>         }
> >>
> >> --
> > Applied as 5.8 material under the "ACPI: PCI: Fix the ASPM part of the
> > _OSC failure message" subject and with a different changelog.
> 
> 
> I'm confused. The original change would print ASPM is getting disabled
> only when ASPM is supported. Now, we are printing disabling ASPM when
> ASPM is not supported.
> 
> Now, we reverted the change and went back to incorrect behavior again.
> 
> Am I missing something?

Well, it turns out that I was confused, as well as the author of the patch.

Dropped now, thanks for the heads-up!



