Return-Path: <SRS0=w3ET=GK=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=w3ET=GK=davemloft.net=davem@kernel.org>
Date: Tue, 20 Mar 2018 17:04:41 -0400 (EDT)
Message-Id: <20180320.170441.1570889987094445930.davem@davemloft.net>
To: helgaas@kernel.org
Cc: khalid.aziz@oracle.com, yinghai@kernel.org, david.ahern@oracle.com,
 linux@iam.tj, airlied@linux.ie, alex.williamson@redhat.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: Sparc 64-bit resource fixups
From: David Miller <davem@davemloft.net>
In-Reply-To: <152157662729.167463.14127576964193645242.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152157662729.167463.14127576964193645242.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 20 Mar 2018 15:14:01 -0500

> These are from an old series from Yinghai [1] that fix some issues on
> sparc64.  The v1 posting is at [2].
> 
> [1] https://lkml.kernel.org/r/20170421050500.13957-1-yinghai@kernel.org
> [2] https://lkml.kernel.org/r/20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com
> 
> Changes from v1:
> - In v1, I reserved the "Video ROM" and "System ROM" regions from system
>   memory, not from the PCI bus address space.  In v2, I removed those
>   reservations completely because they seem to be copied from x86 and are
>   not applicable on sparc.

For the series:

Acked-by: David S. Miller <davem@davemloft.net>
