Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223F8C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 16:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28AE22506
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 16:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="VjcArnpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28AE22506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeKMCQz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:16:55 -0500
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:62948 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727709AbeKMCQy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2018 21:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1542039778; x=1573575778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yLavF+vU3MdjQGMI1lrWWHaKhpWTBbEuw+QcLHM09zM=;
  b=VjcArnpc3iVzJclDtRltn7zHvZbqvo9Tf0SJ4CyhEFvzg1b8mhAU/g+l
   mYoIed7C+DfWr+zRjN75OFUEasCgdTRjmeMCu5wi4/yOgSosW9zgzzVs1
   gY698pwSOW48Hmo5hDhElPyB42iKBbYCv7+0ZDM2doK/9zaF6Suvnswit
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EAAABoqOlbhiWd50NjGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUQQBAQEBAQsBgVWBFIECJwqMBl+LG4INlzWBPzsLAQE?=
 =?us-ascii?q?YCwuBSYIvRgKDLiI0DQ0BAwEBAgEBAgEBAhABAQETCwgpIwyCNiIOBEsvCQE?=
 =?us-ascii?q?yAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQcCDUkBARgBAQE?=
 =?us-ascii?q?BAwERKD8MBAIBCBEDAQEBHxAoIQEFCAIEAQ0FCBqCfwGCAQ+dcgKBEIlYAQE?=
 =?us-ascii?q?Bgh2EP0CFHwWMAIIWgRGDEoRxhWgCiQ8DLYE/lAtGBwKGdoMngmmEDyCBWI8?=
 =?us-ascii?q?YiVqDTIMXhxQCBAIEBQIUgUM3gVdwUIJsgjUbgziKUkABMQELiz2BLIEfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EAAABoqOlbhiWd50NjGQEBAQEBAQEBAQEBAQcBAQEBA?=
 =?us-ascii?q?QGBUQQBAQEBAQsBgVWBFIECJwqMBl+LG4INlzWBPzsLAQEYCwuBSYIvRgKDL?=
 =?us-ascii?q?iI0DQ0BAwEBAgEBAgEBAhABAQETCwgpIwyCNiIOBEsvCQEyAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQcCDUkBARgBAQEBAwERKD8MBAIBC?=
 =?us-ascii?q?BEDAQEBHxAoIQEFCAIEAQ0FCBqCfwGCAQ+dcgKBEIlYAQEBgh2EP0CFHwWMA?=
 =?us-ascii?q?IIWgRGDEoRxhWgCiQ8DLYE/lAtGBwKGdoMngmmEDyCBWI8YiVqDTIMXhxQCB?=
 =?us-ascii?q?AIEBQIUgUM3gVdwUIJsgjUbgziKUkABMQELiz2BLIEfAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Nov 2018 10:22:37 -0600
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACGHpsl076577;
        Mon, 12 Nov 2018 11:22:36 -0500
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0a-00154901.pphosted.com with ESMTP id 2nntughn9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 11:22:36 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Nov 2018 22:22:19 +0600
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.54,495,1534827600"; 
   d="scan'208";a="1324513408"
To:     <mika.westerberg@linux.intel.com>,
        <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <ashok.raj@intel.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>,
        <jacob.jun.pan@intel.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <YehezkelShB@gmail.com>,
        <lukas@wunner.de>, <ckellner@redhat.com>,
        <anthony.wong@canonical.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
Thread-Topic: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
Thread-Index: AQHUeqH3AbqUJigm90i3TsPee80z6KVMUNew
Date:   Mon, 12 Nov 2018 16:22:25 +0000
Message-ID: <d4d2488e85174cff9ab8c641336d5919@ausx13mpc120.AMER.DELL.COM>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com>
In-Reply-To: <20181112160628.86620-5-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120142
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Monday, November 12, 2018 10:06 AM
> To: iommu@lists.linux-foundation.org
> Cc: Joerg Roedel; David Woodhouse; Lu Baolu; Ashok Raj; Bjorn Helgaas; Ra=
fael J.
> Wysocki; Jacob jun Pan; Andreas Noever; Michael Jamet; Yehezkel Bernat; L=
ukas
> Wunner; Christian Kellner; Limonciello, Mario; Anthony Wong; Mika Westerb=
erg;
> linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection suppo=
rt
> to userspace
>=20
>=20
>=20
>=20
> Recent systems shipping with Windows 10 version 1803 or later may
> support a feature called Kernel DMA protection [1]. In practice this
> means that Thunderbolt connected devices are placed behind an IOMMU
> during the whole time it is connected (including during boot) making
> Thunderbolt security levels redundant. Some of these systems still have
> Thunderbolt security level set to "user" in order to support OS
> downgrade (the older version of the OS might not support IOMMU based DMA
> protection so connecting a device still relies on user approval then).
>=20
> Export this information to userspace by introducing a new sysfs
> attribute (iommu_dma_protection). Based on it userspace tools can make
> more accurate decision whether or not authorize the connected device.
>=20
> In addition update Thunderbolt documentation regarding IOMMU based DMA
> protection.
>=20
> [1] https://docs.microsoft.com/en-us/windows/security/information-
> protection/kernel-dma-protection-for-thunderbolt
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  .../ABI/testing/sysfs-bus-thunderbolt         |  9 ++++++++
>  Documentation/admin-guide/thunderbolt.rst     | 23 +++++++++++++++++++
>  drivers/thunderbolt/domain.c                  | 17 ++++++++++++++
>  3 files changed, 49 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> index 151584a1f950..b21fba14689b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> +++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> @@ -21,6 +21,15 @@ Description:	Holds a comma separated list of device
> unique_ids that
>  		If a device is authorized automatically during boot its
>  		boot attribute is set to 1.
>=20
> +What: /sys/bus/thunderbolt/devices/.../domainX/iommu_dma_protection
> +Date:		Mar 2019
> +KernelVersion:	4.21
> +Contact:	thunderbolt-software@lists.01.org
> +Description:	This attribute tells whether the system uses IOMMU
> +		for DMA protection. Value of 1 means IOMMU is used 0 means
> +		it is not (DMA protection is solely based on Thunderbolt
> +		security levels).
> +
>  What: /sys/bus/thunderbolt/devices/.../domainX/security
>  Date:		Sep 2017
>  KernelVersion:	4.13
> diff --git a/Documentation/admin-guide/thunderbolt.rst b/Documentation/ad=
min-
> guide/thunderbolt.rst
> index 35fccba6a9a6..ccac2596a49f 100644
> --- a/Documentation/admin-guide/thunderbolt.rst
> +++ b/Documentation/admin-guide/thunderbolt.rst
> @@ -133,6 +133,29 @@ If the user still wants to connect the device they c=
an
> either approve
>  the device without a key or write a new key and write 1 to the
>  ``authorized`` file to get the new key stored on the device NVM.
>=20
> +DMA protection utilizing IOMMU
> +------------------------------
> +Recent systems shipping with Windows 10 version 1803 or later may suppor=
t a
> +feature called `Kernel DMA Protection for Thunderbolt 3`_.  This means t=
hat

Keep in mind there will be systems that ship with Linux that enable this fe=
ature too ;)

It might be better to make it time frame and platform  firmware oriented as=
 it's
entirely possible for an OEM to have a field firmware upgrade that may enab=
le this
functionality from the platform and allow an end user to upgrade to a suffi=
ciently
protected kernel or Windows OS to take advantage of it.

> +Thunderbolt security is handled by an IOMMU so connected devices cannot
> +access memory regions outside of what is allocated for them by drivers.
> +When Linux is running on such system it automatically enables IOMMU if n=
ot
> +enabled by the user already. These systems can be identified by reading
> +``1`` from ``/sys/bus/thunderbolt/devices/domainX/iommu_dma_protection``
> +attribute.
> +
> +The driver does not do anything special in this case but because DMA
> +protection is handled by the IOMMU, security levels (if set) are
> +redundant. For this reason some systems ship with security level set to
> +``none``. Other systems have security level set to ``user`` in order to
> +support downgrade to older Windows, so users who want to automatically
> +authorize devices when IOMMU DMA protection is enabled can use the
> +following ``udev`` rule::
> +
> +  ACTION=3D=3D"add", SUBSYSTEM=3D=3D"thunderbolt",
> ATTRS{iommu_dma_protection}=3D=3D"1", ATTR{authorized}=3D=3D"0",
> ATTR{authorized}=3D"1"
> +
> +.. _Kernel DMA Protection for Thunderbolt 3: https://docs.microsoft.com/=
en-
> us/windows/security/information-protection/kernel-dma-protection-for-
> thunderbolt
> +
>  Upgrading NVM on Thunderbolt device or host
>  -------------------------------------------
>  Since most of the functionality is handled in firmware running on a
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 93e562f18d40..7416bdbd8576 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -7,7 +7,9 @@
>   */
>=20
>  #include <linux/device.h>
> +#include <linux/dmar.h>
>  #include <linux/idr.h>
> +#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -236,6 +238,20 @@ static ssize_t boot_acl_store(struct device *dev, st=
ruct
> device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(boot_acl);
>=20
> +static ssize_t iommu_dma_protection_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	/*
> +	 * Kernel DMA protection is a feature where Thunderbolt security is
> +	 * handled natively using IOMMU. It is enabled when IOMMU is
> +	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> +	 */
> +	return sprintf(buf, "%d\n",
> +		       iommu_present(&pci_bus_type) && dmar_platform_optin());
> +}
> +static DEVICE_ATTR_RO(iommu_dma_protection);
> +
>  static ssize_t security_show(struct device *dev, struct device_attribute=
 *attr,
>  			     char *buf)
>  {
> @@ -251,6 +267,7 @@ static DEVICE_ATTR_RO(security);
>=20
>  static struct attribute *domain_attrs[] =3D {
>  	&dev_attr_boot_acl.attr,
> +	&dev_attr_iommu_dma_protection.attr,
>  	&dev_attr_security.attr,
>  	NULL,
>  };
> --
> 2.19.1

