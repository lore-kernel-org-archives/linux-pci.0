Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2737587.I0nULev1kj@vostro.rjw.lan>
References: <2737587.I0nULev1kj@vostro.rjw.lan>
Date: Sun, 23 Jun 2013 23:50:15 +0600
Message-ID: <CAN_LGv3LZbp-7JE=Lxo+53GxWTQ_D6nJ=w+OnuQ3JkmWfXOhxg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI / dock / PCI: Fix problems with dock and PCI hotplug
From: "Alexander E. Patrakov" <patrakov@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2013/6/23 Rafael J. Wysocki <rjw@sisk.pl>:
> Alexander, I've modified patch [3/3] a bit since you have tested it.
> The modifications shouldn't affect the behavior, but if you could re-test it,
> that would be great.

Retested, everything works just as with the previous version of your patch.

--
Alexander E. Patrakov
