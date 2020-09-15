Return-Path: <SRS0=UCfD=CY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADC3C43461
	for <linux-pci@archiver.kernel.org>; Tue, 15 Sep 2020 18:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21E7206DB
	for <linux-pci@archiver.kernel.org>; Tue, 15 Sep 2020 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600194593;
	bh=SOf5GPk0ofBAZic38qIw0rzSxyoNY+paZdgL59LQdS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=npeD9ZidTLm6H/FPVVHBsCRecx8I5qNzmAjYXwGvxcl22So7WAczfvHppGUdWms10
	 V5xv8l2oEWW2XgoXy5S6hb7beBWKg5i+vBLBz93OJpII3yKWJxkZJhvid1R0A5s0nT
	 uTYXcIrEDrmF21gml7eBHvWKAI3+iH0ZY5qYd0V8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgIOSSu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgIOSRz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 14:17:55 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A464D206A4;
        Tue, 15 Sep 2020 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600193873;
        bh=SOf5GPk0ofBAZic38qIw0rzSxyoNY+paZdgL59LQdS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2dyWR6CL2IFk0fQVtX4jPy+tyazQgO0d/tZUT6oV24BvEPHvfH2I6t0UcvVcV+hKI
         gw1UxbFwNGdOkjv9licKDUny6aw9JB5BA5ec0yp52bdoi6R0SR/i3ZL3iSSzLZapNP
         FCctIhZrz2oS6TNlZqc2fODXjjkn76NzZA4/N92k=
Date:   Tue, 15 Sep 2020 13:17:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Shiju Jose <shiju.jose@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v15 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Message-ID: <20200915181751.GA1408867@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0goduHVhXdOjDu6WBnD8eBYzRWAD1PO8KjabpyiHuJ1qw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 07:31:50PM +0200, Rafael J. Wysocki wrote:
> On Mon, Sep 14, 2020 at 2:34 PM Shiju Jose <shiju.jose@huawei.com> wrote:
> >
> > Hello,
> >
> > Can you help to merge this series?
> 
> Do you want this series to go in through the ACPI tree?

It crosses ACPI and vendor-specific PCI, but the bulk of the changes
are in PCI.  I gave some comments on the design and acked the PCI part
from my point of view.  I envisioned Lorenzo merging it since he takes
care of drivers/pci/controller/*, but either that (given your ack for
the ACPI part) or ACPI would be OK with me.

> > > drivers/acpi/apei/ghes.c                 |  63 +++++
> > > drivers/pci/controller/Kconfig           |   7 +
> > > drivers/pci/controller/Makefile          |   1 +
> > > drivers/pci/controller/pcie-hisi-error.c | 327 +++++++++++++++++++++++
> > > include/acpi/ghes.h                      |  18 ++
> > > 5 files changed, 416 insertions(+)
> > > create mode 100644 drivers/pci/controller/pcie-hisi-error.c
