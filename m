Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.uli-eckhardt.de ([85.214.28.137]:57311 "EHLO
	mail.uli-eckhardt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757204Ab2JYRQB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2012 13:16:01 -0400
Message-ID: <508973CE.8080603@uli-eckhardt.de>
Date: Thu, 25 Oct 2012 19:15:58 +0200
From: Ulrich Eckhardt <usb@uli-eckhardt.de>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
References: <50841CCC.9030809@uli-eckhardt.de> <5086D067.4000900@uli-eckhardt.de> <CAErSpo4TG8F94qkQzD7XrZnozBcTo3ZGdJsJ0PeLmCtpsU1MtA@mail.gmail.com> <6817642.hqndXjdIQA@vostro.rjw.lan> <CAErSpo5cN5w=E8GYyKE=bX0=67Qk0g0wAW4vVFe0QfPGxo=+MA@mail.gmail.com>
In-Reply-To: <CAErSpo5cN5w=E8GYyKE=bX0=67Qk0g0wAW4vVFe0QfPGxo=+MA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 24.10.2012 23:13, schrieb Bjorn Helgaas:
> On Wed, Oct 24, 2012 at 3:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
>> It can be disabled by writing "on" to the controller's
>> /sys/devices/.../power/control file.
>
> Ulrich, if you boot in the working situation and write "on" to the
> control file as above, can you still reproduce the failure?

I have done first a cat to the control file which returns already on:

uli:/ # cat /sys/devices/pci0000\:00/0000\:00\:04.0/power/control
on

Writing again on to the file does not change anything.

Best Regards
Uli
-- 
Ulrich Eckhardt                  http://www.uli-eckhardt.de

Ein Blitzableiter auf dem Kirchturm ist das denkbar stärkste
Misstrauensvotum gegen den lieben Gott. (Karl Krauss)
