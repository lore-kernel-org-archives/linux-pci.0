Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BA6C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 20:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7985722506
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 20:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="F9IA4/9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7985722506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbeKMGAb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:00:31 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:15683 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbeKMGAb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2018 01:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1542053146; x=1573589146;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sbp8gIVMNq2z7wKV+Us/Oh58FM+BMMhE1vtMpIoI/NI=;
  b=F9IA4/9aKLO4NnV/HJWzpQB/avCaLTpo1D17iCc7Kg533vGxZybUyBZX
   u3/MP5xEhiuYrR1CrQW8fHfYxmQYsmwdc0Szp/av12dK3p79cu/3pbcOU
   ooaRMdiFu7b2EbILq86AiFgd37kh0yDuHRLVUEX3U901+SSwE5GdGknbO
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EMAACO2+lbhiWd50NkGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUwQBAQELAYNrJwqMZYsbgg2XNRSBZgsBAYRsgzAiNgsNAQMBAQI?=
 =?us-ascii?q?BAQIBAQIQAQEBCgkLCCkvgjYigmMBAQEBAgESKD8QAgEIGB4QVwIEARIIFgS?=
 =?us-ascii?q?Cf4F6CJ1IAoEQiVgBAQGCHYotjACCFoERgxKESwESAQcGEiyFLwKKfpN8VQk?=
 =?us-ascii?q?FkRAggViFAoMihnSCdZRcAgQCBAUCFIFKB4EPcXCDPII1G44KQAExi1aBH4E?=
 =?us-ascii?q?fAQE?=
X-IPAS-Result: =?us-ascii?q?A2EMAACO2+lbhiWd50NkGwEBAQEDAQEBBwMBAQGBUwQBA?=
 =?us-ascii?q?QELAYNrJwqMZYsbgg2XNRSBZgsBAYRsgzAiNgsNAQMBAQIBAQIBAQIQAQEBC?=
 =?us-ascii?q?gkLCCkvgjYigmMBAQEBAgESKD8QAgEIGB4QVwIEARIIFgSCf4F6CJ1IAoEQi?=
 =?us-ascii?q?VgBAQGCHYotjACCFoERgxKESwESAQcGEiyFLwKKfpN8VQkFkRAggViFAoMih?=
 =?us-ascii?q?nSCdZRcAgQCBAUCFIFKB4EPcXCDPII1G44KQAExi1aBH4EfAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Nov 2018 14:05:45 -0600
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACJwkkp072710;
        Mon, 12 Nov 2018 15:05:44 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2nqepsrg5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 15:05:44 -0500
Cc:     <keith.busch@intel.com>, <helgaas@kernel.org>,
        <mr.nuke.me@gmail.com>, <linux-pci@vger.kernel.org>,
        <Austin.Bolen@dell.com>, <Shyam.Iyer@dell.com>,
        <linux-kernel@vger.kernel.org>, <jonathan.derrick@intel.com>,
        <lukas@wunner.de>, <ruscur@russell.cc>, <sbobroff@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Nov 2018 02:05:42 +0600
X-LoopCount0: from 10.166.134.88
X-IronPort-AV: E=Sophos;i="5.54,496,1534827600"; 
   d="scan'208";a="1324590346"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <oohall@gmail.com>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUT50UQ290XPGvJEGnaSTTjbCF+g==
Date:   Mon, 12 Nov 2018 20:05:41 +0000
Message-ID: <df85813c9860463d85f6c302dfe07b12@ausx13mps321.AMER.DELL.COM>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com> <20181108200855.GE41183@google.com>
 <20181108220117.GA11466@kroah.com>
 <20181108223258.GD2932@localhost.localdomain>
 <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
 <20181108225109.GA3023@kroah.com>
 <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
 <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.49.166]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120173
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/11/2018 11:50 PM, Oliver O'Halloran wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> Please report any suspicious attachments, links, or requests for sensitiv=
e information.=0A=
> =0A=
> =0A=
> On Thu, 2018-11-08 at 23:06 +0000, Alex_Gagniuc@Dellteam.com wrote:=0A=
>> On 11/08/2018 04:51 PM, Greg KH wrote:=0A=
>>> On Thu, Nov 08, 2018 at 10:49:08PM +0000, Alex_Gagniuc@Dellteam.com wro=
te:=0A=
>>>> In the case that we're trying to fix, this code executing is a result =
of=0A=
>>>> the device being gone, so we can guarantee race-free operation. I agre=
e=0A=
>>>> that there is a race, in the general case. As far as checking the resu=
lt=0A=
>>>> for all F's, that's not an option when firmware crashes the system as =
a=0A=
>>>> result of the mmio read/write. It's never pretty when firmware gets=0A=
>>>> involved.=0A=
>>>=0A=
>>> If you have firmware that crashes the system when you try to read from =
a=0A=
>>> PCI device that was hot-removed, that is broken firmware and needs to b=
e=0A=
>>> fixed.  The kernel can not work around that as again, you will never wi=
n=0A=
>>> that race.=0A=
>>=0A=
>> But it's not the firmware that crashes. It's linux as a result of a=0A=
>> fatal error message from the firmware. And we can't fix that because FFS=
=0A=
>> handling requires that the system reboots [1].=0A=
> =0A=
> Do we know the exact circumsances that result in firmware requesting a=0A=
> reboot? If it happen on any PCIe error I don't see what we can do to=0A=
> prevent that beyond masking UEs entirely (are we even allowed to do=0A=
> that on FFS systems?).=0A=
=0A=
Pull a drive out at an angle, push two drives in at the same time, pull =0A=
out a drive really slow. If an error is even reported to the OS depends =0A=
on PD state, and proprietary mechanisms and logic in the HW and FW. OS =0A=
is not supposed to mask errors (touch AER bits) on FFS.=0A=
=0A=
Sadly, with FFS, behavior can and does change from BIOS version to BIOS =0A=
version. On one product, for example, we eliminated a lot of crashes by =0A=
simply not reporting some classes of PCIe errors to the OS.=0A=
=0A=
Alex=0A=
=0A=
>> If we're going to say that we don't want to support FFS because it's a=
=0A=
>> separate code path, and different flow, that's fine. I am myself, not a=
=0A=
>> fan of FFS. But if we're going to continue supporting it, I think we'll=
=0A=
>> continue to have to resolve these sort of unintended consequences.=0A=
>>=0A=
>> Alex=0A=
>>=0A=
>> [1] ACPI 6.2, 18.1 - Hardware Errors and Error Sources=0A=
> =0A=
> =0A=
=0A=
