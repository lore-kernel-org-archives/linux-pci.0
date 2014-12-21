Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:33474 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbaLUMcX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 21 Dec 2014 07:32:23 -0500
Date: Sun, 21 Dec 2014 13:32:09 +0100
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Bjorn Helgaas <bhelgaas@google.com>, petrihodju@yahoo.com
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Anibal Francisco Martinez Cortina <linuxkid.zeuz@gmail.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [Bug 86121] New: Regression: NVIDIA backlight not working after
 latest vgaarb change
Message-ID: <20141221133209.538ed590@neptune.home>
In-Reply-To: <CAErSpo4uKuxaqNPb20MXmFPFXHvJthEVuaQqJ0LdnpX29hiekA@mail.gmail.com>
References: <bug-86121-41252@https.bugzilla.kernel.org/>
	<CAErSpo5SvnNb7KteHPtr+_XZK3RJYfBNZOR_2cnxbBkF3x+tKA@mail.gmail.com>
	<CAErSpo4uKuxaqNPb20MXmFPFXHvJthEVuaQqJ0LdnpX29hiekA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 17 December 2014 Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Petri]
> 
> On Mon, Oct 13, 2014 at 9:47 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Sun, Oct 12, 2014 at 8:55 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> >> https://bugzilla.kernel.org/show_bug.cgi?id=86121
> >>
> >>             Bug ID: 86121
> >>            Summary: Regression: NVIDIA backlight not working after latest
> >>                     vgaarb change
> >>            Product: Drivers
> >>            Version: 2.5
> >>     Kernel Version: 3.16.5
> >>           Hardware: x86-64
> >>                 OS: Linux
> >>               Tree: Mainline
> >>             Status: NEW
> >>           Severity: normal
> >>           Priority: P1
> >>          Component: PCI
> >>           Assignee: drivers_pci@kernel-bugs.osdl.org
> >>           Reporter: petrihodju@yahoo.com
> >>         Regression: No
> >>
> >> Created attachment 153311
> >>   --> https://bugzilla.kernel.org/attachment.cgi?id=153311&action=edit
> >> kernel boot logs & config
> >>
> >> I have experienced a regression in backlight control with NVIDIA binary blob
> >> driver and kernel 3.16.5. I did a bisect between 3.16.4 and 3.16.5 and found
> >> out that the regression happens with commit "ce027dac vgaarb: Don't default
> >> exclusively to first video device with mem+io"
> >>
> >> I have attached kernel boot log with working backlight (commit 7babfd7f) and
> >> non-working one (commit ce027dac) plus the config used.
> >>
> >> I'm running Ubuntu 14.10
> 
> Ping for status update?  There are some more comments in the bugzilla,
> but the most recent one is from Oct 25.
> 
> This is a regression, so I'd like to make some progress on it.

I'm hoping for more details on how it triggers, e.g. if "BIOS"-configured
boot GPU has some effect or when it starts failing (e.g. with/without proprietary
nvidia driver, or versus nouveau).
>From ACPI code there is nothing that catches my attention tough.

On the other hand, for Apple systems GPU switching should probably not include
any kind of VGA arbitration switching as VGA is not used at all there...

Bruno
