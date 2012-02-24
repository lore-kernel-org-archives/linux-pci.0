Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:58529 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756350Ab2BXVHK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 16:07:10 -0500
Message-ID: <4F47FB6B.3050509@jp.fujitsu.com>
Date: Fri, 24 Feb 2012 16:04:43 -0500
From: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, greg@kroah.com,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org
Subject: Re: [PATCH v5] Add pcie_hp=nomsi to disable MSI/MSI-X for pciehp
 driver
References: <20120202160922.4564.99032.sendpatchset@dhcp-189-101.bos.redhat.com> <20120223123003.662cf548@jbarnes-desktop>
In-Reply-To: <20120223123003.662cf548@jbarnes-desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 23 Feb 2012 12:30:03 -0800,
Jesse Barnes <jbarnes@virtuousgeek.org> wrote:

> On Thu, 2 Feb 2012 11:09:22 -0500
> MUNEDA Takahiro<muneda.takahiro@jp.fujitsu.com>  wrote:
>
>> Not to use MSI/MSI-X for pciehp, add a kernel parameter, pcie_hp=nomsi.
>>
>> In my environment, while shutting down, following stack trace is shown
>> sometimes.
>
> Applied, thanks guys.
>
> Now should we also have a platform/device blacklist to enable this
> option automatically so people don't have to remember to use it?

Hi Jesse,

I agree with you.
However, I don't have a device which *officially* has a problem
regarding this.  I'm waiting a statement from vendor.  We should start
after statement becomes available.

Thanks,
Takahiro
