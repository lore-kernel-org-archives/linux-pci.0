Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:53224 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbbIIFAP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2015 01:00:15 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
	Wed, 9 Sep 2015 15:00:13 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 23BB32BB005D
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2015 15:00:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t89500eL48627940
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2015 15:00:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t894xZvT014326
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2015 14:59:36 +1000
Message-ID: <1441774751.2767.20.camel@au1.ibm.com>
Subject: Re: [PATCH V9 11/11] powerpc/powernv: compound PE for VFs
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Richard Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, linux-pci@vger.kernel.org, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org
Date: Wed, 09 Sep 2015 14:59:11 +1000
In-Reply-To: <20150909033616.GA5148@richards-mbp.cn.ibm.com>
References: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <1437112961-17275-12-git-send-email-weiyang@linux.vnet.ibm.com>
	 <20150729031718.GA18069@richard> <20150909024820.GA6808@gwshan>
	 <20150909033616.GA5148@richards-mbp.cn.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-09-09 at 11:36 +0800, Richard Yang wrote:
> The VF EEH is hung since we re-designed the SRIOV. After the re
> -design, we
> don't have VF groups.
> 
> My plan is to push the VF EEH patch set after the SRIOV Redesign is
> accepted.

What do you mean taht we don't have VF groups ?

If we don't have IOMMU groups per VF that means we can't assign them to
KVM partitions -> they are completely useless.

Ben.

