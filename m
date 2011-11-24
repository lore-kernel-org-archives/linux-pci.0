Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55860 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab1KXB46 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2011 20:56:58 -0500
MIME-Version: 1.0
In-Reply-To: <20111123144735.64dc9f05@jbarnes-desktop>
References: <CAHM4w1kc+5aYWH-09BPTXZdo8+iguFjORKs7mMhG7hea2UU8yQ@mail.gmail.com>
	<CAHM4w1nZ7GgutiuDiTCKu9wUuphn8qOiWgmCYVXXvwW1q8CgoA@mail.gmail.com>
	<20111122150613.GA322@google.com>
	<CAHM4w1nsNTQmAL-0d76O9cYXjNbiq-0f60Y3emWO2yf7HyFWDg@mail.gmail.com>
	<20111123162937.GF25780@google.com>
	<20111123144735.64dc9f05@jbarnes-desktop>
Date: Wed, 23 Nov 2011 17:48:47 -0800
Message-ID: <CAOS58YPM29xi4Jq5L16fjDQDRzv-yc67tp_yqSwoiFBBbtCZkw@mail.gmail.com>
Subject: Re: Crash with sata_sil24 driver
From: Tejun Heo <tj@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Wed, Nov 23, 2011 at 2:47 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
>> Weird, that basically means that somehow pci_iomap() isn't
>> synchronous.  ie. you need to way some time after pci_iomap() before
>> being able to access the mapped address.  Seems like arch / pci
>> weirdness.  Jesse, Russell, any ideas?
>
> As Russel said, pci_iomap shouldn't be async.  But maybe something else
> in the init function is doing a chip reset or causing the chip to go
> off into the weeds for a short time?  That's generally the cause of
> target timeouts for PCI devices.

Yeah, that's much more plausible. Weird that it doesn't happen on x86
tho. Maybe different timeouts? Pratyush, can you look at bus trace and
see what's going on?

Thanks.

-- 
tejun
