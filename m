Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo5sGAEO+kcqUsjyrmn_LAzmkWm4ok0c=rBaR_ErwBX23A@mail.gmail.com>
References: <1558789.gX8cmBgyDV@vostro.rjw.lan>
	<150695156.KNRhubloU5@vostro.rjw.lan>
	<CAErSpo5ZpUaHzYQEpR9Jh0MbcmjHfhKUQ-EpRJH1PNCHR_qnVg@mail.gmail.com>
	<5457615.T2WjKPXXC4@vostro.rjw.lan>
	<CAE9FiQUBpu+rUfnvOwDUm8PTYYVfann3SyhhL4k=54EyfRSmLg@mail.gmail.com>
	<CAErSpo5sGAEO+kcqUsjyrmn_LAzmkWm4ok0c=rBaR_ErwBX23A@mail.gmail.com>
Date: Wed, 26 Dec 2012 12:16:18 -0800
Message-ID: <CAE9FiQWr6-=kvrCXKEWFvUHHv6xbHKt-oAdt+VPUMphVUW4U4A@mail.gmail.com>
Subject: Re: [Alternative][PATCH] ACPI / PCI: Set root bridge ACPI handle in advance
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jiang Liu <liuj97@gmail.com>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 26, 2012 at 12:10 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Do you have a reference for this?  I think this might have been true
> in the past, but I don't think it's true for any version of gcc we
> support for building Linux.

http://lkml.indiana.edu/hypermail/linux/kernel/0804.3/3600.html
