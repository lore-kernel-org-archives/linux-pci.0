Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B6BC43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BD1222D9
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="ePhMKfA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439742AbfBNT0h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:26:37 -0500
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:53808 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439736AbfBNT0c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Feb 2019 14:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1550172392; x=1581708392;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KF5/ZKLPvD3zphF/+bULMEtrWBscpl6jofrPxgRma4k=;
  b=ePhMKfA6K1IGtaY8SQtieeOi+DhyjuSQeD/ToY+EgZm6gYaV9oDLIBQh
   l6mXO3w1xQ6YO5vVwTzpgn1sESV5G0smhtahSjMSAeYWLD/3qbPbHzEfD
   6DyMvCxE2CElg9bfua13eswpMPnyTmsjOUli+0/2CH5vcEc3f+vuXW/GE
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FyAAAjwGVchyeV50NkGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBZYJZgRQnCox1ixKCDZoOCwEBLIRAg2YiOBIBAwEBAgEBAgEBAhA?=
 =?us-ascii?q?BAQEKCwkIKS+COiKCbwEBAQMBEig/BQsCAQgYHhBXAgQTCBqCfoFrCJ5mPQJ?=
 =?us-ascii?q?tgQGJBwEBAYIeijiMRIIWg3UuhQFNhRMCjAeLMot1CQWSRyGBbpEFi0mQYgI?=
 =?us-ascii?q?EAgQFAhSBXYF4cIM8gjaOJ0ExgSiOFQGBHgEB?=
X-IPAS-Result: =?us-ascii?q?A2FyAAAjwGVchyeV50NkGwEBAQEDAQEBBwMBAQGBZYJZg?=
 =?us-ascii?q?RQnCox1ixKCDZoOCwEBLIRAg2YiOBIBAwEBAgEBAgEBAhABAQEKCwkIKS+CO?=
 =?us-ascii?q?iKCbwEBAQMBEig/BQsCAQgYHhBXAgQTCBqCfoFrCJ5mPQJtgQGJBwEBAYIei?=
 =?us-ascii?q?jiMRIIWg3UuhQFNhRMCjAeLMot1CQWSRyGBbpEFi0mQYgIEAgQFAhSBXYF4c?=
 =?us-ascii?q?IM8gjaOJ0ExgSiOFQGBHgEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2019 13:26:30 -0600
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EJE6jw034764;
        Thu, 14 Feb 2019 14:26:30 -0500
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0a-00154901.pphosted.com with ESMTP id 2qnc78rr5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 14:26:29 -0500
Cc:     <mr.nuke.me@gmail.com>, <bhelgaas@google.com>,
        <Austin.Bolen@dell.com>, <keith.busch@intel.com>,
        <Shyam.Iyer@dell.com>, <gustavo@embeddedor.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Feb 2019 01:26:02 +0600
X-LoopCount0: from 10.166.134.85
X-IronPort-AV: E=Sophos;i="5.58,369,1544508000"; 
   d="scan'208";a="354071790"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>
Subject: Re: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Thread-Topic: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Thread-Index: AQHUvZbN4kEiyNA8xUGy+Uw4G87SXw==
Date:   Thu, 14 Feb 2019 19:26:28 +0000
Message-ID: <59479c08d4624ffdb00883813ce80729@ausx13mps321.AMER.DELL.COM>
References: <20190205210701.25387-1-mr.nuke.me@gmail.com>
 <20190209115849.244u67h7wmn3eb7o@wunner.de>
 <52afa1c45f684dbda6a8771b65583a22@ausx13mps321.AMER.DELL.COM>
 <20190212083031.2no7mzn5xug7nba3@wunner.de>
 <b2fffa5beb7941ebaceb8b8ce6e5b133@ausx13mps321.AMER.DELL.COM>
 <20190213083632.GA3387@wunner.de>
 <205e0fd9995a4f2b80ab370a974b6628@ausx13mps321.AMER.DELL.COM>
 <20190214070100.kvikmkkcrp2d32sm@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=715 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140128
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/14/19 1:01 AM, Lukas Wunner wrote:=0A=
> On Wed, Feb 13, 2019 at 06:55:46PM +0000, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> On 2/13/19 2:36 AM, Lukas Wunner wrote:=0A=
>>>> (*) A bit hypothetical: There is no hardware yet implementing the ECN.=
=0A=
>>>=0A=
>>> Hm, this contradicts Austin Bolen's e-mail of Jan 25 that "Yes, this=0A=
>>> platform disables in-band presence" (when asked whether your host=0A=
>>> controller already adheres to the ECN).=0A=
>>=0A=
>> Both statements are true. The hardware does indeed disable in-band=0A=
>> presence, in a rudimentary way that is not compliant with the ECN -- it=
=0A=
>> doesn't implement the bits required by the ECN.=0A=
> =0A=
> Ugh, can a BIOS update make those machines compliant to the ECN=0A=
=0A=
No, that is not possible, I'm told.=0A=
=0A=
> or do we need a quirk specifically for them?=0A=
=0A=
We might have to.=0A=
=0A=
> It should match the spec, which I have no access to.=0A=
=0A=
I am as irritated as you that the spec is not readily available for =0A=
public viewing.=0A=
=0A=
Cheers,=0A=
Alex=0A=
