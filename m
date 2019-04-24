Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10721C10F03
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 01:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BE6218FC
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 01:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfDXBQE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:16:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726840AbfDXBQD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 21:16:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O1EKfE004680
        for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2019 21:16:02 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s2c3w418d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2019 21:16:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Wed, 24 Apr 2019 02:15:59 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 02:15:54 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3O1FrB057344044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 01:15:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8538EA4040;
        Wed, 24 Apr 2019 01:15:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE7D3A4051;
        Wed, 24 Apr 2019 01:15:52 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 01:15:52 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A183BA01DB;
        Wed, 24 Apr 2019 11:15:51 +1000 (AEST)
Subject: Re: [PATCH v2 26/79] docs: powerpc: convert docs to ReST and rename
 to *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <dbbfc37a221aa1a1320bdfbb34f593d8a76f643d.1555938376.git.mchehab+samsung@kernel.org>
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date:   Wed, 24 Apr 2019 11:15:45 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dbbfc37a221aa1a1320bdfbb34f593d8a76f643d.1555938376.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042401-0012-0000-0000-00000312805C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042401-0013-0000-0000-0000214AD363
Message-Id: <5114a435-030a-8c2c-885d-f5e053f9749b@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240009
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/4/19 11:27 pm, Mauro Carvalho Chehab wrote:
> Convert docs to ReST and add them to the arch-specific
> book.
> 
> The conversion here was trivial, as almost every file there
> was already using an elegant format close to ReST standard.
> 
> The changes were mostly to mark literal blocks and add a few
> missing section title identifiers.
> 
> One note with regards to "--": on Sphinx, this can't be used
> to identify a list, as it will format it badly. This can be
> used, however, to identify a long hyphen - and "---" is an
> even longer one.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>  # cxl

Minor possible improvement below, otherwise compiled output looks very nice.

> diff --git a/Documentation/powerpc/cxl.txt b/Documentation/powerpc/cxl.rst
> similarity index 95%
> rename from Documentation/powerpc/cxl.txt
> rename to Documentation/powerpc/cxl.rst
> index c5e8d5098ed3..99e704afb09d 100644
> --- a/Documentation/powerpc/cxl.txt
> +++ b/Documentation/powerpc/cxl.rst
> @@ -1,3 +1,4 @@
> +====================================
>   Coherent Accelerator Interface (CXL)
>   ====================================
>   
> @@ -21,6 +22,8 @@ Introduction
>   Hardware overview
>   =================
>   
> +    ::
> +
>            POWER8/9             FPGA
>          +----------+        +---------+
>          |          |        |         |
> @@ -59,14 +62,16 @@ Hardware overview
>       the fault. The context to which this fault is serviced is based on
>       who owns that acceleration function.
>   
> -    POWER8 <-----> PSL Version 8 is compliant to the CAIA Version 1.0.
> -    POWER9 <-----> PSL Version 9 is compliant to the CAIA Version 2.0.
> +    - POWER8 <------> PSL Version 8 is compliant to the CAIA Version 1.0.
> +    - POWER9 <------> PSL Version 9 is compliant to the CAIA Version 2.0.
> +

This could probably be changed to "POWER8 and PSL Version 8 are 
compliant" or something like that to avoid the ASCII art arrows turning 
into dashes. Happy to pick this up myself if I ever get around to 
revising the rest of the documentation.


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

