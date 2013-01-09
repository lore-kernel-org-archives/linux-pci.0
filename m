Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:51851 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932425Ab3AITR5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 14:17:57 -0500
Date: Wed, 9 Jan 2013 11:17:53 -0800
From: Tejun Heo <tj@kernel.org>
To: Robert Hancock <hancockrwd@gmail.com>
Cc: bl0 <bl0-052@playker.info>, linux-ide@vger.kernel.org,
	linux-pci@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_sil data corruption, possible workarounds
Message-ID: <20130109191753.GQ3926@htj.dyndns.org>
References: <kahap3$mur$1@ger.gmane.org>
 <50CCF1E0.9070804@gmail.com>
 <kakea2$dh1$1@ger.gmane.org>
 <50CEB13B.9010100@gmail.com>
 <kaq1n6$hqa$1@ger.gmane.org>
 <kb9pa2$mi8$1@ger.gmane.org>
 <50ECF6AB.30007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50ECF6AB.30007@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, Robert, bl0 (would be cool if this were your real name :)

On Tue, Jan 08, 2013 at 10:48:43PM -0600, Robert Hancock wrote:
> >>Do you think something should be done about it in the linux sata_sil
> >>driver? For a lack of a better solution, here is my suggestion. There is
> >>already one option 'slow_down' for problematic disks. Another option, for
> >>example 'cache_line_workaround', could be added for problematic
> >>motherboards. If enabled, the most straightforward way is to set cache
> >>line size to 0 and not worry about the fifo_cfg register.
> >
> >Here is the code I currently have, attached as a diff. (This diff is not
> >against the latest git tree, it's against an older linux version which I
> >use.)
> 
> I wouldn't mind something like this as an option, anyway. Jeff,
> Tejun, thoughts?

I don't know.  This thread makes me want to eat obsessivly, cry in
fetal position and then puke and wet my pants.

The issue has been there from the beginning.  The current code seems
to cope with, I hope, majority of configurations; unfortunately, for
the problematic ones, there hasn't been any sensible explanation or
reliable way to detect what is causing the problem.  I don't even know
how we should blacklist them.  Is it chipset-specific or
system-specific?  ie. Should we blacklist north/south bridges or DMI
system identifiers?

Having a module option is easy and can be helpful for the very rare
cases where the admin is aware of the issue, but, in general, it
doesn't really help that much.

So, let's throw in a module option.  Other than that, no idea.

\pukes

-- 
tejun
