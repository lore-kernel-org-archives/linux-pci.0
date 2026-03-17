Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C601D6187;
	Tue, 17 Mar 2026 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747238; cv=none; b=YOBkOLGv43mPadYpXFeiWQ1RVg39xgh9RCdvPdFIMisCt/wBjaQDa/B3Dqr9seB3YP38zoOV9Xur2tQcLbkwuwiH1mhuXcywWlcZO8aniPf5EpKziW5AjFKSgYuVbeqF2L6t0V0wmm5VRu6uZy9HrGQMKmVhuxMiFoHzwQPvSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747238; c=relaxed/simple;
	bh=tdK4i+a6Z3eQ1L5u1jOJ5xYVY1M6+PO9Qehx3Yr0BTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqTPfqI0sD0+KFKv6C9OClTxHGVzHny9s9WwMc+wnV8NpOL3A30mDaZ+qoxxPf5HrltvG3JZ1p/URmD01UnQo4ZjGkpldjY42DtySY02IQTbavbPHppqTzUZWs1P1h7MBddQwh9rlvTisnQkoutu7Reb1bcJcGauxx+FK7yGVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h/Awr1WY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h/Awr1WY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H9eESu983279;
	Tue, 17 Mar 2026 11:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=DxF78H4iShP3mQUjt0zgL/eZzheXlcaOOqbaH6wCOxM=; b=h/Awr1WYMeUb
	JWFdwT/Ph+1w474gjU7a5OZJwHls+SBXmrvqp/UhbXF+pwLd/d+ikKAS1UHtCnwS
	mSPYhGr9B+3xBrsU5kQiyq25x0tl8H55TLTax3bY+mmvY+jCzqBfXpOZdNgz/FWz
	Ffuo5kCqPQcIierRqPH1mc6llAbAQB+Sjju+Fwm8N7K/z9OKY4SDZbY5Zknoqftm
	grK4ikFeacWa6uK6oxABAF47mG2f27Ce/HNPS1WW5pDVF+QicwQEtlKaR8doiz65
	aaLRAfQH3wVM4iVg/7qSkzhyKxq7TObL9NwD7Yedxn+kYmM6jzwgEscpJJ12zFDB
	G49zjvFv5w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaubvwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 11:33:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HAf4Z0004737;
	Tue, 17 Mar 2026 11:33:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s91aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 11:33:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HBXZ5l59900246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 11:33:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CC232004E;
	Tue, 17 Mar 2026 11:33:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E81642004D;
	Tue, 17 Mar 2026 11:33:34 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.87.130.152])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Mar 2026 11:33:34 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w2Sg2-00000006Wqm-2GNe;
	Tue, 17 Mar 2026 12:33:34 +0100
Date: Tue, 17 Mar 2026 12:33:34 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Benjamin Block <lkml@mageta.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI/IOV: Fix race between SR-IOV enable/disable
 and hotplug
Message-ID: <20260317113334.GJ2161595@p1gen4-pw042f0m>
References: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
 <20251216-revert_sriov_lock-v3-2-dac4925a7621@linux.ibm.com>
 <0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net>
 <20260317090149.GA3835708@chlorum.ategam.org>
 <20260317094656.GI2161595@p1gen4-pw042f0m>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317094656.GI2161595@p1gen4-pw042f0m>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA5OSBTYWx0ZWRfX0y/O8j7gZMfY
 xr6mzoz4kBnapBEsFoa9+rS/iMhhH+LEEP5VODpi/lDXO6D1O2/o9VXdMA0xOth0u8J3Gj+d6n2
 Dtx2O+ac9dHmjpwOHpY+DF9orHcdlODqFM+/wfvxHTq/KscDduyJPe4VR7odHONkrCwg+ryKcFi
 JwhjNM48W1XQAnWPGUcLyN/FX2k052PmkDqkO8cfsglsqN77Y3Mnp9T2B9dVwRkXrgqNSxMx/dG
 8X2xovD5SkEyODEaILh+LGlEbNNhyyv9x2VrD8wJ8wgP3MQI8TAob8SCCl0gGJIodSubpv0wWog
 2yWwhgDrTEppDrezoTKH0N9AKMyCe0xeqHHR1DvHga0vQOCaCu4g5gtWbRA+nBcqahkgXcuCYWV
 xAZoNmK/yOzGikZKnwfsLUqLR2Vpog82VJlXIUl1m6c+CkKqEoLYT77iK133BUGaV1u6vwxiSXt
 qjmcPnoxzCOpAQ3RvRg==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b93c13 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=dCyHOxzCRJwJDcqN08wA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: FeMVukiHyaYtLUyA_tdgBcTbV7a4tVcH
X-Proofpoint-GUID: FeMVukiHyaYtLUyA_tdgBcTbV7a4tVcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170099

On Tue, Mar 17, 2026 at 10:46:56AM +0100, Benjamin Block wrote:
> On Tue, Mar 17, 2026 at 10:01:49AM +0100, Benjamin Block wrote:
> > One quick idea: can we somehow unbind the device from any device driver
> > in remove_store() before calling
> > pci_stop_and_remove_bus_device_locked()?  That way we would not have any
> > SR-IOV functions attached anymore at the point where we remove the PF,
> > since the DD are expected to clean them up.
> 
> Very quick-and-dirty:
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 16eaaf749ba9..490b6c1f07d3 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -33,6 +33,8 @@
>  #include <linux/unaligned.h>
>  #include "pci.h"
>  
> +extern void device_driver_detach(struct device *dev);
> +
>  #ifndef ARCH_PCI_DEV_GROUPS
>  #define ARCH_PCI_DEV_GROUPS
>  #endif
> @@ -518,8 +520,10 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>  	if (kstrtoul(buf, 0, &val) < 0)
>  		return -EINVAL;
>  
> -	if (val && device_remove_file_self(dev, attr))
> +	if (val && device_remove_file_self(dev, attr)) {
> +		device_driver_detach(dev);

Hmm, thinking on it, this leaves open the possibility, that something re-binds
the DD in between these two calls. Although unlikely, it might happen.

>  		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
> +	}
>  	return count;
>  }
>  static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,

I guess, I dig the hole a bit deeper.

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 16eaaf749ba9..d2877b805d6e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -33,6 +33,8 @@
 #include <linux/unaligned.h>
 #include "pci.h"
 
+extern void device_driver_detach(struct device *dev);
+
 #ifndef ARCH_PCI_DEV_GROUPS
 #define ARCH_PCI_DEV_GROUPS
 #endif
@@ -518,8 +520,13 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val && device_remove_file_self(dev, attr))
+	if (val && device_remove_file_self(dev, attr)) {
+		device_lock(dev);
+		kill_device(dev);
+		device_unlock(dev);
+		device_driver_detach(dev);
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+	}
 	return count;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,

Marking the device dead prevents re-binding after the unbind.

Same sniff tests as before:

  root@b315lp04:~# cd /sys/bus/pci/
  root@b315lp04:/sys/bus/pci# lspci
  0103:00:00.0 Ethernet controller: Mellanox Technologies ConnectX Family mlx5Gen Virtual Function
  1100:00:00.0 Processing accelerators: IBM Spyre Accelerator (rev 02)
  1100:00:00.1 Processing accelerators: IBM Spyre Accelerator Virtual Function (rev 02)
  1180:00:00.0 Processing accelerators: IBM Spyre Accelerator (rev 02)
  1180:00:00.1 Processing accelerators: IBM Spyre Accelerator Virtual Function (rev 02)
  root@b315lp04:/sys/bus/pci# echo 0 > devices/1100\:00\:00.0/sriov_numvfs
  root@b315lp04:/sys/bus/pci# echo 1 > devices/1100\:00\:00.0/sriov_numvfs
  root@b315lp04:/sys/bus/pci# echo 1100:00:00.0 > drivers/vfio-pci/unbind
  root@b315lp04:/sys/bus/pci# echo 1100:00:00.0 > drivers/vfio-pci/bind
  root@b315lp04:/sys/bus/pci# echo 1 > devices/1100\:00\:00.0/sriov_numvfs
  root@b315lp04:/sys/bus/pci# echo 1 > devices/1100\:00\:00.0/remove
  root@b315lp04:/sys/bus/pci# lspci
  0103:00:00.0 Ethernet controller: Mellanox Technologies ConnectX Family mlx5Gen Virtual Function
  1180:00:00.0 Processing accelerators: IBM Spyre Accelerator (rev 02)
  1180:00:00.1 Processing accelerators: IBM Spyre Accelerator Virtual Function (rev 02)
  root@b315lp04:/sys/bus/pci# rmmod vfio_ccw vfio_pci vfio_pci_core vfio_iommu_type1 vfio
  root@b315lp04:/sys/bus/pci# modprobe -a vfio_ccw vfio_pci vfio_pci_core vfio_iommu_type1 vfio
  root@b315lp04:/sys/bus/pci# echo 1 > rescan
  root@b315lp04:/sys/bus/pci# echo 1 > devices/1100\:00\:00.0/sriov_numvfs
  root@b315lp04:/sys/bus/pci# echo 1 > devices/1180\:00\:00.0/sriov_numvfs
  root@b315lp04:/sys/bus/pci# lspci
  0103:00:00.0 Ethernet controller: Mellanox Technologies ConnectX Family mlx5Gen Virtual Function
  1100:00:00.0 Processing accelerators: IBM Spyre Accelerator (rev 02)
  1100:00:00.1 Processing accelerators: IBM Spyre Accelerator Virtual Function (rev 02)
  1180:00:00.0 Processing accelerators: IBM Spyre Accelerator (rev 02)
  1180:00:00.1 Processing accelerators: IBM Spyre Accelerator Virtual Function (rev 02)
  root@b315lp04:/sys/bus/pci# echo 0 > devices/1180\:00\:00.0/sriov_numvfs
  root@b315lp04:/sys/bus/pci# echo 1 > devices/1180\:00\:00.0/sriov_numvfs
  root@b315lp04:/sys/bus/pci# echo 1180:00:00.0 > drivers/vfio-pci/unbind
  root@b315lp04:/sys/bus/pci# echo 1180:00:00.0 > drivers/vfio-pci/bind
  root@b315lp04:/sys/bus/pci# echo 1 > devices/1180\:00\:00.0/sriov_numvfs
  root@b315lp04:/sys/bus/pci# echo 1 > devices/1180\:00\:00.0/remove
  root@b315lp04:/sys/bus/pci# lspci
  0103:00:00.0 Ethernet controller: Mellanox Technologies ConnectX Family mlx5Gen Virtual Function
  1100:00:00.0 Processing accelerators: IBM Spyre Accelerator (rev 02)
  1100:00:00.1 Processing accelerators: IBM Spyre Accelerator Virtual Function (rev 02)

Same result: all without any Warnings/Lockdep-Splats/Kmemleak-Splats/etc.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
