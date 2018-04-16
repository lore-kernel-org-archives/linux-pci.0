Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50270 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbeDPQsW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2018 12:48:22 -0400
Subject: Re: [Regression] PCI / PM: Simplify device wakeup settings code
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        1745646@bugs.launchpad.net
References: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com>
 <CAJZ5v0j8GAatWoAra37y3c-ti2Ft5am75KONgEkjB6AaypkCqg@mail.gmail.com>
 <ae84e595-dede-1409-4aff-3a29a310f2ba@canonical.com>
 <CAJZ5v0gapMMf=KqBAoDTv0SUBeusrUFPyEz6Z4k8Y3Szizdm5Q@mail.gmail.com>
From: Joseph Salisbury <joseph.salisbury@canonical.com>
Message-ID: <63ab8099-1c33-50dd-8c79-e02d55fe9f81@canonical.com>
Date: Mon, 16 Apr 2018 12:48:18 -0400
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gapMMf=KqBAoDTv0SUBeusrUFPyEz6Z4k8Y3Szizdm5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/16/2018 11:58 AM, Rafael J. Wysocki wrote:
> On Mon, Apr 16, 2018 at 5:31 PM, Joseph Salisbury
> <joseph.salisbury@canonical.com> wrote:
>> On 04/13/2018 05:34 PM, Rafael J. Wysocki wrote:
>>> On Fri, Apr 13, 2018 at 7:56 PM, Joseph Salisbury
>>> <joseph.salisbury@canonical.com> wrote:
>>>> Hi Rafael,
>>>>
>>>> A kernel bug report was opened against Ubuntu [0].  After a kernel
>>>> bisect, it was found that reverting the following two commits resolved
>>>> this bug:
>>>>
>>>> 0ce3fcaff929 ("PCI / PM: Restore PME Enable after config space restoration")
>>>> 0847684cfc5f("PCI / PM: Simplify device wakeup settings code")
>>>>
>>>> This is a regression introduced in v4.13-rc1 and still exists in
>>>> mainline.  The bug causes the battery to drain when the system is
>>>> powered down and unplugged, which does not happed prior to these two
>>>> commits.
>>> What system and what do you mean by "powered down"?  How much time
>>> does it take for the battery to drain now?
>> By powered down, the bug reporter is saying physically powered off and
>> unplugged.  The system is a HP laptop:
>>
>> dmi.chassis.vendor: HP
>> dmi.product.family: 103C_5335KV HP Notebook
>> dmi.product.name: HP Notebook
>> vendor_id    : GenuineIntel
>> cpu family    : 6
>>
>>
>>>> The bisect actually pointed to commit de3ef1e, but reverting
>>>> these two commits fixes the issue.
>>>>
>>>> I was hoping to get your feedback, since you are the patch author.  Do
>>>> you think gathering any additional data will help diagnose this issue,
>>>> or would it be best to submit a revert request?
>>> First, reverting these is not an option or you will break systems
>>> relying on them now.  4.13 is three releases back at this point.
>>>
>>> Second, your issue appears to be related to the suspend/shutdown path
>>> whereas commit 0ce3fcaff929 is mostly about resume, so presumably the
>>> change in pci_enable_wake() causes the problem to happen.  Can you try
>>> to revert this one alone and see if that helps?
>> A test kernel with commits 0ce3fcaff929 and de3ef1eb1cd0 reverted was
>> tested.  However, the test kernel still exhibited the bug.
> So essentially the bisection result cannot be trusted.
Yes, the bisect results were different than usual.  The bisect reported
commit de3ef1eb1cd0 as the first bad commit.  I could not revet commit
de3ef1eb1cd0 without either back porting  the revert of that commit or
reverting 0ce3fcaff929 first.  However, the bug still happened with
these two reverted.  I needed to revert 0847684cfc5f and 0ce3fcaff929
for the bug to go away.  I reverted 0ce3fcaff929 in this case to also
avoid having to back port the revert of 0847684cfc5f.  I was unsure if
these unexpected results were due to the interaction/dependency between
the commits or due to inaccurate testing by the end user.

I'll build some more test kernels and have the user perform some more
testing to see if the bug can be specifically narrowed down to 0847684cfc5f.
