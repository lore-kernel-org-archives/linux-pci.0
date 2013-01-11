Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:57375 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3AKK2t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2013 05:28:49 -0500
Received: by mail-bk0-f44.google.com with SMTP id w11so814898bku.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2013 02:28:47 -0800 (PST)
From: bl0 <bl0-052@playker.info>
To: linux-ide@vger.kernel.org
Subject: Re: sata_sil data corruption, possible workarounds
Date: Fri, 11 Jan 2013 11:28:35 +0100
Cc: linux-pci@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>,
	Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>
References: <kahap3$mur$1@ger.gmane.org> <50ECF6AB.30007@gmail.com> <20130109191753.GQ3926@htj.dyndns.org>
In-Reply-To: <20130109191753.GQ3926@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201301111128.35957.bl0-052@playker.info>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 09 January 2013 20:17:53 Tejun Heo wrote:
> Hello, Robert, bl0 (would be cool if this were your real name :)
>
> On Tue, Jan 08, 2013 at 10:48:43PM -0600, Robert Hancock wrote:
> > I wouldn't mind something like this as an option, anyway. Jeff,
> > Tejun, thoughts?
>
> I don't know.  This thread makes me want to eat obsessivly, cry in
> fetal position and then puke and wet my pants.
>
> The issue has been there from the beginning.  The current code seems
> to cope with, I hope, majority of configurations; unfortunately, for
> the problematic ones, there hasn't been any sensible explanation or
> reliable way to detect what is causing the problem.  I don't even know
> how we should blacklist them.  Is it chipset-specific or
> system-specific?  ie. Should we blacklist north/south bridges or DMI
> system identifiers?
>
> Having a module option is easy and can be helpful for the very rare
> cases where the admin is aware of the issue, but, in general, it
> doesn't really help that much.
>
> So, let's throw in a module option.  Other than that, no idea.
>
> \pukes

Thanks for bringing much needed enthusiasm into this thread. I too would 
like to know the root cause of this problem. Since the chances of finding 
it are very low, the only thing that remains is to deal with data corruption 
problem using the means available.

Some people asked for help and posted relevant entries from their logs. Now 
they would be able to find a hint about the module option in the logs. Some 
people have set the slow_down option. The code i posted enables the 
workaround for them too.

As for blacklisting, I was thinking about maybe looking at the vendor and 
device ID of the PCI bridge under which the sata_sil device is found.
