Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C65C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 16:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948F1208E4
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 16:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948F1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeK1Dse (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:48:34 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33002 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeK1Dse (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Nov 2018 22:48:34 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so20775939otl.0;
        Tue, 27 Nov 2018 08:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJCj7vK0zBuuvOMxLpjkEUxKpjWVJIgSW7zI2E5ss2o=;
        b=dWmtDY5xk3ucXPSMvAeStQULn2ue2nIy+3wkGoU8luP0GAOlItf7qGCt10AMhTNYnS
         BZOiO4oT5mpP+V07GJYiVKyVrNF02qagrjB3x/TxSymMATSyn8p8MvI5PVHlHuRvToyv
         URI/gHIM2pCaQomeEHHVuno1t2x7y1O7XGQAD1rUBNMKdo9zj54l8Ciw0fe29v8Chlpz
         pLLNndT6Xman1YCXgY/KYrz2T4rA2uDxxxpwGpaKDLPV3DXoYmQRUxKXkUBagwG+EgRA
         GRygc0nR218aRJ3DlHzEcn6QzxG+yG25NfkWgklZE6Gm2Yr7AF1bs/y8pKkfXC5w7Gvu
         03vA==
X-Gm-Message-State: AGRZ1gJVhYCWQIZIbYeIkDSSnQMxTmhVMXsG9WGZLhSfMLHYj8FwoJPM
        WV4ioU3DxE88o2DkgC9+5lxdIPfLlEj2aTe8pls=
X-Google-Smtp-Source: AFSGD/WeVBJI0BfxUWVjFs31XL8yQEMlnqITpaAUMyNroLh3tvj5yvobAv1/KZd+fOR6zF4q8a59nI8gIH2BE38cUl4=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr19276782otg.139.1543337404384;
 Tue, 27 Nov 2018 08:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
 <20181126111526.56340-2-mika.westerberg@linux.intel.com> <20181127001711.GC212532@google.com>
 <20181127085426.GI2296@lahna.fi.intel.com>
In-Reply-To: <20181127085426.GI2296@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Nov 2018 17:49:53 +0100
Message-ID: <CAJZ5v0gxap5qWQTrmrTmzfvL0RerZ1T1MUPyh6b1FAHY9N0Ryw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
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

On Tue, Nov 27, 2018 at 9:54 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Nov 26, 2018 at 06:17:11PM -0600, Bjorn Helgaas wrote:
> > Hi Mika,
>
> Hi,
>
> > On Mon, Nov 26, 2018 at 02:15:23PM +0300, Mika Westerberg wrote:
> > > Recent systems with Thunderbolt ports may support IOMMU natively.
> >
> > This sentence doesn't make sense to me.  There's no logical connection
> > between having an IOMMU and having a Thunderbolt port.
> >
> > > This means that the platform utilizes IOMMU to prevent DMA attacks
> > > over externally exposed PCIe root ports (typically Thunderbolt
> > > ports)
> >
> > Nor this one.  The platform only uses the IOMMU to prevent DMA attacks
> > if the OS chooses to do that.
>
> I guess I'm trying to say here that the recent changes add such support
> to the platform BIOS that allows the OS to enable IOMMU without being
> compromised by a malicious device that is already connected. The BIOS
> sets the new ACPI DMAR bit in that case.
>
> > > The system BIOS marks these PCIe root ports as being externally facing
> > > ports by implementing following ACPI _DSD [1] under the root port in
> > > question:
> >
> > There's no standard that requires this, so the best we can say is that
> > a system BIOS *may* mark externally facing ports with this mechanism.
>
> There is no standard but I'm quite sure this is something that will be
> required to be implemented properly by the OEM by Microsoft hardware
> compatibility suite.

I think it would be fair to say that future versions of Windows will
expect the firmware to identify the "externally facing" root PCIe
ports as per the above which practically means that it is as good as a
formal standard in the Windows world.
