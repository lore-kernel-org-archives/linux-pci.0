Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C1C282CE
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 11:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54521217D4
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 11:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDKLdd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:33:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbfDKLdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 07:33:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BBUWfY066587
        for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2019 07:33:31 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rt44n29x2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2019 07:33:31 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 11 Apr 2019 12:33:30 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 12:33:28 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3BBXRfs25428214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 11:33:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACFDDB2064;
        Thu, 11 Apr 2019 11:33:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CEDEB205F;
        Thu, 11 Apr 2019 11:33:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.233.240])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 11:33:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0BD2A16C2940; Thu, 11 Apr 2019 04:33:28 -0700 (PDT)
Date:   Thu, 11 Apr 2019 04:33:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update remaining @linux.vnet.ibm.com
 addresses
Reply-To: paulmck@linux.ibm.com
References: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041111-2213-0000-0000-00000374F133
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010908; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187508; UDB=6.00622031; IPR=6.00968271;
 MB=3.00026392; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 11:33:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041111-2214-0000-0000-00005DFBC336
Message-Id: <20190411113328.GV14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110081
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 11, 2019 at 06:27:52AM +0200, Lukas Bulwahn wrote:
> Paul McKenney attempted to update all email addresses @linux.vnet.ibm.com
> to @linux.ibm.com in commit 1dfddcdb95c4
> ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com"), but
> some still remained.
> 
> We update the remaining email addresses in MAINTAINERS, hopefully finally
> catching all cases for good.
> 
> Fixes: 1dfddcdb95c4 ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

For whatever it is worth:

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
> 
> Tyrel, please take this patch. Thanks.
> 
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2359e12e4c41..454b3cf36aa4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7439,14 +7439,14 @@ F:	drivers/crypto/vmx/ghash*
>  F:	drivers/crypto/vmx/ppc-xlate.pl
>  
>  IBM Power PCI Hotplug Driver for RPA-compliant PPC64 platform
> -M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> +M:	Tyrel Datwyler <tyreld@linux.ibm.com>
>  L:	linux-pci@vger.kernel.org
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
>  F:	drivers/pci/hotplug/rpaphp*
>  
>  IBM Power IO DLPAR Driver for RPA-compliant PPC64 platform
> -M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> +M:	Tyrel Datwyler <tyreld@linux.ibm.com>
>  L:	linux-pci@vger.kernel.org
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> @@ -10388,7 +10388,7 @@ F:	arch/arm/mach-mmp/
>  
>  MMU GATHER AND TLB INVALIDATION
>  M:	Will Deacon <will.deacon@arm.com>
> -M:	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> +M:	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Nick Piggin <npiggin@gmail.com>
>  M:	Peter Zijlstra <peterz@infradead.org>
> -- 
> 2.17.1
> 

