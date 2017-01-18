Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:41913 "EHLO quartz.orcorp.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbdARVIj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jan 2017 16:08:39 -0500
Date: Wed, 18 Jan 2017 14:08:31 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dennis.dalessandro@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH] [RFC] IB/hfi1: Fix port ordering issue in a multiport
 device
Message-ID: <20170118210831.GA7590@obsidianresearch.com>
References: <148409267200.13402.16060755922068447437.stgit@tstruk-mobl1.ra.intel.com>
 <20170111181042.GC22783@obsidianresearch.com>
 <1484773260.2406.58.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1484773260.2406.58.camel@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 18, 2017 at 04:01:00PM -0500, Doug Ledford wrote:

> OK, sure, as far as the reordering stuff is concerned, all you need to
> do is to make use of the EPROBE_DEFER return option to your PCI probe
> routine.  That way, when you get the probe for the out of order
> port,

EPROBE_DEFER is intended when waiting on other components the driver
may need, not for setting stable names.

This is a 'stable device naming' problem, which we have never tried to
solve in RDMA.

udev is the expected kernel way to solve this. Trying to hack stable
names by forcing device bind order is horrible.

hfi runs smack into this because it is the first scheme to actually
typically operate in a multi-struct ib_device world, which means they
get to solve it properly :\

Jason
