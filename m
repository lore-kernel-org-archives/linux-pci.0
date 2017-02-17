Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35245 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934149AbdBQRxO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2017 12:53:14 -0500
Received: by mail-pf0-f179.google.com with SMTP id 68so4220791pfx.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Feb 2017 09:53:14 -0800 (PST)
Date: Fri, 17 Feb 2017 09:47:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci-hyperv: Use device serial number as PCI domain
Message-ID: <20170217094703.1af2e8bd@plumbers-lap.home.lan>
In-Reply-To: <BLUPR03MB1412C010C2F994101438FC5ACA590@BLUPR03MB1412.namprd03.prod.outlook.com>
References: <BLUPR03MB1412C010C2F994101438FC5ACA590@BLUPR03MB1412.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 13 Feb 2017 18:10:11 +0000
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> This allows PCI domain numbers starts with 1, and also unique
> on the same VM. So names, such as VF NIC names, that include
> domain number as part of the name, can be shorter than that
> based on part of bus UUID previously. The new names will also
> stay same for VMs created with copied VHD and same number of
> devices.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>

Looks like a good solution to persistent names.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
