Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:50474 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbbCXBzK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2015 21:55:10 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 24 Mar 2015 11:55:07 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1AF8A2BB004D
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2015 12:55:05 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t2O1suPo32178206
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2015 12:55:05 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t2O1sUaG004320
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2015 12:54:31 +1100
Date: Tue, 24 Mar 2015 09:54:14 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, bhelgaas@google.com,
	benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V14 17/21] powerpc/powernv: Shift VF resource with an
 offset
Message-ID: <20150324015414.GA7824@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1426820797-6267-18-git-send-email-weiyang@linux.vnet.ibm.com>
 <1427152946.2922.3.camel@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427152946.2922.3.camel@axtens.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 24, 2015 at 10:22:26AM +1100, Daniel Axtens wrote:
>> +
>> +		/* Do some magic shift */
>> +		ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
>
>
>Given that you're already doing a version 15, would it be possible to
>include a more informative comment than "Do some magic shift"? Perhaps
>some of the information from your commit message?
>
>Regards,
>Daniel
>

Daniel,

Thanks for your comment, I will add more informative comment at this place.


-- 
Richard Yang
Help you, Help me

