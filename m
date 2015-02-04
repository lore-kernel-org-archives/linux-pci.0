Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:58379 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933819AbbBDOTf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Feb 2015 09:19:35 -0500
Received: by mail-qg0-f44.google.com with SMTP id l89so1336390qgf.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Feb 2015 06:19:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150204033409.GA11577@richard>
References: <20150130230803.GA6795@google.com> <1422946903-12958-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150204001926.GA19540@google.com> <20150204033409.GA11577@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 4 Feb 2015 08:19:14 -0600
Message-ID: <CAErSpo4nLEvL4XGvkvZbfy0dFQcRDHdn5aznkx2fRMMnt1_n4g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: make sure the IOV BAR will not exceed
 limit after shifting
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 3, 2015 at 9:34 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Tue, Feb 03, 2015 at 06:19:26PM -0600, Bjorn Helgaas wrote:
>>On Tue, Feb 03, 2015 at 03:01:43PM +0800, Wei Yang wrote:

>>> +    vf_num = pdn->vf_pes;
>>
>>I can't actually build this, but I don't think pdn->vf_pes is defined yet.
>>
>
> The pdn->vf_pes is defined in the next patch, it is not defined yet.
>
> I thought the incremental patch means a patch on top of the current patch set,
> so it is defined as the last patch.

Yes, that's fine.  I want to keep the series bisectable, so I'll fold
these patches together.

>>I pushed an updated pci/virtualization branch with these updates.  I
>>think there's also a leak that needs to be fixed that Dan Carpenter
>>pointed out.

>>+      vf_num = pdn->vf_pes;           // FIXME not defined yet
>
> Do you want me poll your pci/virtualization branch and fix this?

Don't worry about this FIXME; I can fix that by squashing two patches.
But please do pull my pci/virtualization branch and fix this one (this
is the one that I thought Dan Carpenter pointed out):

  drivers/pci/iov.c:488 sriov_init() warn: possible memory leak of 'iov'
