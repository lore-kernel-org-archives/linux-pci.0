Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:49562 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684Ab2DZAa7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Apr 2012 20:30:59 -0400
Received: by dadz8 with SMTP id z8so762885dad.10
        for <linux-pci@vger.kernel.org>; Wed, 25 Apr 2012 17:30:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120425233632.12292.32916.stgit@bhelgaas.mtv.corp.google.com>
References: <20120425233632.12292.32916.stgit@bhelgaas.mtv.corp.google.com>
Date: Wed, 25 Apr 2012 17:30:58 -0700
Message-ID: <CAE9FiQWUvZZ+z6-g3B1xCjjPcY_VwcY8FX5oMgRDAvLut=vXNw@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: work around Stratus ftServer broken PCIe hierarchy
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Matthew Wilcox <matthew.wilcox@linux.intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Myron Stowe <mstowe@redhat.com>,
	James Paradis <jim.paradis@stratus.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 25, 2012 at 4:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> A PCIe downstream port is a P2P bridge.  Its secondary interface is
> a link that should lead only to device 0 (unless ARI is enabled)[1], so
> we don't probe for non-zero device numbers.
>
> Some Stratus ftServer systems have a PCIe downstream port (02:00.0) that
> leads to both an upstream port (03:00.0) and a downstream port (03:01.0),
> and 03:01.0 has important devices below it:
>
>  [0000:02]-+-00.0-[0000:03]--+-00.0
>                              \-01.0-[0000:xx]--+-[USB]
>                                                \-[NIC]
>
> Previously, we didn't enumerate device 03:01.0, so USB and the network
> didn't work.  This patch adds a DMI quirk to scan all device numbers,
> not just 0, below a downstream port.

is there output for
lspci -vvxxx -s 03:00.0
lspci -vvxxx -s 03:00.1

like to know what is the 03:00.0.

Thanks

Yinghai
