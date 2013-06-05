Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:37615 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab3FEQWK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jun 2013 12:22:10 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so2957177obc.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2013 09:22:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXSQkZxy7OHgEUVQ_UYrTAa2zEjo3TPhecxaUbu5J6ToQ@mail.gmail.com>
References: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com>
 <2947055.dGtK2eC6Fm@vostro.rjw.lan> <CAE9FiQW4UynXesgv58YajV73VZHQLzFiD3M6Dq=7bXmCXDbCiQ@mail.gmail.com>
 <1565177.fVUsxhqHvk@vostro.rjw.lan> <CAE9FiQXSQkZxy7OHgEUVQ_UYrTAa2zEjo3TPhecxaUbu5J6ToQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 5 Jun 2013 10:21:49 -0600
Message-ID: <CAErSpo6TRdZ+_E620b-Cr=dJwku8+=No-N3OpV+kv5O1_TEt9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI, ACPI: Don't glue ACPI dev with pci VFs
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jiang Liu <liuj97@gmail.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 5, 2013 at 9:55 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Jun 4, 2013 at 4:51 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, June 04, 2013 03:57:28 PM Yinghai Lu wrote:
>>> >
>>> > To be precise, I don't quite see why it is impossible or invalid for a VF to
>>> > have a corresponding ACPI device object.  It may not be the case on this
>>> > particular system, but why not in general?
>>>
>>> at least for ioapic routing GSI, we should not mix VF to use other PF's
>>> setting.
>>
>> I can agree with that, but your patch is far more general than this.  It won't
>> allow any VF on any system to be "glued" to any ACPI device object and I'm
>> thinking that that may just go too far.
>
> I think that we should look reversely:
> Is there any reason or use case that we need to bind PCI VF to acpi device?
> PCI vf is only showing up after PF driver call pci_enable_siov.

I disagree with this sentiment.  We should handle VFs the same as PFs
except when that's impossible.  You're proposing a special case of
treating VFs differently, so I think the burden is on you to explain
why we need to do that.

It would be helpful if you answered the questions people ask you, for
example, if you could supply the AML Rafael asked about.  If it's
secret, just say so instead of leaving us with the impression that
you're ignoring the question.

Bjorn
