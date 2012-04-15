Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm25.bullet.mail.bf1.yahoo.com ([98.139.212.184]:24589 "HELO
	nm25.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753338Ab2DOKrJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 15 Apr 2012 06:47:09 -0400
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204132118.22074.rjw@sisk.pl> <1334346546.93033.YahooMailNeo@web161806.mail.bf1.yahoo.com> <201204132219.23106.rjw@sisk.pl> <1334350068.79333.YahooMailNeo@web161804.mail.bf1.yahoo.com> <CAAMvbhEFLHPsemALYVQwsuTaAiom1RviLECcPwqdtzA4ogmuLw@mail.gmail.com>
Message-ID: <1334486827.79192.YahooMailNeo@web161806.mail.bf1.yahoo.com>
Date: Sun, 15 Apr 2012 03:47:07 -0700 (PDT)
From: Mikko Vinni <mmvinni@yahoo.com>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Allen Kay <allen.m.kay@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
In-Reply-To: <CAAMvbhEFLHPsemALYVQwsuTaAiom1RviLECcPwqdtzA4ogmuLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: James Courtier-Dutton:

> 
> On 13 April 2012 21:47, Mikko Vinni <mmvinni@yahoo.com> wrote:
>>        1 firewire_ohci 0000:0a:00.0: Refused to change power state, 
> currently in D3
>>       10 firewire_ohci 0000:0a:00.0: restoring config space at offset 0xf 
> (was 0xffffffff, writing 0x10a)
>>       10 firewire_ohci 0000:0a:00.0: restoring config space at offset 0xe 
> (was 0xffffffff, writing 0x0)
> <snip>
>>        1 sdhci-pci 0000:0a:00.1: Refused to change power state, currently in 
> D3
>>       10 sdhci-pci 0000:0a:00.1: restoring config space at offset 0xf (was 
> 0xffffffff, writing 0x10a)
>>       10 sdhci-pci 0000:0a:00.1: restoring config space at offset 0xe (was 
> 0xffffffff, writing 0x0)
> <snip>
> 
> Could the problem be more due to "Refused to change power state,
> currently in D3".
> the "was 0xffffffff" would be returned if their was no power to the 
> device.
> Don't you need power, before you can write to the config space?
>

Those messages and the problem of the combo card reader and firewire
not working after s2ram has been present for long
(https://bugzilla.kernel.org/show_bug.cgi?id=35452
dmesg here: https://lkml.org/lkml/2011/5/15/55).

Before 3.4-rc1 there was nothing wrong with the touchpad (and keyboard
and reboot) after s2ram, and the problems are somehow separate.
Rafael's patch fixes the new problem, any suggestions for the old
one would be warmly appreciated.


Mikko
