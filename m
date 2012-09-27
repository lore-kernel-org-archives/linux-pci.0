Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo5bTDWCoVbzP-zz_ZcbSL-QJg+eFwoJHQxvaeQAY5OG2A@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<20120918152553.8c8390d8.izumi.taku@jp.fujitsu.com>
	<CAErSpo7hYHkFAgFy=q6ASV_15r-y_Cp=92nUdRAnBSGLi9ZMrA@mail.gmail.com>
	<CAErSpo5bTDWCoVbzP-zz_ZcbSL-QJg+eFwoJHQxvaeQAY5OG2A@mail.gmail.com>
Date: Thu, 27 Sep 2012 10:23:32 -0700
Message-ID: <CAE9FiQUUjPza9Hq8jJR0nLN__26zQooQAr=paB6dRjQtTM=ngw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 27, 2012 at 9:48 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Sep 21, 2012 at 2:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> If we get rid of the struct pci_bus * dependency, then we can easily
>> add the _PRT before doing PCI enumeration behind the bridge, and we
>> can remove the _PRT after removing the PCI devices.  I think this is
>> one small step toward getting rid of the add/start and stop/remove
>> split.
>
> I'm going to work on doing this if nobody else is interested.

I'm not sure if that is needed.

-Yinghai
