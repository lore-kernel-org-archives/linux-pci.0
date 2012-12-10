Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2097693.II1PNyeFLY@vostro.rjw.lan>
References: <8498184.VilrUmatxI@vostro.rjw.lan>
	<2097693.II1PNyeFLY@vostro.rjw.lan>
Date: Sun, 9 Dec 2012 21:34:42 -0800
Message-ID: <CAE9FiQWxoWubagm4gj81YgMeqyEZgpT47ROAfjmXSmoaTn-Yig@mail.gmail.com>
Subject: Re: [PATCH 5/6] ACPI: Replace struct acpi_bus_ops with enum type
From: Yinghai Lu <yinghai@kernel.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	linux-pci@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 9, 2012 at 3:03 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Notice that one member of struct acpi_bus_ops, acpi_op_add, is not
> used anywhere any more and the relationship between its remaining
> members, acpi_op_match and acpi_op_start, is such that it doesn't
> make sense to set the latter without setting the former at the same
> time.  Therefore, replace struct acpi_bus_ops with new a enum type,
> enum acpi_bus_add_type, with three values, ACPI_BUS_ADD_BASIC,
> ACPI_BUS_ADD_MATCH, ACPI_BUS_ADD_START, corresponding to
> both acpi_op_match and acpi_op_start unset, acpi_op_match set and
> acpi_op_start unset, and both acpi_op_match and acpi_op_start set,
> respectively.
>

Can we expand the BUS_ADD_* concept to other devices instead of just
acpi_device?

aka we should let struct device has this add_type field.
