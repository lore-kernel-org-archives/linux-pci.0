Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45022C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 19:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133C3206C0
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 19:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="CXQTpY12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfBVT4m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:56:42 -0500
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:51463 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbfBVT4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 14:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1550865379; x=1582401379;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mCUDY+Sygt522QCXqMHQTd6X6QbkG/EpAaAKhTFn4Z4=;
  b=CXQTpY12w5x7yn2RM5zsId1znR63r5JWT9OBeLyl+EDhid44oJWmW1Zt
   U6tcr5s2KgZlsne4PoF2D9MG7or5blNARV5OUbDCOT6P6fNpn1HzcIms9
   oMrq+tz8MYD4hGDT7YTi/xCOtEBD2x6kD5yjXYdtW6VvOdXC7tlewAE6A
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EDAAB/UnBchieV50NkGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUQUBAQEBCwGCWYEUMYwXX40IgX2WIRSBZwsBASyEQIQBIjQ?=
 =?us-ascii?q?JDQEDAQECAQECAQECEAEBAQoJCwgpL4I6IoJwAQEBAxIVEz8QAgEIGB4QVwI?=
 =?us-ascii?q?EARoTB4J+gXOfUD0CbYEBiQcBAQGBazOKMIxIghaDdS6EaRiFYQKMD5dKCQW?=
 =?us-ascii?q?SUyGTD4pOkg4CBAIEBQIUgUeCD3CDPYI1HI4LQYFZjUQBgR4BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EDAAB/UnBchieV50NkGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?QUBAQEBCwGCWYEUMYwXX40IgX2WIRSBZwsBASyEQIQBIjQJDQEDAQECAQECA?=
 =?us-ascii?q?QECEAEBAQoJCwgpL4I6IoJwAQEBAxIVEz8QAgEIGB4QVwIEARoTB4J+gXOfU?=
 =?us-ascii?q?D0CbYEBiQcBAQGBazOKMIxIghaDdS6EaRiFYQKMD5dKCQWSUyGTD4pOkg4CB?=
 =?us-ascii?q?AIEBQIUgUeCD3CDPYI1HI4LQYFZjUQBgR4BAQ?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa5.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2019 13:56:19 -0600
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MJhLaW193665;
        Fri, 22 Feb 2019 14:56:41 -0500
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com [68.232.153.201])
        by mx0a-00154901.pphosted.com with ESMTP id 2qtp2qgk7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Feb 2019 14:56:41 -0500
Cc:     <bhelgaas@google.com>, <Austin.Bolen@dell.com>,
        <keith.busch@intel.com>, <Shyam.Iyer@dell.com>, <okaya@kernel.org>,
        <linux-pci@vger.kernel.org>, <gustavo@embeddedor.com>,
        <linux-kernel@vger.kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Feb 2019 01:56:30 +0600
X-LoopCount0: from 10.166.134.89
X-IronPort-AV: E=Sophos;i="5.58,400,1544508000"; 
   d="scan'208";a="1200292796"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH RFC v2 2/4] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Thread-Topic: [PATCH RFC v2 2/4] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Thread-Index: AQHUyLqR+ed3yG3ljUu42ub7Hwypsg==
Date:   Fri, 22 Feb 2019 19:56:28 +0000
Message-ID: <dfeadc6798984cce965e2202e90fe0b0@ausx13mps321.AMER.DELL.COM>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
 <20190220012031.10741-3-mr.nuke.me@gmail.com>
 <20190221073634.snvazxlzgvjhilaz@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=595 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220136
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/21/19 1:36 AM, Lukas Wunner wrote:=0A=
> On Tue, Feb 19, 2019 at 07:20:28PM -0600, Alexandru Gagniuc wrote:=0A=
>>   	mutex_lock(&ctrl->state_lock);=0A=
>> +	present =3D pciehp_card_present(ctrl);=0A=
>> +	link_active =3D pciehp_check_link_active(ctrl);=0A=
>>   	switch (ctrl->state) {=0A=
> =0A=
> These two assignments appear to be superfluous as you're also performing=
=0A=
> them in pciehp_check_link_active().=0A=
=0A=
Not sure. Between the first check, and this check, you can have several =0A=
seconds elapse depending on whether the driver's .probe()/remove() is =0A=
invoked. Whatever you got at the beginning would be stale. If you had a =0A=
picture dictionary and looked up 'bad idea', it would have a picture of =0A=
the above code with the second check removed.=0A=
=0A=
I've got all the other review comments addressed in my local branch. I'm =
=0A=
waiting on Lord Helgass' decision on which solution is better.=0A=
=0A=
Alex=0A=
=0A=
=0A=
