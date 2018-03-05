Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751838AbeCEO2m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Mar 2018 09:28:42 -0500
Date: Mon, 5 Mar 2018 08:28:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenny Ballou <kballou@devnulllabs.io>
Cc: linux-pci@vger.kernel.org, googlegot@yahooo.com,
        bhelgaas@google.com
Subject: Re: [PATCH] pci: use kstrtobool over ad hoc string parsing
Message-ID: <20180305142840.GA255556@bhelgaas-glaptop.roam.corp.google.com>
References: <20180212230457.23181-1-kballou@devnulllabs.io>
 <20180228033228.GE127842@bhelgaas-glaptop.roam.corp.google.com>
 <878tbavy4b.fsf@devnulllabs.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <878tbavy4b.fsf@devnulllabs.io>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 02, 2018 at 04:47:16PM -0700, Kenny Ballou wrote:
> 
> On 2018年02月28日 03:32 GMT, Bjorn Helgaas wrote:
> > On Mon, Feb 12, 2018 at 04:04:57PM -0700, Kenny Ballou wrote:
> >> Convert ROM read access enable/disable string parsing to use the
> >> `kstrtobool` function.
> >>
> >> This fixes Bugzilla Bug 111301 -- Sysfs PCI rom file functionality does
> >> not match documentation.
> >>
> >> bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=111301
> >>
> >> Reported-by: googlegot@yahoo.com
> >> Signed-off-by: Kenny Ballou <kballou@devnulllabs.io>
> >> ---
> >>  drivers/pci/pci-sysfs.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >> index eb6bee8724cc..3cde1f25e786 100644
> >> --- a/drivers/pci/pci-sysfs.c
> >> +++ b/drivers/pci/pci-sysfs.c
> >> @@ -1424,10 +1424,12 @@ static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
> >>  {
> >>  	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> >>
> >> -	if ((off ==  0) && (*buf == '0') && (count == 2))
> >> -		pdev->rom_attr_enabled = 0;
> >> -	else
> >> +	bool res = false;
> >> +
> >> +	if (kstrtobool(buf, &res) == 0 && res)
> >>  		pdev->rom_attr_enabled = 1;
> >> +	else
> >> +		pdev->rom_attr_enabled = 0;
> >>
> >>  	return count;
> >>  }
> >
> > I know I proposed kstrtobool().  But looking closer, I don't think
> > it's the right answer because:
> >
> >   - kstrtobool() assumes a NULL-terminated string, and sysfs does not
> >     guarantee that.  This is a binary file and we can write arbitrary
> >     data to it.  kstrtobool_from_user() makes sure the string is
> >     NULL-terminated, but it does a copy_from_user() that we don't want
> >     in the sysfs case.
> >
> >   - The current behavior is that only 2-byte writes starting with '0'
> >     disable the ROM, and all other writes enable it.
> >
> >     Using kstrtobool() would enable the ROM only for writes starting
> >     with y/Y/1/on/oN/On/ON, and all other writes would disable it.
> >
> >     That changes the behavior for most writes, e.g., writing "2"
> >     currently enables, but would now disable.  This feels
> >     unnecessarily risky because we don't know what programs are
> >     writing to enable the ROM.  The doc says to write "1", but the
> >     code comment says "anything except 0".
> >
> > We *could* change the code to accept a single-byte '0' write, but I
> > think the simplest solution would be to change the documentation to
> > explicitly require a 2-byte "0\n" write to disable the ROM.
> >
> > Sorry for dithering on this.
> >
> > Bjorn
> 
> I was not under the impression that this particular device needed data
> written to it(?).  If it is the case that arbitrary data needs to be
> written, your argument makes sense, and I can put together a patch for
> the documentation instead.

I'm not sure I understand your question, but here's a stab at
answering it:

The sysfs "rom" file has a read method (pci_read_rom()) and a write
method (pci_write_rom()).  User-space software can open the file and
do a read() system call to read the contents of the ROM from the
device, so pci_read_rom() is directly connected to the PCI hardware
device.

The write method doesn't touch the hardware device at all; it's only a
software switch, and the data written to the sysfs "rom" file is never
written to the PCI hardware device at all.  It doesn't need any
particular data written to it.  The data can be whatever we decide it
should be, and we can interpret that data in any way we like since
it's purely a software construct.  

However, there is user-space software that assumes certain behavior
(enabling/disabling read access to the ROM).  We don't want to break
that software.  Using kstrtobool() would change the interpretation of
some writes.  We *could* assume that user-space software always writes
"1" to enable reads of the ROM and "0" to disable reads, but it's
impossible to be certain of that.

So the safest thing in terms of not breaking the ABI is to leave the
code unchanged but update the documentation.  Does that make sense?

Bjorn
