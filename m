Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
References: <6401388.2t0qD3iTOr@aspire.rjw.lan> <20180817.144354.2288619657950222607.teika@gmx.com>
In-Reply-To: <20180817.144354.2288619657950222607.teika@gmx.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 Aug 2018 09:50:52 +0200
Message-ID: <CAJZ5v0gueiBtbAS00LQ0yp15=OmvZe-i2ETzxaPvVD5wuZGV7Q@mail.gmail.com>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume all bridges on suspend-to-RAM
To: teika@gmx.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2018 at 7:45 AM Teika Kazura <teika@gmx.com> wrote:
>
> For the record, about the exactness of the patch description.
>
> The patch mentions the regression by the commit c62ec4610c40, but it is not the cause of the bug (https://bugzilla.kernel.org/show_bug.cgi?id=20067)
> reported by me; I reverted c62ec4610c40 on linux-4.17.13, and the bug remained.
>
> # Some details: my bug was introduced by the commit (i) 877b3729ca0 on Jan 3. The commit (ii) c62ec4610c40 was on May 22. The commit (iii) 26112ddc254c
> on Jun 30 fixes one problem caused by c62ec4610c40. The present patch modifies the code of the commit (iii), so it can be said as the completion of the
> commit (iii). It at the same time fixes my bug, too.

You are right, commit 877b3729ca0 introduced the issue for you, but it
did that by exposing the same functional problem in the firmware that
was previously addressed by commit 26112ddc254c in a different case.

> This suggests the present patch possibly fixes other unknown PM problems; former kernels had some loose end(s). Now this patch puts the kernel in a better position.
>
> I'm a lay Linux user, and don't know if this post helps. If it does, it may be worth mentioning it in the above bugzilla entry.

Yes, it does, thanks!

I have updated the tags and the commit log of this patch according to
the information above.

Cheers,
Rafael
