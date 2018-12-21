Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E2EC43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 14:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C208021924
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 14:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390808AbeLUOT7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:19:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389008AbeLUOT7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 09:19:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBLEJ63I115245
        for <linux-pci@vger.kernel.org>; Fri, 21 Dec 2018 09:19:57 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pgxj3sg1s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Fri, 21 Dec 2018 09:19:57 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <sebott@linux.ibm.com>;
        Fri, 21 Dec 2018 14:19:55 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Dec 2018 14:19:53 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBLEJqj34588022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Dec 2018 14:19:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37F19A4059;
        Fri, 21 Dec 2018 14:19:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A63BA4057;
        Fri, 21 Dec 2018 14:19:51 +0000 (GMT)
Received: from sig-9-145-42-38.uk.ibm.com (unknown [9.145.42.38])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Dec 2018 14:19:50 +0000 (GMT)
Date:   Fri, 21 Dec 2018 15:19:49 +0100 (CET)
From:   Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] PCI/IOV: provide flag to skip VF scanning
In-Reply-To: <20181220200750.GF183878@google.com>
References: <20181217173546.GA4106@infradead.org> <20181218101650.23089-1-sebott@linux.ibm.com> <20181220200750.GF183878@google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Matthias?=
 =?ISO-8859-15?Q?_Hartmann_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18122114-0020-0000-0000-000002FAD885
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122114-0021-0000-0000-0000214AEFEB
Message-Id: <alpine.LFD.2.21.1812211514570.22598@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=791 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812210113
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

On Thu, 20 Dec 2018, Bjorn Helgaas wrote:
> I think the strategy is fine, but can you restructure the patches
> like this:
> 
>   1) Factor out sriov_add_vfs() and sriov_dev_vfs().  This makes no
>      functional change at all.
> 
>   2) Add dev->no_vf_scan, set it in the s390 pcibios_add_device(), and
>      test it in sriov_add_vfs(), and sriov_del_vfs().
> 
> I think both pieces will be easier to review that way.

Done. I took the liberty to add Christoph's R-b to the first two patches
since it's just a split of the patch he gave the R-b to.

Thanks!
Sebastian

