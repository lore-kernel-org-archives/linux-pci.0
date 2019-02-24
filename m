Return-Path: <SRS0=PIDp=Q7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A23BC00319
	for <linux-pci@archiver.kernel.org>; Sun, 24 Feb 2019 22:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0132089F
	for <linux-pci@archiver.kernel.org>; Sun, 24 Feb 2019 22:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="k7+41OMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfBXW2J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 24 Feb 2019 17:28:09 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:18121 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbfBXW2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Feb 2019 17:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1551047265; x=1582583265;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fXryVJB11Bct3ZGy6PanoflP1HvJi67XTph04XKYvwg=;
  b=k7+41OMvd4Stcgt0dzixgsndT2L3//bMMpmOM2G2bieR3fmieNUMgXZ6
   qhZ1EzOI6jftJU8Ad5G16M/xQHwrtbC/4UliDK6q403TpmnrdwOLVrgcZ
   CUPyQ27yY7sU/PHR5aUB4Czb7ONCV3JL4VacVJdMJYBCXB8IIXa8DzjUX
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EPAAAXGnNchyWd50NlGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUgUBAQELAYJZgRQnCox2jQSBfZYhFIFnCwEBLIRAhAEiNQgNAQM?=
 =?us-ascii?q?BAQIBAQIBAQIQAQEBCgsJCCkvgjoigm8BAQEBAgESFRM/EAIBCBgeEFcCBBM?=
 =?us-ascii?q?IEweCfoFrCJ5MPQJtgQGJBwEBAYFrM4oijEiCFoN1LoROARIBBxhNhRQCjA+?=
 =?us-ascii?q?EQJMKCQWSUyGBcYVbi0OcXAIEAgQFAhSBSAGBHHFwgzyCKA4JE44LQTGBKIw?=
 =?us-ascii?q?lgR8BgR4BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EPAAAXGnNchyWd50NlGwEBAQEDAQEBBwMBAQGBUgUBA?=
 =?us-ascii?q?QELAYJZgRQnCox2jQSBfZYhFIFnCwEBLIRAhAEiNQgNAQMBAQIBAQIBAQIQA?=
 =?us-ascii?q?QEBCgsJCCkvgjoigm8BAQEBAgESFRM/EAIBCBgeEFcCBBMIEweCfoFrCJ5MP?=
 =?us-ascii?q?QJtgQGJBwEBAYFrM4oijEiCFoN1LoROARIBBxhNhRQCjA+EQJMKCQWSUyGBc?=
 =?us-ascii?q?YVbi0OcXAIEAgQFAhSBSAGBHHFwgzyCKA4JE44LQTGBKIwlgR8BgR4BAQ?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2019 16:27:44 -0600
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1OMNLoB192100;
        Sun, 24 Feb 2019 17:28:07 -0500
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com [68.232.153.201])
        by mx0b-00154901.pphosted.com with ESMTP id 2qu1kfw455-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 24 Feb 2019 17:28:06 -0500
Cc:     <mr.nuke.me@gmail.com>, <bhelgaas@google.com>,
        <Austin.Bolen@dell.com>, <keith.busch@intel.com>,
        <Shyam.Iyer@dell.com>, <okaya@kernel.org>,
        <linux-pci@vger.kernel.org>, <gustavo@embeddedor.com>,
        <linux-kernel@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Feb 2019 04:28:06 +0600
X-LoopCount0: from 10.166.134.85
X-IronPort-AV: E=Sophos;i="5.58,409,1544508000"; 
   d="scan'208";a="1366162022"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>
Subject: Re: [PATCH RFC v2 2/4] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Thread-Topic: [PATCH RFC v2 2/4] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Thread-Index: AQHUyLqR+ed3yG3ljUu42ub7Hwypsg==
Date:   Sun, 24 Feb 2019 22:27:53 +0000
Message-ID: <b54916c90e044d93a06a3f0d297ee30f@ausx13mps321.AMER.DELL.COM>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
 <20190220012031.10741-3-mr.nuke.me@gmail.com>
 <20190221073634.snvazxlzgvjhilaz@wunner.de>
 <dfeadc6798984cce965e2202e90fe0b0@ausx13mps321.AMER.DELL.COM>
 <20190223064926.mh24zzlj4xykwcjf@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-24_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902240176
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/23/19 12:50 AM, Lukas Wunner wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Fri, Feb 22, 2019 at 07:56:28PM +0000, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> On 2/21/19 1:36 AM, Lukas Wunner wrote:=0A=
>>> On Tue, Feb 19, 2019 at 07:20:28PM -0600, Alexandru Gagniuc wrote:=0A=
>>>>    	mutex_lock(&ctrl->state_lock);=0A=
>>>> +	present =3D pciehp_card_present(ctrl);=0A=
>>>> +	link_active =3D pciehp_check_link_active(ctrl);=0A=
>>>>    	switch (ctrl->state) {=0A=
>>>=0A=
>>> These two assignments appear to be superfluous as you're also performin=
g=0A=
>>> them in pciehp_check_link_active().=0A=
>>=0A=
>> Not sure. Between the first check, and this check, you can have several=
=0A=
>> seconds elapse depending on whether the driver's .probe()/remove() is=0A=
>> invoked. Whatever you got at the beginning would be stale. If you had a=
=0A=
>> picture dictionary and looked up 'bad idea', it would have a picture of=
=0A=
>> the above code with the second check removed.=0A=
> =0A=
> I don't quite follow.  You're no longer using the "present" and=0A=
> "link_active" variables in pciehp_handle_presence_or_link_change(),=0A=
> the variables are set again further down in the function and you're=0A=
> *also* reading PDS and DLLLA in is_delayed_presence_up_event().=0A=
> So the above-quoted assignments are superfluous.  Am I missing something?=
=0A=
> =0A=
> (Sorry, I had copy-pasted the wrong function name, I meant=0A=
> is_delayed_presence_up_event() above, not pciehp_check_link_active().=0A=
=0A=
=0A=
I see what I did. You're right. I should remove the following lines from =
=0A=
the patch. I'll have that fixed when I re-submit this.=0A=
=0A=
+       present =3D pciehp_card_present(ctrl);=0A=
+       link_active =3D pciehp_check_link_active(ctrl);=0A=
=0A=
> =0A=
>> I've got all the other review comments addressed in my local branch. I'm=
=0A=
>> waiting on Lord Helgass' decision on which solution is better.=0A=
>               ^^^^^^^^^^^^=0A=
> =0A=
> Can we keep this discussion in a neutral tone please?=0A=
=0A=
I'm sorry. I thought comparing linux to feudalism would be hillarious, =0A=
but I now see not everyone agrees. Sorry, Bjorn.=0A=
=0A=
Alex=0A=
