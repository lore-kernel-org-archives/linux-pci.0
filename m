Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8119513.v7VrlzcaZC@vostro.rjw.lan>
References: <8498184.VilrUmatxI@vostro.rjw.lan>
	<CAE9FiQWZ8WaAJm8ayU+woVRqNLdSRtPS4=gpsrJovmzrUG6FNw@mail.gmail.com>
	<38722368.Fl8pJoLSRi@vostro.rjw.lan>
	<8119513.v7VrlzcaZC@vostro.rjw.lan>
Date: Mon, 10 Dec 2012 18:26:08 -0800
Message-ID: <CAE9FiQXYPPcRZZBFGrqcV--0-UixMH1f+q4WdovErthsLhxn7A@mail.gmail.com>
Subject: Re: [PATCH 5/6] ACPI: Replace struct acpi_bus_ops with enum type
From: Yinghai Lu <yinghai@kernel.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Jiang Liu <jiang.liu@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	linux-pci@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 10, 2012 at 5:28 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>
>> OK, thanks for the pointers.  I actually see more differences between our
>> patchsets.  For one example, you seem to have left the parent->ops.bind()
>> stuff in acpi_add_single_object() which calls it even drivers_autoprobe is
>> set.
>
> Sorry, that should have been "which calls it even when drivers_autoprobe is
> not set".  I need to be more careful.
>

oh,  Jiang Liu had one patch to remove that workaround.

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=b40dba80c2b8395570d8357e6b3f417c27c84504

ACPI/pci-bind: remove bind/unbind callbacks from acpi_device_ops

Maybe you can review that patches in my for-pci-next2...
those are ACPI related anyway.

those patches have been there for a while, and Bjorn did not have time
to digest them.

or you prefer I resend updated version as huge whole patchset?

Thanks

Yinghai
