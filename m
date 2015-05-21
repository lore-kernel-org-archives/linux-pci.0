Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <555DF723.2000103@linaro.org>
Date: Thu, 21 May 2015 23:17:55 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH] ACPI / PCI: remove stale list_head in struct acpi_prt_entry
References: <1432216352-8016-1-git-send-email-hanjun.guo@linaro.org> <CAErSpo6kFfXd9gFuL86qQWcVN6NYe11Ps+SoAefz1z2md8j_tA@mail.gmail.com>
In-Reply-To: <CAErSpo6kFfXd9gFuL86qQWcVN6NYe11Ps+SoAefz1z2md8j_tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015年05月21日 23:10, Bjorn Helgaas wrote:
> On Thu, May 21, 2015 at 8:52 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> list_head "list" in struct acpi_prt_entry was used to connect
>> _PRT entries for PCI irq, but after commit 181380b7 (PCI/ACPI:
>> Don't cache _PRT, and don't associate them with bus numbers),
>> the list head for _PRT entries was removed, but left "list" in
>> struct acpi_prt_entry which is useless and stale, remove it now.
>
> Please use the canonical commit reference format, i.e.,
>
> 181380b702ee ("PCI/ACPI: Don't cache _PRT, and don't associate them
> with bus numbers")

OK, now I know what is a canonical commit reference format :)

>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> CC: Yinghai Lu <yinghai@kernel.org>
>> CC: Yijing Wang <wangyijing@huawei.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks, will update the change log soon.

Hanjun
