Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59458 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab3FDW53 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2013 18:57:29 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so1842671iec.19
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2013 15:57:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2947055.dGtK2eC6Fm@vostro.rjw.lan>
References: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com>
	<1369974092-11450-2-git-send-email-jiang.liu@huawei.com>
	<2049081.aBp0De0oje@vostro.rjw.lan>
	<2947055.dGtK2eC6Fm@vostro.rjw.lan>
Date: Tue, 4 Jun 2013 15:57:28 -0700
Message-ID: <CAE9FiQW4UynXesgv58YajV73VZHQLzFiD3M6Dq=7bXmCXDbCiQ@mail.gmail.com>
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

On Tue, Jun 4, 2013 at 3:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, June 05, 2013 12:44:27 AM Rafael J. Wysocki wrote:
>> On Friday, May 31, 2013 12:21:30 PM Jiang Liu wrote:
>> > From: Yinghai Lu <yinghai@kernel.org>
>> >
>> > When sriov is enabled, VF could just start after PF in pci tree.
>> > like c1:00.0 will be PF, and c1:00.1 and after will be VF.
>> >
>> > acpi do have dev with same ADR. that will make them get glued
>> > wrongly.
>>
>> How exactly are they glued in that case?
>>
>> > Skip that if it is virtfn.
>>
>> That should be a bit more specific as far as I can say.  I don't see why a VF
>> would not have a valid ACPI device object corresponding to it.  Is there any
>> particular reason?
>
> To be precise, I don't quite see why it is impossible or invalid for a VF to
> have a corresponding ACPI device object.  It may not be the case on this
> particular system, but why not in general?

at least for ioapic routing GSI, we should not mix VF to use other PF's
setting.

Yinghai
