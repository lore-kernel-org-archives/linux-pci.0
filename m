Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150721165759.GD21967@google.com>
References: <1436565766-21820-1-git-send-email-jordan_hargrave@dell.com>
	<20150713093518.7e869d07@endymion.delvare>
	<CAC1AzdfFjPrfvg2iBYXY5JDKhbVH3LPQdh5LzyjMaBFSNDBi6Q@mail.gmail.com>
	<20150721165759.GD21967@google.com>
Date: Tue, 21 Jul 2015 12:31:35 -0500
Message-ID: <CAC1AzddX-HQe_UQ4C=ohyWDGjE=aed5+soDzjypQjjcqFfWTNA@mail.gmail.com>
Subject: Re: [PATCH] Add support for reading SMBIOS Slot number for PCI devices
From: Jordan Hargrave <jharg93@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 21, 2015 at 11:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 13, 2015 at 09:57:32AM -0500, Jordan Hargrave wrote:
>> On Mon, Jul 13, 2015 at 2:35 AM, Jean Delvare <jdelvare@suse.de> wrote:
>>
>> > Hi Jordan,
>> >
>> > On Fri, 10 Jul 2015 17:02:46 -0500, Jordan Hargrave wrote:
>> > > From: Jordan Hargrave <Jordan_Hargrave@dell.com>
>> > >
>> > > There currently isn't an easy way to determine which PCI devices belong
>> > to
>> > > system slots.  This patch adds support to read SMBIOS Type 9 (System
>> > Slots).
>> >
>> > I'm wondering, can't you use dmidecode or libsmbios to retrieve the
>> > same information?
>> >
>> > --
>> > Jean Delvare
>> > SUSE L3 Support
>> >
>>
>> You can but it's as not easy to determine the slot number for leaf devices
>> on bridges.  Eventually planning on using this for pulling slot number for
>> identifying network cards and disk numbering for systemd
>
> Can you outline the problems with using dmidecode or libsmbios?

Neither dmidecode nor libsmbios report the slot number for devices
behind bridges in a slot.  I'm wanting to use this sysfs variable to
get slot numbers for systemd, so using libsmbios and dmidecode aren't
very useful.  We already report the index for embedded devices in
pci-label.c, this code should have gone in at the same time.

For example.  The SMBIOS entry for slot 3 is 40:00.0 There is a
quad-port NIC in the slot with a bridge at 40:00.0

42:00.0 Bridge (sec=43, sub=45)
43:02.0 Bridge (sec=44, sub=44)
43:04.0 Bridge (sec=45, sub=45)
44:00.0 Ethernet
44:00.1 Ethernet
45:00.0 Ethernet
45:00.1 Ethernet

So dmidecode only returns the slot number for 42:00.0 but not any
child devices.  This code will provide a 'slot' sysfs variable that
reports '3' for all devices under and including the bridge.
