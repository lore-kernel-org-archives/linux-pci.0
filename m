Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:48723 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab3HTUNF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2013 16:13:05 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so1785393oag.35
        for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2013 13:13:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52135FB3.3090700@huawei.com>
References: <1376533135-36708-1-git-send-email-wangyijing@huawei.com>
 <1376533135-36708-2-git-send-email-wangyijing@huawei.com> <20130816221716.GA25780@google.com>
 <521187A5.6030002@huawei.com> <CAPoiz9zpovgcnx=DG-g4v7VpA17H5P2EYv1spm7TGLOwO6zYCQ@mail.gmail.com>
 <CAErSpo7kxfJDrm1QwNrGd4onfKBzUW+jVV-8p14i1yJqkMFobg@mail.gmail.com>
 <CAErSpo7tf+9NUGT2U5WBcQUtZb9=ZT_4wAjxzhiiWh9n_KEbAA@mail.gmail.com>
 <CAPoiz9wMo+sr1EWp+fPdwKTBoJpQGjZg-dASRMHAtvPBE+G4Eg@mail.gmail.com>
 <5212DA84.6070409@huawei.com> <20130820044416.GA22188@google.com> <52135FB3.3090700@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 20 Aug 2013 14:12:44 -0600
Message-ID: <CAErSpo7e=KW11RHoSD3kAEkRNrage5V5gq_FuOtqQXue_HOSmw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: fix the only slot identification in pcie_find_smpss()
To: Yijing Wang <wangyijing@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 20, 2013 at 6:23 AM, Yijing Wang <wangyijing@huawei.com> wrote:

>> I don't think we should look at the dev->bus->devices list at all
>> because that only applies to the current configuration and
>> doesn't account for any future hot-plugs.
>
> I think so.
>
> If Jon agree too , I will update this patch.

No need to wait for Jon; this is a tiny patch, and things will go
faster if you just go ahead and update the patch, test it, and post
it.  Then we can all see exactly what change you propose, and it's
always easier to comment on a concrete patch rather than an English
description of it.  If Jon disagrees with the patch, we can discuss
some more and go from there.

Bjorn
