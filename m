Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44378 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756857AbcFACqj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2016 22:46:39 -0400
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u512ib3R012924
	for <linux-pci@vger.kernel.org>; Tue, 31 May 2016 22:46:38 -0400
Message-Id: <201606010246.u512ib3R012924@mx0a-001b2d01.pphosted.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23961rjfta-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 31 May 2016 22:46:37 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
	Wed, 1 Jun 2016 12:46:33 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id BDF5A2BB005E
	for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2016 12:46:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u512jlwR63635540
	for <linux-pci@vger.kernel.org>; Wed, 1 Jun 2016 12:46:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u512j8A4011434
	for <linux-pci@vger.kernel.org>; Wed, 1 Jun 2016 12:45:09 +1000
Subject: Re: [PATCH v10 03/18] powerpc/powernv: Remove PCI_RESET_DELAY_US
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1463726502-14679-4-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, linux-pci@vger.kernel.org, alistair@popple.id.au
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 1 Jun 2016 12:35:23 +1000
MIME-Version: 1.0
In-Reply-To: <1463726502-14679-4-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20/05/16 16:41, Gavin Shan wrote:
> The macro defined in arch/powerpc/platforms/powernv/pci.c isn't
> used by anyone. Just remove it.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Looks like the only user of it disappeared in late 2014...

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

