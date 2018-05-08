Return-Path: <SRS0=vvZa=H3=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=vvZa=H3=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 1745646@bugs.launchpad.net, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Regression] PCI / PM: Simplify device wakeup settings code
Date: Wed, 09 May 2018 00:13:37 +0200
Message-ID: <2702274.xkNDNdUuIr@aspire.rjw.lan>
In-Reply-To: <405049ce-5ea4-48b6-40da-4775daa94aea@canonical.com>
References: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com> <3450120.zJjNP64voh@aspire.rjw.lan> <405049ce-5ea4-48b6-40da-4775daa94aea@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Monday, May 7, 2018 6:15:01 PM CEST Joseph Salisbury wrote:
> On 05/04/2018 07:14 AM, Rafael J. Wysocki wrote:
> > On Thursday, May 3, 2018 11:29:18 PM CEST Rafael J. Wysocki wrote:
> >> On Thu, May 3, 2018 at 9:11 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> On Thu, May 03, 2018 at 02:29:02PM -0400, Joseph Salisbury wrote:
> >>>> On 05/02/2018 06:41 AM, Rafael J. Wysocki wrote:
> >>>>> On Tue, May 1, 2018 at 9:55 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>>>> On Tue, May 01, 2018 at 10:34:29AM +0200, Rafael J. Wysocki wrote:
> >>>>>>> On Mon, Apr 30, 2018 at 4:22 PM, Joseph Salisbury
> >>>>>>> <joseph.salisbury@canonical.com> wrote:
> >>>>>>>> On 04/16/2018 11:58 AM, Rafael J. Wysocki wrote:
> >>>>>>>>> On Mon, Apr 16, 2018 at 5:31 PM, Joseph Salisbury
> >>>>>>>>> <joseph.salisbury@canonical.com> wrote:
> >>>>>>>>>> On 04/13/2018 05:34 PM, Rafael J. Wysocki wrote:
> >>>>>>>>>>> On Fri, Apr 13, 2018 at 7:56 PM, Joseph Salisbury
> >>>>>>>>>>> <joseph.salisbury@canonical.com> wrote:
> >>>>>>>>>>>> Hi Rafael,
> >>>>>>>>>>>>
> >>>>>>>>>>>> A kernel bug report was opened against Ubuntu [0].  After a kernel
> >>>>>>>>>>>> bisect, it was found that reverting the following two commits resolved
> >>>>>>>>>>>> this bug:
> >>>>>>>>>>>>
> >>>>>>>>>>>> 0ce3fcaff929 ("PCI / PM: Restore PME Enable after config space restoration")
> >>>>>>>>>>>> 0847684cfc5f("PCI / PM: Simplify device wakeup settings code")
> >>>>>>>>>>>>
> >>>>>>>>>>>> This is a regression introduced in v4.13-rc1 and still exists in
> >>>>>>>>>>>> mainline.  The bug causes the battery to drain when the system is
> >>>>>>>>>>>> powered down and unplugged, which does not happed prior to these two
> >>>>>>>>>>>> commits.
> >>>>>>>>>>> What system and what do you mean by "powered down"?  How much time
> >>>>>>>>>>> does it take for the battery to drain now?
> >>>>>>>>>> By powered down, the bug reporter is saying physically powered off and
> >>>>>>>>>> unplugged.  The system is a HP laptop:
> >>>>>>>>>>
> >>>>>>>>>> dmi.chassis.vendor: HP
> >>>>>>>>>> dmi.product.family: 103C_5335KV HP Notebook
> >>>>>>>>>> dmi.product.name: HP Notebook
> >>>>>>>>>> vendor_id    : GenuineIntel
> >>>>>>>>>> cpu family    : 6
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>> The bisect actually pointed to commit de3ef1e, but reverting
> >>>>>>>>>>>> these two commits fixes the issue.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I was hoping to get your feedback, since you are the patch author.  Do
> >>>>>>>>>>>> you think gathering any additional data will help diagnose this issue,
> >>>>>>>>>>>> or would it be best to submit a revert request?
> >>>>>>>>>>> First, reverting these is not an option or you will break systems
> >>>>>>>>>>> relying on them now.  4.13 is three releases back at this point.
> >>>>>>>>>>>
> >>>>>>>>>>> Second, your issue appears to be related to the suspend/shutdown path
> >>>>>>>>>>> whereas commit 0ce3fcaff929 is mostly about resume, so presumably the
> >>>>>>>>>>> change in pci_enable_wake() causes the problem to happen.  Can you try
> >>>>>>>>>>> to revert this one alone and see if that helps?
> >>>>>>>>>> A test kernel with commits 0ce3fcaff929 and de3ef1eb1cd0 reverted was
> >>>>>>>>>> tested.  However, the test kernel still exhibited the bug.
> >>>>>>>>> So essentially the bisection result cannot be trusted.
> >>>>>>>> We performed some more testing and confirmed just a revert of the
> >>>>>>>> following commit resolves the bug:
> >>>>>>>>
> >>>>>>>> 0847684cfc5f0 ("PCI / PM: Simplify device wakeup settings code")
> >>>>>>> Thanks for confirming this!
> >>>>>>>
> >>>>>>>> Can you think of any suggestions to help debug further?
> >>>>>>> The root cause of the regression is likely the change in
> >>>>>>> pci_enable_wake() removing the device_may_wakeup() check from it.
> >>>>>>>
> >>>>>>> Probably, one of the drivers in the platform calls pci_enable_wake()
> >>>>>>> directly from its ->shutdown() callback and that causes the device to
> >>>>>>> be set up for system wakeup which in turn causes the power draw while
> >>>>>>> the system is off to increase.
> >>>>>>>
> >>>>>>> I would look at the PCI drivers used on that platform to find which of
> >>>>>>> them call pci_enable_wake() directly from ->shutdown() and I would
> >>>>>>> make these calls conditional on device_may_wakeup().
> >>>>>> I took a quick look with
> >>>>>>
> >>>>>>   git grep -E "pci_enable_wake\(.*[^0]\);|device_may_wakeup"
> >>>>>>
> >>>>>> and didn't notice any pci_enable_wake() callers that called
> >>>>>> device_may_wakeup() first.
> >>>>> I've just look at a bunch of network drivers doing that.
> >>>>>
> >>>>> It looks like I may need to restore __pci_enable_wake() with an extra
> >>>>> "runtime" argument for internal use.
> >>>>>
> >>>>> Joseph, can you ask the reporter to test the Bjorn's patch, please?
> >>>> The bug reporter has testing Bjorn's patch.  It did in fact resolve the
> >>>> bug.  Thanks for the quick help, Rafael and Bjorn!
> >>> Just as a word of caution, I think Rafael said my patch was not the
> >>> right fix because it would break something else.  So I would wait for
> >>> a better patch from Rafael before actually resolving this issue.
> >> I'll do my best to provide one in the next couple of days.
> > Something like the appended one (compiled-only at this point).
> >
> > Joseph, this should be functionally equivalent to the Bjorn's patch except
> > for the runtime PM part which is irrelevant for the issue in question, but
> > please ask the reported to test this one too.
> >
> > If it is confirmed to work, I'll repost it with a proper changelog.
> The bug reporter confirms that your latest patch also resolves the bug. 
> Thanks!

Thanks for the confirmation.
