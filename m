Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB88AC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79552086B
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79552086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeK1ENa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:13:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37484 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbeK1ENa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Nov 2018 23:13:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so20812174oth.4;
        Tue, 27 Nov 2018 09:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2zW3A5K1YtzD+gc1wMJeWzleSHV1n0uhJaIMiVyWpk=;
        b=fLEppOQXMrK/YsMxBypT0ZS8jk78JFSdO9athPdG2yfY3xYr5HUlpqF2pH3Renvq0T
         m8LYThdqu6iC4XQK+epEKC0DpJhWAMHJIsIfCP2EBixhxIXswi02o7HM0cxgH8OO7rSL
         pUEgvDlldsRekJiyYtuWOmrwmIR8DBeSnYrHXOPB7CoYN57pzXJuklaBZwd7NWvClJo6
         0wIJd2+gXQUNxMae0IPhsj95gOxI/u2Ufgwt3mIZk68KfwsC5XSmufV4xNaDDD4+YA2U
         JbWuX0m7C1GRlLBwbwDNRl2uIjEFFajNDFy/yZb9rcJ+j5ZTlyBCg6j2Zsn+ol6HSZOM
         4u1g==
X-Gm-Message-State: AA+aEWZMYrHVfYbUNSAMZi+NT7oCPD+TgwClS2jmZSHZ+ATcmtoatCK5
        Ao39aVrnL7AnF1iMHj5MBdjEJsbplVDaffL5AOs=
X-Google-Smtp-Source: AFSGD/WBnHQ4Jg2NCAd36rtM2rDQGzWSY2TiXGaItfQGlX+yRmTcOlLFLStrKzHQV0D+5XlU6/RZifnJZ2SIKp2qZ5k=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr17194581otf.124.1543338894950;
 Tue, 27 Nov 2018 09:14:54 -0800 (PST)
MIME-Version: 1.0
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com> <20181126111526.56340-2-mika.westerberg@linux.intel.com>
In-Reply-To: <20181126111526.56340-2-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Nov 2018 18:14:43 +0100
Message-ID: <CAJZ5v0he4BmyJ97=uwVpJtojhe0f5pTq81LBdAQG6RFy6edKrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, ckellner@redhat.com,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 26, 2018 at 12:15 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Recent systems with Thunderbolt ports may support IOMMU natively. This
> means that the platform utilizes IOMMU to prevent DMA attacks over
> externally exposed PCIe root ports (typically Thunderbolt ports)
>
> The system BIOS marks these PCIe root ports as being externally facing
> ports by implementing following ACPI _DSD [1] under the root port in
> question:
>
>   Name (_DSD, Package () {
>       ToUUID ("efcc06cc-73ac-4bc3-bff0-76143807c389"),
>       Package () {
>           Package () {"ExternalFacingPort", 1},
>           Package () {"UID", 0 }
>       }
>   })
>
> To make it possible for IOMMU code to identify these devices, we look up
> for this property and mark all children devices (including the root port
> itself) with a new flag (->is_untrusted). This flag is meant to be used
> with all PCIe devices (not just Thunderbolt) that cannot be trusted in
> the same level than integrated devices and may need to put behind full
> IOMMU protection.
>
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/property.c |  3 +++
>  drivers/pci/pci-acpi.c  | 18 ++++++++++++++++++
>  drivers/pci/probe.c     | 22 ++++++++++++++++++++++
>  include/linux/pci.h     |  8 ++++++++
>  4 files changed, 51 insertions(+)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 8c7c4583b52d..4bdad32f62c8 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -31,6 +31,9 @@ static const guid_t prp_guids[] = {
>         /* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
>         GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
>                   0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
> +       /* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
> +       GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
> +                 0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
>  };

One observation here.  Note that I really have no strong opinion on
that, so this is not an objection, but IMO it is fair to make things
clear for everybody.

So this causes the External facing port GUID (which already is the
case with the Hotplug in D3 GUID for that matter) to be practically
equivalent to the ACPI _DSD device properties GUID.  This means that
Linux will consider a combination of any of these GUIDs with any
properties defined for any of them as valid, which need not be the
case in Windows.

For example, since the ExternalFacingPort property is defined along
with the External facing port GUID, Windows will likely ignore it if
it is used in a combination with the Hotplug in D3 GUID or the ACPI
_DSD device properties GUID.  If the firmware combines the Hotplug in
D3 GUID or the ACPI _DSD device properties GUID with that property,
Windows will not regard it as valid, most likely, but Linux will use
it just fine.  In the face of ASL bugs, which are inevitable (at least
just because ASL is code written by humans), that may become a real
problem, as systems successfully tested with Windows may not work with
Linux as expected and vice versa because of it.

From the ecosystem purity perspective this should be avoided, but then
I do realize that this allows code to be re-used and avoids quite a
bit of complexity.  The likelihood of an ASL bug that will expose this
issue is arguably small, so maybe it is not a practical concern after
all.
