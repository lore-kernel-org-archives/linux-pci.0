Return-Path: <SRS0=7uyK=MA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984FCECE560
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 13:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2315E2086B
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 13:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="sM9sjopT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2315E2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeIRSkh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:40:37 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:20884 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727207AbeIRSkg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 14:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1537276065; x=1568812065;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Hm5GoymEOjt/oLg++PSaotiBRYzeh4BHKEvvGGISNcU=;
  b=sM9sjopTIPtlNii9ESv8JZnmYwutVRZr9prrr819NTnAxmmQgUyb5sli
   7xN7cfKoawyMyIaMFKZK/7jqWVX73xVNuCwudn7ElnQ0guMj7m6t38GxB
   Kx0ehuOT0UjvgbEaGivbIMbc+xhCP4puigKNTBdBxcP9cLiLP8RbhMzgY
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EcAADt96BbhyWd50NbGwEBAQEDAQE?=
 =?us-ascii?q?BCQEBAYFQg1oSKAqLfV+NXIhejW4UgWYLhGyEIzQYAQMBAQIBAQIBAQIQAQE?=
 =?us-ascii?q?BCgsJCCkjDEIQAYFiIoJiAQEBAwESFRM/BQsCAQgYHhAhNgIEARIIEweCf4F?=
 =?us-ascii?q?qAw0ImSWJVwEBAYFoM4c3DYJPjQSEJIJWghAYhVgCiBmFT4VYiEIjLAkFiUG?=
 =?us-ascii?q?DRIMPH48UglGKB4drAgQCBAUCFIFCgg5wgzyCJQ4Jh06GSW8BhF6HSoEeAQE?=
X-IPAS-Result: =?us-ascii?q?A2EcAADt96BbhyWd50NbGwEBAQEDAQEBCQEBAYFQg1oSK?=
 =?us-ascii?q?AqLfV+NXIhejW4UgWYLhGyEIzQYAQMBAQIBAQIBAQIQAQEBCgsJCCkjDEIQA?=
 =?us-ascii?q?YFiIoJiAQEBAwESFRM/BQsCAQgYHhAhNgIEARIIEweCf4FqAw0ImSWJVwEBA?=
 =?us-ascii?q?YFoM4c3DYJPjQSEJIJWghAYhVgCiBmFT4VYiEIjLAkFiUGDRIMPH48UglGKB?=
 =?us-ascii?q?4drAgQCBAUCFIFCgg5wgzyCJQ4Jh06GSW8BhF6HSoEeAQE?=
Received: from mx0b-00154901.pphosted.com (HELO mx0a-00154901.pphosted.com) ([67.231.157.37])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Sep 2018 08:07:44 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8ID33Th086173;
        Tue, 18 Sep 2018 09:08:03 -0400
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2mjtxsjav6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Sep 2018 09:08:03 -0400
Cc:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <keith.busch@intel.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <Narendra.K@dell.com>,
        <Stuart.Hayes@dell.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2018 19:08:01 +0600
X-LoopCount0: from 10.166.134.89
X-IronPort-AV: E=Sophos;i="5.53,389,1531803600"; 
   d="scan'208";a="231717807"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUKEtdWZAK09POFEiUwzvn0dT1gA==
Date:   Tue, 18 Sep 2018 13:07:58 +0000
Message-ID: <5c7aa51ff9294b1aab51a3bda2416094@ausx13mps321.AMER.DELL.COM>
References: <20180730212146.31909-1-mr.nuke.me@gmail.com>
 <20180912212831.GM118330@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.90.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=825 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809180132
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180918130758.b2kUMksdty8zXzNhYz2KgZK0Uf9N8-mGwMe_6xa4mX8@z>

On 9/12/2018 4:28 PM, Bjorn Helgaas wrote:=0A=
> On Mon, Jul 30, 2018 at 04:21:44PM -0500, Alexandru Gagniuc wrote:=0A=
>> When a PCI device is gone, we don't want to send IO to it if we can=0A=
>> avoid it. We expose functionality via the irq_chip structure. As=0A=
>> users of that structure may not know about the underlying PCI device,=0A=
>> it's our responsibility to guard against removed devices.=0A=
> =0A=
> I'm pretty ambivalent about pci_dev_is_disconnected() in general, but=0A=
> I think I'll take this, given a couple minor changelog clarifications:=0A=
> =0A=
>> irq_write_msi_msg is already guarded. pci_msi_(un)mask_irq are not.=0A=
>> Guard them for completeness.=0A=
> =0A=
> By the irq_write_msi_msg() guard, I guess you mean this path:=0A=
> =0A=
>    pci_msi_domain_write_msg       # irq_chip.irq_write_msi_msg=0A=
>      __pci_write_msi_msg=0A=
>        if (dev->current_state !=3D PCI_D0 || pci_dev_is_disconnected(dev)=
)=0A=
>          /* don't touch */=0A=
=0A=
Yes!=0A=
=0A=
> pci_msi_(un)mask_irq() may be irq_chip.irq_mask, .irq_unmask, etc=0A=
> pointers.  So these are parallel because they're all irq_chip function=0A=
> pointers, but the changelog isn't (yet) parallel because it uses the=0A=
> irq_chip pointer name for .irq_write_msi_msg but not for mask/unmask=0A=
=0A=
Good catch! I'll get this corrected.=0A=
=0A=
=0A=
>> For example, surprise removal of a PCIe device triggers teardown. This=
=0A=
>> touches the irq_chips ops some point to disable the interrupts. I/O=0A=
>> generated here can crash the system on machines with buggy firmware.=0A=
>> Not triggering the IO in the first place eliminates the problem.=0A=
> =0A=
> It doesn't eliminate the problem completely because .irq_mask() and=0A=
> .irq_unmask() may be called for reasons other than surprise removal,=0A=
> and if a surprise removal happens after the pci_dev_is_disconnected()=0A=
> check but before the readl(), we will still generate I/O to a device=0A=
> that's gone.  I'd be OK if you said it "reduces" the problem.=0A=
=0A=
That sounds reasonable.=0A=
=0A=
> One reason I'm ambivalent about pci_dev_is_disconnected() is that in=0A=
> cases like this, it turns a reproducible problem into a very=0A=
> hard-to-reproduce problem, which reduces the likelihood that the buggy=0A=
> firmware will be fixed.=0A=
=0A=
If it manages to turn this into 99.999% territory, I'll be much happier. =
=0A=
I'd love to give you an academically correct solution, but I just don't =0A=
see how, given how firmware-first philosophy is written.=0A=
=0A=
> Do you have information about known platforms with this buggy firmware=0A=
> and the signature of the crash?  If you do, it's always nice to be=0A=
> able to connect a patch with the user-visible problem it fixes.=0A=
=0A=
 From what I've heard, it won't be fixed. The number of changes needed =0A=
would require re-qualifying the firmware. I'm told that's very hard to =0A=
do on platforms that are shipping. I can reword this to say =0A=
"firmware-first" instead of "buggy" since they are mostly synonymous.=0A=
=0A=
Alex=0A=
=0A=
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>=0A=
>> ---=0A=
>>=0A=
>> There's another patch by Lukas Wunner that is needed (not yet published)=
=0A=
>> in order to fully block IO on SURPRISE!!! removal. The existing code onl=
y=0A=
>> sets the PCI_DEV_DISCONNECTED bit in an unreasonably narrow set of=0A=
>> circumstances. Lukas' patch fixes that.=0A=
>>=0A=
>> However, this change is otherwise fully independent, and enjoy!=0A=
>>=0A=
>>   drivers/pci/msi.c | 3 +++=0A=
>>   1 file changed, 3 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c=0A=
>> index 4d88afdfc843..5f47b5cb0401 100644=0A=
>> --- a/drivers/pci/msi.c=0A=
>> +++ b/drivers/pci/msi.c=0A=
>> @@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, =
u32 flag)=0A=
>>   {=0A=
>>   	struct msi_desc *desc =3D irq_data_get_msi_desc(data);=0A=
>>   =0A=
>> +	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))=0A=
>> +		return;=0A=
>> +=0A=
>>   	if (desc->msi_attrib.is_msix) {=0A=
>>   		msix_mask_irq(desc, flag);=0A=
>>   		readl(desc->mask_base);		/* Flush write to device */=0A=
>> -- =0A=
>> 2.17.1=0A=
>>=0A=
> =0A=
=0A=
