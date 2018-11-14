Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444DBC43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 20:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F171E22419
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 20:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="Mhx9GORe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F171E22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbeKOG5D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:57:03 -0500
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:33079 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725895AbeKOG5D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 01:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1542228731; x=1573764731;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OK57INNTIDwKwcDqWEq68OIXp0NJI6SwNBEEbFIte+0=;
  b=Mhx9GORecmBubjEF7nBxjv+6soLhUx8EF3aLuVxi4z89+MfkICb5Ja4/
   oaWbpCQ/eJ/GUXSRF8zXY95YjL8ILCpNkgiDG3YxMGXmi1GjKE0+wZ5BI
   jEnXuYoPP4u+n4C4NlnnF/24nyR2b2DErCbgVYCcfgnSvwSMY8Y7fUWZP
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EXAABJiuxbhiWd50NiHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBAYNqJwqMBl+LGoINlzaBegsBAYRsg0wiNA0NAQMBAQIBAQI?=
 =?us-ascii?q?BAQIQAQEBCgkLCCkvQgEQAYFiIoJjAQEBAQIBEhUTOAcFCwIBCBgeEFcCBBM?=
 =?us-ascii?q?IGoJ/gXoInkcCgRCJWAEBAYFqM4onjAWCFoERgxKEfk2FDgKLA5RbCQWRFSC?=
 =?us-ascii?q?JWocbgnWUZQIEAgQFAhSBRYIOcIM8gjUbjgpAATGCB4pggR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EXAABJiuxbhiWd50NiHAEBAQQBAQcEAQGBUQcBAQsBA?=
 =?us-ascii?q?YNqJwqMBl+LGoINlzaBegsBAYRsg0wiNA0NAQMBAQIBAQIBAQIQAQEBCgkLC?=
 =?us-ascii?q?CkvQgEQAYFiIoJjAQEBAQIBEhUTOAcFCwIBCBgeEFcCBBMIGoJ/gXoInkcCg?=
 =?us-ascii?q?RCJWAEBAYFqM4onjAWCFoERgxKEfk2FDgKLA5RbCQWRFSCJWocbgnWUZQIEA?=
 =?us-ascii?q?gQFAhSBRYIOcIM8gjUbjgpAATGCB4pggR8BAQ?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Nov 2018 14:52:10 -0600
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAEKlmj1021100;
        Wed, 14 Nov 2018 15:52:13 -0500
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com [68.232.153.201])
        by mx0b-00154901.pphosted.com with ESMTP id 2nrmxktch6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Nov 2018 15:52:13 -0500
Cc:     <helgaas@kernel.org>, <oohall@gmail.com>,
        <gregkh@linuxfoundation.org>, <mr.nuke.me@gmail.com>,
        <linux-pci@vger.kernel.org>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <linux-kernel@vger.kernel.org>,
        <jonathan.derrick@intel.com>, <lukas@wunner.de>,
        <ruscur@russell.cc>, <sbobroff@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Nov 2018 02:52:10 +0600
X-LoopCount0: from 10.166.134.87
X-IronPort-AV: E=Sophos;i="5.56,233,1539666000"; 
   d="scan'208";a="1325421759"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <keith.busch@intel.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUT50UQ290XPGvJEGnaSTTjbCF+g==
Date:   Wed, 14 Nov 2018 20:52:10 +0000
Message-ID: <644fd16cf02c4fe5b7e250c226c80f2e@ausx13mps321.AMER.DELL.COM>
References: <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
 <20181108225109.GA3023@kroah.com>
 <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
 <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
 <df85813c9860463d85f6c302dfe07b12@ausx13mps321.AMER.DELL.COM>
 <20181113050240.GA182139@google.com>
 <19136f44cd5c45e79bbef7e78a6bf332@ausx13mps321.AMER.DELL.COM>
 <20181114055956.GA144931@google.com>
 <1eb0fa27924f426992715684f5e63346@ausx13mps321.AMER.DELL.COM>
 <20181114202333.GE11416@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.49.166]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140185
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/14/2018 02:27 PM, Keith Busch wrote:=0A=
> On Wed, Nov 14, 2018 at 07:22:04PM +0000, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> On 11/14/2018 12:00 AM, Bjorn Helgaas wrote:=0A=
>>> Just to make sure we're on the same page, can you point me to this=0A=
>>> rule?  I do see that OSPM must request control of AER using _OSC=0A=
>>> before it touches the AER registers.  What I don't see is the=0A=
>>> connection between firmware-first and the AER registers.=0A=
>>=0A=
>> ACPI 6.2 - 6.2.11.3, Table 6-197:=0A=
>>[...]=0A=
>> Maybe Keith knows better why we're doing it this way. From ACPI text, it=
=0A=
>> doesn't seem that control of AER would be tied to HEST entries, although=
=0A=
>> in practice, it is.=0A=
> =0A=
> I'm not sure, that predates me.  HEST does have a FIRMWARE_FIRST flag, bu=
t=0A=
> spec does not say anymore on relation to _OSC control or AER capability.=
=0A=
> Nothing in PCIe spec either.=0A=
=0A=
Speaking to one of the PCIe (and _HPX type 3) spec authors, ownership of =
=0A=
AER should be determined by _OSC. period. The result of _OSC applies to =0A=
every device under the root port. This crap we do with checking HEST is =0A=
crap.=0A=
=0A=
If I'm not stepping on anyone toes, and there's no known unintended =0A=
consequences, I can look at patching this up. I'm not promising a patch, =
=0A=
though, but it's exactly the sort of thing I like to fix.=0A=
=0A=
> I also don't know why Linux disables the AER driver if only one=0A=
> device has a FIRMWARE_FIRST HEST. Shouldn't that just be a per-device=0A=
> decision?=0A=
=0A=
I think the logic is if one HEST entry has both FFS and GLOBAL flags =0A=
set, then then disable AER services for all devices. It works in =0A=
practice better than it works in theory. I think _OSC should be the =0A=
determining factor here, not HEST.=0A=
=0A=
>>> The closest I can find is the "Enabled" field in the HEST PCIe=0A=
>>> AER structures (ACPI v6.2, sec 18.3.2.4, .5, .6), where it says:=0A=
>>> [...]=0A=
>>> AFAICT, Linux completely ignores the Enabled field in these=0A=
>>> structures.=0A=
>>=0A=
>> I don't think ignoring the field is a problem:=0A=
>>    * With FFS, OS should ignore it.=0A=
>>    * Without FFS, we have control, and we get to make the decisions anyw=
ay.=0A=
>> In the latter case we decide whether to use AER, independent of the crap=
=0A=
>> in ACPI. I'm not even sure why "Enabled" matters in native AER handling.=
=0A=
>> Probably one of the check-boxes in "Binary table designer's handbook"?=
=0A=
> =0A=
> And why doesn't Linux do anything with _OSC response other than logging=
=0A=
> it? If OS control wasn't granted, shouldn't that take priority over HEST?=
=0A=
=0A=
But it does in portdrv_core.c:=0A=
=0A=
	if (dev->aer_cap && pci_aer_available() &&=0A=
	    (pcie_ports_native || host->native_aer)) {=0A=
		services |=3D PCIE_PORT_SERVICE_AER;=0A=
=0A=
That flag later creates a pcie device that allows aerdrv to attach to.=0A=
=0A=
Alex=0A=
