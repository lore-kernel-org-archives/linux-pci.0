Return-Path: <SRS0=ERpC=5Y=canonical.com=kai.heng.feng@kernel.org>
Return-Path: <SRS0=ERpC=5Y=canonical.com=kai.heng.feng@kernel.org>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1706161327410.1715-100000@iolanthe.rowland.org>
References: <CAAd53p4ntaZ48dsHG+ftDadgOnX=xwX9c3WeBr2SXZye3VL4CA@mail.gmail.com>
 <Pine.LNX.4.44L0.1706161327410.1715-100000@iolanthe.rowland.org>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 19 Jun 2017 11:30:18 +0800
Message-ID: <CAAd53p6iH=T+ynpsdmQVeexOXRdwdiznLiRGM40Q88__r1s7QQ@mail.gmail.com>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, gregkh@linuxfoundation.org,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 17, 2017 at 1:30 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sat, 17 Jun 2017, Kai-Heng Feng wrote:
>
>> On Fri, Jun 16, 2017 at 11:07 AM, Kai-Heng Feng
>> <kai.heng.feng@canonical.com> wrote:
>> > On Thu, Jun 15, 2017 at 10:12 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> >> Those documents refer to a hardware bug with a workaround in the BIOS.
>> >> Have you checked to see if your BIOS is up to date?
>> >
>> > Yes, it's up to date.
>> >
>>
>> Alan, I re-sent a patch but I forgot to add you to CC list:
>> http://marc.info/?l=linux-pci&m=149760607914628&w=2
>
> Thanks for letting me know.  The patch seems reasonable.
>
> Have you tested it with system suspend?  That is, if you suspend the
> whole computer, does plugging or unplugging a USB device cause the
> system to wake up?

No, the system will not wake up when plugging or unplugging.
Tried several times, nether runtime PM enabled nor runtime PM disabled
will wake up the system under S3, when (un)plugging USB devices.

>
> Alan Stern
>
