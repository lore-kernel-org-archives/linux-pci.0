Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120203160146.GM889@n2100.arm.linux.org.uk>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
 <20120130165745.3231.37109.stgit@bhelgaas.mtv.corp.google.com> <20120203160146.GM889@n2100.arm.linux.org.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 3 Feb 2012 08:12:02 -0800
Message-ID: <CAErSpo6Ytx06f0yMW5q=YQBTcLxRdbBbB6EzSAFWNG82t=Qe4g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 07/18] arm/PCI: get rid of device resource fixups
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 3, 2012 at 8:01 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 30, 2012 at 09:57:45AM -0700, Bjorn Helgaas wrote:
>> Tell the PCI core about host bridge address translation so it can take
>> care of bus-to-resource conversion for us.
>
> Are the rest of these patches (in particular whereever is introduced
> the generic versions) available somewhere?

Oh, sorry, this doesn't mean much without the context.  Here's a
pointer to the overview, with a git tree and so on:

http://marc.info/?l=linux-arch&m=132794281821723&w=2

Bjorn
