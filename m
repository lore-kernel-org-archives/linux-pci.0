Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEF1C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 19:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F8A20868
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 19:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="EXJeUjyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfAQTCx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:02:53 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:22600 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725967AbfAQTCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 14:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1547751742; x=1579287742;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kW74RBM+b8D648eSCazvqQ4T+1Ka2zli1qG6o6gvb3A=;
  b=EXJeUjyxgnXCQ8BLYrfYmz2FK20gToJkRNbc7qz8X1rAfY09zHBXqgfM
   631eMXXS6Yz/l01h+WOfc92eUdIDo+0NY6yjQ8h6m58sZnFO1KMx+Ixk4
   hRt9s6cRLwJMTDP03jvQW56MdPrp3GZ2HI21LNel4Xt9Wle3t3oX2+Qqe
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ElAAD70EBchiWd50NjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUwUBAQsBg1kSMYxwjRSXfoF7CwEBhGyCfTYHDQEDAQECAQECAQECEAE?=
 =?us-ascii?q?BAQoJCwgpL4I6IoJvAQEBAQIBEig/BQsCAQgYHhBXAgQBGhqDAIF6CJ9lPQK?=
 =?us-ascii?q?BbokHAQEBgh6KM45VgRGDEoUBhWACi1qKfIpgWgkFkgYgkgstiVOQZwIEAgQ?=
 =?us-ascii?q?FAhSBTQ6BenCDPYImDgmOHkABikWBHwEB?=
X-IPAS-Result: =?us-ascii?q?A2ElAAD70EBchiWd50NjHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?1kSMYxwjRSXfoF7CwEBhGyCfTYHDQEDAQECAQECAQECEAEBAQoJCwgpL4I6I?=
 =?us-ascii?q?oJvAQEBAQIBEig/BQsCAQgYHhBXAgQBGhqDAIF6CJ9lPQKBbokHAQEBgh6KM?=
 =?us-ascii?q?45VgRGDEoUBhWACi1qKfIpgWgkFkgYgkgstiVOQZwIEAgQFAhSBTQ6BenCDP?=
 =?us-ascii?q?YImDgmOHkABikWBHwEB?=
Received: from mx0b-00154901.pphosted.com (HELO mx0a-00154901.pphosted.com) ([67.231.157.37])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2019 13:02:21 -0600
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HJ2jUQ081522;
        Thu, 17 Jan 2019 14:02:50 -0500
Received: from esa6.dell-outbound2.iphmx.com (esa6.dell-outbound2.iphmx.com [68.232.154.99])
        by mx0b-00154901.pphosted.com with ESMTP id 2q2r5m2nx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 14:02:50 -0500
Cc:     <Austin.Bolen@dell.com>, <keith.busch@intel.com>,
        <Shyam.Iyer@dell.com>, <lukas@wunner.de>, <okaya@kernel.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Jan 2019 01:02:49 +0600
X-LoopCount0: from 10.166.134.83
X-IronPort-AV: E=Sophos;i="5.56,489,1539666000"; 
   d="scan'208";a="1247205003"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [RFC] PCI / ACPI: Implementing Type 3 _HPX records
Thread-Topic: [RFC] PCI / ACPI: Implementing Type 3 _HPX records
Thread-Index: AQHUqTnurHiSjfxvdkuUWWPIsLecJQ==
Date:   Thu, 17 Jan 2019 19:02:47 +0000
Message-ID: <edf8493f2c184bd6b28d269fe5aa337a@ausx13mps321.AMER.DELL.COM>
References: <20190110231136.31163-1-mr.nuke.me@gmail.com>
 <20190114200120.GA33971@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.192]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=837 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170133
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn=0A=
=0A=
On 1/14/19 2:01 PM, Bjorn Helgaas wrote:=0A=
> On Thu, Jan 10, 2019 at 05:11:27PM -0600, Alexandru Gagniuc wrote:=0A=
>> _HPX Type 3 is intended to be more generic and allow configuration of=0A=
>> settings not possible with Type 2 tables. For example, FW could ensure=
=0A=
>> that the completion timeout value is set accordingly throughout the PCI=
=0A=
>> tree; some switches require very special handling.=0A=
>>=0A=
>> Type 3 can come in an arbitrary number of ACPI packages. With the older=
=0A=
>> types we only ever had one descriptor. We could get lazy and store it=0A=
>> on the stack. The current flow is to parse the HPX table=0A=
>> --pci_get_hp_params()-- and then program the PCIe device registers.=0A=
>>=0A=
>> In the current flow, we'll need to malloc(). Here's what I tried:=0A=
>>   1) devm_kmalloc() on the pci_dev=0A=
>>    This ended up giving me NULL dereference at boot time.=0A=
> =0A=
> Yeah, I don't think devm_*() is going to work because that's part of the=
=0A=
> driver binding model; this is in the PCI core and this use is not related=
=0A=
> to the lifetime of a driver's binding to a device.=0A=
> =0A=
>>   2) Add a cleanup function to be called after writing the PCIe register=
s=0A=
>>=0A=
>> This RFC implements method 2. The HPX3 stuff is still NDA'd, but the=0A=
>> housekeeping parts are in here. Is this a good way to do things? I'm not=
=0A=
>> too sure about the need to call cleanup() on a stack variable. But if=0A=
>> not that, then what else?=0A=
> =0A=
> pci_get_hp_params() is currently exported, but only used inside=0A=
> drivers/pci, so I think it could be unexported.=0A=
=0A=
It can.=0A=
=0A=
> I don't remember if there's a reason why things are split between=0A=
> pci_get_hp_params(), which runs _HPX or _HPP, and the program_hpp_type*()=
=0A=
> functions.  If we could get rid of that split, we could get rid of struct=
=0A=
> hotplug_params and do the configuration directly in the pci_get_hp_params=
()=0A=
> path.  I think that would simplify the memory management.=0A=
=0A=
Thanks for the in-depth analysis. I'm working on a proof-of-concept =0A=
patch to do what you suggested. On downside though, is that we may have =0A=
to parse some things twice.=0A=
=0A=
Another thing, I've been thinking is, why not store the hotplug =0A=
parameters from ACPI with the pci_bus struct. That way, you only need to =
=0A=
parse ACPI once per bus, instead of each time a device is probed. There =0A=
would be some memory overhead, but the hotplug structures are =0A=
(thankfully) still relatively small. I could try a proof of concept for =0A=
this idea as well... let me know.=0A=
=0A=
Alex=0A=
