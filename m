Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59876 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab3FEPzT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jun 2013 11:55:19 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so4113314iec.33
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2013 08:55:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1565177.fVUsxhqHvk@vostro.rjw.lan>
References: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com>
	<2947055.dGtK2eC6Fm@vostro.rjw.lan>
	<CAE9FiQW4UynXesgv58YajV73VZHQLzFiD3M6Dq=7bXmCXDbCiQ@mail.gmail.com>
	<1565177.fVUsxhqHvk@vostro.rjw.lan>
Date: Wed, 5 Jun 2013 08:55:18 -0700
Message-ID: <CAE9FiQXSQkZxy7OHgEUVQ_UYrTAa2zEjo3TPhecxaUbu5J6ToQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI, ACPI: Don't glue ACPI dev with pci VFs
From: Yinghai Lu <yinghai@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <liuj97@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 4, 2013 at 4:51 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, June 04, 2013 03:57:28 PM Yinghai Lu wrote:
>> >
>> > To be precise, I don't quite see why it is impossible or invalid for a VF to
>> > have a corresponding ACPI device object.  It may not be the case on this
>> > particular system, but why not in general?
>>
>> at least for ioapic routing GSI, we should not mix VF to use other PF's
>> setting.
>
> I can agree with that, but your patch is far more general than this.  It won't
> allow any VF on any system to be "glued" to any ACPI device object and I'm
> thinking that that may just go too far.

I think that we should look reversely:
Is there any reason or use case that we need to bind PCI VF to acpi device?
PCI vf is only showing up after PF driver call pci_enable_siov.

Yinghai
