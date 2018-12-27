Return-Path: <SRS0=7J7L=PE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58E1C43387
	for <linux-pci@archiver.kernel.org>; Thu, 27 Dec 2018 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F30321741
	for <linux-pci@archiver.kernel.org>; Thu, 27 Dec 2018 19:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="D2/buqyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeL0T3B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:29:01 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:21553 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbeL0T3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Dec 2018 14:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1545938940; x=1577474940;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q+UMh7jY8U1VIkQH4DCkm2HjF2/QZr37Q90LowfjR4U=;
  b=D2/buqywZmRmi72VJz/48p1Z2IUdnUD/n0nqEZg1g1sZK+3NyGdZshi1
   t69UrNQlAv10JDVeAABEKk9GaTFvPSUrOMalqNgOtLEFOGlyoiqY5iO+e
   1VHBxH7GjLEr3uDX8dyE18Yj1tLwZ362/lqogLAkwTMonzhMSTC66Awyv
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EXAAC6JyVchyWd50NjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBAYNqJwqMDV+LFIINiRiOSxSBZwsBAYRsgkQiNAkNAQMBAQI?=
 =?us-ascii?q?BAQIBAQIQAQEBFQkIKSMMQgEQAYFmIoJwAQEEEig/EAIBCBgeECE2AgQBEgg?=
 =?us-ascii?q?agwCBagMVmlM9AoFuiQYBAQGCHYd3DYIdjD+CFoQjgleBdwESAQcGEoVfAok?=
 =?us-ascii?q?pghyVLCczCQWOMYMrIIFghSGKZYMQhkmGE4oWAgQCBAUCFIFGN2dxcIM8gjU?=
 =?us-ascii?q?bh0GGSkABMQGDOIgjgR+BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2EXAAC6JyVchyWd50NjHAEBAQQBAQcEAQGBUQcBAQsBA?=
 =?us-ascii?q?YNqJwqMDV+LFIINiRiOSxSBZwsBAYRsgkQiNAkNAQMBAQIBAQIBAQIQAQEBF?=
 =?us-ascii?q?QkIKSMMQgEQAYFmIoJwAQEEEig/EAIBCBgeECE2AgQBEggagwCBagMVmlM9A?=
 =?us-ascii?q?oFuiQYBAQGCHYd3DYIdjD+CFoQjgleBdwESAQcGEoVfAokpghyVLCczCQWOM?=
 =?us-ascii?q?YMrIIFghSGKZYMQhkmGE4oWAgQCBAUCFIFGN2dxcIM8gjUbh0GGSkABMQGDO?=
 =?us-ascii?q?IgjgR+BHwEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Dec 2018 13:28:59 -0600
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBRJS28F021123;
        Thu, 27 Dec 2018 14:28:59 -0500
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0b-00154901.pphosted.com with ESMTP id 2pmveu2dgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Dec 2018 14:28:59 -0500
Cc:     <linux-pci@vger.kernel.org>, <keith.busch@intel.com>,
        <Austin.Bolen@dell.com>, <Shyam.Iyer@dell.com>,
        <linux-kernel@vger.kernel.org>, <jonathan.derrick@intel.com>,
        <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
        <ruscur@russell.cc>, <sbobroff@linux.ibm.com>, <oohall@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>
Received: from ausxippc110.us.dell.com ([143.166.85.200])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Dec 2018 01:28:39 +0600
X-LoopCount0: from 10.166.134.84
X-IronPort-AV: E=Sophos;i="5.56,406,1539666000"; 
   d="scan'208";a="745242649"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUT50UQ290XPGvJEGnaSTTjbCF+g==
Date:   Thu, 27 Dec 2018 19:28:55 +0000
Message-ID: <4bc22b1696f345e483a21da16ac4b745@ausx13mps321.AMER.DELL.COM>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com> <20181108200855.GE41183@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.192]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-27_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=915 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812270171
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/8/18 2:09 PM, Bjorn Helgaas wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> Please report any suspicious attachments, links, or requests for sensitiv=
e information.=0A=
> =0A=
> =0A=
> [+cc Jonathan, Greg, Lukas, Russell, Sam, Oliver for discussion about=0A=
> PCI error recovery in general]=0A=
> =0A=
> On Wed, Nov 07, 2018 at 05:42:57PM -0600, Bjorn Helgaas wrote:=0A=
>> On Tue, Sep 18, 2018 at 05:15:00PM -0500, Alexandru Gagniuc wrote:=0A=
>>> When a PCI device is gone, we don't want to send IO to it if we can=0A=
>>> avoid it. We expose functionality via the irq_chip structure. As=0A=
>>> users of that structure may not know about the underlying PCI device,=
=0A=
>>> it's our responsibility to guard against removed devices.=0A=
>>>=0A=
>>> .irq_write_msi_msg() is already guarded inside __pci_write_msi_msg().=
=0A=
>>> .irq_mask/unmask() are not. Guard them for completeness.=0A=
>>>=0A=
>>> For example, surprise removal of a PCIe device triggers teardown. This=
=0A=
>>> touches the irq_chips ops some point to disable the interrupts. I/O=0A=
>>> generated here can crash the system on firmware-first machines.=0A=
>>> Not triggering the IO in the first place greatly reduces the=0A=
>>> possibility of the problem occurring.=0A=
>>>=0A=
>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>=0A=
>>=0A=
>> Applied to pci/misc for v4.21, thanks!=0A=
> =0A=
> I'm having second thoughts about this. =0A=
=0A=
Do we have a verdict on this? If you don't like this approach, then I'll =
=0A=
have to fix the problem in some other way, but the problem still needs =0A=
to be fixed.=0A=
=0A=
Alex=0A=
