Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com>
References: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Apr 2018 23:34:52 +0200
Message-ID: <CAJZ5v0j8GAatWoAra37y3c-ti2Ft5am75KONgEkjB6AaypkCqg@mail.gmail.com>
Subject: Re: [Regression] PCI / PM: Simplify device wakeup settings code
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        1745646@bugs.launchpad.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 13, 2018 at 7:56 PM, Joseph Salisbury
<joseph.salisbury@canonical.com> wrote:
> Hi Rafael,
>
> A kernel bug report was opened against Ubuntu [0].  After a kernel
> bisect, it was found that reverting the following two commits resolved
> this bug:
>
> 0ce3fcaff929 ("PCI / PM: Restore PME Enable after config space restoration")
> 0847684cfc5f("PCI / PM: Simplify device wakeup settings code")
>
> This is a regression introduced in v4.13-rc1 and still exists in
> mainline.  The bug causes the battery to drain when the system is
> powered down and unplugged, which does not happed prior to these two
> commits.

What system and what do you mean by "powered down"?  How much time
does it take for the battery to drain now?

> The bisect actually pointed to commit de3ef1e, but reverting
> these two commits fixes the issue.
>
> I was hoping to get your feedback, since you are the patch author.  Do
> you think gathering any additional data will help diagnose this issue,
> or would it be best to submit a revert request?

First, reverting these is not an option or you will break systems
relying on them now.  4.13 is three releases back at this point.

Second, your issue appears to be related to the suspend/shutdown path
whereas commit 0ce3fcaff929 is mostly about resume, so presumably the
change in pci_enable_wake() causes the problem to happen.  Can you try
to revert this one alone and see if that helps?
