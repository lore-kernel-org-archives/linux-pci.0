Return-Path: <SRS0=Y6U6=MP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD357C00449
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 22:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622B62064D
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 22:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="vZaT5252"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622B62064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbeJDEuh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:50:37 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:2296 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725723AbeJDEuh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Oct 2018 00:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1538604017; x=1570140017;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PtpaPfwaIK9dzSY+IUD7+Xr18VxCJDTjx2HWC5N4iEA=;
  b=vZaT52521hkD84cet01YqBs7sCgScE1x/Fnvk5Az4UoVkJss6AnYPq2b
   LdJ1GiLGhv0agDF+P00Qigb9irsEgBwi7rEaLA9snQFcjAPGuTwuhD/de
   zNea7aJRAZDBn7UIjkOU1p6VDr5dcpOrWkAsm9l5eDPQeeReDMYK4JBgy
   4=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EJAABKO7VbhyeV50NcGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUoFjgRB/KAqMXo1HiGKNehSBZgslCYQ+hCMhNRcBAwEBAgE?=
 =?us-ascii?q?BAgEBAhABAQEVCQgpIwxCDgGBZCIRS2sBAQEBAQEjAg1kAQEBAxIoPxACAQg?=
 =?us-ascii?q?YFQkQITYCBAESCBqCNEsBgWkDFQ+adolXAQEBghuHNw2CTAWLIYIXgRKDEoJ?=
 =?us-ascii?q?WLBkEGIECEgESAQ0SLBOFGQKIMZRwLAkFhkSGWIMVH4FKhGKJNowXcYgiAgQ?=
 =?us-ascii?q?CBAUCFIFEAjNmcXCDPIIzh1iBC4U+bwGBZolwgR+BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2EJAABKO7VbhyeV50NcGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?oFjgRB/KAqMXo1HiGKNehSBZgslCYQ+hCMhNRcBAwEBAgEBAgEBAhABAQEVC?=
 =?us-ascii?q?QgpIwxCDgGBZCIRS2sBAQEBAQEjAg1kAQEBAxIoPxACAQgYFQkQITYCBAESC?=
 =?us-ascii?q?BqCNEsBgWkDFQ+adolXAQEBghuHNw2CTAWLIYIXgRKDEoJWLBkEGIECEgESA?=
 =?us-ascii?q?Q0SLBOFGQKIMZRwLAkFhkSGWIMVH4FKhGKJNowXcYgiAgQCBAUCFIFEAjNmc?=
 =?us-ascii?q?XCDPIIzh1iBC4U+bwGBZolwgR+BHwEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Oct 2018 17:00:16 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w93LrNRq017484;
        Wed, 3 Oct 2018 18:00:22 -0400
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0a-00154901.pphosted.com with ESMTP id 2mw0smht2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Oct 2018 18:00:22 -0400
Cc:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <keith.busch@intel.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <ariel.elior@cavium.com>,
        <everest-linux-l2@cavium.com>, <davem@davemloft.net>,
        <michael.chan@broadcom.com>, <ganeshgr@chelsio.com>,
        <jeffrey.t.kirsher@intel.com>, <tariqt@mellanox.com>,
        <saeedm@mellanox.com>, <leon@kernel.org>,
        <jakub.kicinski@netronome.com>, <dirk.vandermerwe@netronome.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>,
        <oss-drivers@netronome.com>, <stephen@networkplumber.org>,
        <mj@ucw.cz>
Received: from ausxippc110.us.dell.com ([143.166.85.200])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Oct 2018 03:59:57 +0600
X-LoopCount0: from 10.166.134.84
X-IronPort-AV: E=Sophos;i="5.54,337,1534827600"; 
   d="scan'208";a="710724416"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH 1/9] PCI: sysfs: Export available PCIe bandwidth
Thread-Topic: [PATCH 1/9] PCI: sysfs: Export available PCIe bandwidth
Thread-Index: AQHUQ7BfSa0aPLhtZE62OuK+W8HsxQ==
Date:   Wed, 3 Oct 2018 22:00:19 +0000
Message-ID: <f9fbc8babbb344eca593a3f8b0d096d9@ausx13mps321.AMER.DELL.COM>
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
 <20180903180242.14504-2-mr.nuke.me@gmail.com>
 <20181003213054.GH120535@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.90.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810030199
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/03/2018 04:31 PM, Bjorn Helgaas wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> Please report any suspicious attachments, links, or requests for sensitiv=
e information.=0A=
> =0A=
> =0A=
> [+cc Stephen, Martin (for possible lspci changes)]=0A=
> =0A=
> Hi Alexandru,=0A=
> =0A=
> On Mon, Sep 03, 2018 at 01:02:28PM -0500, Alexandru Gagniuc wrote:=0A=
>> For certain bandwidth-critical devices (e.g. multi-port network cards)=
=0A=
>> it is useful to know the available bandwidth to the root complex. This=
=0A=
>> information is only available via the system log, which doesn't=0A=
>> account for link degradation after probing.=0A=
>>=0A=
>> With a sysfs attribute, we can computes the bandwidth on-demand, and=0A=
>> will detect degraded links.=0A=
>>=0A=
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>=0A=
>> ---=0A=
>>   drivers/pci/pci-sysfs.c | 13 +++++++++++++=0A=
>>   1 file changed, 13 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c=0A=
>> index 9ecfe13157c0..6658e927b1f5 100644=0A=
>> --- a/drivers/pci/pci-sysfs.c=0A=
>> +++ b/drivers/pci/pci-sysfs.c=0A=
>> @@ -218,6 +218,18 @@ static ssize_t current_link_width_show(struct devic=
e *dev,=0A=
>>   }=0A=
>>   static DEVICE_ATTR_RO(current_link_width);=0A=
>>   =0A=
>> +static ssize_t available_bandwidth_show(struct device *dev,=0A=
>> +				       struct device_attribute *attr, char *buf)=0A=
>> +{=0A=
>> +	struct pci_dev *pci_dev =3D to_pci_dev(dev);=0A=
>> +	u32 bw_avail;=0A=
>> +=0A=
>> +	bw_avail =3D pcie_bandwidth_available(pci_dev, NULL, NULL, NULL);=0A=
>> +=0A=
>> +	return sprintf(buf, "%u.%03u Gb/s\n", bw_avail / 1000, bw_avail % 1000=
);=0A=
>> +}=0A=
>> +static DEVICE_ATTR_RO(available_bandwidth);=0A=
> =0A=
> Help me understand this.  We already have these sysfs attributes:=0A=
> =0A=
>    max_link_speed          # eg, 16 GT/s=0A=
>    max_link_width          # eg, 8=0A=
>    current_link_speed      # eg, 16 GT/s=0A=
>    current_link_width      # eg, 8=0A=
> =0A=
> so I think the raw materials are already exposed.=0A=
> > The benefits I see for this new file are that=0A=
> =0A=
>    - pcie_bandwidth_available() does the work of traversing up the=0A=
>      tree, doing the computations (link width * speed, reduced by=0A=
>      encoding overhead), and finding the minimum, and=0A=
> =0A=
>    - it re-traverses the path every time we look at it, while the=0A=
>      boot-time check is a one-time event.=0A=
> =0A=
> In principle this could all be done in user space with the attributes=0A=
> that are already exported.  There's some precedent for things like=0A=
> this in lspci, e.g., "NUMA node" [1], and lspci might even be a more=0A=
> user-friendly place for users to look for this, as opposed to=0A=
> searching through sysfs.=0A=
=0A=
Parsing the endpoint to root port bandwidth is, in principle, possible =0A=
from userspace. It's just that in practice it's very clumsy to do, and, =0A=
as you pointed out, not that reliable.=0A=
=0A=
I understand it's not information that all users would jump in the air =0A=
to know. However, it was important enough for certain use cases, that =0A=
the kernel already has a very reliable way to calculate it.=0A=
=0A=
It seems to me that the most elegant way is to let the kernel tell us, =0A=
since the kernel already has this facility. To quote one of the texts =0A=
under Documentation/, it is an elegant way to "avoid reinventing kernel =0A=
wheels in userspace".=0A=
=0A=
Alex=0A=
=0A=
> [1] https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/commit/?id=
=3D90ec4a6d0ae8=0A=
> =0A=
>>   static ssize_t secondary_bus_number_show(struct device *dev,=0A=
>>   					 struct device_attribute *attr,=0A=
>>   					 char *buf)=0A=
>> @@ -786,6 +798,7 @@ static struct attribute *pcie_dev_attrs[] =3D {=0A=
>>   	&dev_attr_current_link_width.attr,=0A=
>>   	&dev_attr_max_link_width.attr,=0A=
>>   	&dev_attr_max_link_speed.attr,=0A=
>> +	&dev_attr_available_bandwidth.attr,=0A=
>>   	NULL,=0A=
>>   };=0A=
>>   =0A=
>> -- =0A=
>> 2.17.1=0A=
>>=0A=
> =0A=
=0A=
