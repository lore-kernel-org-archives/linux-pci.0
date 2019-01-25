Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969C8C282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A384218D0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 22:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="H0qiG64E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAYWjJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:39:09 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:12507 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbfAYWjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 17:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1548455947; x=1579991947;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7usOP7eJIrxgYtnJ5CHILdCzxkvBTIfJc2o1mVWhzAc=;
  b=H0qiG64EAl7BJ3tYzYZkub8az4GlbPQRifHYTUGUoOWCveRWhlbv5BFT
   V2Xa1uO6pS3viu65LTQGBtogvnqYgOkVFgNOsrwDECsmomahyJK2A48mH
   +zgbHZLDmgBiSMzl3iDfzVXuzoL2g3Y82SIgDV1OaOK+CgjM9VhHUDg4C
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EKAACRjktchyeV50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBgVUFgRCBAxUSCodBhFBfixU7gVKYBxSBZwsBASWBUoJ1gw0?=
 =?us-ascii?q?iNAkNAQMBAQIBAQIBAQIQAQEBFQkIKSMMgjoigVMsCAVJAQEYAQEBAQEBARI?=
 =?us-ascii?q?oPxACAQgYHhBXAgQBDQUIARIBBoI1SwGBeQgPnhk9AoFuiFM0AQEBgh6DclB?=
 =?us-ascii?q?BhSmMQYEOgQiBEYJkLoMeAwFfOgkKARIBCBeFYAKJSFWYGwcChyyDW4cbIIF?=
 =?us-ascii?q?qiG+HTooThSWIMYM1AgQCBAUCFIFGN2dxcIM8CYIsgQkBAoJIhRSFP0ABMQE?=
 =?us-ascii?q?BiG6BH4EfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EKAACRjktchyeV50NkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VUFgRCBAxUSCodBhFBfixU7gVKYBxSBZwsBASWBUoJ1gw0iNAkNAQMBAQIBA?=
 =?us-ascii?q?QIBAQIQAQEBFQkIKSMMgjoigVMsCAVJAQEYAQEBAQEBARIoPxACAQgYHhBXA?=
 =?us-ascii?q?gQBDQUIARIBBoI1SwGBeQgPnhk9AoFuiFM0AQEBgh6DclBBhSmMQYEOgQiBE?=
 =?us-ascii?q?YJkLoMeAwFfOgkKARIBCBeFYAKJSFWYGwcChyyDW4cbIIFqiG+HTooThSWIM?=
 =?us-ascii?q?YM1AgQCBAUCFIFGN2dxcIM8CYIsgQkBAoJIhRSFP0ABMQEBiG6BH4EfAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jan 2019 16:38:21 -0600
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0PMX9c0037930
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 17:39:07 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0a-00154901.pphosted.com with ESMTP id 2q83ysapuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 17:39:07 -0500
From:   <Austin.Bolen@dell.com>
To:     <lukas@wunner.de>, <Austin.Bolen@dell.com>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Jan 2019 04:39:06 +0600
X-LoopCount0: from 10.166.135.137
X-IronPort-AV: E=Sophos;i="5.56,523,1539666000"; 
   d="scan'208";a="1351597572"
CC:     <keith.busch@intel.com>, <Alex_Gagniuc@Dellteam.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Topic: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Index: AQHUtIcS5mR8YZ0nPk+DZaS87pNxDw==
Date:   Fri, 25 Jan 2019 22:39:04 +0000
Message-ID: <731c53d1e5f849388e530a537cde1060@AUSX13MPC131.AMER.DELL.COM>
References: <20190125082212.ltq2fos5a27kqqi3@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-25_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901250172
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/25/2019 2:22 AM, Lukas Wunner wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Thu, Jan 24, 2019 at 10:00:49PM +0000, Austin.Bolen@dell.com wrote:=0A=
>> You're welcome!  And yes, this ECN is not yet in 5.0 draft but should be=
=0A=
>> there soon.  Much of what is in the ECN can be implemented with existing=
=0A=
>> DPC hardware.  There are associated ECNs in ACPI and PCI Firmware=0A=
>> Specifications as well.  The ACPI spec changes will not be public until=
=0A=
>> the 6.3 spec is released (soon).  The PCI Firmware Specification changes=
=0A=
>> should be ratified in a few weeks as well.  In the meantime, UEFI org=0A=
>> (which ACPI is a part of) has a git repo accessible to UEFI forum=0A=
>> members where the Linux code to support these new async hot-plug=0A=
>> mechanisms is being developed.  Will be made public once the specs are=
=0A=
>> public.=0A=
> =0A=
> Unfortunately I don't have access to those ECNs or the non-public=0A=
> git repo.=0A=
> =0A=
=0A=
The PCIe Async Hot-Plug ECN has most of the new stuff. It has been =0A=
released and has the same level of access as the PCIe Base Spec so if =0A=
you have access to the PCIe base spec then you should have access to =0A=
this ECN.=0A=
=0A=
> =0A=
>> Some people have slow hands :-).  This is a U.2 device.  There are 2=0A=
>> pins (Pin 4 =3D IfDet#/Pin 10 =3D PRSNT#) that determine presence and ea=
ch=0A=
>> pin is a different length (On insert, IfDet# mates first, PRSNT# mates=
=0A=
>> second, PCIe data lanes mate 3rd).=0A=
> =0A=
> But I've found a public spec for that:=0A=
> http://www.ssdformfactor.org/docs/SSD_Form_Factor_Version1_00.pdf=0A=
> >=0A=
>> These 2 pins determine if it is a SAS or NVMe drive.  We have to wait=0A=
>> until both pins mate in order to know for sure it's an NVMe drive and=0A=
>> therefore generate PRSNT# to DSP above the drive.  But there is no way=
=0A=
>> to know when both pins have mated due to the way the U.2 connector=0A=
>> signals were defined so we have to dead wait.=0A=
> =0A=
> What I don't get is, a lot of the pins are used either for PCIe or SAS:=
=0A=
> If the host controller doesn't know yet whether it's PCIe or SAS, why doe=
s=0A=
> it already start driving them in PCIe mode and bring up the link?=0A=
>  > Also, those PCIe pins mate 3rd, so by the time the host controller sta=
rts=0A=
> driving those pins in PCIe mode, IfDet# and PRSNT# pins are known to be=
=0A=
> connected (because they mate earlier), so the host controller can stop=0A=
> waiting and start sampling the two pins?  Or is it mechanically possible=
=0A=
> to insert the drive in such a way that the pins do not mate before the=0A=
> PCIe pins, contrary to the spec?=0A=
=0A=
In this case, there's not a single host controller.  There are two =0A=
things at play.  The sideband signals (IfDet#, PRSNT#) are routed to =0A=
logic on the platform motherboard or drive backplane.  The PCIe lanes =0A=
are routed to a downstream port (Root Port or Switch Downstream port). =0A=
The platform can see when the sideband signals connect but can't see =0A=
when the link trains.  When the link trains and Data Link Layer goes to =0A=
Active state, the DSP will notify OS via DLLSC interrupt but platform =0A=
has no visibility into this (because we grant control of hot-plug to OS =0A=
natively) and there's no way for platform to get notified when the link =0A=
becomes active.  The PCIe ECN referenced above provides ability to =0A=
notify the platform in this scenario but requires hardware change.=0A=
=0A=
Likewise the DSP doesn't know or care if it's possible to plug a SAS =0A=
drive into the slot.  As soon as it starts seeing training sets on the =0A=
PCIe link it's going to train regardless of the state of IfDet#/PRSNT#.=0A=
=0A=
Also, the DSP doesn't know the state of IfDet#/PRSNT# directly.  There's =
=0A=
a pin called PRSNT# in PCIe DSPs (different than the U2 P10 PRSNT#). =0A=
The platform will assert PCIe PRSNT# to the DSP when U.2 PRSNT#/IfDet# =0A=
indicate it's an NVMe drive (and platform doesn't know this until around =
=0A=
400 ms after IfDet# mates because of the reasons described earlier). =0A=
But PCIe Base spec does not require DSPs to see PCIe PRSNT# asserted in =0A=
order to start the training sequence.  So that's why the PCIe link comes =
=0A=
up before the platform knows its an NVMe drive.=0A=
=0A=
> =0A=
> Link up means in-band presence, =0A=
=0A=
Link Up and In-band Presence are slightly different states (see Table =0A=
4.15 in PCIe Base Spec).  In-band presence is a lower-level detection =0A=
mechanism and can be set even when link is not up.=0A=
=0A=
so I assume this host controller already=0A=
> adheres to the ECN discussed earlier?  =0A=
=0A=
Yes, this platform disables in-band presence.=0A=
=0A=
What is the rationale of the ECN=0A=
> given that it causes these issues?=0A=
=0A=
In certain link states like L1, DSPs can't detect in-band presence going =
=0A=
away.  If you remove a device while the link is in one of these states =0A=
then OS will not get notified.  OS will not be able to detect subsequent =
=0A=
insertions either. Only way out of this is for user to go into the OS =0A=
and manually get the link out of L1.=0A=
=0A=
The PCIe spec doesn't have any strict requirements on how long the time =0A=
between DLLSC and PDSC can be but from our measurements 100 ms is not =0A=
long enough to cover the time delta from first pins mating until the =0A=
device is fully inserted. At a platform level, we use 1 second to allow =0A=
for insertion and removal events and this seems adequate for most cases =0A=
but can be defeated if someone makes an effort to slowly insert or =0A=
remove a device.=0A=
=0A=
Is this product being shipped or=0A=
> can it still be changed?=0A=
> =0A=
=0A=
It's shipping.  It could be changed with a firmware change to re-enable =0A=
in-band presence but then we'd have the issue where hot-plug breaks when =
=0A=
removing devices when link is in certain states like L1 so that is not a =
=0A=
viable solution.=0A=
=0A=
> =0A=
>>> We do allow a 20 + 100 ms delay in pcie_wait_for_link() between link up=
=0A=
>>> and presence detect up, just not 400 ms.=0A=
>>=0A=
>> Is the hot-inserted device's config space accessed immediately after=0A=
>> waiting this 20 + 100 ms delay?=0A=
> =0A=
> Yes.=0A=
> =0A=
> You can follow the code via this link, click your way down the call stack=
:=0A=
> https://elixir.bootlin.com/linux/v5.0-rc3/source/drivers/pci/hotplug/pcie=
hp_hpc.c#L602=0A=
> =0A=
> pciehp_ist()=0A=
>    pciehp_handle_presence_or_link_change() /* called on PDC or DLLSC even=
t */=0A=
>      pciehp_enable_slot() /* called if PDS or DLLLA is 1 */=0A=
>        __pciehp_enable_slot()=0A=
>          board_added()=0A=
> 	  pciehp_check_link_status()=0A=
> 	    pcie_wait_for_link()=0A=
> 	      /*=0A=
> 	       * wait 20 ms per PCIe r4.0 sec 6.6.1,=0A=
> 	       * then wait for up to 1 s until DLLLA is 1,=0A=
> 	       * then wait 100 ms per PCIe r4.0 sec 6.7.3.3=0A=
> 	       */=0A=
> 	    pci_bus_check_dev()=0A=
> 	      /*=0A=
> 	       * first access to hotplugged device:=0A=
> 	       * wait for up to 1 s until vendor ID is accessible=0A=
> 	       */=0A=
> 	    /*=0A=
> 	     * any additionl PDC or DLLSC event that occurred up to this point=
=0A=
> 	     * is ignored because the link is up and config space accessible;=0A=
> 	     * read Link Status register and verify link is trained=0A=
> 	     */=0A=
> 	  pciehp_configure_device()=0A=
> 	    /* enumerate hotplugged device */=0A=
> =0A=
> The 20 ms delay in pcie_wait_for_link() was added by Keith with commit=0A=
> f0157160b359 ("PCI: Make link active reporting detection generic")=0A=
> so that the function can also be used by the DPC driver.  I think that=0A=
> additional delay wouldn't normally be necessary for hotplug but it=0A=
> doesn't hurt much either.=0A=
> =0A=
> =0A=
>> Per PCIe spec, in Gen 3 mode, software=0A=
>> should wait at least (1s - CTO value) after Data Link Layer Link Active=
=0A=
>> before accessing config space.=0A=
> =0A=
> Hm, do you have a spec reference for that?  PCIe r4.0 sec 6.7.3.3 only sa=
ys:=0A=
> =0A=
>     "Software must wait for 100 ms after the Data Link Layer Link Active=
=0A=
>      bit reads 1b before initiating a configuration access to the hot=0A=
>      added device (see Section 6.6)."=0A=
> =0A=
=0A=
Next sentence says "Software must allow 1 second after the Data Link =0A=
Layer Link Active bit reads 1b before it is permitted to determine that =0A=
a hot plugged device which fails to return a Successful Completion for a =
=0A=
Valid Configuration Request is a broken device".=0A=
=0A=
And Section 6.6.1 on Conventional Reset says "Software should use 100 ms =
=0A=
wait periods only if software enables CRS Software Visibility. =0A=
Otherwise, Completion timeouts, platform timeouts, or lengthy processor =0A=
instruction stalls may result."=0A=
=0A=
The "Completion timeouts" reference here is the key. Since CRS Software =0A=
Visibility is not used, the device still has 900 ms before it has to =0A=
return a Successful Completion if you issue a config read 100 ms after =0A=
DLLSC.=0A=
=0A=
CTO timers are typically set around 50 to 65 ms on x86 systems.  So if =0A=
you issue config read after 100 ms you could see a CTO around 50 to 65 =0A=
ms after it's issued which would crash the system.  In order to avoid =0A=
this CTO software has to wait (1 s - CTO value) after DLLSC before =0A=
issuing a config read at Gen 3 (timing is slightly different for Gen 1/2 =
=0A=
speeds). This timing constraint needs to be observed any time a device =0A=
is reset as well.=0A=
=0A=
Probably won't see an issue most of the time because most devices can =0A=
come up and respond to config accesses way faster than 100 ms but I've =0A=
seen devices take longer than that in certain corner cases. Regardless =0A=
of most devices' ability to be ready faster than required by PCIe it's =0A=
probably a good idea to wait longer for hot-insert anyway since =0A=
insertion events can be slow so need time for everything to reach steady =
=0A=
state (fully inserted) before starting to configure things and 100 ms is =
=0A=
not enough time for that based on our lab measurements.  Likewise, DLLSC =
=0A=
and PDSC interrupts can be spread pretty far apart on removal as well =0A=
depending on how slowly the user removes the device.=0A=
=0A=
> >> The exception is if OS enables CRS=0A=
>> Software Visibility in which case config space can be accessed 100 ms=0A=
>> after Data Link Layer Link Active.  Is CRS Software Visibility being use=
d?=0A=
> =0A=
> Not that I'm aware of, no.=0A=
> =0A=
> =0A=
>> I forgot... Readiness Notifications can also let software bypass these=
=0A=
>> first access times but I've not seen anybody implement RN so assume it=
=0A=
>> is not being used here.=0A=
> =0A=
> Right, I think this isn't used either so far.=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Lukas=0A=
> =0A=
=0A=
