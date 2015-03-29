Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:48156 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbbC2XPs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Mar 2015 19:15:48 -0400
Date: Mon, 30 Mar 2015 01:15:39 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 00/86] pci: export pci_ids.h and related cleanups
Message-ID: <20150330011539.4bfa5288@kant>
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mar 29 Michael S. Tsirkin wrote:
> The macros in pci_ids.h are pretty useful for userspace
> using the pci sysfs interface, e.g. to decode class
> device and vendor sysfs files.
> 
> At the moment userspace is forced to duplicate these macros (e.g. QEMU does
> this, so does gpxe, seabios, etc), it is better to export them in
> /usr/include/linux/pci_ids.h so everyone can just include this header.
> 
> This patchset is structured as follows:
> 1. include/linux/pci_ids.h is moved to include/uapi/linux/pci_ids.h;
>    a stub file is created in include/linux/pci_ids.h to avoid breaking
>    bisect

Since linux' include/linux/pci_ids.h is incomplete, I am doubtful that it
is appropriate for userspace.

> 2. all users are converted to use the new header

This step should not be necessary.  It has not been done with other
headers which were moved to include/uapi.

> 3. include/linux/pci_ids.h is removed
> 4. cleanups for several issues detected during step 2

-- 
Stefan Richter
-=====-===== --== ====-
http://arcgraph.de/sr/
