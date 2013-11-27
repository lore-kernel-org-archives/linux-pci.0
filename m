Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22145 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab3K0Tta (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2013 14:49:30 -0500
Message-ID: <52964C9A.6040305@oracle.com>
Date: Wed, 27 Nov 2013 12:48:42 -0700
From: Khalid Aziz <khalid.aziz@oracle.com>
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: bhelgaas@google.com, cl91tp@gmail.com, tianyu.lan@intel.com,
	khlebnikov@openvz.org, gnomes@lxorguk.ukuu.org.uk,
	indou.takao@jp.fujitsu.com, jility09@gmail.com, f.otti@gmx.at,
	ebiederm@xmission.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Clear Bus Master bit only on kexec reboot
References: <1385579908-24608-1-git-send-email-khalid.aziz@oracle.com> <20131127192420.GC11829@srcf.ucam.org>
In-Reply-To: <20131127192420.GC11829@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/27/2013 12:24 PM, Matthew Garrett wrote:
> On Wed, Nov 27, 2013 at 12:18:28PM -0700, Khalid Aziz wrote:
>
>> +/* flag to track if kexec reboot is in progress */
>> +extern unsigned long kexec_in_progress;
>
> Adding this to pci.h seems a little odd. We may want to use it somewhere
> else at some point. Add it to kexec.h instead?
>

I debated between pci.h and kexec.h but pci-driver.c does not include 
kexec.h and I didn't want to include a whole new file. Now I see another 
problem with adding that extern declaration to pci.h - if CONFIG_KEXEC 
is not set, build will fail. I should add #ifdef CONFIG_KEXEC to the 
code in pci-driver.c as well. Time for v2.

--
Khalid
