Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40622 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbcBWOHy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 09:07:54 -0500
Date: Tue, 23 Feb 2016 08:07:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH v4 00/11] PCI VPD access fixes
Message-ID: <20160223140750.GA12885@localhost>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hannes,

Thanks for taking a look at the rest of these.

On Mon, Feb 22, 2016 at 06:46:23PM -0600, Bjorn Helgaas wrote:
> Hi Hannes,
> 
> This is a revision of your v3 series:
> http://lkml.kernel.org/r/1455525722-122040-1-git-send-email-hare@suse.de
> 
> Here's the description from your v3 posting:
> 
>   the current PCI VPD page access assumes that the entire possible VPD
>   data is readable. However, the spec only guarantees a VPD data up to
>   the 'end' marker, with everything beyond that being undefined.
>   This causes a system lockup on certain devices.
> 
>   With this patch we always set the VPD sysfs attribute size to '0', and
>   calculate the available VPD size on the first access.
>   If no valid data can be read an I/O error is returned.

Just to see if I have this right: the VPD file size in sysfs will
always appear as zero, regardless of whether it has been read or
written, right?  I don't think the user-visible size should change.

Bjorn
