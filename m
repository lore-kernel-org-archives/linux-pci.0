Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 28 Feb 2018 09:17:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] pci: Re-use new dmi_get_bios_year() helper
Message-ID: <20180228151714.GF127842@bhelgaas-glaptop.roam.corp.google.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
 <20180222125923.57385-4-andriy.shevchenko@linux.intel.com>
 <20180223214051.GN14632@bhelgaas-glaptop.roam.corp.google.com>
 <1519565224.10722.148.camel@linux.intel.com>
 <20180226181943.GC25159@bhelgaas-glaptop.roam.corp.google.com>
 <1519812742.10722.251.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519812742.10722.251.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 12:12:22PM +0200, Andy Shevchenko wrote:
> On Mon, 2018-02-26 at 12:19 -0600, Bjorn Helgaas wrote:
> > On Sun, Feb 25, 2018 at 03:27:04PM +0200, Andy Shevchenko wrote:
> > > On Fri, 2018-02-23 at 15:40 -0600, Bjorn Helgaas wrote:
> > > > On Thu, Feb 22, 2018 at 02:59:23PM +0200, Andy Shevchenko wrote:
> > > > > ...instead of open coding its functionality.
> > > > 
> > > > Same comment about making the changelog complete, independent of
> > > > the
> > > > subject.
> > > 
> > > Any suggestion how it would look like? (Same question for previous
> > > comment)
> > 
> >   PCI: Re-use new dmi_get_bios_year() helper
> > 
> >   Use new dmi_get_bios_year() helper instead of open-coding its
> >   functionality.
> > 
> > The usual document structure is something like:
> > 
> >   TITLE
> > 
> >   This abstract contains a summary of the entire document, in a few
> >   paragraphs of complete sentences.
> > 
> > Where "TITLE" makes sense all by itself, even without reading the
> > body, and "Body" is a complete statement that also makes sense all by
> > itself without having to read "TITLE" first.
> > 
> 
> Thank you for a hint!
> 
> > Granted, it's trivial, but following the convention improves
> > readability slightly because it fits the reader's expectations.
> 
> > When the body is "...instead of open coding its functionality", it's a
> > bit of a hiccup because I have to start over and look back up to the
> > title to re-read the thing as a whole.
> 
> OK, I got your point, though I don't like duplication in the subject and
> body.

Ah, I see.  I think of the subject and the body as serving two
distinct purposes, so for me there's no issue even if they happen to
contain exactly the same text.

Bjorn
