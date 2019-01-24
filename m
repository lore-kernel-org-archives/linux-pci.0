Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A76CC282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 22:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07001218D2
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 22:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="Xz59DJmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfAXWnc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:43:32 -0500
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:3253 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbfAXWnc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 17:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1548369811; x=1579905811;
  h=from:cc:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ulg60Uz+POhTWuRhZxG6Gu3/4t/5UFTog6ehKzEyWuU=;
  b=Xz59DJmJ1m9OatzUHjWDsLnpzBuzf+Y5kA7F2uqOf7e2hn4UxScvWCBm
   hdykYfoq/THh0wF6k0PTrtMam+lWzLehbxXEkerGD/HUj9jkCXu9ABfjV
   RiUJ8bP6nyaFXh5xfnsH/MS61KHxdx8VQecXCHgZ3ishqLOiwTvbZzZVJ
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EnAAD3PkpchyWd50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUwUBAQsBgVqCEzGMcIsUgg2BfpYJgXsLAQGBd4J1gwYiNgcNAQMBAQI?=
 =?us-ascii?q?BAQIBAQIQAQEBCgsJCCkvgjoigm8BAQEBAgESKD8QAgEIGB4QVwIEARoagjV?=
 =?us-ascii?q?LgXoIoEg9AoFuiQcBAQGCHoowjEGCFoN1LoQ7RoVgAqItBwKSHiCSH4oMkQQ?=
 =?us-ascii?q?CBAIEBQIUgU0EggRwgz2CNIEJAQIHjRRAAYkhgR+BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2EnAAD3PkpchyWd50NkHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VqCEzGMcIsUgg2BfpYJgXsLAQGBd4J1gwYiNgcNAQMBAQIBAQIBAQIQAQEBC?=
 =?us-ascii?q?gsJCCkvgjoigm8BAQEBAgESKD8QAgEIGB4QVwIEARoagjVLgXoIoEg9AoFui?=
 =?us-ascii?q?QcBAQGCHoowjEGCFoN1LoQ7RoVgAqItBwKSHiCSH4oMkQQCBAIEBQIUgU0Eg?=
 =?us-ascii?q?gRwgz2CNIEJAQIHjRRAAYkhgR+BHwEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jan 2019 16:43:30 -0600
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OMgV5b017151
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2019 17:43:30 -0500
Received: from esa6.dell-outbound2.iphmx.com (esa6.dell-outbound2.iphmx.com [68.232.154.99])
        by mx0a-00154901.pphosted.com with ESMTP id 2q3ydgrgn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2019 17:43:29 -0500
From:   <Austin.Bolen@dell.com>
Cc:     <Alex_Gagniuc@Dellteam.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <Austin.Bolen@dell.com>
Received: from ausxippc110.us.dell.com ([143.166.85.200])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Jan 2019 04:43:28 +0600
X-LoopCount0: from 10.166.135.141
X-IronPort-AV: E=Sophos;i="5.56,518,1539666000"; 
   d="scan'208";a="755418154"
To:     <lukas@wunner.de>, <keith.busch@intel.com>
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Topic: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Index: AQHUs0hi5mR8YZ0nPk+DZaS87pNxDw==
Date:   Thu, 24 Jan 2019 22:43:27 +0000
Message-ID: <016c526ec63240c799ac03bef7a20e74@AUSX13MPC131.AMER.DELL.COM>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123184453.GB6629@localhost.localdomain>
 <20190123190204.csjedbvcxkjlr43d@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=768 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240154
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/23/2019 1:02 PM, Lukas Wunner wrote:=0A=
> =0A=
=0A=
<snip>=0A=
=0A=
> =0A=
> Well, usually it's desirable to bring up the slot as quickly as possible,=
=0A=
> so once we get any kind of link or presence event, we immediately try to=
=0A=
> bring up the slot.=0A=
> =0A=
> We do allow a 20 + 100 ms delay in pcie_wait_for_link() between link up=
=0A=
> and presence detect up, just not 400 ms.=0A=
=0A=
Is the hot-inserted device's config space accessed immediately after =0A=
waiting this 20 + 100 ms delay?  Per PCIe spec, in Gen 3 mode, software =0A=
should wait at least (1s - CTO value) after Data Link Layer Link Active =0A=
before accessing config space. The exception is if OS enables CRS =0A=
Software Visibility in which case config space can be accessed 100 ms =0A=
after Data Link Layer Link Active.  Is CRS Software Visibility being used?=
=0A=
=0A=
Cheers,=0A=
Austin=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Lukas=0A=
> =0A=
=0A=
