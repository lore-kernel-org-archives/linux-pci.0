Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE26C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 14:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D5120882
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 14:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="DBKkxStp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfA3O2y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:28:54 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:2287 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbfA3O2x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2019 09:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1548858533; x=1580394533;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=n40pg8CYYifBAPZuKV6isYoXVQSqIfQGmJlCsAKPgI0=;
  b=DBKkxStpVZ2n70Cz80zpmixORSQOyiIzrwhMSY+ujxEXIzdUI0+UVYHe
   u8dG/b9MOUgKO2Sy8rWUltorfncggXPKqoqd5eOhxtN3OxKa1AD4sxFzL
   akliBrs5mYqVOcR99xDrVu48YzP60D+rfxvVB2wbkfvjRAR854/4OzBsb
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GVAQCBs1FchyeV50NjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZYFWgQQRgQMVEgqMcosagg2YIYFnCwEBJQmBSYJ1gwoiOBIBAwEBAgE?=
 =?us-ascii?q?BAgEBAhABAQEKCwkIKSMMgjoiHE1rAQEBAQEBIwJDLQEBAQMBEig/BQsCAQg?=
 =?us-ascii?q?YHhBXAgQBDQ0TB4MAAYF5CA+efD0CgW6JBwEBAYIehC4BAwSFegWMQIIWgRG?=
 =?us-ascii?q?CFFAuhEUlF4VgAolMIDIDmDcHAocuinwggWuFOWmCUodUihmFLIt2AgQCBAU?=
 =?us-ascii?q?CFIFdgXhwgz2CNINUilNAATKOZ4EaBQEB?=
X-IPAS-Result: =?us-ascii?q?A2GVAQCBs1FchyeV50NjHAEBAQQBAQcEAQGBZYFWgQQRg?=
 =?us-ascii?q?QMVEgqMcosagg2YIYFnCwEBJQmBSYJ1gwoiOBIBAwEBAgEBAgEBAhABAQEKC?=
 =?us-ascii?q?wkIKSMMgjoiHE1rAQEBAQEBIwJDLQEBAQMBEig/BQsCAQgYHhBXAgQBDQ0TB?=
 =?us-ascii?q?4MAAYF5CA+efD0CgW6JBwEBAYIehC4BAwSFegWMQIIWgRGCFFAuhEUlF4VgA?=
 =?us-ascii?q?olMIDIDmDcHAocuinwggWuFOWmCUodUihmFLIt2AgQCBAUCFIFdgXhwgz2CN?=
 =?us-ascii?q?INUilNAATKOZ4EaBQEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2019 08:28:52 -0600
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UENBSu085601
        for <linux-pci@vger.kernel.org>; Wed, 30 Jan 2019 09:28:52 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0a-00154901.pphosted.com with ESMTP id 2q8jnwg06c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Wed, 30 Jan 2019 09:28:52 -0500
From:   <Austin.Bolen@dell.com>
To:     <lukas@wunner.de>, <Austin.Bolen@dell.com>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Jan 2019 20:28:48 +0600
X-LoopCount0: from 10.166.135.141
X-IronPort-AV: E=Sophos;i="5.56,540,1539666000"; 
   d="scan'208";a="346264592"
CC:     <keith.busch@intel.com>, <Alex_Gagniuc@Dellteam.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Topic: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Index: AQHUtIcS5mR8YZ0nPk+DZaS87pNxDw==
Date:   Wed, 30 Jan 2019 14:28:48 +0000
Message-ID: <8151069b62ed493ebcecbc296fbbb10c@AUSX13MPC131.AMER.DELL.COM>
References: <20190125082212.ltq2fos5a27kqqi3@wunner.de>
 <731c53d1e5f849388e530a537cde1060@AUSX13MPC131.AMER.DELL.COM>
 <20190126121212.lyt5zpwvo6eijhsi@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300114
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/26/2019 6:12 AM, Lukas Wunner wrote:=0A=
> =0A=
<snip>=0A=
=0A=
> =0A=
> Yes, that's why pci_bus_check_dev() polls the vendor ID register for=0A=
> up to 1 sec before it declares failure.  If that approach is not correct=
=0A=
> or if we deviate from the spec somewhere else then that should of course=
=0A=
> be fixed, so please let me know if so.=0A=
> =0A=
> >> And Section 6.6.1 on Conventional Reset says "Software should use 100 =
ms=0A=
>> wait periods only if software enables CRS Software Visibility.=0A=
>> Otherwise, Completion timeouts, platform timeouts, or lengthy processor=
=0A=
>> instruction stalls may result."=0A=
>>=0A=
>> The "Completion timeouts" reference here is the key. Since CRS Software=
=0A=
>> Visibility is not used, the device still has 900 ms before it has to=0A=
>> return a Successful Completion if you issue a config read 100 ms after=
=0A=
>> DLLSC.=0A=
> =0A=
> I'm truly sorry, I double-checked the code and it turns out Linux does=0A=
> enable CRS Software Visibility unconditionally for all bridges that=0A=
> support it:=0A=
> =0A=
> pci_scan_bridge_extend()=0A=
>    pci_enable_crs()=0A=
> =0A=
> My apologies for the misinformation in my previous e-mail.  Since your=0A=
> explanation hinges on CRS not being used, I'm not sure in how far it=0A=
> applies to the problem at hand.  (I do thank you though for the=0A=
> comprehensive explanation, I have a much better understanding now=0A=
> of the issue you're facing.)=0A=
> =0A=
> =0A=
=0A=
Yes great, with CRS Software Visibility mechanism in place it sounds =0A=
good.  Thanks for double-checking on it!  There is a weird corner case =0A=
where as you insert a device the Data Link Layer becomes active (gold =0A=
fingers on the connector just barely make contact) but as you continue =0A=
to insert the device the link goes back down then back up once it's =0A=
fully inserted (we've captured this and other similar oddities in the =0A=
lab).  The link down/up would reset the device and so in this case, it =0A=
looks like the logic could do a config read before the device is ready. =0A=
 From platform side we usually wait 1 second around hot-plug events for =0A=
everything to reach steady state since you don't otherwise know when the =
=0A=
mechanical action around hot-insert/hot-remove has ended.=0A=
=0A=
The other way to handle this is via DPC since it will avoid link coming =0A=
back up on its own but more work is needed to support DPC on some =0A=
systems.  The coming ACPI additions should hopefully allow DPC to be =0A=
enabled on such systems.=0A=
=0A=
>>> Is this product being shipped or can it still be changed?=0A=
>>=0A=
>> It's shipping.  It could be changed with a firmware change to re-enable=
=0A=
>> in-band presence but then we'd have the issue where hot-plug breaks when=
=0A=
>> removing devices when link is in certain states like L1 so that is not a=
=0A=
>> viable solution.=0A=
> =0A=
> An alternative idea would be to change firmware to always drive PCIe PRSN=
T#=0A=
> high as soon as U.2 PRSNT#/IfDet# is sensed, regardless whether it's NVMe=
=0A=
> or not.  Linux will try to bring up the slot and if it can't be brought u=
p=0A=
> because it's a SAS drive, all you'll get is an error message in dmesg,=0A=
> but you shouldn't see other negative effects.=0A=
=0A=
We used to do this but this error and similar in other OSes is what =0A=
prompted the 500 ms delay circuitry.=0A=
=0A=
> =0A=
> I think the proper solution would be to add a microcontroller to each=0A=
> U.2 slot on your motherboard which snoops on the PCIe pins to determine=
=0A=
> whether communication is taking place and sample the PRSNT#/IfDet# pins=
=0A=
> if so.  This leads to higher BOM cost and development cost of course.=0A=
> > Arguably your platform firmware-based solution tries avoid that cost=0A=
> by simulating what a microcontroller would do but can't really achieve=0A=
> the same result because it lacks access to the PCIe pins.  Vendors such=
=0A=
> as Apple do go to the lengths of adding microcontrollers in similar cases=
,=0A=
> e.g. Apple used one on their motherboards with first generation Thunderbo=
lt=0A=
> controllers:=0A=
> =0A=
> Because the physical port can be used either to attach a Thunderbolt=0A=
> or a DisplayPort device, they added an NXP LP1112A ARM controller=0A=
> which snoops on the pins and drives a multiplexer to route signals=0A=
> either to the Thunderbolt controller or the GPU.  See page 75 of=0A=
> these schematics ("DisplayPort/T29 A MUXing"):=0A=
> =0A=
> https://forums.macrumors.com/attachments/a1278-j30-820-3115-b-051-9058-pd=
f.451409/=0A=
> =0A=
> Newer Thunderbolt controllers integrate that functionality so the=0A=
> BOM cost and development cost is no longer necessary today.=0A=
> =0A=
> =0A=
=0A=
Thanks for the links.  And yes, we looked at things like this too but =0A=
they're prohibitively expensive. It's one thing if you have a single =0A=
thunderbolt connector but we have 24 or more drives.=0A=
=0A=
But we do have other less expensive ways to detect when a link has =0A=
trained but those mechanisms or the microcontroller idea above all =0A=
require hardware changes so won't be possible on the systems already in =0A=
the field.  Future platforms + DPC should handle it better.=0A=
=0A=
>>> Unfortunately I don't have access to those ECNs or the non-public=0A=
>>> git repo.=0A=
>>=0A=
>> The PCIe Async Hot-Plug ECN has most of the new stuff. It has been=0A=
>> released and has the same level of access as the PCIe Base Spec so if=0A=
>> you have access to the PCIe base spec then you should have access to=0A=
>> this ECN.=0A=
> =0A=
> Unfortunately I'm not associated with a member of the PCISIG,=0A=
> so my level of access to the PCIe Base Spec is constrained=0A=
> to leaked documents found on Ukrainian websites. ;-)=0A=
>=0A=
=0A=
Maybe you'll get lucky and they'll leak the ECN too :-)=0A=
=0A=
> Thanks,=0A=
> =0A=
> Lukas=0A=
> =0A=
=0A=
