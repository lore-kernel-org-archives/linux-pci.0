Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51174 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759061Ab2AGBaP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2012 20:30:15 -0500
Received: by ggdk6 with SMTP id k6so971528ggd.19
        for <linux-pci@vger.kernel.org>; Fri, 06 Jan 2012 17:30:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120106135833.3d026d3f@jbarnes-desktop>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-4-git-send-email-yinghai@kernel.org>
	<20120106135833.3d026d3f@jbarnes-desktop>
Date: Fri, 6 Jan 2012 17:30:15 -0800
Message-ID: <CAE9FiQU6FPWb+aO3iqrf1Bwb7bmNO4H9v-pcpNGEx71NEiJhAg@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: Using add_list in pcie hotplug path.
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 6, 2012 at 1:58 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> On Wed,  7 Dec 2011 00:53:02 -0800
> Yinghai Lu <yinghai@kernel.org> wrote:
>
>> We need add size for hot plug path when pluging in hotplug chassis without cards.
>> -v2: change descriptions. make it can be applied after
>>       pci: Check bridge resources after resource allocation.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>
> 3, 4, and 5 are related right?

4, 5 are related.

>  Do you have bug reports to reference
> for the case where a chassis w/o devices is plugged in then you try to
> plug in a device and it fails?  I suppose even if devices are added one
> at a time and enabled the realloc will still work as long as it only
> grows and doesn't move or shrink...

No report, just from the code review.

can you check other patch in my branch?

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci

esp:

PCI: Make sriov work with hotplug remove
pciehp: Checking pci conf reading to new added device instead of sleep 1s

Thanks

Yinghai Lu
