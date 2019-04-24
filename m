Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633FC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 21:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96A120835
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 21:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="d9yv5tYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfDXVeS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:34:18 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:56656 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730946AbfDXVeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 17:34:17 -0400
X-Greylist: delayed 17308 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 17:34:16 EDT
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OGjfBn009844;
        Wed, 24 Apr 2019 12:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Fa+5pvA4VjME8gtAVYbFev0HRvIUx/Cx0pVvp2rr50Q=;
 b=d9yv5tYoIUxDrfQnwaGP/wvyVhjBsfOqCemHr1x7wE92njHi4Vg6Fu2vkmatzIbqpbXs
 esk2VVBrXNsdg+CZlgJY2D02qjdg3SwJMrlfv2x9T3E+C9U4MlHukiOSK4eUmIGGNmta
 6T1ocj7cIrReEXrtLg2Gx2IUnyNSYnqw0qVUwP6xD5Lj80FCMXHFBJbrxGXS2mpWXqHY
 tytQbC5fvAW2eSDEtKgh1C+Vz0BXAMht/QQwBI3pCFx5LtSJ+kiGon+di7HREwQ1DyHJ
 gVDvNIoIVq/H2VvoXJ/W8jkXtM7RYgNiHe8csBXT9tNpSZVw6PjWpN328Mbqr+xSy61P hQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2s1t1sxu18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 12:45:47 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OGhMIB181943;
        Wed, 24 Apr 2019 12:45:47 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2s2t4c9ws3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 12:45:47 -0400
X-LoopCount0: from 10.166.134.84
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="300016064"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <alex.williamson@redhat.com>, <bhelgaas@google.com>,
        <helgaas@kernel.org>, <mr.nuke.me@gmail.com>,
        <linux-pci@vger.kernel.org>
CC:     <Austin.Bolen@dell.com>, <keith.busch@intel.com>,
        <Shyam.Iyer@dell.com>, <lukas@wunner.de>, <okaya@kernel.org>,
        <torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add link_change error handler and vfio-pci user
Thread-Topic: [PATCH] PCI: Add link_change error handler and vfio-pci user
Thread-Index: AQHU+iXZXShkTAm30kO83GstO3E6fw==
Date:   Wed, 24 Apr 2019 16:45:45 +0000
Message-ID: <44c43b8c1739488181930c074bb6eddb@ausx13mps321.AMER.DELL.COM>
References: <155605909349.3575.13433421148215616375.stgit@gimli.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240125
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904240125
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/23/2019 5:42 PM, Alex Williamson wrote:=0A=
> The PCIe bandwidth notification service generates logging any time a=0A=
> link changes speed or width to a state that is considered downgraded.=0A=
> Unfortunately, it cannot differentiate signal integrity related link=0A=
> changes from those intentionally initiated by an endpoint driver,=0A=
> including drivers that may live in userspace or VMs when making use=0A=
> of vfio-pci.  Therefore, allow the driver to have a say in whether=0A=
> the link is indeed downgraded and worth noting in the log, or if the=0A=
> change is perhaps intentional.=0A=
> =0A=
> For vfio-pci, we don't know the intentions of the user/guest driver=0A=
> either, but we do know that GPU drivers in guests actively manage=0A=
> the link state and therefore trigger the bandwidth notification for=0A=
> what appear to be entirely intentional link changes.=0A=
> =0A=
> Fixes: e8303bb7a75c PCI/LINK: Report degraded links via link bandwidth no=
tification=0A=
> Link: https://lore.kernel.org/linux-pci/155597243666.19387.12059508706017=
42062.stgit@gimli.home/T/#u=0A=
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>=0A=
> ---=0A=
> =0A=
> Changing to pci_dbg() logging is not super usable, so let's try the=0A=
> previous idea of letting the driver handle link change events as they=0A=
> see fit.  Ideally this might be two patches, but for easier handling,=0A=
> folding the pci and vfio-pci bits together.  Comments?  Thanks,=0A=
=0A=
I think this callback opens up a can of worms where drivers can ad-hoc =0A=
kill a number what otherwise can be indicators of problems. But I don't =0A=
have to like it to review it :).=0A=
=0A=
>   drivers/pci/probe.c         |   13 +++++++++++++=0A=
>   drivers/vfio/pci/vfio_pci.c |   10 ++++++++++=0A=
>   include/linux/pci.h         |    3 +++=0A=
>   3 files changed, 26 insertions(+)=0A=
> =0A=
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c=0A=
> index 7e12d0163863..233cd4b5b6e8 100644=0A=
> --- a/drivers/pci/probe.c=0A=
> +++ b/drivers/pci/probe.c=0A=
> @@ -2403,6 +2403,19 @@ void pcie_report_downtraining(struct pci_dev *dev)=
=0A=
=0A=
I don't think you want to change pcie_report_downtraining(). You're =0A=
advertising to "report" something, by nomenclature, but then go around =0A=
and also call a notification callback. This is also used during probe, =0A=
and you've now just killed your chance to notice you've booted with a =0A=
degraded link.=0A=
If what you want to do is silence the bandwidth notification, you want =0A=
to modify the threaded interrupt that calls this.=0A=
=0A=
>   	if (PCI_FUNC(dev->devfn) !=3D 0 || dev->is_virtfn)=0A=
>   		return;=0A=
>   =0A=
> +	/*=0A=
> +	 * If driver handles link_change event, defer to driver.  PCIe drivers=
=0A=
> +	 * can call pcie_print_link_status() to print current link info.=0A=
> +	 */=0A=
> +	device_lock(&dev->dev);=0A=
> +	if (dev->driver && dev->driver->err_handler &&=0A=
> +	    dev->driver->err_handler->link_change) {=0A=
> +		dev->driver->err_handler->link_change(dev);=0A=
> +		device_unlock(&dev->dev);=0A=
> +		return;=0A=
> +	}=0A=
> +	device_unlock(&dev->dev);=0A=
=0A=
Can we write this such that there is a single lock()/unlock() pair?=0A=
=0A=
> +=0A=
>   	/* Print link status only if the device is constrained by the fabric *=
/=0A=
>   	__pcie_print_link_status(dev, false);=0A=
>   }=0A=
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c=0A=
> index cab71da46f4a..c9ffc0ccabb3 100644=0A=
> --- a/drivers/vfio/pci/vfio_pci.c=0A=
> +++ b/drivers/vfio/pci/vfio_pci.c=0A=
> @@ -1418,8 +1418,18 @@ static pci_ers_result_t vfio_pci_aer_err_detected(=
struct pci_dev *pdev,=0A=
>   	return PCI_ERS_RESULT_CAN_RECOVER;=0A=
>   }=0A=
>   =0A=
> +/*=0A=
> + * Ignore link change notification, we can't differentiate signal relate=
d=0A=
> + * link changes from user driver power management type operations, so do=
=0A=
> + * nothing.  Potentially this could be routed out to the user.=0A=
> + */=0A=
> +static void vfio_pci_link_change(struct pci_dev *pdev)=0A=
> +{=0A=
> +}=0A=
> +=0A=
>   static const struct pci_error_handlers vfio_err_handlers =3D {=0A=
>   	.error_detected =3D vfio_pci_aer_err_detected,=0A=
> +	.link_change =3D vfio_pci_link_change,=0A=
>   };=0A=
>   =0A=
>   static struct pci_driver vfio_pci_driver =3D {=0A=
> diff --git a/include/linux/pci.h b/include/linux/pci.h=0A=
> index 27854731afc4..e9194bc03f9e 100644=0A=
> --- a/include/linux/pci.h=0A=
> +++ b/include/linux/pci.h=0A=
> @@ -763,6 +763,9 @@ struct pci_error_handlers {=0A=
>   =0A=
>   	/* Device driver may resume normal operations */=0A=
>   	void (*resume)(struct pci_dev *dev);=0A=
> +=0A=
> +	/* PCIe link change notification */=0A=
> +	void (*link_change)(struct pci_dev *dev);=0A=
>   };=0A=
>   =0A=
>   =0A=
> =0A=
> =0A=
=0A=
=0A=
