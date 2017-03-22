Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] pci-error-recovery: doc cleanup
To: <linasvepstas@gmail.com>
References: <1490102658-22768-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <CAHrUA34WX1sqEWJiuiy8yN2B1NHjDzj5UQ2A=0Nsdad1cVNjDw@mail.gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S. Tsirkin" <mst@redhat.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58D21FDF.4000506@cn.fujitsu.com>
Date: Wed, 22 Mar 2017 14:55:27 +0800
MIME-Version: 1.0
In-Reply-To: <CAHrUA34WX1sqEWJiuiy8yN2B1NHjDzj5UQ2A=0Nsdad1cVNjDw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC MST who touched this file in last commit on it.

On 03/22/2017 01:48 PM, Linas Vepstas wrote:
> Hi,
> 
> On Tue, Mar 21, 2017 at 9:24 PM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>> Include whitespace shooting; correction; typo fix; superfluous word
>> dropping.
> 
>>
>> diff --git a/Documentation/PCI/pci-error-recovery.txt b/Documentation/PCI/pci-error-recovery.txt
>> index da3b217..0b6bb3e 100644
>> --- a/Documentation/PCI/pci-error-recovery.txt
>> +++ b/Documentation/PCI/pci-error-recovery.txt
>>
>> @@ -231,14 +231,14 @@ proceeds to STEP 4 (Slot Reset)
>>  STEP 3: Link Reset
>>  ------------------
>>  The platform resets the link.  This is a PCI-Express specific step
>> -and is done whenever a non-fatal error has been detected that can be
>> +and is done whenever a fatal error has been detected that can be
>>  "solved" by resetting the link.
> 
> First: I thought I saw a patch a few months ago that proposed removing
> the link rest step.  I don't know if the patch was accepted or not.
> 

Yes, I sent this one and I asked to ignore it. At that time, .link_reset
handler still exists, now is gone.

> If link resets are still supported, then they can only fix NON-fatal errors:
> basically, one resets the link, and only the link; one does NOT reset
> either the device driver, nor the device state. The idea is that after a link
> reset, communications with the device can immediately resume right
> where it left off. (this can be hard in practice, if the driver/firmware doesn't
> know what it was doing when the error occurred.  this might be why no one
> implements it.)  Anyway, the whole point of a link reset is that it is
> explicitly
> a non-fatal error.
> 

Perhaps you are still talking about link re-training. After last commit
on this file, section "Link Reset" seems only focus on PCI-Express. If
it is a PCI-Express specific step, then I think the "fatal" &
"non-fatal" referred here are in the PCI-Express(AER) territory, and
according to the AER driver(function do_recovery()), platform level link
reset targeted to fatal error.

-- 
Sincerely,
Cao jin
