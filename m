Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B611C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 18:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B08120835
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 18:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="w6avBZiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfBMSzv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:55:51 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:10295 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbfBMSzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2019 13:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1550084142; x=1581620142;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oEoh43nRADGmAp/RzU36FMbey/Ilw0wJ5l7YR+zZmbs=;
  b=w6avBZiYo4n+e/zZbLOSCnUjmdl3EaXY4tQHZu3Y+bxJphjWgDHZfDc+
   gTUDuIsftI5CFOLJIyKcvMlF2DfA5FskYe6zDomWvZXQYKM47WeYNA6y0
   4cQadTXAJvCMly40L/lZjewFmmea7cNkvLuqN5/yfD4mro8EeIJyWLoBT
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EKAABGZ2RchyeV50NjGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUgUBAQELAYFaf4EUMYx0ixSCDZgTFIFnCwEBLIFLgnWDXCI1CA0?=
 =?us-ascii?q?BAwEBAgEBAgEBAhABAQEKCwkIKS+COiKCbwEBAQMBEig/BQsCAQgYHhBXAgQ?=
 =?us-ascii?q?bFAaCN0uBegieMj0CbYEBiQcBAQGCHoovjESCFoN1LoRqF02FEwKMBZciCQW?=
 =?us-ascii?q?SRiGSb5wdAgQCBAUCFIFHAYINcIM9gjWBCQEJjRRBgVmNMQGBHgEB?=
X-IPAS-Result: =?us-ascii?q?A2EKAABGZ2RchyeV50NjGwEBAQEDAQEBBwMBAQGBUgUBA?=
 =?us-ascii?q?QELAYFaf4EUMYx0ixSCDZgTFIFnCwEBLIFLgnWDXCI1CA0BAwEBAgEBAgEBA?=
 =?us-ascii?q?hABAQEKCwkIKS+COiKCbwEBAQMBEig/BQsCAQgYHhBXAgQbFAaCN0uBegieM?=
 =?us-ascii?q?j0CbYEBiQcBAQGCHoovjESCFoN1LoRqF02FEwKMBZciCQWSRiGSb5wdAgQCB?=
 =?us-ascii?q?AUCFIFHAYINcIM9gjWBCQEJjRRBgVmNMQGBHgEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Feb 2019 12:55:42 -0600
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DIrVq1100854;
        Wed, 13 Feb 2019 13:55:49 -0500
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0a-00154901.pphosted.com with ESMTP id 2qmmwp9qyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 13:55:49 -0500
Cc:     <mr.nuke.me@gmail.com>, <bhelgaas@google.com>,
        <Austin.Bolen@dell.com>, <keith.busch@intel.com>,
        <Shyam.Iyer@dell.com>, <gustavo@embeddedor.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2019 00:55:43 +0600
X-LoopCount0: from 10.166.134.85
X-IronPort-AV: E=Sophos;i="5.58,366,1544508000"; 
   d="scan'208";a="272207396"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>
Subject: Re: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Thread-Topic: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Thread-Index: AQHUvZbN4kEiyNA8xUGy+Uw4G87SXw==
Date:   Wed, 13 Feb 2019 18:55:46 +0000
Message-ID: <205e0fd9995a4f2b80ab370a974b6628@ausx13mps321.AMER.DELL.COM>
References: <20190205210701.25387-1-mr.nuke.me@gmail.com>
 <20190209115849.244u67h7wmn3eb7o@wunner.de>
 <52afa1c45f684dbda6a8771b65583a22@ausx13mps321.AMER.DELL.COM>
 <20190212083031.2no7mzn5xug7nba3@wunner.de>
 <b2fffa5beb7941ebaceb8b8ce6e5b133@ausx13mps321.AMER.DELL.COM>
 <20190213083632.GA3387@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130130
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/13/19 2:36 AM, Lukas Wunner wrote:=0A=
>> (*) A bit hypothetical: There is no hardware yet implementing the ECN.=
=0A=
> =0A=
> Hm, this contradicts Austin Bolen's e-mail of Jan 25 that "Yes, this=0A=
> platform disables in-band presence" (when asked whether your host=0A=
> controller already adheres to the ECN).=0A=
=0A=
Both statements are true. The hardware does indeed disable in-band =0A=
presence, in a rudimentary way that is not compliant with the ECN -- it =0A=
doesn't implement the bits required by the ECN.=0A=
=0A=
=0A=
>> I'm=0A=
>> not sure that there is a spec-justifiable reason to not access a device=
=0A=
>> whose DLL is up, but PD isn't.=0A=
> =0A=
> Austin asked in an e-mail of Jan 24 whether "the hot-inserted device's=0A=
> config space [is] accessed immediately after waiting this 20 + 100 ms=0A=
> delay", which sounded to me like you'd prefer the device not to be=0A=
> accessed until PDS is 1.=0A=
=0A=
"Unless Readiness Notifications mechanisms are used (see Section 6.23), =0A=
the Root Complex and/or system software must allow at least 1.0 s after =0A=
a Conventional Reset of a device, before it may determine that a device =0A=
which fails to return a Successful Completion status for a valid =0A=
Configuration Request is a broken device. This period is independent of =0A=
how quickly Link training completes."=0A=
	(Section 6.6)=0A=
=0A=
The concern was the one second delay, which is addressed by the use of =0A=
pci_bus_wait_crs().=0A=
=0A=
>>> Be mindful however that pcie_wait_for_link() is also called from the=0A=
>>> DPC driver.  Keith should be able to judge whether a change to that=0A=
>>> function breaks DPC.=0A=
>>=0A=
>> That's why I went for ammending pciehp_handle_presence_or_link_change().=
=0A=
>> Smaller bug surface ;). What I'm thinking at this point is, keep the=0A=
>> patch as is, but, also check for in-band PD disable before aborting the=
=0A=
>> shutdown. Old behavior stays the same.=0A=
> =0A=
> I'm worried that amending pciehp_handle_presence_or_link_change() makes=
=0A=
> the event handling logic more difficult to understand.=0A=
=0A=
Don't worry. It's already difficult to understand ;)=0A=
=0A=
>  Polling PDS in=0A=
> pcie_wait_for_link() or disabling either PDC or DLLSC if in-band presence=
=0A=
> is disabled seems simpler to reason about.=0A=
=0A=
pcie_wait_for_link() is generic PCIe layer. I don't think mixing hotplug =
=0A=
concepts is a good layering violation.=0A=
=0A=
Disabling PDC or DLLSC can work. I've sometimes wondered why we even =0A=
care about PDC. I can imagine situations where platform might want to =0A=
signal imminent removal by yanking PD.=0A=
=0A=
>> in-band PD disable (what's a good acronym for that, BTW?)=0A=
> =0A=
> I don't know, maybe inband_presence_disabled?=0A=
=0A=
PCI_EXP_SLTCAP2_IBPD ?=0A=
