Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:48296 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650Ab3E1Eyo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 00:54:44 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so19990283ieb.38
        for <linux-pci@vger.kernel.org>; Mon, 27 May 2013 21:54:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51A437A8.7090104@huawei.com>
References: <1369709709-14504-1-git-send-email-wangyijing@huawei.com>
	<CAE9FiQXkwoRfFbcEn15MRGv6fVeOM5WC1Gh2NAhWj7yTda3G+g@mail.gmail.com>
	<51A437A8.7090104@huawei.com>
Date: Mon, 27 May 2013 21:54:43 -0700
Message-ID: <CAE9FiQW8LMPu+o_PYiE26dRLg4iTpdnzOi7x8EwWwUxshPfUMQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/X86: increase info->res_num before checking
 pci_use_crs return
From: Yinghai Lu <yinghai@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Feng Tang <feng.tang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 27, 2013 at 9:50 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2013/5/28 12:35, Yinghai Lu wrote:
>> On Mon, May 27, 2013 at 7:55 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>> I separate this patch from patchset "Add hostbridge resource release to
>>> support root bus hotplug in IA64", because it's a Separate issue.
>>>
>>> We should increase info->res_num before we checking pci_use_crs return
>>> when pci=nocrs set.
>>
>> there is no function change or issue here.
>
> Hi Yinghai,
>    Thanks for review and comments!
> Yes, this patch is no functional change. I just sent this patch for make code flow more clearly.
> Because free_pci_root_info_res() will free all info->res and info->res_offset. So I think move info->res_num++
> before pci_use_crs check is better, better readability.

sure.
