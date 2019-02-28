Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64540C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 20:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E862084F
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 20:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW1Nh+cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbfB1Um1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:42:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37555 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733049AbfB1Um1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 15:42:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so10164021wmg.2
        for <linux-pci@vger.kernel.org>; Thu, 28 Feb 2019 12:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wo/LUz+YAoHMxzB9Y7V0ETnhY6VR9dzHyL71ShD5rSA=;
        b=LW1Nh+cuFRwVhlqTTyUjN+fKMDPV5Ij6APlwPDgTrF99V362MKgmc1EF6k1GwDE3OA
         Gb5ka8IS89BVzhzza5St7D8WNWD58lDqQbqbgNMvqvKMVM/6Gjo96IkYqvQ0+OOhJtDs
         XGAPEWstafAhSKpsLh+nwAbzWzxTT+bEZu0rrrTckhCOitnGu93xnndgUdLdu4l7DT4J
         xI8TfWEt48cAOnmwqzYQn+7bxIj+TWTp3cKpNd6o8qPDBeydYfHLLR9IyKBkyIfC+gXH
         y5KQJGjKWuZIZ+1Cyi5t8B1mRnzDOKtkwVSYii5hOVdQ8A04ArO3ec3ySso3w7UgVGW7
         HCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wo/LUz+YAoHMxzB9Y7V0ETnhY6VR9dzHyL71ShD5rSA=;
        b=n1XwUhJd1XEW9NFLKLxOrj9G2prny1NoQJgfoFQeYbidB4l5HGpxuN0ll/lka7Vr8+
         DLVoAjtHNf7hJOWPKZkphGvoQVox/pc5eEJkzrz/yc66GM0lCTQoUAF3RMJEbf97Xekf
         7XI0UdzWDM+yoQDSlkKQR0jIRsvJz3VbGUu72v8sMfwOUkluAHdr/aSbLJdg0qsiYqQk
         GpsO5Y5Ppq0SpIVebJ6o/UU8DnBpNGf12YZlk3yA+wSQnOurkokCKG9TfrjCfJkiJdzm
         FDRnq7eH9Opuy/tFpWCgMtQ5SBb8JOj/ppX3CQA93coXJNU2u2hA/aWKT131cpBynZ6X
         CyLg==
X-Gm-Message-State: APjAAAWCjSaOX0g7l2oSu6sas65J62rLc99KLZNDFFDuc2B2g6IVJ+qp
        mikOpx1lhKhLLhx8386IK9SCetRBX/zVPD8/fRvV
X-Google-Smtp-Source: AHgI3IaS31r8tqzQtG9diGcEoXIbxHGnKO889J/PyXS1u8RFw/damVN2hxhcGZeqDTBkUQZUEMoK3NMQn0kbH2CDOBc=
X-Received: by 2002:a1c:6409:: with SMTP id y9mr1048634wmb.68.1551386545111;
 Thu, 28 Feb 2019 12:42:25 -0800 (PST)
MIME-Version: 1.0
References: <1943648.NMEmlssb0J@aspire.rjw.lan>
In-Reply-To: <1943648.NMEmlssb0J@aspire.rjw.lan>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 28 Feb 2019 14:42:13 -0600
Message-ID: <CAErSpo6WEgqQ2Loub4QKzCvmh5V6nU8X8sui3WLdJbgVZ0BnJw@mail.gmail.com>
Subject: Re: [PATCH] PCI: PCIe: PME: Fix pcie_pme_remove()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dongdong Liu <liudongdong3@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 27, 2019 at 5:58 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is incorrect to call pcie_pme_suspend() from pcie_pme_remove() for
> two reasons.
>
> First, pcie_pme_suspend() calls synchronize_irq() that will wait for
> the native hotplug interrupt handler as well as for the PME one,
> because they share one IRQ (as per the spec).  That may deadlock if
> hotplug is signaled while pcie_pme_remove() is running and the latter
> calls pci_lock_rescan_remove() before the former.
>
> Second, if pcie_pme_suspend() figures out that wakeup needs to be
> enabled for the port, it will return without disabling the interrupt
> as expected by pcie_pme_remove() which was overlooked by commit
> c7b5a4e6e8fb ("PCI / PM: Fix native PME handling during system
> suspend/resume").
>
> To fix that, rework pcie_pme_remove() to disable the PME interrupt,
> clear its status and prevent the PME worker function from re-enabling it
> before calling free_irq() on it which should be sufficient.
>
> Fixes: c7b5a4e6e8fb ("PCI / PM: Fix native PME handling during system suspend/resume")
> Reported-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I added the deadlock details from Dongdong and applied this to pci/pm
for v5.1, thanks!

Bjorn
