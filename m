Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <52D9F98A.2090003@linux.intel.com>
Date: Sat, 18 Jan 2014 11:48:26 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v1 2/3] ACPI, PCI: reuse ACPI hotplug framework to support
 PCI host bridge hotplug
References: <1390013297-23462-1-git-send-email-jiang.liu@linux.intel.com>	<1390013297-23462-2-git-send-email-jiang.liu@linux.intel.com> <CAE9FiQXS-vctiWtXBcw8g6dqPEJGSND+GXB1t64kEoCiygBhjQ@mail.gmail.com>
In-Reply-To: <CAE9FiQXS-vctiWtXBcw8g6dqPEJGSND+GXB1t64kEoCiygBhjQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi yinghai,
	Sorry for the noise. I didn't noticed Rafael's work,
so I generated this patchset when encountered this issue
during testing PCI host bridge hotplug. It should achieve
the same goal.
Thanks!
Gerry

On 2014/1/18 11:23, Yinghai Lu wrote:
> ACPI / hotplug: Make ACPI PCI root hotplug use common hotplug code
