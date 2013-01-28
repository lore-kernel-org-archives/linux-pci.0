Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo7vHXdh=ogvfZnxx9gqgiifWGa=XzS+ZKjXFFOPue4TTw@mail.gmail.com>
References: <1358525267-14268-1-git-send-email-jiang.liu@huawei.com>
	<1358525267-14268-5-git-send-email-jiang.liu@huawei.com>
	<3500982.MUDp6kKU3R@vostro.rjw.lan>
	<CAErSpo4fbNzFaBxH+eKD+BKVgghyCJEYLDMzc6_gdxABAPe3QQ@mail.gmail.com>
	<CAE9FiQVM4+Wirpb3_D0Zxi4r1p9SAMi4ZrNYr=-eas-C6pKJYA@mail.gmail.com>
	<CAErSpo7WbbzZ8cKfLvuE331ofWir2vswUnYaxVLBBYGFowedXQ@mail.gmail.com>
	<CAE9FiQXkrYubkgbbOXmrEXvGZBZXMZ6sh8kGTpF1_=tD3OMPJw@mail.gmail.com>
	<CAErSpo7vHXdh=ogvfZnxx9gqgiifWGa=XzS+ZKjXFFOPue4TTw@mail.gmail.com>
Date: Mon, 28 Jan 2013 14:58:15 -0800
Message-ID: <CAE9FiQU84OSQrQJEGAQTDzVv8kGCi+fmgM8+ycoMXMUfHsNe-g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 4/8] ACPI, PCI: avoid building pci_slot as module
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jiang Liu <liuj97@gmail.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 28, 2013 at 2:14 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> CONFIG_ACPI_PCI_SLOT=y in RHEL6, so evidently they have this problem.

oh, I only checked opensuse that has that set to m.

>
> Asking users to edit module.conf by hand is not a solution, just like
> asking users to boot with a command line option is not a solution.
> That sort of stuff is fine for a hobbyist OS intended only for techie
> geeks.  It's not fine for Linux.

not sure. add something in command line or conf files.
but recompile kernel is another story.

>
> If you would give a concrete example of the ACPI namespace info and
> device config, hotplug sequence, etc., required to show the problem,
> we could have a useful discussion about ways to fix it.  But if all
> you have is FUD about "this might break and users won't have the
> ability to edit modules.conf," that doesn't help me see why this patch
> is a bad idea.

Never mind, We should save your bandwidth to more patches.

Yinghai
