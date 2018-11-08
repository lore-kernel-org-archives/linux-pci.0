Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB8FC43441
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 22:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8936F20892
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 22:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="sl6BFOcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8936F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeKIH6p (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:58:45 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:9002 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727124AbeKIH6o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Nov 2018 02:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1541715659; x=1573251659;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/veGbqNCoKmiukWkRwql7I6DqzGyFo+CqGykJEdwGxo=;
  b=sl6BFOcWSZzEAKDM0aCBrCl5gUd2h/ODou3tmUPFilihoslmgWktxn4B
   C/aa5sdWDB8yXDIl3pyH62+xyDQ1DciZdG/bMAZ9mwvNSWI8k473ijE4l
   hQhTmt+Ns7MGhmXMKTAs+ZiSWgaUkn0MEdnL9Z+yRiIZahNZFWKfv6dts
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EFAADOteRbhyeV50NkGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUQYBAQELAYNrMYwGX4sdgg16ljgUgWYLAQGEbIMbIjQNDQEDAQE?=
 =?us-ascii?q?CAQECAQECEAEBAQoLCQgpL4I2IoJjAQEBAQIBEig/BQsCAQgYHhBXAgQBGhq?=
 =?us-ascii?q?Cf4F6CJx7AoEQiVgBAQGCHIosi3mCF4ERgl01hEoBARIBDRIshS8CiG2CEIQ?=
 =?us-ascii?q?EkEcJBY0tg1wggVcihF+DIoZygnSUVQIEAgQFAhSBQ4EdcXCDPYI0G44KQAG?=
 =?us-ascii?q?LSIEfgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EFAADOteRbhyeV50NkGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYNrMYwGX4sdgg16ljgUgWYLAQGEbIMbIjQNDQEDAQECAQECAQECEAEBA?=
 =?us-ascii?q?QoLCQgpL4I2IoJjAQEBAQIBEig/BQsCAQgYHhBXAgQBGhqCf4F6CJx7AoEQi?=
 =?us-ascii?q?VgBAQGCHIosi3mCF4ERgl01hEoBARIBDRIshS8CiG2CEIQEkEcJBY0tg1wgg?=
 =?us-ascii?q?VcihF+DIoZygnSUVQIEAgQFAhSBQ4EdcXCDPYI0G44KQAGLSIEfgR8BAQ?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Nov 2018 16:20:59 -0600
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8MDS2r142087;
        Thu, 8 Nov 2018 17:21:09 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2nmr0f28ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Nov 2018 17:21:08 -0500
Cc:     <linux-pci@vger.kernel.org>, <keith.busch@intel.com>,
        <Austin.Bolen@dell.com>, <Shyam.Iyer@dell.com>,
        <linux-kernel@vger.kernel.org>, <jonathan.derrick@intel.com>,
        <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
        <ruscur@russell.cc>, <sbobroff@linux.ibm.com>, <oohall@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Nov 2018 04:21:07 +0600
X-LoopCount0: from 10.166.134.83
X-IronPort-AV: E=Sophos;i="5.54,481,1534827600"; 
   d="scan'208";a="1323434476"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUT50UQ290XPGvJEGnaSTTjbCF+g==
Date:   Thu, 8 Nov 2018 22:20:46 +0000
Message-ID: <555e85227c6541ea96afa330e632dead@ausx13mps321.AMER.DELL.COM>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com> <20181108200855.GE41183@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.90.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080187
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/08/2018 02:09 PM, Bjorn Helgaas wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> Please report any suspicious attachments, links, or requests for sensitiv=
e information.=0A=
> =0A=
> =0A=
> [+cc Jonathan, Greg, Lukas, Russell, Sam, Oliver for discussion about=0A=
> PCI error recovery in general]=0A=
=0A=
Has anyone seen seen the ECRs in the PCIe base spec and ACPI that have =0A=
been floating around the past few months? -- HPX, SFI, CER. Without =0A=
divulging too much before publication, I'm curious on opinions on how =0A=
well (or not well) those flows would work in general, and in linux.=0A=
=0A=
> On Wed, Nov 07, 2018 at 05:42:57PM -0600, Bjorn Helgaas wrote:=0A=
> I'm having second thoughts about this.  One thing I'm uncomfortable=0A=
> with is that sprinkling pci_dev_is_disconnected() around feels ad hoc=0A=
> instead of systematic, in the sense that I don't know how we convince=0A=
> ourselves that this (and only this) is the correct place to put it. >=0A=
> Another is that the only place we call pci_dev_set_disconnected() is=0A=
> in pciehp and acpiphp, so the only "disconnected" case we catch is if=0A=
> hotplug happens to be involved.  Every MMIO read from the device is an=0A=
> opportunity to learn whether it is reachable (a read from an=0A=
> unreachable device typically returns ~0 data), but we don't do=0A=
> anything at all with those.=0A=
 >=0A=
> The config accessors already check pci_dev_is_disconnected(), so this=0A=
> patch is really aimed at MMIO accesses.  I think it would be more=0A=
> robust if we added wrappers for readl() and writel() so we could=0A=
> notice read errors and avoid future reads and writes.=0A=
=0A=
I wouldn't expect anything less than  complete scrutiny and quality =0A=
control of unquestionable moral integrity :). In theory ~0 can be a =0A=
great indicator that something may be wrong. Though I think it's about =0A=
as ad-hoc as pci_dev_is_disconnected().=0A=
=0A=
I slightly like the idea of wrapping the MMIO accessors. There's still =0A=
memcpy and DMA that cause the same MemRead/Wr PCIe transactions, and the =
=0A=
same sort of errors in PCIe land, and it would be good to have more =0A=
testing on this. Since this patch is tested and confirmed to fix a known =
=0A=
failure case, I would keep it, and the look at fixing the problem in a =0A=
more generic way.=0A=
=0A=
BTW, a lot of the problems we're fixing here come courtesy of =0A=
firmware-first error handling. Do we reach a point where we draw a line =0A=
in handling new problems introduced by FFS? So, if something is a =0A=
problem with FFS, but not native handling, do we commit to supporting it?=
=0A=
=0A=
Alex=0A=
=0A=
