Return-Path: <SRS0=CE1T=KE=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=CE1T=KE=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <1530608741-30664-2-git-send-email-hari.vyas@broadcom.com>
 <20180719174118.GM128988@bhelgaas-glaptop.roam.corp.google.com> <CAM5rFu9ZKpeKGhS+8cn3p0wKP0+GQrtexboxtwgGfDms3oBX0w@mail.gmail.com>
In-Reply-To: <CAM5rFu9ZKpeKGhS+8cn3p0wKP0+GQrtexboxtwgGfDms3oBX0w@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 20 Jul 2018 07:20:40 -0500
Message-ID: <CAErSpo4FfjHUMMLT_=fvX=cVkoUF0ApdEimZbxswen+Z8TqvSA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Data corruption happening due to race condition
To: hari.vyas@broadcom.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-pci@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 20, 2018 at 4:16 AM Hari Vyas <hari.vyas@broadcom.com> wrote:
>
> On Thu, Jul 19, 2018 at 11:11 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jul 03, 2018 at 02:35:41PM +0530, Hari Vyas wrote:
> >> When a pci device is detected, a variable is_added is set to
> >> 1 in pci device structure and proc, sys entries are created.
> >>
> >> When a pci device is removed, first is_added is checked for one
> >> and then device is detached with clearing of proc and sys
> >> entries and at end, is_added is set to 0.
> >>
> >> is_added and is_busmaster are bit fields in pci_dev structure
> >> sharing same memory location.
> >>
> >> A strange issue was observed with multiple times removal and
> >> rescan of a pcie nvme device using sysfs commands where is_added
> >> flag was observed as zero instead of one while removing device
> >> and proc,sys entries are not cleared.  This causes issue in
> >> later device addition with warning message "proc_dir_entry"
> >> already registered.
> >>
> >> Debugging revealed a race condition between pcie core driver
> >> enabling is_added bit(pci_bus_add_device()) and nvme driver
> >> reset work-queue enabling is_busmaster bit (by pci_set_master()).
> >> As both fields are not handled in atomic manner and that clears
> >> is_added bit.
> >>
> >> Fix moves device addition is_added bit to separate private flag
> >> variable and use different atomic functions to set and retrieve
> >> device addition state. As is_added shares different memory
> >> location so race condition is avoided.
> >
> > If/when you post a v4 of this, can you include the bugzilla URL
> > right here, i.e.,
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200283
> >> Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
> >
> > That way we can connect the commit with the bugzilla, which contains
> > more information that may be useful in the future.

> Bit confused.  Do I  need  to change commit message for including bugzila link ?
> Believe v3 should be Okay from code perspective time-being. Please confirm

You don't need to repost it just to update the commit message (I'll
try to remember to add the link when I apply it).  But if you do
repost it for some other reason, it helps me out if you include the
link.
