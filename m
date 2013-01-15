Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 17/22] PCI, ACPI: Add alloc_acpi_hp_work()
Date: Tue, 15 Jan 2013 12:27:04 +0100
Message-ID: <5134894.kiC8yZAa7S@vostro.rjw.lan>
In-Reply-To: <CAE9FiQU_jokR9b2+G7P77aUfxsE6H1HFtO3k5XjqxyD2JZPpFQ@mail.gmail.com>
References: <1357944049-29620-1-git-send-email-yinghai@kernel.org> <3988288.MTBNr2Bzqb@vostro.rjw.lan> <CAE9FiQU_jokR9b2+G7P77aUfxsE6H1HFtO3k5XjqxyD2JZPpFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, January 14, 2013 10:59:28 PM Yinghai Lu wrote:
> On Sat, Jan 12, 2013 at 3:45 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, January 11, 2013 02:40:44 PM Yinghai Lu wrote:
> >> Will use it with acpiphp and pci_root_hp events handling
> >
> > I think it would be better if you folded patches [17-20/22] together.
> 
> just want to make move/split more simple. so could separate out old
> code in acpiphp is
> moved at first, then apply change etc.

Well, OK.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
