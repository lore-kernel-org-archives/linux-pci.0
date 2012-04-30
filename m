Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <4F9F0473.9090408@fisher-privat.net>
Date: Mon, 30 Apr 2012 23:30:27 +0200
From: Oleksij Rempel <bug-track@fisher-privat.net>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Andrey Rahmatullin <wrar@wrar.name>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] ACPI / PCI: Make _SxD/_SxW check follow ACPI 4.0a spec
References: <Pine.LNX.4.44L0.1204301348180.1558-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1204301348180.1558-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 30.04.2012 19:53, Alan Stern wrote:
> On Mon, 30 Apr 2012, Bjorn Helgaas wrote:
> 
>> On Sun, Apr 29, 2012 at 2:44 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>> From: Oleksij Rempel <bug-track@fisher-privat.net>
>>>
>>> This patch makes _SxD/_SxW check follow the ACPI 4.0a specification
>>> more closely and fixes suspend bug found on ASUS Zenbook UX31E.
>>>
>>> Some OEM use _SxD fileds do blacklist brocken Dx states.
>>> If _SxD/_SxW return values are check before suspend as appropriate,
>>> some nasty suspend/resume issues may be avoided.
>>>
>>> References: https://bugzilla.kernel.org/show_bug.cgi?id=42728
>>> Signed-off-by: Oleksij Rempel <bug-track@fisher-privat.net>
>>> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>>> ---
>>>
>>> Bjorn, Len,
>>>
>>> This is -stable material and therefore v3.4 as well, IMO. �Please let me
>>> know if one of you can take it or whether you want me to handle it all the
>>> way to Linus.
>>
>> I'm OK with this from a PCI perspective.  Most of the change is in
>> ACPI, so I propose that either you or Len take care of it.
>>
>> The second paragraph of the changelog has several typos
>> (fileds/fields, do/to, brocken/broken, etc).
> 
> It also turns out that the normal wakeup mechanism doesn't work for the
> devices in question.  Can this be detected by ACPI?  We don't want to 
> tell userspace that wakeup works when in fact it doesn't.

hm... how about using pci config and acpi together. PCI config provides
map of Dx states and wakeup support of them. If pci says wakeup works
only on D0 and D3 and acpi say - we can use only D2 in S3, then there is
no wakeup.

-- 
Regards,
Oleksij
