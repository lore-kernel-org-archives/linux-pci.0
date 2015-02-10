Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:36926 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbbBJBg1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 20:36:27 -0500
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 10 Feb 2015 11:36:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5F4043578048
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 12:36:23 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1A1aExu34537630
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 12:36:22 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1A1Zm2Y018473
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 12:35:49 +1100
Date: Tue, 10 Feb 2015 09:35:32 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, bhelgaas@google.com,
	gwshan@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V11 02/17] PCI/IOV: add VF enable/disable hook
Message-ID: <20150210013532.GA6326@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <1423527979.4924.67.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423527979.4924.67.camel@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 10, 2015 at 11:26:19AM +1100, Benjamin Herrenschmidt wrote:
>On Thu, 2015-01-15 at 10:27 +0800, Wei Yang wrote:
>> +       if ((retval = pcibios_sriov_enable(dev, initial))) {
>> +               dev_err(&dev->dev, "Failure %d from
>> pcibios_sriov_setup()\n",
>> +                       retval);
>> +               return retval;
>> +       }
>> +
>
>Don't we want pcibios_sriov_enable() to be able to crop the number
>of VFs or do we think any resource limits have been applied
>already ?

The second parameter "initial" is the number of VFs will be enabled. Arch
dependent function will check the resources for these number of VFs.

Do I catch your question correctly?

>
>Ben.
>

-- 
Richard Yang
Help you, Help me

