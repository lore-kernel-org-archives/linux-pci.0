Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:33647 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932877AbbBDPVm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Feb 2015 10:21:42 -0500
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 5 Feb 2015 01:21:39 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2CA382BB0047
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2015 02:21:36 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t14FLR6Y33554496
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2015 02:21:35 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t14FL2ED026833
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2015 02:21:02 +1100
Date: Wed, 4 Feb 2015 23:20:42 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/powernv: make sure the IOV BAR will not exceed
 limit after shifting
Message-ID: <20150204152042.GA6273@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150130230803.GA6795@google.com>
 <1422946903-12958-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150204001926.GA19540@google.com>
 <20150204033409.GA11577@richard>
 <CAErSpo4nLEvL4XGvkvZbfy0dFQcRDHdn5aznkx2fRMMnt1_n4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4nLEvL4XGvkvZbfy0dFQcRDHdn5aznkx2fRMMnt1_n4g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 04, 2015 at 08:19:14AM -0600, Bjorn Helgaas wrote:
>On Tue, Feb 3, 2015 at 9:34 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> On Tue, Feb 03, 2015 at 06:19:26PM -0600, Bjorn Helgaas wrote:
>>>On Tue, Feb 03, 2015 at 03:01:43PM +0800, Wei Yang wrote:
>
>>>> +    vf_num = pdn->vf_pes;
>>>
>>>I can't actually build this, but I don't think pdn->vf_pes is defined yet.
>>>
>>
>> The pdn->vf_pes is defined in the next patch, it is not defined yet.
>>
>> I thought the incremental patch means a patch on top of the current patch set,
>> so it is defined as the last patch.
>
>Yes, that's fine.  I want to keep the series bisectable, so I'll fold
>these patches together.
>
>>>I pushed an updated pci/virtualization branch with these updates.  I
>>>think there's also a leak that needs to be fixed that Dan Carpenter
>>>pointed out.
>
>>>+      vf_num = pdn->vf_pes;           // FIXME not defined yet
>>
>> Do you want me poll your pci/virtualization branch and fix this?
>
>Don't worry about this FIXME; I can fix that by squashing two patches.
>But please do pull my pci/virtualization branch and fix this one (this
>is the one that I thought Dan Carpenter pointed out):
>
>  drivers/pci/iov.c:488 sriov_init() warn: possible memory leak of 'iov'

Sure, let me take a look.

-- 
Richard Yang
Help you, Help me

