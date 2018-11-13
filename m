Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5886C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 22:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F91921780
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 22:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="K5WFWD4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F91921780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeKNIjo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:39:44 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:57725 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbeKNIjn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Nov 2018 03:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1542148752; x=1573684752;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=W2DbNLLksvmskUQ/VWUeRlO6OW8oqCIt+M5GxO18dMs=;
  b=K5WFWD4OvwjrA055DJaF+cgaJAhUY996q0JfnXO8Rz779ZGXqOCCUdz5
   iGZ/YTegxKI2E+bKtldav1jAvrbDGg3FtfXIXpr2SPdBQsxZBWFgB55fj
   i4OVJQys7AzByzZUg7+OxAsFOtv+0DnuiObHkT+NroiuKwWJhkfe9EFbw
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EbAADjUOtbhyeV50NjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUgYBAQsBgmmBAicKjGWNK5c1FIFmCwEBJQmEPoM/IjUMDQEDAQECAQE?=
 =?us-ascii?q?CAQECEAEBAQoLCQgpIwyCNiISS2sBAQEBAQEjAg1jAQEBAQIBEig/BQsCAQg?=
 =?us-ascii?q?YHhBXAgQTCBqCfwGBeQgPnS4CgRCJWAEBAYIdhC0BhXYFjAKCFoERgxKESwE?=
 =?us-ascii?q?SAQ0SLCGFDgKLAJRWCQWGcoojIIFYhQSKF4J1ih4Vii4CBAIEBQIUgUUBajB?=
 =?us-ascii?q?xcIM8E4IiG4hMhT5AATEBAQEBizeBH4EfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EbAADjUOtbhyeV50NjHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?mmBAicKjGWNK5c1FIFmCwEBJQmEPoM/IjUMDQEDAQECAQECAQECEAEBAQoLC?=
 =?us-ascii?q?QgpIwyCNiISS2sBAQEBAQEjAg1jAQEBAQIBEig/BQsCAQgYHhBXAgQTCBqCf?=
 =?us-ascii?q?wGBeQgPnS4CgRCJWAEBAYIdhC0BhXYFjAKCFoERgxKESwESAQ0SLCGFDgKLA?=
 =?us-ascii?q?JRWCQWGcoojIIFYhQSKF4J1ih4Vii4CBAIEBQIUgUUBajBxcIM8E4IiG4hMh?=
 =?us-ascii?q?T5AATEBAQEBizeBH4EfAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2018 16:39:11 -0600
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wADMY5N3034979;
        Tue, 13 Nov 2018 17:39:25 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0a-00154901.pphosted.com with ESMTP id 2nr7cbg1vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 17:39:24 -0500
Cc:     <oohall@gmail.com>, <gregkh@linuxfoundation.org>,
        <keith.busch@intel.com>, <mr.nuke.me@gmail.com>,
        <linux-pci@vger.kernel.org>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <linux-kernel@vger.kernel.org>,
        <jonathan.derrick@intel.com>, <lukas@wunner.de>,
        <ruscur@russell.cc>, <sbobroff@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Nov 2018 04:39:17 +0600
X-LoopCount0: from 10.166.134.87
X-IronPort-AV: E=Sophos;i="5.56,230,1539666000"; 
   d="scan'208";a="318258073"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUT50UQ290XPGvJEGnaSTTjbCF+g==
Date:   Tue, 13 Nov 2018 22:39:15 +0000
Message-ID: <19136f44cd5c45e79bbef7e78a6bf332@ausx13mps321.AMER.DELL.COM>
References: <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com> <20181108220117.GA11466@kroah.com>
 <20181108223258.GD2932@localhost.localdomain>
 <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
 <20181108225109.GA3023@kroah.com>
 <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
 <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
 <df85813c9860463d85f6c302dfe07b12@ausx13mps321.AMER.DELL.COM>
 <20181113050240.GA182139@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.49.166]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811130201
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/12/2018 11:02 PM, Bjorn Helgaas wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> Please report any suspicious attachments, links, or requests for sensitiv=
e information.=0A=
> =0A=
> =0A=
> [+cc Jon, for related VMD firmware-first error enable issue]=0A=
> =0A=
> On Mon, Nov 12, 2018 at 08:05:41PM +0000, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> On 11/11/2018 11:50 PM, Oliver O'Halloran wrote:=0A=
>>> On Thu, 2018-11-08 at 23:06 +0000, Alex_Gagniuc@Dellteam.com wrote:=0A=
> =0A=
>>>> But it's not the firmware that crashes. It's linux as a result of a=0A=
>>>> fatal error message from the firmware. And we can't fix that because F=
FS=0A=
>>>> handling requires that the system reboots [1].=0A=
>>>=0A=
>>> Do we know the exact circumsances that result in firmware requesting a=
=0A=
>>> reboot? If it happen on any PCIe error I don't see what we can do to=0A=
>>> prevent that beyond masking UEs entirely (are we even allowed to do=0A=
>>> that on FFS systems?).=0A=
>>=0A=
>> Pull a drive out at an angle, push two drives in at the same time, pull=
=0A=
>> out a drive really slow. If an error is even reported to the OS depends=
=0A=
>> on PD state, and proprietary mechanisms and logic in the HW and FW. OS=
=0A=
>> is not supposed to mask errors (touch AER bits) on FFS.=0A=
> =0A=
> PD?=0A=
=0A=
Presence Detect=0A=
=0A=
> Do you think Linux observes the rule about not touching AER bits on=0A=
> FFS?  I'm not sure it does.  I'm not even sure what section of the=0A=
> spec is relevant.=0A=
=0A=
I haven't found any place where linux breaks this rule. I'm very =0A=
confident that, unless otherwise instructed, we follow this rule.=0A=
=0A=
> The whole issue of firmware-first, the mechanism by which firmware=0A=
> gets control, the System Error enables in Root Port Root Control=0A=
> registers, etc., is very murky to me.  Jon has a sort of similar issue=0A=
> with VMD where he needs to leave System Errors enabled instead of=0A=
> disabling them as we currently do.=0A=
=0A=
Well, OS gets control via _OSC method, and based on that it should =0A=
touch/not touch the AER bits. The bits that get set/cleared come from =0A=
_HPX method, and there's a more about the FFS described in ACPI spec. It =
=0A=
seems that if platform, wants to enable VMD, it should pass the correct =0A=
bits via _HPX. I'm curious to know in what new twisted way FFS doesn't =0A=
work as intended.=0A=
=0A=
Alex=0A=
=0A=
> Bjorn=0A=
> =0A=
> [1] https://lore.kernel.org/linux-pci/20181029210651.GB13681@bhelgaas-gla=
ptop.roam.corp.google.com=0A=
> =0A=
=0A=
