Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46469 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933927AbcKWWOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2016 17:14:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uANMESvp039220
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2016 17:14:31 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26we2y38c9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2016 17:14:30 -0500
Received: from localhost
        by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Thu, 24 Nov 2016 08:14:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
        by d23dlp02.au.ibm.com (Postfix) with ESMTP id BEBE82BB005D
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2016 09:14:02 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
        by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id uANME2Dq29622346
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2016 09:14:02 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
        by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id uANME26q018737
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2016 09:14:02 +1100
Date: Thu, 24 Nov 2016 09:15:20 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCI driver reset function?
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <CAHhAz+jGkc5DQ719zC_A8g1vF7L41Dowh9yTiLkYoHcEaAw+RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHhAz+jGkc5DQ719zC_A8g1vF7L41Dowh9yTiLkYoHcEaAw+RA@mail.gmail.com>
Message-Id: <20161123221520.GA4783@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2016 at 06:42:25PM +0530, Muni Sekhar wrote:
>HI All,
>
>Does the PCI driver have any associated reset function?
>

Please take a look on drivers/pci/pci.c::pci_reset_function().

Thanks,
Gavin

