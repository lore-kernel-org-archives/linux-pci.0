Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <11307583.LtSeEfeXbs@vostro.rjw.lan>
References: <1364444938-19801-1-git-send-email-yinghai@kernel.org>
	<2045510.EK2WTuFZxV@vostro.rjw.lan>
	<CAE9FiQWM=egh3OPcWMD+bJv2FtSsGopk_Pq0JUpQCy+pvja-6A@mail.gmail.com>
	<11307583.LtSeEfeXbs@vostro.rjw.lan>
Date: Fri, 29 Mar 2013 18:08:35 -0700
Message-ID: <CAE9FiQV+zic-pi4yomQDoy-Rc0u1_+s4KbXJZKf9i_9xkvaknA@mail.gmail.com>
Subject: Re: [PATCH] PCI, ACPI: Don't query OSC support with all possible controls
From: Yinghai Lu <yinghai@kernel.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Len Brown <len.brown@intel.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 29, 2013 at 6:12 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, March 29, 2013 06:02:45 PM Yinghai Lu wrote:
>> On Fri, Mar 29, 2013 at 5:36 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >> -             /* Run _OSC query for all possible controls. */
>> >> -             capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
>> >> +             /* Run _OSC query only with existing controls. */
>> >> +             capbuf[OSC_CONTROL_TYPE] = root->osc_control_set;
>> >
>> > I suppose we can do that, but then why this should be root->osc_control_set and
>> > not just 0?
>>
>> in case query support and set control are called in mixed sequence.
>
> OK, that's a good enough reason I think.
>
> I'm kind of afarid of regressions that may result from this, though, so I'm
> going to queue it up for 3.10.

Ok,

Thanks
