Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C738C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 18:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0F220836
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 18:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="0YKFq0AV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfBUSFb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:05:31 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:3859 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbfBUSF3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 13:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1550772316; x=1582308316;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gbrTQ7C0FpnadYKKaqwwZcvmqu3BZ8ow4NIgZIaKeIk=;
  b=0YKFq0AV7yLhY0hgl/oejJMvt4wQC63iI0Z5pofU30Ika8x4VftrnzIJ
   PRV8r2rd3j/9roWbc6kLdzzQML+Bx3Xv/zUBn5wdXicuOL06wBxP2yKEi
   FBUDQaG1qNsMGKz8pRGuX0pevVf5fPrJe/wFZCE0+LMPJEjKTu2RRP79C
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EJAAAj6G5chieV50NkGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUgUBAQELAYJZgRQxjHaNA5geFIFnCwEBLIRAg30iNQgNAQMBAQI?=
 =?us-ascii?q?BAQIBAQIQAQEBCgkLCCkvgjoigm8BAQEBAgESFRM/BQsCAQgYHhBXAgQBGhq?=
 =?us-ascii?q?CfoFrCKBEPQJtgQGJBwEBAYFrM4otjEiCFoQjhE4BEgEfhWACjA6XRQkFklE?=
 =?us-ascii?q?hkwuKSZIHAgQCBAUCFIFJAYEbcXCDPYI1jidBgVmMJYEfAYEeAQE?=
X-IPAS-Result: =?us-ascii?q?A2EJAAAj6G5chieV50NkGwEBAQEDAQEBBwMBAQGBUgUBA?=
 =?us-ascii?q?QELAYJZgRQxjHaNA5geFIFnCwEBLIRAg30iNQgNAQMBAQIBAQIBAQIQAQEBC?=
 =?us-ascii?q?gkLCCkvgjoigm8BAQEBAgESFRM/BQsCAQgYHhBXAgQBGhqCfoFrCKBEPQJtg?=
 =?us-ascii?q?QGJBwEBAYFrM4otjEiCFoQjhE4BEgEfhWACjA6XRQkFklEhkwuKSZIHAgQCB?=
 =?us-ascii?q?AUCFIFJAYEbcXCDPYI1jidBgVmMJYEfAYEeAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2019 12:05:13 -0600
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LHrkdB029909;
        Thu, 21 Feb 2019 13:05:25 -0500
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0a-00154901.pphosted.com with ESMTP id 2qsyugrd8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 13:05:25 -0500
Cc:     <bhelgaas@google.com>, <Austin.Bolen@dell.com>,
        <keith.busch@intel.com>, <Shyam.Iyer@dell.com>, <okaya@kernel.org>,
        <linux-pci@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
        <andy.shevchenko@gmail.com>, <mika.westerberg@linux.intel.com>,
        <poza@codeaurora.org>, <linux-kernel@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Feb 2019 00:05:19 +0600
X-LoopCount0: from 10.166.134.89
X-IronPort-AV: E=Sophos;i="5.58,396,1544508000"; 
   d="scan'208";a="1364793122"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH RFC v2 1/4] PCI: hotplug: Add support for disabling
 in-band presence
Thread-Topic: [PATCH RFC v2 1/4] PCI: hotplug: Add support for disabling
 in-band presence
Thread-Index: AQHUyLqYrzwot6C9Ik6lskQh1EhBRQ==
Date:   Thu, 21 Feb 2019 18:05:22 +0000
Message-ID: <842e01310e894fd695b213652efdede7@ausx13mps321.AMER.DELL.COM>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
 <20190220012031.10741-2-mr.nuke.me@gmail.com>
 <20190221071946.poqwdilfijpafhvb@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=617 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210127
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/21/19 1:20 AM, Lukas Wunner wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Tue, Feb 19, 2019 at 07:20:27PM -0600, Alexandru Gagniuc wrote:=0A=
>> @@ -846,6 +846,9 @@ struct controller *pcie_init(struct pcie_device *dev=
)=0A=
>>   	if (pdev->is_thunderbolt)=0A=
>>   		slot_cap |=3D PCI_EXP_SLTCAP_NCCS;=0A=
>>   =0A=
>> +	if (pdev->no_in_band_presence)=0A=
>> +		ctrl->inband_presence_disabled =3D 1;=0A=
>> +=0A=
>>   	ctrl->slot_cap =3D slot_cap;=0A=
>>   	mutex_init(&ctrl->ctrl_lock);=0A=
>>   	mutex_init(&ctrl->state_lock);=0A=
> =0A=
> The above hunk belongs in patch 4.=0A=
> =0A=
> =0A=
>> --- a/include/linux/pci.h=0A=
>> +++ b/include/linux/pci.h=0A=
>> @@ -413,6 +413,7 @@ struct pci_dev {=0A=
>>   	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */=0A=
>>   	unsigned int	is_probed:1;		/* Device probing in progress */=0A=
>>   	unsigned int	link_active_reporting:1;/* Device capable of reporting l=
ink active */=0A=
>> +	unsigned int	no_in_band_presence:1;	/* Device does not report in-band =
presence */=0A=
>>   	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablemen=
t */=0A=
>>   	pci_dev_flags_t dev_flags;=0A=
>>   	atomic_t	enable_cnt;	/* pci_enable_device has been called */=0A=
> =0A=
> Same here.=0A=
=0A=
:)=0A=
=0A=
> Thanks,=0A=
> =0A=
> Lukas=0A=
> =0A=
=0A=
