Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63253 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751553AbaAON26 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2014 08:28:58 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Rajat Jain <rajatjain@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>
Subject: Re: User initiated hotplug and kernel initiated hotplug - where is the synchronization?
Date: Wed, 15 Jan 2014 14:42:57 +0100
Message-ID: <18064064.UldA0zYdyf@vostro.rjw.lan>
In-Reply-To: <635a0ddff97142e2a06f9bd9c3428d01@DM2PR05MB671.namprd05.prod.outlook.com>
References: <635a0ddff97142e2a06f9bd9c3428d01@DM2PR05MB671.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, January 15, 2014 09:43:58 AM Rajat Jain wrote:
> Hello,

Hi,

> I have this doubt lingering on, and I'd appreciate if some one could throw light on this:
> 
> The kernel hotplug driver pciehp can initiate hotplug based on what it senses from the HW (button press etc).
> 
> The user space can also initiate the same operations by using "rescan" or "remove" attributes in sysfs.
> 
> My questions:
> 
> 1) Is it safe to mix the above two?

Not right now, but with these patches applied:

https://patchwork.kernel.org/patch/3466551/
https://patchwork.kernel.org/patch/3466581/
https://patchwork.kernel.org/patch/3466601/
https://patchwork.kernel.org/patch/3466591/
https://patchwork.kernel.org/patch/3466631/
https://patchwork.kernel.org/patch/3466641/
https://patchwork.kernel.org/patch/3466651/
https://patchwork.kernel.org/patch/3491811/
https://patchwork.kernel.org/patch/3466491/
https://patchwork.kernel.org/patch/3473341/

it should be.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
