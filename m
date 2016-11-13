Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60235 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752814AbcKMXW7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2016 18:22:59 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uADNIb1D089761
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2016 18:22:58 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26pqqu4p31-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2016 18:22:58 -0500
Received: from localhost
        by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Mon, 14 Nov 2016 09:22:55 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
        by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0F5E92BB0057
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 10:22:52 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
        by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id uADNMp5Y49545442
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 10:22:51 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
        by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id uADNMpt8013924
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 10:22:51 +1100
Date: Mon, 14 Nov 2016 10:24:01 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Noa Osherovich <noaos@mellanox.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        gwshan@linux.vnet.ibm.com, majd@mellanox.com
Subject: Re: [PATCH 0/4] Cover letter
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1479046901-25360-1-git-send-email-noaos@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479046901-25360-1-git-send-email-noaos@mellanox.com>
Message-Id: <20161113232401.GA12678@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 13, 2016 at 04:21:38PM +0200, Noa Osherovich wrote:
>The following 3 patches unmark some Mellanox devices as having broken
>INTx masking.
>
>The first patch moves all broken INTx masking to FINAL instead of
>HEADER so that the fixup can execute on all archs.
>The second fixup changes the Mellanox marking to be according to a
>list of devices rather than a general fixup by vendor.
>The third patch excludes some Mellanox devices from the INTx broken
>marking according to device ID / firmware version.
>

Noa, some of your script might be broken. As the subject, which is
"[PATCH 0/4] Cover letter", there are 4 patches in total. However,
I just saw 3 patches.

Thanks,
Gavin

>Noa Osherovich (3):
>  PCI: Use FINAL fixup to mark broken INTx masking
>  PCI: Convert Mellanox quirks to be for listed devices only
>  PCI: Add checks to mellanox_check_broken_intx_masking
>
> drivers/pci/quirks.c | 172 ++++++++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 136 insertions(+), 36 deletions(-)
>
>-- 
>1.8.3.1
>

