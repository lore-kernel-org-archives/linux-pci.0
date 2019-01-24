Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43FBC282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 12:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838892184B
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 12:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0T6eS9v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfAXMaL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:30:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42184 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfAXMaK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 07:30:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0OCT5a9115839;
        Thu, 24 Jan 2019 12:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hTQDulfmjd7+MSutxcuI8Pgtaoy2isZdHjbeCOBZ7q4=;
 b=0T6eS9v/vAnon1MWSFMdM55u/NTbOtps/WtpQEgsP6q83QQ4+c56dkucJpiKbotjZOID
 Mv7G1XBTOhJpIawf8aGyK/t4LRflXApnQeL1lkxXES7O/Y34jfiNY0aTQg8romjZpbgt
 x7EFH8vWeAffDWHh6w+NV6LRwN+H8XpvLTd/l/HRGHWmNEiOK0nGAZCXQdv0pjUd9k9i
 tKYhzwGdxmznRpG9Lnx1+Y2F/AYi2TMVyaj//AyhCTR4DrblnujmUUDHSZRzqusyfrVF
 gqvTWa5TPiFWV9q8uBb4+PWB/A34jXw2N1xmNyISBQO78JbTt6oygBEzbWXR/Amji9+8 vA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2q3vhrydj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 12:29:52 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0OCTp14023485
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 12:29:52 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0OCTodn029526;
        Thu, 24 Jan 2019 12:29:50 GMT
Received: from kadam (/197.157.34.164)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Jan 2019 04:29:50 -0800
Date:   Thu, 24 Jan 2019 15:29:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, marcelo.cerri@canonical.com,
        vkuznets@redhat.com, haiyangz@microsoft.com,
        driverdev-devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: hv: Refactor hv_irq_unmask() to use
 cpumask_to_vpset()
Message-ID: <20190124122918.GL4482@kadam>
References: <cover.1548232616.git.m.maya.nakamura@gmail.com>
 <885d207cd90a558364d611e4ebd64a87aa8962d7.1548232616.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <885d207cd90a558364d611e4ebd64a87aa8962d7.1548232616.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=965
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901240091
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 01:02:12PM -0800, Maya Nakamura wrote:
> @@ -908,12 +906,12 @@ static void hv_irq_unmask(struct irq_data *data)
>  	struct retarget_msi_interrupt *params;
>  	struct hv_pcibus_device *hbus;
>  	struct cpumask *dest;
> +	cpumask_var_t tmp;
>  	struct pci_bus *pbus;
>  	struct pci_dev *pdev;
>  	unsigned long flags;
>  	u32 var_size = 0;
> -	int cpu_vmbus;
> -	int cpu;
> +	int cpu, nr_bank = 0;
                        ^^^^^
No need to initialize this to a bogus value.  It's misleading and it
turns off GCC's uninitialized variable warning so it can lead to bugs.

>  	u64 res;
>  
>  	dest = irq_data_get_effective_affinity_mask(data);
> @@ -953,29 +951,28 @@ static void hv_irq_unmask(struct irq_data *data)
>  		 */
>  		params->int_target.flags |=
>  			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> -		params->int_target.vp_set.valid_bank_mask =
> -			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
> +
> +		if (!alloc_cpumask_var(&tmp, GFP_KERNEL)) {
> +			dev_err(&hbus->hdev->device, "out of memory");


No need for this error message.  alloc_cpumask_var() already has better
debug messages built in.

> +			return;

We can't return directly.  We need to unlock first.

> +		}
> +
> +		cpumask_and(tmp, dest, cpu_online_mask);
> +		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
> +		free_cpumask_var(tmp);
> +
> +		if (!nr_bank) {
> +			dev_err(&hbus->hdev->device, "too high CPU");

This error message is not useful.

> +			res = 1;
> +			goto exit_unlock;
> +		}

regards,
dan carpenter

