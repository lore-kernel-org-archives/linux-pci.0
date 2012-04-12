Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:43370 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab2DLEGd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2012 00:06:33 -0400
Date: Wed, 11 Apr 2012 22:06:31 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Don Dutile <ddutile@redhat.com>
Cc: "Hao, Xudong" <xudong.hao@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V4] Quirk for IVB graphics FLR errata
Message-ID: <20120412040630.GC6557@parisc-linux.org>
References: <403610A45A2B5242BD291EDAE8B37D300FD0DA33@SHSMSX102.ccr.corp.intel.com> <4F8594FD.8020109@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F8594FD.8020109@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 11, 2012 at 10:28:13AM -0400, Don Dutile wrote:
>> +	cycles_t cyc_op_timeout = tsc_khz*op_timeout*1000;
> Don't we know how to do a 10sec timeout w/o tying it to tsc_khz?

Right, this code should of course be using jiffies and msleep.

> --> other arch compile problem source???

Well, this device is part of the x86 CPU.  It's never going to be found
as part of any other architecture.  Why force other architectures to
carry this quirk around?


-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
