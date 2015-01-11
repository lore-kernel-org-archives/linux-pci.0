Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:37960 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbbAKWUw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 11 Jan 2015 17:20:52 -0500
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 12 Jan 2015 08:20:50 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id B53BF2BB003F
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2015 09:20:47 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0BMKlTM46006504
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2015 09:20:47 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0BMKkWJ002563
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2015 09:20:46 +1100
Date: Mon, 12 Jan 2015 09:20:44 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Ajit Kumar Khaparde <Ajit.Khaparde@Emulex.Com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Mark broken INTx masking for BENET devices
Message-ID: <20150111222044.GA5446@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1420424274-3194-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <a227414f-6f4b-4656-b65b-ef8d6e68f135@CMEXHTCAS1.ad.emulex.com>
 <20150109003320.GA24054@shangw>
 <1257448143.6977594.1420766719306.JavaMail.zimbra@redhat.com>
 <f588414b-dba0-4d83-942b-0e5841f1e89c@CMEXHTCAS1.ad.emulex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f588414b-dba0-4d83-942b-0e5841f1e89c@CMEXHTCAS1.ad.emulex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 09, 2015 at 07:40:08AM +0000, Venkat Duvvuru wrote:
>> >
>> > Venkat, On IBM's Power7 box, I passed through following adpater to guest
>> with
>> > following
>> ...
>> >
>> > Steps to recreate the issue
>> > ===========================
>> >
>> > 1. Configure the NIC and ping it from external.
>> > 2. Inject EEH error by running following command in host side. After about
>> >    20 seconds, I got following message from host side. With the patch
>> applied
>> >    to host kernel, I didn't see the warning messages:
>> 
>> This seems really dubious and I don't see any justification at all for declaring
>> DisINTx broken for all devices for the vendor.  Typically to call DisINTx broken
>> for a given device, you can just boot the guest with pci=nomsi to force INTx
>> to be used.  If that works, then DisINTx masking works.  If you require EEH
>> injection to to trigger this, then the problem is more likely some containment
>> issue during EEH recovery.  Thanks,
>> 
>> Alex
>Yes I agree with Alex. 
>pci=nomsi is what exactly we did to see if DisINTx is broken or not and DisINTx works fine in our setup.
>I think, we need to analyze this EEH injection scenario further, to root cause the problem.
>We will post you updates on our findings after the analysis.

Thanks for suggestions. I'll do more experiments to locate the EEH. With the older
QEMU version, I didn't find this issue, so I guess it would be introduced by recent
QEMU VFIO changes.

Note: pci=nomsi didn't give me usable console from the guest side. I don't know why
yet. Need some time to investigate.

Thanks,
Gavin

