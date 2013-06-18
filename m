Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <51C07909.9030508@gmail.com>
Date: Tue, 18 Jun 2013 23:13:13 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@gmail.com>
CC: Jiang Liu <jiang.liu@huawei.com>, alexdeucher@gmail.com,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-acpi@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUGFIX v2 0/4] fix bug 56531, 59501 and 59581
References: <1371238081-32260-1-git-send-email-jiang.liu@huawei.com> <CAN_LGv1itN=ADE-3LNCoBJFXmpWZffhQb6NQuoBzvONkX3brug@mail.gmail.com> <51BDF705.5090904@gmail.com> <CAN_LGv0yXhQi82ck3mvTbwuZv2dhnYB7Xnk9P4=5XVoAaAAeZQ@mail.gmail.com> <CAN_LGv2GTgMJB8NL7iPnyk9bMvbDKE9i6HP0UV5d_9CfytJ0pg@mail.gmail.com>
In-Reply-To: <CAN_LGv2GTgMJB8NL7iPnyk9bMvbDKE9i6HP0UV5d_9CfytJ0pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/18/2013 01:07 AM, Alexander E. Patrakov wrote:
> 2013/6/17 Alexander E. Patrakov <patrakov@gmail.com>:
>> I am not 100% sure that the static key backtrace is the same in all
>> cases. However, I do remember that it does appear both in the
>> non-hotplug and hotplug cases.
>>
>> I will retest this after work, i.e. in ~12 hours.
> 
> Tried again, failed to reproduce this warning. Sorry :(
Sounds like another memory corruption caused by race conditions:(

> 
> --
> Alexander E. Patrakov
> 

