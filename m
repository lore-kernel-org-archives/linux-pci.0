Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:6869 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753314AbdASQvX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jan 2017 11:51:23 -0500
Subject: Re: [PATCH] [RFC] IB/hfi1: Fix port ordering issue in a multiport
 device
To: Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <148409267200.13402.16060755922068447437.stgit@tstruk-mobl1.ra.intel.com>
 <20170111181042.GC22783@obsidianresearch.com>
 <1484773260.2406.58.camel@redhat.com>
 <20170118210831.GA7590@obsidianresearch.com>
 <934eb6c4-fbba-28d0-d6bb-f036cc9ced5c@intel.com>
 <1484785071.2406.69.camel@redhat.com>
Cc: linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dennis.dalessandro@intel.com, ira.weiny@intel.com
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <7f728991-3bc6-b3ce-ebee-094a6439c369@intel.com>
Date: Thu, 19 Jan 2017 08:51:22 -0800
MIME-Version: 1.0
In-Reply-To: <1484785071.2406.69.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/18/2017 04:17 PM, Doug Ledford wrote:
>>> EPROBE_DEFER is intended when waiting on other components the
>>> driver
>>> may need, not for setting stable names.
>> Also EPROBE_DEFER only works during boot time.
>> After boot when a module gets rmmod/insmod EPROBE_DEFER has no
>> effect.
> Are you positive about this?  And even if you are, my answer is to fix
> the core to honor EPROBE_DEFER post boot.

Yes, the driver_deferred_probe_trigger() function is called from
late_initcall(). After boot there is nothing to call it again.
I'm investigating the udev path now as Jason suggested, but
udev has its own limitations.
I will see what it would take to extend the EPROBE_DEFER
functionality after boot.
Thanks,
-- 
Tadeusz
