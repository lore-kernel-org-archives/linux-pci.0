Return-Path: <SRS0=GaQ6=FR=fireburn.co.uk=mike@kernel.org>
Return-Path: <SRS0=GaQ6=FR=fireburn.co.uk=mike@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180222131343.GA205018@bhelgaas-glaptop.roam.corp.google.com>
References: <20180212105523.15984-1-mika.westerberg@linux.intel.com>
 <CAHbf0-Exsu14dBmmfYy8Tcb4R58eYJKLFPPoM9RkqxHWDkqwXQ@mail.gmail.com>
 <20180212152122.GB75542@bhelgaas-glaptop.roam.corp.google.com>
 <CAHbf0-HffVDu0vxyTrSfgCtJ5rGtu_4HqAoo2sseG3HoE-1djw@mail.gmail.com> <20180222131343.GA205018@bhelgaas-glaptop.roam.corp.google.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Fri, 23 Feb 2018 10:14:48 +0000
Message-ID: <CAHbf0-FUhpmJat5zo4iGNL8zbSVmhkfNDgzTLNdGvj8DJx-ddg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 22 February 2018 at 13:13, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Not on your end.  But thanks fo the reminder, and also for the hint
> that you'd like it in -rc3.  It's not likely to make -rc3 because I
> like things to at least be in -next for a few days before I ask Linus
> to pull them.
>
> But more importantly, what's the justification for adding this after
> the merge window?  It doesn't look like a regression or a fix for
> something we broke in the merge window.  It certainly *could* still be
> merged for v4.16, but the default target would be v4.17.
>
> Bjorn

Hi Bjorn

Apologies, I thought all fixes got into the release candidates rather
than just regressions

I was hoping the original fix was going to make it into the merge
window that just passed

I just wanted to make sure the patch doesn't fall through the cracks

I'm carrying this patch locally so it doesn't make too much difference
to me which route it takes

Thanks again

Mike
