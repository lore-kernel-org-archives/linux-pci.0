Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:61771 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab3FZQgd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2013 12:36:33 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so14907548oag.40
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2013 09:36:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXmP54PLSOYq17hi54ziDRM0fe+i0sRymz4+yeAxhT3-w@mail.gmail.com>
References: <20130626025001.GA25384@google.com> <CAE9FiQXmP54PLSOYq17hi54ziDRM0fe+i0sRymz4+yeAxhT3-w@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 26 Jun 2013 10:36:11 -0600
Message-ID: <CAErSpo7MELuvuR9stzrLydn78wxsKwMPE1+sCDVbFextd06j7Q@mail.gmail.com>
Subject: Re: Current open PCI defects
To: Yinghai Lu <yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 25, 2013 at 11:51 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Jun 25, 2013 at 7:50 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Here's a list of the current PCI defects open in https://bugzilla.kernel.org
>>
>> Hint: maintainers really like it when people take the initiative to
>> resolve open issues.
>>
>> Regressions (8 total):
>
>>   57961 ExpressCard hot-remove and hot-add not recognized by acpiphp
>
> for 3.9 stable:
> https://patchwork.kernel.org/patch/2676821/
>
> Greg, can you pick that for 3.9.8?

That patch is already in Linus' tree and is marked correctly (AFAICS)
for 3.9 stable:

commit 3f327e39b4b8f760c331bb2836735be6d83fbf53
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Tue May 7 11:06:03 2013 -0600

    PCI: acpiphp: Re-enumerate devices when host bridge receives Bus Check

    ...

    [bhelgaas: changelog, references]
    Reference: https://lkml.kernel.org/r/CAAh6nkmbKR3HTqm5ommevsBwhL_u0N8Rk7Wsms_LfP=nBgKNew@mail.gmail.com
    Reference: https://bugzilla.kernel.org/show_bug.cgi?id=57961
    Reported-by: Gavin Guo <tuffkidtt@gmail.com>
    Tested-by: Gavin Guo <tuffkidtt@gmail.com>
    Signed-off-by: Yinghai Lu <yinghai@kernel.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Jiang Liu <jiang.liu@huawei.com>
    Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    CC: stable@vger.kernel.org  # v3.9+
