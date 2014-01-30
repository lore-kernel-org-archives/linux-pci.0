Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:46029 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbaA3ATU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 19:19:20 -0500
Received: by mail-ob0-f179.google.com with SMTP id wo20so2769658obc.24
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 16:19:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CALdTtnsEo74UeYgoQ0DF7=LN074b_0bL0vg6Bxs02B9nDkRTNA@mail.gmail.com>
References: <1390599168-13150-1-git-send-email-tinamdar@apm.com> <CALdTtnsEo74UeYgoQ0DF7=LN074b_0bL0vg6Bxs02B9nDkRTNA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 29 Jan 2014 17:18:58 -0700
Message-ID: <CAErSpo7Dfd4NJBEDuVe1VCvZObFq1YvV2x77S60Z4-CZq89QJw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 0/4] APM X-Gene PCIe controller
To: Dann Frazier <dann.frazier@canonical.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Landley <rob@landley.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	linux-doc@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	patches <patches@apm.com>, Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 25, 2014 at 9:09 AM, Dann Frazier
<dann.frazier@canonical.com> wrote:
> On Fri, Jan 24, 2014 at 2:32 PM, Tanmay Inamdar <tinamdar@apm.com> wrote:
>> This patch adds support for AppliedMicro X-Gene PCIe host controller. The
>> driver is tested on X-Gene platform with different gen1/2/3 PCIe endpoint
>> cards.
>>
>> X-Gene PCIe controller driver has depedency on the pcie arch support for
>> arm64. The arm64 pcie arch support is not yet part of mainline Linux kernel
>> and approach for arch support is under discussion with arm64 maintainers.
>> The reference patch can be found here --> https://lkml.org/lkml/2013/10/23/244
>
> The reference patch looks corrupted (pcibios.c has no includes, etc),
> would you mind reposting?

When you repost, please make sure you fix whatever problem is
preventing your email from appearing on the vger mailing lists.  I
won't apply things that haven't appeared on the linux-pci list,
because that list is the opportunity for other people to review them.

Bjorn
