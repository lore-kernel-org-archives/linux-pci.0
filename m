Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:10868 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeIHPu6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Sep 2018 11:50:58 -0400
Subject: Re: [PATCH] PCI: Reprogram bridge prefetch registers on resume
To: Peter Wu <peter@lekensteyn.nl>, Daniel Drake <drake@endlessm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, linux-pm@vger.kernel.org,
        kherbst@redhat.com, andriy.shevchenko@linux.intel.com,
        rafael.j.wysocki@intel.com, keith.busch@intel.com,
        mika.westerberg@linux.intel.com, jonathan.derrick@intel.com,
        davem@davemloft.net, hkallweit1@gmail.com, netdev@vger.kernel.org,
        nic_swsd@realtek.com
References: <20180907053614.6540-1-drake@endlessm.com>
 <20180907150515.GA28739@al>
From: Thomas Martitz <kugel@rockbox.org>
Message-ID: <cd2f572a-9c1f-41c1-6e95-759cfec501d9@rockbox.org>
Date: Sat, 8 Sep 2018 13:05:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180907150515.GA28739@al>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 07.09.18 um 17:05 schrieb Peter Wu:
> On Fri, Sep 07, 2018 at 01:36:14PM +0800, Daniel Drake wrote:
> <..>
>> Thomas Martitz reports that this workaround also solves an issue where
>> the AMD Radeon Polaris 10 GPU on the HP Zbook 14u G5 is unresponsive
>> after S3 suspend/resume.
> 
> Where was this claimed? It is not stated in the linked bug:
> (https://bugs.freedesktop.org/show_bug.cgi?id=105760
> 


Actually, I reported that https://patchwork.kernel.org/patch/10583229/ 
works. I updated the bug now, I didn't do so yet because it's closed.

However, I did not actually test the exact patch *this* thread is about. 
Do you want me to give it a spin?

Best regards.
