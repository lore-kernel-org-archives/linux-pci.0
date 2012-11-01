Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:37908 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751312Ab2KAGIk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 1 Nov 2012 02:08:40 -0400
Message-ID: <5092119F.1000600@cn.fujitsu.com>
Date: Thu, 01 Nov 2012 14:07:27 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: bhelgaas@google.com, lenb@kernel.org, jiang.liu@huawei.com,
	izumi.taku@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] Use acpi_os_hotplug_execute() instead of alloc_acpi_hp_work().
References: <1351668471-31436-1-git-send-email-tangchen@cn.fujitsu.com> <1351668471-31436-2-git-send-email-tangchen@cn.fujitsu.com> <CAE9FiQWZ=Xgnw-U=4v2a5W7OwBkA3gT63qDnNYGT9p8Rn0O3fg@mail.gmail.com>
In-Reply-To: <CAE9FiQWZ=Xgnw-U=4v2a5W7OwBkA3gT63qDnNYGT9p8Rn0O3fg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/01/2012 11:52 AM, Yinghai Lu wrote:
> On Wed, Oct 31, 2012 at 12:27 AM, Tang Chen<tangchen@cn.fujitsu.com>  wrote:
> Please check if you can just fold
>     acpi_hp_cb_execute
> callers, and use acpi_os_hotplug_execute directly.
>
> and have two local conext struct too.
>
I think this could bring some duplicated work. We need to do the same
work every time we call acpi_os_hotplug_execute(), what has been done
in acpi_hp_cb_execute().

I can try to modify it and resend a new patch to see if it is better.

Thanks. :)



