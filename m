Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC70BC43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 19:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B794B213A2
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 19:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="ZluQfg3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B794B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeK3GH2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:07:28 -0500
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:23315 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbeK3GH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Nov 2018 01:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1543518060; x=1575054060;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=P+Nzt6x41Rg4ijcLtew8mPGRDWbz2rkReTVGzosRE5Y=;
  b=ZluQfg3wWTO25bHK7OjMuRGXkHNSW1Fu7M4HDajKpGCynGdwIeIaKBOm
   1nMqNQTphCr5BbWdyaFNj6Wou2AyWfr+Tc2JF1Ff4W6u7qLQlOawpywbn
   UwKLl4xyGQjgbq6Ol1lVINxVVhFdfPFiAhJ7OOkp8B+y6KbSbZ8CV113q
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EcAAD5NgBchyeV50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUgYBAQsBg2sxjGaLKYINgX2VRxSBZgsBAYRsgzUiNQgNAQMBAQIBAQI?=
 =?us-ascii?q?BAQIQAQEBCgsJCCkvgjYigmUBAQEBAgESFRM9AhACAQgYHhBXAgQBGhqCf4F?=
 =?us-ascii?q?6CJttPQKBEIlYAQEBgWozijCMFoIWg3UugSaDQxiFWwKLGZUKCQWKJoZ/IJE?=
 =?us-ascii?q?ciHiPLwIEAgQFAhSBSAOCCXCDPYImDgmOHUABjViBHwEB?=
X-IPAS-Result: =?us-ascii?q?A2EcAAD5NgBchyeV50NkHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?2sxjGaLKYINgX2VRxSBZgsBAYRsgzUiNQgNAQMBAQIBAQIBAQIQAQEBCgsJC?=
 =?us-ascii?q?CkvgjYigmUBAQEBAgESFRM9AhACAQgYHhBXAgQBGhqCf4F6CJttPQKBEIlYA?=
 =?us-ascii?q?QEBgWozijCMFoIWg3UugSaDQxiFWwKLGZUKCQWKJoZ/IJEciHiPLwIEAgQFA?=
 =?us-ascii?q?hSBSAOCCXCDPYImDgmOHUABjViBHwEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2018 13:00:59 -0600
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wATIwxai170187;
        Thu, 29 Nov 2018 14:01:03 -0500
Received: from esa6.dell-outbound2.iphmx.com (esa6.dell-outbound2.iphmx.com [68.232.154.99])
        by mx0a-00154901.pphosted.com with ESMTP id 2p2gf5j72f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 14:01:02 -0500
Cc:     <bhelgaas@google.com>, <Austin.Bolen@dell.com>,
        <keith.busch@intel.com>, <Shyam.Iyer@dell.com>, <lukas@wunner.de>,
        <okaya@codeaurora.org>, <rafael.j.wysocki@intel.com>,
        <poza@codeaurora.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Nov 2018 01:01:01 +0600
X-LoopCount0: from 10.166.134.85
X-IronPort-AV: E=Sophos;i="5.56,295,1539666000"; 
   d="scan'208";a="244748106"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <mika.westerberg@linux.intel.com>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Report degraded links via link bandwidth
 notification
Thread-Topic: [PATCH] PCI: pciehp: Report degraded links via link bandwidth
 notification
Thread-Index: AQHUh3extvl0RTSvTEW+XZDJcp0hUQ==
Date:   Thu, 29 Nov 2018 19:00:58 +0000
Message-ID: <9f76adf7315842cb82375eeaad0a0563@ausx13mps321.AMER.DELL.COM>
References: <20181129000829.14751-1-mr.nuke.me@gmail.com>
 <20181129160625.GC3078@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.193]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290156
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/29/2018 10:06 AM, Mika Westerberg wrote:=0A=
>> @@ -515,7 +515,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)=
=0A=
>>   	struct controller *ctrl =3D (struct controller *)dev_id;=0A=
>>   	struct pci_dev *pdev =3D ctrl_dev(ctrl);=0A=
>>   	struct device *parent =3D pdev->dev.parent;=0A=
>> -	u16 status, events;=0A=
>> +	struct pci_dev *endpoint;=0A=
>> +	u16 status, events, link_status;=0A=
> =0A=
> Looks better if you write them in opposite order (reverse xmas-tree):=0A=
> =0A=
> 	u16 status, events, link_status;=0A=
> 	struct pci_dev *endpoint;=0A=
> =0A=
=0A=
I don't decorate in November :p=0A=
=0A=
>> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status);=0A=
>> +=0A=
> =0A=
> Unnecessary empty line.=0A=
=0A=
However Bjorn wants it, though I don't like the crowded look with this =0A=
line removed.=0A=
=0A=
>> +	if (link_status & PCI_EXP_LNKSTA_LBMS) {=0A=
>> +		if (pdev->subordinate && pdev->subordinate->self)=0A=
>> +			endpoint =3D pdev->subordinate->self;=0A=
> =0A=
> Hmm, I thought pdev->subordinate->self =3D=3D pdev, no?=0A=
=0A=
That makes no sense, but I think you're right. I'm trying to get to the =0A=
other end of the PCIe link. Is there a simple way to do that? (other =0A=
than convoluted logic that all leads to the same mistake)=0A=
=0A=
>>   static void pcie_enable_notification(struct controller *ctrl)=0A=
>>   {=0A=
>>   	u16 cmd, mask;=0A=
>> @@ -713,6 +743,9 @@ static void pcie_enable_notification(struct controll=
er *ctrl)=0A=
>>   	pcie_write_cmd_nowait(ctrl, cmd, mask);=0A=
>>   	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,=0A=
>>   		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);=0A=
>> +=0A=
>> +	if (pcie_link_bandwidth_notification_supported(ctrl))=0A=
>> +		pcie_enable_link_bandwidth_notification(ctrl);=0A=
> =0A=
> Do we ever need to disable it?=0A=
=0A=
I can't think of a case where that would be needed.=0A=
=0A=
Alex=0A=
