Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Myron Stowe <mstowe@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] acpi, acpi_pci_irq_enable must return an error if ACPI cannot map an IRQ.
Date: Wed, 07 Aug 2013 00:44:21 +0200
Message-ID: <86005101.W2j5ifU8yA@vostro.rjw.lan>
In-Reply-To: <52010A40.1040409@redhat.com>
References: <1373900260-1599-1-git-send-email-prarit@redhat.com> <20130805140416.GA3882@xps8300> <52010A40.1040409@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, August 06, 2013 10:37:52 AM Prarit Bhargava wrote:
> On 08/05/2013 10:04 AM, Heikki Krogerus wrote:
> > Hi,
> > 
> > On Mon, Aug 05, 2013 at 03:30:16PM +0200, Rafael J. Wysocki wrote:
> >> On Sunday, August 04, 2013 07:35:37 PM Prarit Bhargava wrote:
> >>> Hey Rafael,
> >>>
> >>> I know you're busy but I was just wondering if this was queued up anywhere or if
> >>> you had any other questions?
> >>
> >> Should be qeued up for 3.12 (currently in linux-next).
> > 
> > This breaks my xHCI :(
> > 
> > If the issues is that you are not getting any interrupt, then should
> > it not be checked separately and only fail in that case? I'm attaching
> > a patch that I made on top of linux-next, where I do just that. Would
> > that work for you?
> > 
> 
> Testing this right now ... I'll get back to everyone when I have results.

In the meantime I've dropped that commit from linux-next as it caused the xHCI
breakage to happen.

Thanks,
Rafael

