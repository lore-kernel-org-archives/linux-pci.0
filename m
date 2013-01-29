Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:36415 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756569Ab3A2Opc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 09:45:32 -0500
Message-ID: <5107E088.6030608@fold.natur.cuni.cz>
Date: Tue, 29 Jan 2013 15:45:28 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Oliver Neukum <oneukum@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: pciehp: errors on resume
References: <1359377173.1345.25.camel@x61.thuisdomein>  <51072F83.7040102@cn.fujitsu.com>  <1359455732.1345.46.camel@x61.thuisdomein>  <3774810.Obias7PJ4I@vostro.rjw.lan> <1359462737.1345.58.camel@x61.thuisdomein>
In-Reply-To: <1359462737.1345.58.camel@x61.thuisdomein>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Paul Bolle wrote:
> On Tue, 2013-01-29 at 12:35 +0100, Rafael J. Wysocki wrote:
>> On Tuesday, January 29, 2013 11:35:32 AM Paul Bolle wrote:
>>> Thanks. So should the fix here be to actually suspend and remove this
>>> device? (Note that pciehp_suspend() is now basically a NOP.)
>>
>> I think it wouldn't be useful to remove devices on all suspends, but then there
>> are a few different situations that resume has to consider and handle correctly:
>>
>> 1) Device has been removed while suspended.
>> 2) Device was present before suspend and is still there.
>> 3) Device has been added while suspended.
> 
> Obviously, I care about situation 2) here. (It would be quite a feat to
> remove or add a wireless card while the laptop is suspended.)

  I don't use suspend on my laptop to avoid possible problems with crashes
and data loss (so I rather quit my apps and shutdown). Therefore I have no
experience with that ... but it is my impression that the obvious use is to
close the lid, unplug an external mouse/keyboard and go elsewhere, maybe
re-plug the mouse/keyboard into different slots (hey, I can't remember
whether I had mouse in this or the other socket) and open the lid. Even
being unintentionally nasty to the OS and re-plugging the devices after
I opened the laptop lid! I understand one is in all these scenarios just
doing the bad thing and just asking for a trouble ... but that's why I
don't use that feature. My memory is leaky and my behavior is error-prone
so I am sure once I would screw the order. Maybe OS could force disconnect of all
external devices which are reasonably safe (mouse and keyboard while not
say external USB drive)?

  Nevertheless, is it possible to have an external drive connection preserved
through suspend so that it survives under same device id? I don't know if this
a possible at all ... If not, then OS could could unplug even external drives.

My apologies if I am talking talking non-sense here. I really don't use suspend
so my knowledge is zero.
Martin
