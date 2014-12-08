Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:34989 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbaLHXjE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Dec 2014 18:39:04 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 9 Dec 2014 09:39:01 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7D1243578048
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2014 10:38:58 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sB8Ncv6h42139718
	for <linux-pci@vger.kernel.org>; Tue, 9 Dec 2014 10:38:58 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sB8NcuDV018539
	for <linux-pci@vger.kernel.org>; Tue, 9 Dec 2014 10:38:57 +1100
Date: Tue, 9 Dec 2014 10:38:55 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	Marek =?iso-8859-1?Q?Kord=EDk?= <kordikmarek@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
Message-ID: <20141208233855.GA15713@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
 <CAErSpo63uZeo1feoPjjXpdH43nsbcWh63kpBmxCnckPd0t9yrg@mail.gmail.com>
 <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
 <20141204173411.GA5949@google.com>
 <CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
 <1417777177.4741.69.camel@kernel.crashing.org>
 <20141208004735.GA15508@shangw>
 <CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
 <1418074683.13358.1.camel@kernel.crashing.org>
 <CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2014 at 02:46:00PM -0700, Bjorn Helgaas wrote:
>[-cc Saifi (bouncing)]
>
>On Mon, Dec 8, 2014 at 2:38 PM, Benjamin Herrenschmidt
><benh@kernel.crashing.org> wrote:
>> On Mon, 2014-12-08 at 14:04 -0700, Bjorn Helgaas wrote:
>>>
>>> However, I think 5b28541552ef is taking the wrong approach.  Consider
>>> a device that, like this Radeon, has a 32-bit prefetchable BAR.  If
>>> the upstream bridge has a 32-bit prefetchable window, things work as
>>> expected -- we put the prefetchable BAR in the prefetchable window.
>>> But if the bridge has a 64-bit prefetchable window, we put that same
>>> BAR in a 32-bit non-prefetchable window.
>>
>> Well, that's expected, unless the 64-bit prefetchable window happens to
>> be fully enclosed in 32-bit space ... So maybe the approach is to check
>> that this is the case and "downgrade" such 64-bit prefetchable BARs to
>> 32-bit ...
>
>Yeah, I didn't word that very clearly.  I meant that after
>5b28541552ef, that 64-bit window is wasted unless there's a 64-bit BAR
>below it; we can't even place the window below 4GB and use it for
>32-bit prefetchable BARs.
>

Yes, I agree. It's why I suggested to return error from pbus_size_mem()
to indicate the case: 64-bits prefetchable window isn't used and it's
still available to be used by child 32-bits prefetchable BARs. Please
take a look on the attached draft patch, which helps to explain the idea
only.

Thanks,
Gavin

--YiEDa0DAkWCtVeE4
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-PCI-Use-64-bits-pref-window-accomodate-pref-BARs.patch"

>From bef332d8e2bfc464da202daa2c9d1415db1f1224 Mon Sep 17 00:00:00 2001
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Tue, 9 Dec 2014 10:21:24 +1100
Subject: [PATCH] PCI: Use 64-bits pref window accomodate pref BARs

The PCI resource allocation and reassignment has been changed a
lot by Commit 5b28541552ef ("PCI: Restrict 64-bit prefetchable
bridge windows to 64-bit resources"): If parent bridge has 64-bits
prefetchable window, all child 64-bits prefetchable BARs are
expected to be assigned from the window. The left child BARs are
going to be allocated from parent non-prefetchable window.

If there're no child 64-bits prefetchable BARs, pbus_size_mem()
should return error so that the 64-bits prefetchable window still
can be used to accomodate child 32-bits prefetchable BARs.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v1: Draft patch to explain idea only
---
 drivers/pci/setup-bus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 0482235..7a7778f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -989,6 +989,16 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		}
 	}
 
+	/*
+	 * If we don't have unassigned BARs with indicated type, the
+	 * corresponding window won't be used. However, we might use
+	 * this window for BARs with other types, e.g. 64-bits pref
+	 * window for 32-bits pref BARs. Here to return error to
+	 * indicate the case.
+	 */
+	if (!size)
+		return -ENODEV;
+
 	min_align = calculate_mem_align(aligns, max_order);
 	min_align = max(min_align, window_alignment(bus, b_res->flags));
 	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
-- 
1.8.3.2


--YiEDa0DAkWCtVeE4--

