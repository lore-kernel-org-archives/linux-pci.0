Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1927C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 22:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3352082C
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 22:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="pfIZ7H9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfAXWwG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:52:06 -0500
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:47274 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbfAXWwG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 17:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1548370315; x=1579906315;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fhoJ8MBNDocot3n5QwZfkiUNdvCiZyMHCtX8ofaEDR8=;
  b=pfIZ7H9Sinwe/YKERW1uxGQ5128B8x1E0ELw4yL32P5LEcNaSG32NVFn
   oXAE7wCaDrC1XNmemMA3uxGReGUcEzwOs/TIw2ZzMJfEy6nMytOfzHyQu
   omovMpnebCJjz35y4upPJ0dyVoV69CyAUTbCmSKkq66m/npFxFhRtHg8M
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EnAAA0QEpchyWd50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUwUBAQsBgVqCExUcjHCLFIINgX6WCYF7CwEBgXeCdYMGIjYHDQEDAQE?=
 =?us-ascii?q?CAQECAQECEAEBAQoLCQgpL4I6IoJvAQEBAQIBEig/BQsCAQgYHhBXAgQBDQ0?=
 =?us-ascii?q?agjVLgXoIoDQ9AoFuiQcBAQGCHoowjEGCFoN1LoQ7RoVgAqItBwKSHiCSH4o?=
 =?us-ascii?q?MkQQCBAIEBQIUgU0MgXxwgz2CNIEJAQIHjRRAAYkhgR+BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2EnAAA0QEpchyWd50NkHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VqCExUcjHCLFIINgX6WCYF7CwEBgXeCdYMGIjYHDQEDAQECAQECAQECEAEBA?=
 =?us-ascii?q?QoLCQgpL4I6IoJvAQEBAQIBEig/BQsCAQgYHhBXAgQBDQ0agjVLgXoIoDQ9A?=
 =?us-ascii?q?oFuiQcBAQGCHoowjEGCFoN1LoQ7RoVgAqItBwKSHiCSH4oMkQQCBAIEBQIUg?=
 =?us-ascii?q?U0MgXxwgz2CNIEJAQIHjRRAAYkhgR+BHwEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jan 2019 16:51:55 -0600
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OMmLvk029907
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2019 17:52:04 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2q7nvy0683-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2019 17:52:04 -0500
From:   <Austin.Bolen@dell.com>
To:     <Austin.Bolen@dell.com>, <lukas@wunner.de>, <keith.busch@intel.com>
Received: from ausxipps310.us.dell.com ([143.166.148.211])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Jan 2019 04:52:02 +0600
X-LoopCount0: from 10.166.134.82
X-IronPort-AV: E=Sophos;i="5.56,518,1539666000"; 
   d="scan'208";a="310525674"
CC:     <Alex_Gagniuc@Dellteam.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Topic: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Index: AQHUs0hi5mR8YZ0nPk+DZaS87pNxDw==
Date:   Thu, 24 Jan 2019 22:52:01 +0000
Message-ID: <0a833dec6028485cbceaf7e7743588ce@AUSX13MPC131.AMER.DELL.COM>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123184453.GB6629@localhost.localdomain>
 <20190123190204.csjedbvcxkjlr43d@wunner.de>
 <016c526ec63240c799ac03bef7a20e74@AUSX13MPC131.AMER.DELL.COM>
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
 mlxlogscore=889 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240155
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/24/2019 4:43 PM, Bolen, Austin wrote:=0A=
> On 1/23/2019 1:02 PM, Lukas Wunner wrote:=0A=
>>=0A=
> =0A=
> <snip>=0A=
> =0A=
>>=0A=
>> Well, usually it's desirable to bring up the slot as quickly as possible=
,=0A=
>> so once we get any kind of link or presence event, we immediately try to=
=0A=
>> bring up the slot.=0A=
>>=0A=
>> We do allow a 20 + 100 ms delay in pcie_wait_for_link() between link up=
=0A=
>> and presence detect up, just not 400 ms.=0A=
> =0A=
> Is the hot-inserted device's config space accessed immediately after=0A=
> waiting this 20 + 100 ms delay?  Per PCIe spec, in Gen 3 mode, software=
=0A=
> should wait at least (1s - CTO value) after Data Link Layer Link Active=
=0A=
> before accessing config space. The exception is if OS enables CRS=0A=
> Software Visibility in which case config space can be accessed 100 ms=0A=
> after Data Link Layer Link Active.  Is CRS Software Visibility being used=
?=0A=
> =0A=
=0A=
I forgot... Readiness Notifications can also let software bypass these =0A=
first access times but I've not seen anybody implement RN so assume it =0A=
is not being used here.=0A=
=0A=
> Cheers,=0A=
> Austin=0A=
> =0A=
>>=0A=
>> Thanks,=0A=
>>=0A=
>> Lukas=0A=
>>=0A=
> =0A=
> =0A=
=0A=
